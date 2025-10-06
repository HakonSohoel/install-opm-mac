#!/bin/bash

uv tool install cmake==3.29.6
brew install boost suite-sparse
brew install open-mpi

./build_dune.sh
./install_zoltan.sh