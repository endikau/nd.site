# AGENTS GUIDE — nd.site

For LLM/automation agents working in this repo.

## Build & render
- **Local build** (tracked files only): `./scripts/build_local.sh` — requires Docker BuildKit/buildx and an `.npmrc` (override with `NPMRC_PATH`).
- **Render locally**: `docker run --rm -v "$(pwd)/_public:/project/_public" nd_site-static_serve:local`.
- **CI**: `.github/workflows/build.yml` streams `git ls-files | tar | docker buildx build --push`; needs secret `NPMRC_FILE` containing the `.npmrc` content.

## Dockerfile expectations
- `Dockerfile` copies the tracked repo into `/project`, runs `npm update` with a BuildKit secret-mounted `.npmrc`, then `scripts/setup_envs.R`, and renders on container start via entrypoint.
- Build context must be the streamed git tar; **do not use** `docker build .` (context is intentionally empty because `.dockerignore` is `**`).

## Secrets & safety
- Never bake `.npmrc` into images; use `--secret id=npmrc`.
- Keep `.dockerignore` as `**` unless the build path changes.

## Key files
- `Dockerfile` — main image.
- `scripts/build_local.sh` — tracked-files BuildKit build.
- `scripts/setup_envs.R` — env/bootstrap.
- `compose.yml` — local render helper (uses `nd_site-static_serve:local`).

## Quick checklist for changes
1) Use `git ls-files`-based contexts; avoid `docker build .`.
2) Preserve BuildKit secret mounts for npm.
3) Keep `NPMRC_FILE` secret requirement in CI docs if flow changes.
4) Update README if the build/run steps change.
