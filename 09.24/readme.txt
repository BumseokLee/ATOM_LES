#================================================
# Case Summary: Stage 1 to 3 w/o the turbine    #
#================================================

                      Neutral                Convective
domain size :   3200 X 3200 X 1000      4800 X 4800 X 1600
zi          :           700                    1000
Q0          :           0                      0.05
Init dx     :           10                      20
Ref. level  :           3                        4
min dx      :           1.25                   1.25
z0          :           0.1                    0.1
length scale:         17.888 m               24.803 m

# Simulation Stages
- Stage 1: 15,000s
  - w/o mesh refinement
- Stage 2:  5,000s
  - w/ mesh refinement
- Stage 3:  1,800s
  - w/ mesh refinement, data sampling



#================================================
#     Case Summary: Stage 4 w/ the turbine      #
#================================================
- Joukowsky disk turbine, additional mesh refinement, data sampling

# Sampling information with Joukowsky disk
- Periodic BCs in both x and y directions
- Turbine located at about 1/3 of the domain in x direction and center in y direction
- Sampling period 10 mins
- Sampling frequency 10Hz

Convective		
   - Max AMR Level: 6
   	- min cell size: 0.3125m, 11.84 cells / rotor diameter
   - Sampling domain: 100 x 100
	- Sampling x domain: 1574.2 to 1674.2
   	- Sampling y domain: 2350.0 to 2450.0
   - Turbine (Jukowsky disk) at : x=1600, y=2400, z=9.5

Neutral		
   - Max AMR Level: 5
   	- min cell size: 0.3125m, 11.84 cells / rotor diameter
   - Sampling domain: 100 x 100
    	- Sampling x domain: 1074.2 to 1174.2
   	- Sampling y domain: 1550.0 to 1650
   - Turbine (Jukowsky disk) at : x=1100, y=1600, z=9.5

