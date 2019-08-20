Univariate NDF Analysis for MATLAB
Written by Eric Manning
Small Molecule Biophotonics Group
University of Southern California

=============================================================================
INSTRUCTIONS:
=============================================================================
1) Download all the files in the repository into a desired folder. Load MAIN.m into matlab. This is the main script that will be used to run the software. 

2) Hard code in the parameters at the top of main.m. A list and explaination of each input parameter is described below. 

Inputs: 
  data: name of the data set as a .txt or .m file with 2 column vectors containing the x and y data for analysis
  x1: x data as a column vector. Should be an N x 1 array of doubles/floats and the same length as 'y1'.
  y1: y data as a column vector. Should also be an N x 1 array of doubles/floats and the same length as 'x1'. 
  st: step size used in the analysis. Should be a non-negative integer scalar. 
  max_step: maximum desired step of interest to be analyzed. Should be a non-negative integer scalar larger than 'st'. 
  points: number of data points in the x or y data sets. Should be a non-negative integer equal to the length of 'x1' and 'y1'. 
  
3) Run program after the input parameters are hard coded into the main script. The software will ask if anlysis with edge correction is wanted or not. 

4) The NDF vector generated from the analysis will be saved into a vector called 'ndf' in the MATLAB workspace. 
=============================================================================
