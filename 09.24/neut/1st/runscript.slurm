#!/bin/bash
#SBATCH --job-name=neutral
#SBATCH --nodes=4
#SBATCH --account=atom
#SBATCH --time=48:00:00
##SBATCH --mail-user=bumseok.lee@nrel.gov
##SBATCH --mail-type=BEGIN,END,FAIL

export SPACK_MANAGER=/home/bslee/ExaWind/spack-manager
source /home/bslee/ExaWind/spack-manager/start.sh
spack-start
quick-activate /home/bslee/ExaWind/spack-manager/environments/sviv
spack load exawind

srun -n 144 amr_wind 0_spinup.i &> log.out
