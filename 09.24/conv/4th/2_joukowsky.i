#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#            SIMULATION CONTROL         #
#.......................................#
time.stop_time                           = 22400.1  #21800.1     # Max (simulated) time to evolve [s]
time.max_step                            = -1          # Max number of time steps; -1 means termination set by timestamps
time.fixed_dt                            = 0.05        # Use this constant dt if > 0
time.cfl                                 = 0.95         # CFL factor

time.plot_interval                       = 3000       # Steps between plot files
time.checkpoint_interval                 = 3000       # Steps between checkpoint files

#ABL.bndry_file                           = bndry_file.native
#ABL.bndry_io_mode                        = 0          # 0 = write, 1 = read
#ABL.bndry_planes                         = ylo xlo
#ABL.bndry_output_start_time              = 7200.0
#ABL.bndry_var_names                      = velocity temperature tke

incflo.physics                           = ABL Actuator
io.restart_file                          = chk98001
incflo.use_godunov                       = 1
incflo.godunov_type                      = weno_z                 
turbulence.model                         = OneEqKsgsM84  
TKE.source_terms                         = KsgsM84Src
incflo.gravity                           = 0.  0. -9.81  # Gravitational force (3D)
incflo.density                           = 0.958          # Reference density; make sure this agrees with OpenFAST values
transport.viscosity                      = 1.5e-5   # air kinematic viscosity
transport.laminar_prandtl                = 0.7
transport.turbulent_prandtl              = 0.3333

incflo.verbose                           =   0          # incflo_level

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#            GEOMETRY & BCs             #
#.......................................#
geometry.prob_lo                         =    0.     0.     0.  # Lo corner coordinates
geometry.prob_hi                         = 4800.  4800.  1600.  # Hi corner coordinates
amr.n_cell                               =  240    240     80   # Grid cells at coarsest AMRlevel
geometry.is_periodic                     = 1   1   0   # Periodicity x y z (0/1)
incflo.delp                              = 0.  0.  0.  # Prescribed (cyclic) pressure gradient

tagging.labels = static
tagging.static.type = CartBoxRefinement
## static_refinement_def columns: xlo, ylo, zlo, xhi, yhi, zhi
tagging.static.static_refinement_def = static_box.txt
amr.max_level           = 6

#xlo.type                                 = mass_inflow         
#xlo.density                              = 1.225               
#xlo.temperature                          = 290.0               
#xlo.tke                                  = 0.0
#xhi.type                                 = pressure_outflow    

#ylo.type                                 = mass_inflow         
#ylo.density                              = 1.225               
#ylo.temperature                          = 290.0               
#ylo.tke                                  = 0.0
#yhi.type                                 = pressure_outflow     

zlo.type                                 = wall_model
zhi.type                                 = slip_wall
zhi.temperature_type                     = fixed_gradient
zhi.temperature                          = 0.003 # [K/m]

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#               PHYSICS                 #
#.......................................#
ICNS.source_terms                        = BoussinesqBuoyancy CoriolisForcing ABLForcing ActuatorForcing
##--------- Additions by calc_inflow_stats.py ---------#
ABL.wall_shear_stress_type = "local"
#ABL.inflow_outflow_mode = true
#ABL.wf_velocity = XX XX
#ABL.wf_vmag = XX
#ABL.wf_theta = XX
#BodyForce.magnitude = XX XX XX
#BoussinesqBuoyancy.read_temperature_profile = true
#BoussinesqBuoyancy.tprofile_filename = avg_theta.dat
##-----------------------------------------------------#
incflo.velocity                          = 3.0 0.0 0.0  # target velocity
ABLForcing.abl_forcing_height            = 9.5      # Skystream HH / AT met-mast sonic height
CoriolisForcing.latitude                 = 39.91    # approx location of Skystream
CoriolisForcing.north_vector             = 0.0 1.0 0.0
CoriolisForcing.east_vector              = 1.0 0.0 0.0
BoussinesqBuoyancy.reference_temperature = 300   # M2 2-m
ABL.reference_temperature                = 300
ABL.temperature_heights                  =   0.0  1000.0  1100.0  1700.0    # Make sure the top height here goes above the domain height
ABL.temperature_values                   = 300.0   300.0   308.0   309.8    # 8K/100m capping inversion, 3 K/km weak inversion -- should agree with fixed_gradient zhi.temperature
ABL.perturb_temperature                  = true
ABL.cutoff_height                        = 50.0
ABL.perturb_velocity                     = true
ABL.perturb_ref_height                   = 50.0
ABL.Uperiods                             = 4.0
ABL.Vperiods                             = 4.0
ABL.deltaU                               = 1.0
ABL.deltaV                               = 1.0
ABL.kappa                                = 0.40
ABL.surface_roughness_z0                 = 0.1    
ABL.surface_temp_flux                    = 0.025    # Surface temperature flux [K-m/s]

Actuator.labels = Turb1 
Actuator.JoukowskyDisk.rotor_diameter = 3.7
Actuator.JoukowskyDisk.hub_height     = 9.5
Actuator.JoukowskyDisk.yaw            = 270.0
Actuator.JoukowskyDisk.epsilon        = 5.0 5.0 5.0
Actuator.JoukowskyDisk.output_frequency = 500
Actuator.JoukowskyDisk.diameters_to_sample = 2.5
Actuator.JoukowskyDisk.thrust_coeff = 0.1319  0.3004  0.4689  0.5412  0.5763  0.6037  0.6317  0.6509
Actuator.JoukowskyDisk.wind_speed  =  2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0
Actuator.JoukowskyDisk.rpm         =  101. 120. 139. 176. 213. 250. 288. 325.
Actuator.JoukowskyDisk.num_points_r   = 5
Actuator.JoukowskyDisk.num_points_t   = 5

# Turbine 1
Actuator.Turb1.type = JoukowskyDisk 
Actuator.Turb1.base_position  = 1600 2400 0

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#          POST-Processing              #
#.......................................#
##io.output_hdf5_plotfile                  = true  # Uncomment these two lines if save to .hdf instead of plt#####/
##io.hdf5_compression                      = "ZFP_ACCURACY@0.001"
#
##incflo.post_processing                   = sampling # averaging
#
### --- Sampling parameters ---
##sampling.output_frequency                = 1                 
##sampling.fields                          = velocity temperature
##
###---- sample defs ----
##sampling.labels                          = probe1
##
##sampling.probe1.type = ProbeSampler
##sampling.probe1.probe_location_file = "probe_locations.txt"
#
incflo.post_processing  = averaging box_at

box_at.output_format    = netcdf
box_at.output_frequency = 2
box_at.fields           = velocity temperature #tke
box_at.labels           = box1

# High sampling grid spacing = 1.25 m
box_at.box1.type          = PlaneSampler
box_at.box1.num_points    =     81       81
box_at.box1.origin        = 1574.2   2350.0    0.0
box_at.box1.axis1         =  100.0      0.0    0.0
box_at.box1.axis2         =    0.0    100.0    0.0
box_at.box1.offset_vector =    0.0      0.0    1.0
box_at.box1.offsets       =  0.625  1.875  3.125  4.375  5.625  6.875  8.125  9.375  9.5  10.625  11.875  13.125  14.375  15.625 
#box_at.box1.normal       =    0.0      0.0    1.0
 

# --- Sampling parameters ---
box_corr.output_format        = netcdf
box_corr.output_frequency     = 10  # every 0.5s
box_corr.fields               = velocity
#---- sample defs ----
box_corr.labels                = xyplane
box_corr.xyplane.type          = PlaneSampler
box_corr.xyplane.num_points    =     1920      1920   # 2.5m resoluion
box_corr.xyplane.origin        =    0.625     0.625    9.375
box_corr.xyplane.axis1         =   4797.5       0.0      0.0
box_corr.xyplane.axis2         =      0.0    4797.5      0.0
box_corr.xyplane.offset_vector =      0.0       0.0      1.0
box_corr.xyplane.offsets       =      0.0
#box_corr.xyplane.normal       =      0.0       0.0      1.0
#
#
##¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
##              AVERAGING                #
##.......................................#
averaging.type                           = TimeAveraging
averaging.labels                         = means stress

averaging.averaging_window               = 1800.0
averaging.averaging_start_time           = 12000.0

averaging.means.fields                   = velocity
averaging.means.averaging_type           = ReAveraging

averaging.stress.fields                  = velocity
averaging.stress.averaging_type          = ReynoldsStress

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#            MESH REFINEMENT            #
#.......................................#


#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#               TURBINES                #
#.......................................#
