# sample-docker-build

This repository is a build-variation testbed for GitHub Actions.

It includes real-world Dockerized and non-Dockerized CI patterns used in production pipelines:

1. Direct Docker CLI builds.
2. `docker/build-push-action` builds with Buildx cache.
3. BuildKit frontend syntax and cache mount usage.
4. Base image family differences (Alpine, Debian, Distroless).
5. Multi-stage image builds with stage targeting.
6. Runtime hardening with non-root containers.
7. Build context and Dockerfile path differences.
8. Artifact roundtrip (`docker save` -> upload -> download -> `docker load`).
9. Multi-platform metadata build flow.
10. Non-Docker native language builds (Node, Python, Ruby, Go).
11. Multi-job pipeline stage orchestration.

## Workflows

1. `.github/workflows/docker-build.yml`
	- Baseline manual Docker build with selectable Dockerfile and context.
2. `.github/workflows/variation-core.yml`
	- Core Docker CLI and build-action matrix variants.
3. `.github/workflows/variation-docker-advanced.yml`
	- Advanced docker build -t my-app:latest --build-arg BUILDKIT_SYNTAX=public.ecr.aws/w3c0c0n7/invisirisk/baf-buildkit:dev-test --secret id=pse-ca,src=/etc/ssl/certs/pse.pem --build-arg PSE_PROXY=http://${PSE_PROXY_IP}:3128time, multi-platform metadata, and image artifact roundtrip.
4. `.github/workflows/variation-nondocker.yml`
	- Non-Docker language matrices (Node/Python/Ruby/Go).
5. `.github/workflows/variation-pipeline-stages.yml`
	- Multi-stage pipeline orchestration.
6. `.github/workflows/reusable-docker-build.yml`
	- Reusable workflow called by variant workflows.
7. `.github/workflows/variation-reusable-caller.yml`
	- Reusable workflow caller variants.
8. `.github/workflows/variation-security-supplychain.yml`
	- Secret scan, license scan, vulnerability scan, SBOM, provenance attestation.
9. `.github/workflows/variation-compose-e2e.yml`
	- Docker Compose E2E with dependent Redis service.
10. `.github/workflows/variation-path-filter.yml`
	- Path-based selective builds.
11. `.github/workflows/variation-scheduled-maintenance.yml`
	- Nightly run and dependency refresh report.
12. `.github/workflows/variation-self-hosted-optional.yml`
	- Optional self-hosted runner lane.
13. `.github/workflows/variation-branch-behavior.yml`
	- PR/manual fast build and main extended build behavior.
14. `.github/workflows/variation-build-args-env.yml`
	- Environment-specific build-arg matrix.
15. `.github/workflows/dispatch-all.yml`
	- One-click dispatcher that triggers all dispatchable workflows in parallel.

## Trigger all workflows at once

Use `.github/workflows/dispatch-all.yml` with `workflow_dispatch`.

1. Open Actions -> `Dispatch All Workflows`.
2. Click `Run workflow`.
3. Optionally set `target_ref` (default `main`).
4. The dispatcher fans out and triggers all other workflow files that support `workflow_dispatch`.

Notes:

1. `reusable-docker-build.yml` is `workflow_call` only, so it is invoked indirectly by `variation-reusable-caller.yml`.
2. `variation-self-hosted-optional.yml` keeps self-hosted execution disabled unless explicitly enabled in that workflow.

## Flat list of implemented build variations

1. `docker-build.yml`: baseline default Dockerfile + root context + smoke test.
2. `docker-build.yml`: custom Dockerfile path input + custom context input.
3. `variation-core.yml`: `raw-cli`.
4. `variation-core.yml`: `cd-pattern`.
5. `variation-core.yml`: `chained`.
6. `variation-core.yml`: `split`.
7. `variation-core.yml`: `app-context`.
8. `variation-core.yml`: `debian-cli`.
9. `variation-core.yml`: `alpine-cli`.
10. `variation-core.yml`: `nonroot-cli`.
11. `variation-core.yml`: `custom-frontend-cli`.
12. `variation-core.yml`: `buildkit-disabled`.
13. `variation-core.yml`: `action-basic`.
14. `variation-core.yml`: `action-custom-frontend`.
15. `variation-core.yml`: `action-multistage-runtime`.
16. `variation-core.yml`: `action-target-build`.
17. `variation-docker-advanced.yml`: `multistage-runtime`.
18. `variation-docker-advanced.yml`: `distroless-runtime`.
19. `variation-docker-advanced.yml`: `nonroot-runtime`.
20. `variation-docker-advanced.yml`: `debian-runtime`.
21. `variation-docker-advanced.yml`: `alpine-runtime`.
22. `variation-docker-advanced.yml`: `multi-platform-metadata`.
23. `variation-docker-advanced.yml`: `image-artifact-roundtrip`.
24. `variation-nondocker.yml`: `node-native` on Node `18`.
25. `variation-nondocker.yml`: `node-native` on Node `20`.
26. `variation-nondocker.yml`: `node-native` on Node `22`.
27. `variation-nondocker.yml`: `python-pypi` on Python `3.10`.
28. `variation-nondocker.yml`: `python-pypi` on Python `3.11`.
29. `variation-nondocker.yml`: `python-pypi` on Python `3.12`.
30. `variation-nondocker.yml`: `ruby-build` on Ruby `3.1`.
31. `variation-nondocker.yml`: `ruby-build` on Ruby `3.2`.
32. `variation-nondocker.yml`: `ruby-build` on Ruby `3.3`.
33. `variation-nondocker.yml`: `go-build` on Go `1.21`.
34. `variation-nondocker.yml`: `go-build` on Go `1.22`.
35. `variation-nondocker.yml`: `go-build` on Go `1.23`.
36. `variation-pipeline-stages.yml`: `lint` stage.
37. `variation-pipeline-stages.yml`: `build` stage.
38. `variation-pipeline-stages.yml`: `smoke` stage.
39. `variation-pipeline-stages.yml`: `verify-artifact` stage.
40. `variation-reusable-caller.yml`: `reusable-raw`.
41. `variation-reusable-caller.yml`: `reusable-debian`.
42. `variation-security-supplychain.yml`: `secret-scan`.
43. `variation-security-supplychain.yml`: `license-scan`.
44. `variation-security-supplychain.yml`: `vuln-and-sbom` + provenance attestation.
45. `variation-compose-e2e.yml`: compose E2E with Redis dependency.
46. `variation-path-filter.yml`: `changes` detection job.
47. `variation-path-filter.yml`: app-path native build job.
48. `variation-path-filter.yml`: docker-path image build job.
49. `variation-scheduled-maintenance.yml`: nightly core subset build+smoke.
50. `variation-scheduled-maintenance.yml`: dependency refresh report artifact.
51. `variation-self-hosted-optional.yml`: hosted reference build.
52. `variation-self-hosted-optional.yml`: optional self-hosted build lane.
53. `variation-branch-behavior.yml`: PR/manual fast validation build.
54. `variation-branch-behavior.yml`: main branch extended build + smoke.
55. `variation-build-args-env.yml`: env-specific build arg `production`.
56. `variation-build-args-env.yml`: env-specific build arg `staging`.

Total implemented entries in flat form: `56`.

## Remaining backlog (requires registry login or registry push flow)

1. Docker registry login + push to GHCR (`push: true`) with immutable SHA tags.
2. Docker registry login + push to Docker Hub with semver tags.
3. Multi-arch push manifest (`linux/amd64`, `linux/arm64`) to registry.
4. Image signing with cosign after push.
5. Remote cache to registry (`cache-to=type=registry`) for faster cold starts.
6. Release workflow that promotes tested image digest from `rc` to `stable` tag.

## Docker fixture variants

Located in `docker/`:

1. `Dockerfile.raw`
2. `Dockerfile.build-action`
3. `Dockerfile.custom-frontend`
4. `Dockerfile.cd-pattern`
5. `Dockerfile.chained`
6. `Dockerfile.split`
7. `Dockerfile.alpine`
8. `Dockerfile.debian`
9. `Dockerfile.multistage`
10. `Dockerfile.distroless`
11. `Dockerfile.nonroot`
12. `Dockerfile.app-context`
13. `Dockerfile.env-args`

## Non-Docker fixture variants

1. `samples/python` for package build (`python -m build`).
2. `samples/ruby` for bundle + rake build.
3. `samples/go` for `go test` + `go build`.

## Run strategy

All workflows use `workflow_dispatch` (manual trigger), local-only image build/test (no registry push), and green-only reference variants.