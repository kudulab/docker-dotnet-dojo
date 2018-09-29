# docker-dotnet-ide

An [IDE](https://github.com/ai-traders/ide) docker image with tools for dotnet development.
Based on `microsoft/dotnet` image. Implements a few conventions from IDE project,
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
 * Paket installed globally. `5.182.0-alpha001`
 * Fake installed globally.
 * (only in mono-variant) Mono `5.14.0.177`

## Usage
1. Install [IDE](https://github.com/ai-traders/ide). (It's just a script on $PATH)
2. In your project you should have an `Idefile`
```
IDE_DRIVER=docker
IDE_DOCKER_IMAGE="tomzo/dotnet-ide:2.0.0"
```
3. Run some build commands:
```bash
ide paket install
ide msbuild /t:Publish
```

By default, current directory in docker container is `/ide/work`,
which is a mount from your current docker host.

You can also enter interactive mode by just running `ide` in the root of your project.

## Example projects

 * [multi-target dotnet project](https://github.com/ai-traders/spike-core2-mono5) using msbuild
 * [dotnet SDK only project](https://github.com/ai-traders/dotnet-example) using newest paket and fake

# License

MIT
