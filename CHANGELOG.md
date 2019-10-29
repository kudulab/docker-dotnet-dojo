### 3.1.4 (2019-Oct-18)

* Paket 5.226.0
* use Dojo scripts from Dojo 0.6.3
* add task build_one_local, which can be invoked locally
* newer base image sdk 2.2.402
* Fake 5.18.2

### 3.1.3 (2019-Jun-09)
Update pipeline, vault setup

### 3.1.2 (2019-May-01)

* use Dojo scripts from Dojo 0.4.3 so that this directory is set up: `/run/user/<ID>`;
 add test

### 3.1.1 (2019-Apr-29)

* use Dojo scripts from Dojo 0.4.1 so that this directory is set up: `/run/user/<ID>`

### 3.1.0 (2019-Apr-27)

 * use dockerhub to as temporary and final registry
 * use new operations scripts from kudulab
 * drop oversion
 * change license to Apache

### 3.0.0 (2019-Mar-09)

* port from an Ide docker image: https://github.com/ai-traders/docker-dotnet-ide
 to Dojo docker image
* do not set docker build args: this_image_tag_arg and this_image_name_arg
* bump paket to 5.198.0

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
