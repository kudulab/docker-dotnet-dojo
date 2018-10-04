FROM microsoft/dotnet:2.1.402-sdk-stretch

ENV NUGET_CLI_VERSION=v4.7.1 \
  PAKET_VERSION=5.182.0-alpha001 \
  FAKE_VERSION=5.7.2 \
  MONO_VERSION=5.14.0.177 \
  IDE_VERSION=0.10.3

ENV NODE_VERSION=v8.12.0 NPM_VERSION=6 YARN_VERSION=latest
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  sudo git ca-certificates wget apt-utils locales git unzip nano ssh-client xz-utils
RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
    amd64) ARCH='x64';; \
    ppc64el) ARCH='ppc64le';; \
    s390x) ARCH='s390x';; \
    arm64) ARCH='arm64';; \
    armhf) ARCH='armv7l';; \
    i386) ARCH='x86';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  && curl -SLO "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-$ARCH.tar.xz" \
  && tar -xJf "node-${NODE_VERSION}-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "node-${NODE_VERSION}-linux-$ARCH.tar.xz" \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs
RUN npm -g install yarn
################################################################################
# For ide
################################################################################
RUN git clone --depth 1 -b ${IDE_VERSION} https://github.com/ai-traders/ide.git /tmp/ide_git && \
  /tmp/ide_git/ide_image_scripts/src/install.sh && \
  rm -r /tmp/ide_git && \
  echo 'ide ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

################################################################################
# Above ide
################################################################################

RUN su ide -c 'dotnet tool install fake-cli -g --version ${FAKE_VERSION}'
RUN su ide -c 'dotnet tool install Paket -g --version ${PAKET_VERSION} --add-source https://api.nuget.org/v3/index.json'

# Install common usage apt packages.
# * ssh-client - to run git clone over ssh
# * locale-gen en_US.UTF-8 - so that perl does not complain like: "perl: warning: Setting locale failed."
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF &&\
  locale-gen en_US.UTF-8 && localedef -i en_US -f UTF-8 en_US.UTF-8 && update-locale

RUN mkdir -p /home/ide/.config/NuGet/ /home/ide/.nuget/NuGet
COPY NuGet.Config /home/ide/.nuget/NuGet/NuGet.Config
RUN ln -s /home/ide/.nuget/NuGet/NuGet.Config /home/ide/.config/NuGet/NuGet.Config &&\
  chown ide:ide -R /home/ide/.nuget

# Install mono.
# * libfsharp-core4.3-cil and fsharp must be installed in a separate "apt-get install" run or else it fails
RUN echo "deb http://download.mono-project.com/repo/debian stretch/snapshots/${MONO_VERSION} main" > /etc/apt/sources.list.d/mono-xamarin.list &&\
  apt-get update &&\
  DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends\
  gcc-6-base libgcc1 libstdc++6\
  mono-devel mono-complete ca-certificates-mono mono-vbnc referenceassemblies-pcl mono-complete nunit-console &&\
  DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends\
  libfsharp-core4.3-cil fsharp &&\
  DEBIAN_FRONTEND=noninteractive apt-get -y install graphviz &&\
  apt-get -y autoremove && apt-get -y autoclean && apt-get -y clean &&\
  rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/*

COPY paket.sh /usr/local/bin/paket
RUN wget https://github.com/fsprojects/Paket/releases/download/${PAKET_VERSION}/paket.exe -O /usr/local/bin/paket.exe &&\
  chmod 755 /usr/local/bin/paket

COPY nuget.sh /usr/local/bin/nuget
RUN wget https://dist.nuget.org/win-x86-commandline/${NUGET_CLI_VERSION}/nuget.exe -O /usr/local/bin/nuget.exe &&\
  chmod 755 /usr/local/bin/nuget


# Install bats
RUN git clone --depth 1 https://github.com/sstephenson/bats.git /opt/bats &&\
   git clone --depth 1 https://github.com/ztombol/bats-support.git /opt/bats-support &&\
   git clone --depth 1 https://github.com/ztombol/bats-assert.git /opt/bats-assert &&\
 /opt/bats/install.sh /usr/local

# Warm up image
RUN su ide -c 'mkdir -p /tmp/warmup && cd /tmp/warmup && dotnet new classlib && dotnet restore && dotnet build && rm -rf /tmp/warmup' &&\
 rm -rf /tmp/NuGetScratch
# Disable microsoft spying
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

# For Bash
COPY profile /home/ide/.profile
COPY bashrc_default /home/ide/.bashrc
RUN chown ide:ide -R /home/ide

# Those are light to install and may change often, so they go at the bottom
# of this Dockerfile.
COPY etc_ide.d/scripts/* /etc/ide.d/scripts/

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

ENV this_image_tag=2.1.0 this_image_name=tomzo/dotnet-ide