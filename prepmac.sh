#!/bin/bash -e

GEN='Xcode'

source "${0%/*}/common.sh" "$@"

ARCH=-DCMAKE_OSX_ARCHITECTURES="${CMAKE_OSX_ARCHITECTURES:i386;x86_64}"
export MACOSX_DEPLOYMENT_TARGET=10.8
export MACOSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk

pushd "$BUILDDIR"
cmake -G "$GEN" -DFB_PROJECTS_DIR="${PROJDIR}" ${ARCH} "$@" "${FB_ROOT}"
if [ "$?" -ne 0 ]; then
    echo "CMake failed. Please check error messages"
    popd > /dev/null
    exit
else
    popd
fi
