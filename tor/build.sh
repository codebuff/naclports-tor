# # Copyright 2015 The Native Client Authors. All rights reserved.
# # Use of this source code is governed by a BSD-style license that can be
# # found in the LICENSE file.
#
EnableCliMain
EnableGlibcCompat

EXTRA_CONFIGURE_ARGS=" --disable-tool-name-check --disable-system-torrc \
    --disable-gcc-hardening --disable-unittests"

ConfigureStep() {
    EXTRA_CONFIGURE_ARGS+=" --enable-static-tor \
        --enable-static-libevent --with-libevent-dir=${NACL_PREFIX} \
        --enable-static-openssl --with-openssl-dir=${NACL_PREFIX} \
        --enable-static-zlib --with-zlib-dir=${NACL_PREFIX}"
  # building with NDEBUG not allowed
  NACLPORTS_CFLAGS="${NACLPORTS_CFLAGS/-DNDEBUG/}"
  DefaultConfigureStep
}

# PublishStep() {
#   MakeDir ${PUBLISH_DIR}
#   local platform_dir="${PUBLISH_DIR}/_platform_specific/${NACL_ARCH}"
#   MakeDir ${platform_dir}
#   local exe=${PUBLISH_DIR}/_platform_specific/${NACL_ARCH}/tor${NACL_EXEEXT}
#   LogExecute cp ${BUILD_DIR}/src/or/tor${NACL_EXEEXT} ${exe}
#   cd ${PUBLISH_DIR}
#   LogExecute python ${NACL_SDK_ROOT}/tools/create_nmf.py \
#     _platform_specific/*/tor${NACL_EXEEXT} -s . -o tor.nmf
#   InstallNaClTerm ${PUBLISH_DIR}
#   GenerateManifest ${START_DIR}/manifest.json ${PUBLISH_DIR}
#   LogExecute cp ${START_DIR}/krotor_16.png ${PUBLISH_DIR}
#   LogExecute cp ${START_DIR}/krotor_48.png ${PUBLISH_DIR}
#   LogExecute cp ${START_DIR}/krotor_128.png ${PUBLISH_DIR}
#   LogExecute cp ${START_DIR}/background.js ${PUBLISH_DIR}
#   LogExecute cp ${START_DIR}/tor.js ${PUBLISH_DIR}
#   LogExecute cp ${START_DIR}/index.html ${PUBLISH_DIR}
# }
