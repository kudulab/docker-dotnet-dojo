# docker-dotnet-dojo

A [Dojo](https://github.com/ai-traders/dojo) docker image with tools for dotnet development.
Based on `microsoft/dotnet` image. Implements a few conventions from Dojo project,
which provides a quick and repeatable method for building your projects (in docker) without installing anything.

## Specification

There 4 variants of this image. Because mono is still needed in some projects.
* basic (everything) mono and dotnet core. tag: `<version>`
* core only (debian stretch). tag `stretch-<version>`
* core only (ubuntu bionic). tag `bionic-<version>`
* core only (alpine 3.7). tag `alpine3.7-<version>`

This image has installed:
 * dotnet SDK 2.1
 * NuGet CLI
 * Paket installed globally. `5.198.0`
 * Fake installed globally.
 * (only in mono-variant) Mono `5.14.0.177`

## Usage
1. Install [Dojo](https://github.com/ai-traders/dojo). (It's just a script on $PATH)
2. In your project you should have an `Dojofile`
```
DOJO_DRIVER=docker
DOJO_DOCKER_IMAGE="ai-traders/dotnet-dojo:2.0.0"
```
3. Run some build commands:
```bash
dojo paket install
dojo msbuild /t:Publish
```

By default, current directory in docker container is `/dojo/work`,
which is a mount from your current docker host.

You can also enter interactive mode by just running `dojo` in the root of your project.

## Example projects

 * [multi-target dotnet project](https://github.com/ai-traders/spike-core2-mono5) using msbuild
 * [dotnet SDK only project](https://github.com/ai-traders/dotnet-example) using newest paket and fake

# License

MIT
