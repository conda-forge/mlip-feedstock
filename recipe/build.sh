#!/bin/bash

if [[ "${mpi}" == "nompi" ]]; then
    CONFIGURE_ARGS="--no-mpi"
    MAKE_ARGS="CC=${CC} CXX=${CXX} FC=${FC}"
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
