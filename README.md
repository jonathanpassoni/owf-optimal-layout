# owf-optimal-layout
**Offshore Wind Farm Layout Optimization**

This project aims to obtain the optimal layout of turbines in an offshore wind farm. The optimization problem intends to find the layout which minimizes the percentage of losses in power generation, given a fixed number of turbines, provided as an input. 

The wind farm layout has a great impact on power generation due to the **wake effect**, in which an upstream turbine reduces the wind speed perceived by a downstream turbine.

Developed in MATLAB, the project considered two optimization methods:

* The Genetic Algorithm; and
* The Multiple Objective Particle Swarm Optimization (MOPSO).


This project considered the work in [Optimization of the Wind Turbine Layout and Transmission System Planning for a Large-Scale Offshore WindFarm by AI Technology](https://ieeexplore.ieee.org/document/6607158) and in [Wake effect in wind farm performance: Steady-state and dynamic behavior](https://www.sciencedirect.com/science/article/abs/pii/S0960148111005155).

## Top-level layout
    .
    ├── Optimization - Genetic Algorithm      # All files related to the optimization using GA
    ├── Optimization - MOPSO     # All files related to the optimization using MOPSO
    ├── Isocontour               # All files related to the code implemented to produce wind speed contours
    └── README.md

## The approach considered

The wind farm was designed as a squared matrix, whose elements represent turbines. 

The wind direction is fixed, but the probability distribution of wind speed is considered.

## Input Data

* Air density

* Wind farm parameters:
	* Number of elements of the squared matrix representing the wind farm;
	* Number of turbines;
	* Probability distribution of wind speed in a year for the area considered to receive a wind farm.
	
* Wind Turbine parameters:
	* Rotor diameter;
	* Set of data specifying the Nominal Power(P) and the Rotor Power Coefficient (Cp) for a set of wind speed data;
	
## Output

* The wind farm layout;
* The average efficiency for the resultant wind farm layout.


## Displaying the wake effect on the wind farm layout

This project also includes the code developed to visually display in 2D the wake effect on a wind farm.

Given the same input parameters enunciated above and a wind farm represented by a squared matrix, it produces the wind speed contours.








