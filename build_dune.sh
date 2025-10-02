#!/bin/bash

# Edit the next two variables to match your wishes and system.
parallel_build_tasks=$(( $(sysctl -n hw.ncpu) + 1 ))

# Set of modules to build
modules="dune-common dune-geometry dune-grid dune-istl"

# Clone modules, check out the 2.10 release.
for m in $modules; do
    echo "==================================================="
    echo "=        Cloning module: $m"
    echo "==================================================="
    (
        if [ ! -d "$m" ]; then
            git clone -b releases/2.10 https://gitlab.dune-project.org/core/$m.git
        else
            echo "******** Skipping $m, module already cloned."
        fi
        if [ -d "$m/.git" ]; then
            rm -rf "$m/.git"
        fi
    )
done

# Build the modules, and install them to the chosen directory
for m in $modules; do
    echo "==================================================="
    echo "=        Building module: $m"
    echo "==================================================="
    (
        cd $m
        builddir="build-cmake"
        if [ ! -d "$builddir" ]; then
            mkdir "$builddir"
            cd "$builddir"
            cmake -DCMAKE_INSTALL_PREFIX=$install_prefix ".."
            make -j $parallel_build_tasks
        else
            echo "******** Skipping $m, build dir $builddir already exists."
        fi
    )
done
