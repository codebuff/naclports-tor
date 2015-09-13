# Copyright 2015 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# following flag are needed only if you want to run samples in devenv
NACLPORTS_CPPFLAGS+=" -Dmain=nacl_main"
export LIBS="${NACL_CLI_MAIN_LIB}"

ConfigureStep() {
  if [ "${NACL_LIBC}" = "newlib" ]; then
    NACLPORTS_CPPFLAGS+=" -I${NACLPORTS_INCLUDE}/glibc-compat"
    export LIBS+=" -lglibc-compat"
    # setitimer and getitimer not available in newlib, no plan to implement them
    #TODO(dt) remove this flag once this issue is sorted.
    EXTRA_CONFIGURE_ARGS+=" --disable-libevent-regress"
  fi
  DefaultConfigureStep
}
