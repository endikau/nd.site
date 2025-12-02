FROM condaforge/miniforge3:latest
SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Berlin \
    CONDA_ENV=quarto_render \
    RENV_PATHS_CACHE=/renv_cache \
    CONDA_PKGS_DIRS=/conda_cache

# curl too old
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential git curl locales tzdata pkg-config libcairo2-dev \
      libcurl4-openssl-dev libfontconfig1-dev libfreetype6-dev libfribidi-dev \
      libgit2-dev libglpk-dev libharfbuzz-dev libicu-dev libjpeg-dev \
      libmagick++-dev libnode-dev libpango1.0-dev libpng-dev \
      libpoppler-cpp-dev libprotobuf-dev protobuf-compiler libssl-dev \
      libtiff5-dev libxml2-dev libssh2-1-dev libnghttp2-dev libpsl-dev \
      libidn2-dev librtmp-dev zlib1g-dev gsfonts libgsl0-dev pandoc \
      libprotoc-dev libwebp-dev && \
    rm -rf /var/lib/apt/lists/*

# Create conda env with pinned versions
# System libcurl version is too old!
RUN conda config --add channels conda-forge && conda config --set channel_priority strict && \
    conda create -y -n ${CONDA_ENV} \
      r-base=4.5.1 \
      python=3.10.16 \
      quarto=1.5.57 \
      hugo=0.139.3 && \ 
    conda clean -afy

ENV PATH=/opt/conda/envs/${CONDA_ENV}/bin:/opt/conda/bin:${PATH} \
    CONDA_DEFAULT_ENV=${CONDA_ENV} \
    PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:${PKG_CONFIG_PATH}

# RUN wget -qO- https://github.com/jeroen/curl/releases/download/libcurl-8.14.1/libcurl-8.14.1-x86_64-rocky8-minimal.tar.gz | \
#         gunzip | \
#         tar xvf - -C /opt/libcurl-8.14.1
# ENV CURL_CFLAGS="-I/opt/libcurl-8.14.1/include" \
#     CURL_LIBS="/opt/libcurl-8.14.1/lib/libcurl.a -l:libnghttp2.so.14 -l:libssl.so.1.1 -l:libcrypto.so.1.1 -l:libgssapi_krb5.so.2 -l:libldap-2.4.so.2 -l:libkrb5.so.3 -l:libk5crypto.so.3 -l:libcom_err.so.2 -l:libz.so.1 -l:libpthread.so.0 -l:libidn2.so.0"

# RUN curl -sOL "https://github.com/jeroen/curl/releases/download/libcurl-8.14.1/get-curl-linux.sh" && \
#     . ./get-curl-linux.sh 

RUN mkdir -p /project /conda_cache /renv_cache /output


# COPY renv.lock /project/renv.lock
# # COPY environment.yml /project/environment.yml
# ENV RENV_CONFIG_PAK_ENABLED=TRUE
# RUN R -e "install.packages(c('renv', 'pak'), repos = 'http://cran.rstudio.com')"
# RUN R -e "renv::restore(project = '/project', clean = TRUE, prompt = FALSE)"

CMD ["sh", "-c", "sleep 60m"]
# CMD ["R", "-e", "renv::status()"]
# CMD ["quarto", "render"]
