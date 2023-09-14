#!/bin/bash

# Build 
./configure --blas=openblas --blas-root=${PREFIX}
make mlp
make libinterface

# Test 
export OMPI_MCA_plm=isolated
export OMPI_MCA_btl_vader_single_copy_mechanism=none
export OMPI_MCA_rmaps_base_oversubscribe=yes
make test

# Install
mkdir -p ${PREFIX}/bin
mkdir -p ${PREFIX}/lib
cp bin/mlp ${PREFIX}/bin
cp lib/lib_mlip_interface.a ${PREFIX}/lib/lib_mlip_interface.a
