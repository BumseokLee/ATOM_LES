#!/bin/bash
#SBATCH --job-name=conv
#SBATCH --nodes=40
#SBATCH --account=atom
#SBATCH --time=96:00:00
##SBATCH --reservation=weto-debug
#SBATCH --mail-user=bumseok.lee@nrel.gov
#SBATCH --mail-type=BEGIN,END,FAIL


#======================================================#
module purge
module restore
source /nopt/nrel/apps/cpu_stack/env_cpe23.sh
module load PrgEnv-intel
module load cray-python
module list
#======================================================#
export EXAWIND_MANAGER=/home/bslee/exawind-manager
source ${EXAWIND_MANAGER}/start.sh
spack-start
quick-activate ${EXAWIND_MANAGER}/environments/trans_exa
spack load amr-wind
#======================================================#
export LD_PRELOAD=/nopt/nrel/apps/cray-mpich-stall/libs_mpich_nrel_intel/libmpi_intel.so.12:/nopt/nrel/apps/cray-mpich-stall/libs_mpich_nrel_intel/libmpifort_intel.so.12

export MPICH_VERSION_DISPLAY=1
export MPICH_OFI_CQ_STALL=1
#export MPICH_OFI_CQ_STALL_USECS=3
export MPICH_OFI_CQ_STALL_USECS=16
export MPICH_OFI_CXI_COUNTER_REPORT=2
export MPICH_ENV_DISPLAY=1

BINDW='--cpu_bind=map_cpu:0,52,13,65,26,78,39,91,1,53,14,66,27,79,40,92,2,54,15,67,28,80,41,93,3,55,16,68,29,81,42,94,4,56,17,69,30,82,43,95,5,57,18,70,31,83,44,96,6,58,19,71,32,84,45,97,7,59,20,72,33,85,46,98,8,60,21,73,34,86,47,99,9,61,22,74,35,87,48,100,10,62,23,75,36,88,49,101,11,63,24,76,37,89,50,102,12,64,25,77,38,90,51,103'

export FI_MR_CACHE_MONITOR=memhooks
export MPICH_SMP_SINGLE_COPY_MODE=NONE
export FI_CXI_RX_MATCH_MODE=software
#======================================================#

echo "run"

srun -N40 -n2080 --ntasks-per-node=52 --distribution=block:cyclic $BINDW amr_wind 2_joukowsky.i  &> log.out
