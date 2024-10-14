#!/bin/bash
#SBATCH --job-name=neu
#SBATCH --nodes=20
#SBATCH --account=atom
#SBATCH --time=72:00:00
####SBATCH --qos=standby
#####SBATCH --reservation=weto-debug
#SBATCH --mail-user=bumseok.lee@nrel.gov
#SBATCH --mail-type=BEGIN,END,FAIL

module purge
module load craype-x86-spr
module load libfabric/1.15.2.0
module load craype-network-ofi
module load perftools-base/22.09.0
module load intel/2023.2.0
module load craype/2.7.17
module load cray-dsmml/0.2.2
module load cray-mpich/8.1.23
module load PrgEnv-intel/8.5.0
module load hdf5/1.14.1-2-cray-mpich-intel
module load netcdf-c/4.9.2-cray-mpich-intel
module load cmake/3.20.2
module load cray-libsci/22.12.1.1

export MPICH_SHARED_MEM_COLL_OPT=mpi_bcast,mpi_barrier
export MPICH_COLL_OPT_OFF=mpi_allreduce

echo "Job ID is " $SLURM_JOBID

#srun -N30 -n1560 --ntasks-per-node=52 --distribution=cyclic:cyclic --cpu_bind=cores amr_wind 0_spinup.i  &> log.out
#srun -N8 -n416 --ntasks-per-node=52 --distribution=cyclic:cyclic --cpu_bind=cores amr_wind 0_spinup.i  &> log.out
srun -N20 -n1920 --ntasks-per-node=96 --distribution=cyclic:cyclic --cpu_bind=cores amr_wind 0_spinup.i  &> log.out
