#!/bin/bash

# Edit the next two variables to match your wishes and system.
#install_prefix="/Users/FCUR/Trilinos"
install_prefix="/Users/FCUR/duneinstall"
parallel_build_tasks=4

git clone https://github.com/trilinos/Trilinos.git
cd Trilinos
git checkout trilinos-release-12-8-1
mkdir build
(
  cd build
  cmake \
    -D CMAKE_INSTALL_PREFIX=$install_prefix \
    -D TPL_ENABLE_MPI:BOOL=ON \
    -D MPI_BASE_DIR:PATH=/usr/local \
    -D Trilinos_ENABLE_ALL_PACKAGES:BOOL=OFF \
    -D Trilinos_ENABLE_Zoltan:BOOL=ON \
    ../
  make -j $parallel_build_tasks
)
