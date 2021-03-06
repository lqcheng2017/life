function S = feComputeSignal(S0, bvecs, bvals, Q)
% Compute expected diffusion signal from a collection of tensors
%
%  S = feComputeSignal(S0, bvals, bvecs, Q)
%
% This function implements the Stejskal Tanner equation prediction given a
% quadratic form.
%
% See: http://en.wikipedia.org/wiki/Diffusion_MRI#Diffusion_imaging
%
% INPUTS
%   S0    - The signal measured in the non-diffusion weighted scans (B0)  
%   bvals - the b values
%   bvecs - the b vectors
%   Q     - The tensors (quadratic forms) corresponding to each node in a
%           voxel. Each row is a tensor from some node. So if there are M
%           nodes then Q is M x 9.
%
% OUTPUTS
%   S     - The signal predicted according to this form of the Stejskal/Tanner eq: 
% 
%         S = S0 exp(-bval*(bvec*Q*bvec))
%
%   So if there are 30 directions and 4 tensors, the returned signals is 30 x 4.
%
% Example:
%
% Copyright (2013-2014), Franco Pestilli, Stanford University, pestillifranco@gmail.com.

% Converts the tensors and bvecs into ADC values.  If there are 80
% directions and 4 tensors, the returned ADC is 80 x 4, with each column
% representing the ADCs in all directions for one of the tensors.
% ADC = dtiADC(Q, bvecs);
%
% We have a bval for each ADC:     S = S0 * exp(-bvals .* ADC);
%
% We repmat the bvals to have the same number of rows as Q.  Each row is a
% tensor.  But bvals will have nDirs x nTensors after the repmat.
% S = S0 * exp(- (repmat(bvals, 1, size(Q,1)) .* ADC));
%
S = S0 * exp(- (repmat(bvals, 1, size(Q,1)) .* dtiADC(Q, bvecs)));

% Plot the S values as a function of direction
% p = diag(S)*bvecs;
% mrvNewGraphWin; plot3(p(:,1),p(:,2),p(:,3),'o')

end
