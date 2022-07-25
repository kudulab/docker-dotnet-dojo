# docker-dotnet-dojo

A [Dojo](https://github.com/kudulab/dojo) docker image with tools **for dotnet development**.

Based on `mcr.microsoft.com/dotnet/sdk` image. Implements a few conventions from Dojo project, which provides a quick and repeatable method for building your projects (in docker) without installing anything.

## Specification - what is included

* .NET 6.0 (with the `dotnet` CLI command)
* Paket installed globally
* Fake installed globally
* Node.js, npm, yarn for typescript support and building web UIs
* Bats for testing

The image is published on [Docker Hub](https://hub.docker.com/r/kudulab/dotnet-dojo).

## Usage
1. Set up the prerequisites: Docker and Bash
2. Install [Dojo](https://github.com/kudulab/dojo#installation)
3. In the root directory of your project create a file called `Dojofile`
```
DOJO_DRIVER=docker
DOJO_DOCKER_IMAGE="kudulab/dotnet-dojo:debian-${version}"
# or if you prefer alpine instead of debian:
# DOJO_DOCKER_IMAGE="kudulab/dotnet-dojo:alpine-${version}"
```
4. Create and enter the container by running `dojo` in the same directory as `Dojofile`
5. Run some example commands
```bash
dotnet build
dotnet test
paket install
msbuild /t:Publish
```

By default, current directory in docker container is `/dojo/work`,
which is a mount from your current directory of the docker host.

## Example projects

* [official dotnet samples](https://github.com/dotnet/dotnet-docker/)
* [dotnet SDK only project](https://github.com/ai-traders/dotnet-example) using paket and fake
* [multi-target dotnet project](https://github.com/ai-traders/spike-core2-mono5) using msbuild

## Contributing
Instructions how to update this project.

1. Create a new feature branch from the main branch
1. Work on your changes in that feature branch. If you want, describe you changes in [CHANGELOG.md](CHANGELOG.md)
1. Build your image locally to check that it succeeds: `./tasks build debian` and `./tasks build alpine`
1. Test your image locally: `./tasks itest debian` and `./tasks itest alpine`. You may need to install the test framework - you can do it  by following the same commands as in the Dockerfile of this project.
1. If you are happy with the results, create a PR from your feature branch to master branch

After this, someone will read your PR, merge it and ensure version bump (using `./tasks set_version`). CI pipeline will run to automatically build and test docker image, release the project and publish the docker image.

## License

Copyright 2019-2022 Ava Czechowska, Tom Setkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
