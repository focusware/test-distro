SUMMARY = "Go text processing libraries"
HOMEPAGE = "https://godoc.org/golang.org/x/text"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707 \
                    file://src/${GO_IMPORT}/vendor/golang.org/x/tools/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707"
SRC_URI = "git://github.com/golang/text;name=text \
           git://github.com/golang/tools;name=tools;destsuffix=git/src/${GO_IMPORT}/vendor/golang.org/x/tools"

require golang-x-srcrevs.inc

SRCREV_text ?= "${GOLANG_X_TEXT_SRCREV}"
SRCREV_tools ?= "${GOLANG_X_TOOLS_SRCREV}"
SRCREV_FORMAT = "text+tools"
PV="1.0+git${SRCPV}"

GO_IMPORT = "golang.org/x/text"
CGO_ENABLED = "1"
GOPTESTFLAGS = ""
S = "${WORKDIR}/git"

inherit go

RDEPENDS_${PN}-ptest = "${PN}-dev"
INSANE_SKIP_${PN}-ptest = "dev-deps"
RDEPENDS_${PN}-dev = "bash"
BBCLASSEXTEND = "native nativesdk"
