# CIRCT Images

Docker images for the CIRCT project

## Docker images

Images and associated scripts and data are stored in subdirectories. Docker
requires that the image definition and any files the definition needs to
`COPY` over are stored in or below its directory. To build locally (for
testing) `cd` into the image directory and run `docker build . -t <tag>`
wherein tag is what you want the image to be called.

## Workflow

The publishing workflow for all the images is in
`.github/workflow/publish_images.yml`. It works by logging into the [GitHub
container
registry](https://docs.github.com/en/free-pro-team@latest/packages/getting-started-with-github-container-registry/about-github-container-registry),
building the Docker image, then pushing that image to the registry. The
password (really a PAT) is stored and exposed to the workflow as an
[Encrypted
secret](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets).
The `CR_PAT` secret is a PAT generated from the `circt-ma` [machine
user](https://developer.github.com/v3/guides/managing-deploy-keys/#machine-users).

## Updating images

The workflow is triggered by a GitHub `release`. So clone the repo, make your
changes, test them locally via a `docker build <image_dir>`, commit & push
your change to the `trunk` branch, then do a
[release](https://docs.github.com/en/free-pro-team@latest/github/administering-a-repository/managing-releases-in-a-repository).

## Using images

Example from CIRCT nightly:

```yml
  build-circt:
    name: Build and Test
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/circt/images/circt-integration-test:v1
```
