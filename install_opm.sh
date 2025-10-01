#!/bin/bash
for repo in opm-common opm-grid opm-models opm-simulators opm-upscaling
do
    echo "=== Cloning and building module: $repo"
    git clone https://github.com/OPM/$repo.git
    mkdir $repo/build
    cd $repo/build
    cmake -DCMAKE_PREFIX_PATH="/Users/FCUR/duneinstall;/Users/FCUR/dune-common/build-cmake;/Users/FCUR/dune-grid/build-cmake;/Users/FCUR/dune-geometry/build-cmake;/Users/FCUR/dune-istl/build-cmake;" \
          -DZOLTAN_LIBRARY="/Users/FCUR/Trilinos/build/packages/zoltan/src/libzoltan.a" \
          -DZOLTAN_INCLUDE_DIR="/Users/FCUR/Trilinos/packages/zoltan/src/include;/Users/FCUR/Trilinos/build/packages/zoltan/src" ..
    # Run Make with verbose output and capture both stdout and stderr
    make -j 7 VERBOSE=1 2>&1 | tee -a make_output.txt
    cd ../..
done
