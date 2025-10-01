# How to install OPM

- Install Prerequisites: https://opm-project.org/?page_id=239
    - Run `build_dune.sh`
    - Run `install_zoltan.sh`

- Run `install_opm.sh`

- Run simulations in parallel using MPI:
    - mpirun -np 4 flow NORNE_ATW2013.DATA --output-dir=out_parallel