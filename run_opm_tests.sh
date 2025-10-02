#!/bin/bash

for repo in opm-common opm-grid opm-simulators opm-upscaling
do
    cd $repo/build
    ctest
    cd ../..
done
