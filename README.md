# How to install OPM

- Run `install_prerequisites.sh` (Implements steps described for mac here: https://opm-project.org/?page_id=239)

- Run `install_opm.sh`

- Optionally run tests to verify a successful build: `run_opm_tests.sh`

- Make flow available in your terminal by adding “\<path-to-this-directory\>/opm-simulators/build/bin/" to your PATH. 

- Run simulations in parallel using MPI:
    - mpirun -np 4 flow NORNE_ATW2013.DATA --output-dir=out_parallel