#!/bin/bash

# Edit the next two variables to match your wishes and system.
parallel_build_tasks=$(( $(sysctl -n hw.ncpu) + 1 ))

git clone -b trilinos-release-12-8-1 https://github.com/trilinos/Trilinos.git
rm -rf Trilinos/.git
cd Trilinos

mkdir build
(
  cd build
  cmake \
    -DTPL_ENABLE_MPI:BOOL=ON \
    -DMPI_BASE_DIR:PATH=/usr/local \
    -DTrilinos_ENABLE_ALL_PACKAGES:BOOL=OFF \
    -DTrilinos_ENABLE_Zoltan:BOOL=ON \
    ../
  make -j $parallel_build_tasks
)
