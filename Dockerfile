# syntax=docker/dockerfile:1.7

ARG RUNTIME_TAG=4.6.0-py3.12.12-v4

FROM ghcr.io/endikau/nd_docker-runtime:${RUNTIME_TAG} AS r-deps

ENV RENV_PATHS_CACHE=/root/.cache/R/renv

WORKDIR /project

COPY renv.lock .Rprofile ./
COPY renv/activate.R renv/settings.json renv/
COPY scripts/setup_envs.R scripts/setup_envs.R

RUN --mount=type=cache,target=/root/.cache/R/renv \
    --mount=type=secret,id=github_pat,required=false \
    if [ -s /run/secrets/github_pat ]; then \
      export GITHUB_PAT="$(cat /run/secrets/github_pat)"; \
    fi; \
    Rscript scripts/setup_envs.R


FROM ghcr.io/endikau/nd_docker-runtime:${RUNTIME_TAG} AS python-deps

COPY requirements.txt /tmp/requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip \
    python -m venv /opt/nd/venv \
 && /opt/nd/venv/bin/python -m pip install --upgrade pip \
 && /opt/nd/venv/bin/python -m pip install -r /tmp/requirements.txt


FROM ghcr.io/endikau/nd_docker-runtime:${RUNTIME_TAG} AS node-deps

WORKDIR /project

COPY package.json package-lock.json ./

RUN --mount=type=cache,target=/root/.npm \
    --mount=type=secret,id=npmrc,target=/root/.npmrc \
    npm ci


FROM ghcr.io/endikau/nd_docker-runtime:${RUNTIME_TAG} AS build

ARG HUGO_VERSION=0.163.3
ARG PANDOC_VERSION=3.10
ARG QUARTO_VERSION=1.9.38

ENV HUGO_VERSION=${HUGO_VERSION} \
    PANDOC_VERSION=${PANDOC_VERSION} \
    QUARTO_VERSION=${QUARTO_VERSION} \
    RENV_PATHS_CACHE=/tmp/renv-cache \
    RENV_PYTHON=/opt/nd/venv/bin/python \
    RETICULATE_PYTHON=/opt/nd/venv/bin/python

RUN /rocker_scripts/install_pandoc.sh "${PANDOC_VERSION}" \
 && /rocker_scripts/install_quarto.sh "${QUARTO_VERSION}" \
 && /opt/nd-docker/scripts/install_hugo.sh

WORKDIR /project

COPY . .
COPY --from=r-deps /project/renv/library/ ./renv/library/
COPY --from=node-deps /project/node_modules/ ./node_modules/
COPY --from=python-deps /opt/nd/venv/ /opt/nd/venv/

RUN quarto render


FROM ghcr.io/endikau/nd_docker-static_serve:${RUNTIME_TAG}

ENV RENV_PATHS_CACHE=/tmp/renv-cache \
    RENV_PYTHON=/opt/nd/venv/bin/python \
    RETICULATE_PYTHON=/opt/nd/venv/bin/python

WORKDIR /project

COPY --from=build /project/ /project/
COPY --from=python-deps /opt/nd/venv/ /opt/nd/venv/
