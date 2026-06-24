# nd.site Static Serve

The image builds on the same shared R/pyenv/s6 runtime as `nd.apps`. Quarto,
Pandoc, and Hugo are present only in the build stage; the final container adds
only static-web-server to the shared runtime. Node/npm and `libnode-dev` are
part of the shared runtime.

## Prerequisites
- Docker with BuildKit/buildx (`docker buildx inspect` should succeed).
- `.npmrc` with registry auth at repo root (override with `NPMRC_PATH=/path/to/.npmrc`).
- Set `GITHUB_PAT` when `renv.lock` references private GitHub repositories.

## Build locally (tracked files only)
Uses a streamed git context, so only tracked files are sent to Docker.

```bash
./scripts/build_local.sh
```

Result: `nd_site-static_serve:local`.

## Set up local R/Python environments
For non-Docker rendering, run:

```bash
Rscript scripts/setup_envs.R
```

This restores R packages with renv, creates the Python virtualenv recorded in
`renv.lock`, and installs `requirements.txt`.

## Render locally
Run the rendered site:

```bash
docker run --rm -p 12348:8080 nd_site-static_serve:local
```

## CI build (GitHub Actions)
`.github/workflows/build.yml` builds from the tracked Git state and pushes both
`latest` and an immutable `sha-<commit>` tag. It expects `NPMRC_FILE` and can
optionally use `ND_ACTIONS_READ_TOKEN` for private R dependencies.

## Notes
- `.dockerignore` is `**` to discourage `docker build .`; supported path is the streamed git context.
- R, Python, and npm dependencies are restored in independent stages.
- `@endikau/nd_assets` is installed from the private npm registry with
  `npm ci`.
- The R package `nd.util` is restored from GitHub through `renv.lock`.
- The runtime base and all build tools are explicitly versioned.
