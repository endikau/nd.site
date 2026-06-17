# syntax=docker/dockerfile:1.6
FROM ghcr.io/endikau/nd_docker-static_serve:latest
# FROM nd_docker-static_serve:local

ENV R_LIBS_USER=/usr/local/lib/R/site-library
ENV RENV_PATHS_LIBRARY=/usr/local/lib/R/site-library

WORKDIR /project

# Copy tracked repo contents (build context is streamed via git ls-files).
COPY . /project/

# Use BuildKit secret mount so npm auth is not baked into layers.
RUN --mount=type=secret,id=npmrc,target=/root/.npmrc npm update

# Optionally load a PAT for GitHub/renv installs without leaking it into layers.
RUN --mount=type=secret,id=github_pat,required=false \
    if [ -f /run/secrets/github_pat ]; then \
      export GITHUB_PAT="$(cat /run/secrets/github_pat)"; \
    fi; \
    Rscript --vanilla scripts/setup_envs.R

# Render the site
RUN quarto render
