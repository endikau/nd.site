FROM condaforge/miniforge3:latest
SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Berlin \
    CONDA_ENV=quarto_render

# add back to install: --no-install-recommends
RUN apt-get update && \
    apt-get install -y \
      build-essential git curl locales tzdata pkg-config libcairo2-dev \
      libcurl4-openssl-dev libfontconfig1-dev libfreetype6-dev libfribidi-dev \
      libgit2-dev libglpk-dev libharfbuzz-dev libicu-dev libjpeg-dev \
      libmagick++-dev libnode-dev libpango1.0-dev libpng-dev \
      libpoppler-cpp-dev libprotobuf-dev protobuf-compiler libssl-dev \
      libtiff5-dev libxml2-dev libssh2-1-dev libnghttp2-dev libpsl-dev \
      libidn2-dev librtmp-dev zlib1g-dev gsfonts libgsl0-dev pandoc \
      libprotoc-dev libwebp-dev && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /project /conda_cache /renv_cache /output

# Create conda env with pinned versions of core packages
# System libcurl version is too old! Try next time...
RUN conda config --add channels conda-forge && conda config --set channel_priority strict && \
    conda create -y -n ${CONDA_ENV} \
      r-base=4.5.1 \
      python=3.10.16 \
      quarto=1.5.57 \
      hugo=0.139.3 \
      pandoc \
      deno \
      libpng \
      libzlib \
      libxml2 \
      libxslt \
      libcurl \
      protobuf \
      libprotobuf \
      abseil-cpp \
      openssl \
      libssh2 \
      libnghttp2 \
      libidn2 \
      libpsl \
      zlib && \
    conda clean -afy

ENV PATH=/opt/conda/envs/${CONDA_ENV}/bin:/opt/conda/bin:${PATH} \
    CONDA_DEFAULT_ENV=${CONDA_ENV} \
    PKG_CONFIG_PATH=/opt/conda/envs/${CONDA_ENV}/lib/pkgconfig:/opt/conda/envs/${CONDA_ENV}/share/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:${PKG_CONFIG_PATH} \
    LIBRARY_PATH=/opt/conda/envs/${CONDA_ENV}/lib:/usr/lib/x86_64-linux-gnu:${LIBRARY_PATH} \
    QUARTO_DENO=/opt/conda/envs/${CONDA_ENV}/bin/deno \
    QUARTO_SHARE_PATH=/opt/conda/envs/${CONDA_ENV}/share/quarto

COPY renv.lock /project/renv.lock
COPY environment.yml /project/environment.yml
RUN R -e "install.packages(c('renv', 'pak'), repos = 'http://cran.rstudio.com')"
RUN R -e "renv::restore(project = '/project', repos = 'http://cran.rstudio.com', clean = TRUE, prompt = FALSE)"
RUN R -e "reticulate::conda_create("")"


WORKDIR /project

CMD ["quarto", "render"]
