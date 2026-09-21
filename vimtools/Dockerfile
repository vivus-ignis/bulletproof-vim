FROM ubuntu:16.04 AS builder

ENV BDIR="/opt/vimtools/bin"
ENV TDIR="/opt/vimtools/tmp"

ENV BUILDER_NAME="vivus-ignis"
ENV BUILDER_EMAIL="theartoftheterminal@gmail.com"

RUN mkdir -p ${BDIR}
RUN apt-get update && apt-get install -y make unzip wget build-essential clang

WORKDIR ${TDIR}

# -- go --
ENV GOLANG_VERSION="1.26.4"

RUN wget --quiet https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz
RUN tar xzf go${GOLANG_VERSION}.linux-amd64.tar.gz

# -- pyoxidizer --
ENV PYOXIDIZER_VERSION="0.24.0"

RUN wget --quiet https://github.com/indygreg/PyOxidizer/releases/download/pyoxidizer%2F${PYOXIDIZER_VERSION}/pyoxidizer-${PYOXIDIZER_VERSION}-x86_64-unknown-linux-musl.tar.gz
RUN tar xzf pyoxidizer-${PYOXIDIZER_VERSION}-x86_64-unknown-linux-musl.tar.gz
RUN chmod +x pyoxidizer-${PYOXIDIZER_VERSION}-x86_64-unknown-linux-musl/pyoxidizer
RUN mv pyoxidizer-${PYOXIDIZER_VERSION}-x86_64-unknown-linux-musl/pyoxidizer /usr/bin/

# -- checkmake --
# https://github.com/checkmake/checkmake
ENV CHECKMAKE_VERSION="0.3.2"

RUN wget --quiet https://github.com/checkmake/checkmake/archive/refs/tags/v${CHECKMAKE_VERSION}.tar.gz
RUN tar xzf v${CHECKMAKE_VERSION}.tar.gz
WORKDIR ${TDIR}/checkmake-${CHECKMAKE_VERSION}
RUN BUILDER_NAME=${BUILDER_NAME} BUILDER_EMAIL=${BUILDER_EMAIL} PATH=${TDIR}/go/bin:$PATH make checkmake
RUN chmod +x checkmake
RUN mv checkmake ${BDIR}/

WORKDIR ${TDIR}

# -- shellcheck --
# https://github.com/koalaman/shellcheck
ENV SHELLCHECK_VERSION="0.11.0"

RUN wget --quiet https://github.com/koalaman/shellcheck/releases/download/v${SHELLCHECK_VERSION}/shellcheck-v${SHELLCHECK_VERSION}.linux.x86_64.tar.gz
RUN tar xzf shellcheck-v${SHELLCHECK_VERSION}.linux.x86_64.tar.gz
RUN chmod +x shellcheck-v${SHELLCHECK_VERSION}/shellcheck
RUN mv shellcheck-v${SHELLCHECK_VERSION}/shellcheck ${BDIR}/

# -- shfmt --
# https://github.com/patrickvane/shfmt
RUN wget https://github.com/patrickvane/shfmt/releases/download/master/shfmt_linux_amd64
RUN chmod +x shfmt_linux_amd64
RUN mv shfmt_linux_amd64 ${BDIR}/shfmt

# -- yamllint --
# https://github.com/adrienverge/yamllint
ENV YAMLFMT_VERSION="0.21.0"
RUN mkdir yamllint
WORKDIR ${TDIR}/yamllint
COPY yamllint-pyoxidizer.bzl pyoxidizer.bzl
RUN pyoxidizer build --release
RUN chmod +x ./build/x86_64-unknown-linux-gnu/release/install/yamllint
RUN mv ./build/x86_64-unknown-linux-gnu/release/install/yamllint ${BDIR}/

WORKDIR ${TDIR}

# -- yamlfmt --
# https://github.com/google/yamlfmt/
RUN wget --quiet https://github.com/google/yamlfmt/releases/download/v${YAMLFMT_VERSION}/yamlfmt_${YAMLFMT_VERSION}_Linux_arm64.tar.gz
RUN tar xzf yamlfmt_*.tar.gz
RUN chmod +x yamlfmt
RUN mv yamlfmt ${BDIR}/

# -- tflint --
# https://github.com/terraform-linters/tflint
ENV TFLINT_VERSION="0.64.0"

RUN wget https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip
RUN unzip tflint_linux_amd64.zip
RUN chmod +x tflint
RUN mv tflint ${BDIR}/

# -- checkov --
# https://github.com/bridgecrewio/checkov
ENV CHECKOV_VERSION="3.3.6"

RUN mkdir checkov
WORKDIR ${TDIR}/checkov
COPY checkov-pyoxidizer.bzl pyoxidizer.bzl
RUN pyoxidizer build --release
RUN chmod +x ./build/x86_64-unknown-linux-gnu/release/install/checkov
RUN mv ./build/x86_64-unknown-linux-gnu/release/install/checkov ${BDIR}/

WORKDIR ${TDIR}

# -- dprint --
# https://github.com/dprint/dprint
ENV DPRINT_VERSION="0.55.1"

RUN wget https://github.com/dprint/dprint/releases/download/${DPRINT_VERSION}/dprint-x86_64-unknown-linux-gnu.zip
RUN unzip dprint-x86_64-unknown-linux-gnu.zip
RUN chmod +x dprint
RUN mv dprint ${BDIR}/

# -- nagelfar --
# https://nagelfar.sourceforge.net
ENV NAGELFAR_VERSION="135"

RUN wget https://downloads.sourceforge.net/project/nagelfar/Rel_${NAGELFAR_VERSION}/nagelfar${NAGELFAR_VERSION}.linux.gz
RUN gunzip nagelfar${NAGELFAR_VERSION}.linux.gz
RUN chmod +x nagelfar${NAGELFAR_VERSION}.linux
RUN mv nagelfar${NAGELFAR_VERSION}.linux ${BDIR}/nagelfar

# -- jq --
# https://github.com/jqlang/jq
ENV JQ_VERSION="1.8.2"

RUN wget https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}/jq-linux-amd64
RUN chmod +x jq-linux-amd64
RUN mv jq-linux-amd64 ${BDIR}/jq

# -- biome --
# https://github.com/biomejs/biome
ENV BIOME_VERSION="2.5.14"

RUN wget https://github.com/biomejs/biome/releases/download/%40biomejs%2Fbiome%40${BIOME_VERSION}/biome-linux-x64-musl
RUN chmod +x biome-linux-x64-musl
RUN mv biome-linux-x64-musl ${BDIR}/biome

WORKDIR ${BDIR}

FROM scratch
ENV BDIR="/opt/vimtools/bin"
COPY --from=builder ${BDIR} .
