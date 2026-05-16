#!/bin/bash

if [[ "${mpi}" == "nompi" ]]; then
    CONFIGURE_ARGS="--no-mpi"
    MAKE_ARGS="CC=${CC} CXX=${CXX} FC=${FC}"
fi

if [[ "$(uname)" = Darwin ]]; then
  export CFLAGS="${CFLAGS//-march=core2/}"
  export CFLAGS="${CFLAGS//-mtune=haswell/}"
  export CFLAGS="${CFLAGS//-mssse3/}"
  export CFLAGS="${CFLAGS//-ftree-vectorize/}"
  export CFLAGS="${CFLAGS} -O0"
  export CFLAGS="${CFLAGS} -fno-strict-aliasing"
  export CFLAGS="${CFLAGS} -fno-vectorize -fno-slp-vectorize"

  export CXXFLAGS="${CXXFLAGS//-march=core2/}"
  export CXXFLAGS="${CXXFLAGS//-mtune=haswell/}"
  export CXXFLAGS="${CXXFLAGS//-mssse3/}"
  export CXXFLAGS="${CXXFLAGS//-ftree-vectorize/}"
  export CXXFLAGS="${CXXFLAGS} -O0"
  export CXXFLAGS="${CXXFLAGS} -fno-strict-aliasing"
  export CXXFLAGS="${CXXFLAGS} -fno-vectorize -fno-slp-vectorize"
fi

# Build 
./configure --blas=openblas --blas-root=${PREFIX} ${CONFIGURE_ARGS}
make mlp ${MAKE_ARGS}
make libinterface ${MAKE_ARGS}

# Test 
make test ${MAKE_ARGS}

# Install
mkdir -p ${PREFIX}/bin
mkdir -p ${PREFIX}/lib
cp bin/mlp ${PREFIX}/bin
cp lib/lib_mlip_interface.a ${PREFIX}/lib/lib_mlip_interface.a
