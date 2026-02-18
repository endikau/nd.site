# nd.site Static Serve

Build and render the site image using the tracked git state and BuildKit.

## Prerequisites
- Docker with BuildKit/buildx (`docker buildx inspect` should succeed).
- `.npmrc` with registry auth at repo root (override with `NPMRC_PATH=/path/to/.npmrc`).

## Build locally (tracked files only)
Uses a streamed git context, so only tracked files are sent to Docker.

```bash
./scripts/build_local.sh
```

Result: `nd_site-static_serve:local`.

## Render locally
Render into your working tree `_public`:

```bash
docker run --rm -v "$(pwd)/_public:/project/_public" nd_site-static_serve:local
```

## CI build (GitHub Actions)
`.github/workflows/build.yml` streams `git ls-files | tar | docker buildx build --push` and tags `ghcr.io/<owner>/nd_site-static_serve:latest`. It expects a secret `NPMRC_FILE` containing your `.npmrc` content.

## Notes
- `.dockerignore` is `**` to discourage `docker build .`; supported path is the streamed git context.
- Dockerfile copies the tracked repo into `/project`, runs `npm update` with a secret-mounted `.npmrc`, then `scripts/setup_envs.R`, and renders on container start via entrypoint.
