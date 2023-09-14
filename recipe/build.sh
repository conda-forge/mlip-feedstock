#!/bin/bash

# Build 
./configure --blas=openblas
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
cp make/mlp ${PREFIX}/bin
cp lib/libmlip.a ${PREFIX}/lib/libmlip.a
