# syntax=docker/dockerfile:1.7

ARG RUNTIME_TAG=4.6.0-py3.12.10-v4

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
    ND_SETUP_ENVS=R Rscript scripts/setup_envs.R


FROM ghcr.io/endikau/nd_docker-runtime:${RUNTIME_TAG} AS python-deps

WORKDIR /project

COPY renv.lock requirements.txt ./
COPY scripts/setup_envs.R scripts/setup_envs.R

RUN --mount=type=cache,target=/root/.cache/pip \
    ND_SETUP_ENVS=PYTHON \
    ND_PYTHON_VENV=/opt/nd/venv \
    Rscript scripts/setup_envs.R


FROM ghcr.io/endikau/nd_docker-runtime:${RUNTIME_TAG} AS node-deps

WORKDIR /project

COPY package.json package-lock.json ./

RUN --mount=type=cache,target=/root/.npm \
    --mount=type=secret,id=npmrc,target=/root/.npmrc \
    npm ci


# Gemeinsame Basis fuer den Build und das Endimage: Quarto, Pandoc und Hugo
# kommen aus .deb-Paketen und verteilen sich ueber /opt und /usr/local — sie
# einzeln zwischen Stages zu kopieren waere bruechig. Stattdessen einmal hier
# installieren; beide Seiten teilen sich denselben Layer, und das Endimage kann
# damit auch selbst rendern.
FROM ghcr.io/endikau/nd_docker-static_serve:${RUNTIME_TAG} AS serve-base

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


FROM serve-base AS build

WORKDIR /project

COPY --from=python-deps /opt/nd/venv/ /opt/nd/venv/
COPY --from=r-deps /project/renv/library/ ./renv/library/
COPY --from=node-deps /project/node_modules/ ./node_modules/
COPY . .

RUN quarto render


FROM serve-base

WORKDIR /project

# Reihenfolge nach Aenderungshaeufigkeit, seltenstes zuerst: ein neuer Layer
# invalidiert alle folgenden. Frueher lag alles in einem einzigen COPY, weshalb
# eine Textaenderung auch renv-Library und node_modules neu uebertragen hat.
COPY --from=python-deps /opt/nd/venv/ /opt/nd/venv/
COPY --from=r-deps /project/renv/library/ ./renv/library/
COPY --from=node-deps /project/node_modules/ ./node_modules/
COPY . .
COPY --from=build /project/_hugo/ ./_hugo/
COPY --from=build /project/_public/ ./_public/
