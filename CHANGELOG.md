* port from an Ide docker image: https://github.com/ai-traders/docker-dotnet-ide
 to Dojo docker image
* do not set docker build args: this_image_tag_arg and this_image_name_arg

### 2.1.0 (2018-Oct-04)

 * added node.js and yarn for typescript support
 * fixed imagerc publish dir
 * fix ssh setup, keys are not required

### 2.0.0 (2018-Sep-29)

First open source release based on `mono-ide:2.0.1`.
 * update paket to `5.182.0-alpha001` so that it can run without mono
 * install fake globally so that it can run globally version `5.7.2`

Split into 4 variants of the image:
* basic (everything) mono and dotnet core. tag: `<version>`
* core only (debian stretch). tag `stretch-<version>`
* core only (ubuntu bionic). tag `bionic-<version>`
* core only (alpine 3.7). tag `alpine3.7-<version>`

Upgraded to dotnet core 2.1

Mono update to `5.14.0.177`
