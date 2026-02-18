# syntax=docker/dockerfile:1.6
# FROM ghcr.io/endikau/nd_docker-static_serve:latest
FROM nd_docker-static_serve:local

WORKDIR /project

# Copy tracked repo contents (build context is streamed via git ls-files).
COPY . /project/

# Use BuildKit secret mount so npm auth is not baked into layers.
RUN --mount=type=secret,id=npmrc,target=/root/.npmrc npm update

RUN Rscript --vanilla scripts/setup_envs.R

# Render the site
RUN quarto render
