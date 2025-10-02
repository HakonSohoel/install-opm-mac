#!/bin/bash

brew install boost@1.85
parallel_build_tasks=$(( $(sysctl -n hw.ncpu) + 1 ))

# opm-models/README.md -> THIS MODULE IS DEPRECATED The models module has been integrated into opm-simulators
for repo in opm-common opm-grid opm-simulators opm-upscaling
do
    echo "=== Cloning and building module: $repo"
    git clone https://github.com/OPM/$repo.git
    rm -rf "$repo/.git"
    mkdir $repo/build
    cd $repo/build
    cmake -DCMAKE_PREFIX_PATH="/opt/homebrew/opt/boost@1.85" \
          -Ddune-common_DIR=$(realpath ../../dune-common/build-cmake) \
          -Ddune-grid_DIR=$(realpath ../../dune-grid/build-cmake) \
          -Ddune-geometry_DIR=$(realpath ../../dune-geometry/build-cmake) \
          -Ddune-istl_DIR=$(realpath ../../dune-istl/build-cmake) \
          -DZOLTAN_LIBRARY=$(realpath ../../Trilinos/build/packages/zoltan/src/libzoltan.a) \
          -DZOLTAN_INCLUDE_DIR="$(realpath ../../Trilinos/packages/zoltan/src/include);$(realpath ../../Trilinos/build/packages/zoltan/src)" ..
    # Run Make with verbose output and capture both stdout and stderr
    make -j $parallel_build_tasks VERBOSE=1 2>&1 | tee -a make_output.txt
    cd ../..
done
