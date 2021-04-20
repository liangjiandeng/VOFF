%%%%===================================================
%%%% This is the demo code for 
%%%% "VO+Net: An Adaptive Approach Using Variational 
%%%%  Optimization and Deep Learning for Panchromatic Sharpening"
%%%% by Z.-C. Wu, T.-Z. Huang, L.-J. Deng, J.-F. Hu and G. Vivone.

% Reference:
%           [WU2021VONet]    Z.-C. Wu, T.-Z. Huang, L.-J. Deng, J.-F. Hu and G. Vivone, VO+Net: An Adaptive Approach 
 %             Using Variational Optimization and Deep Learning for Panchromatic Sharpening, IEEE TGRS, 2021.

%% 
clc;
clear;
close all;
addpath(genpath(pwd));


%% Load data which type is double precision and the range is [0 1]
load 'Pleiades_Test_256.mat'
Ref_I_GT   = gt;
I_LRMS = lrms;
I_PAN  = pan;
X_net   = output;
clear gt lrms pan output;
%% Define the type of sensor
sensor = 'none';        % 'WV3'and 'WV2'etc.

%%
%%  Initialization
[~,~,L]  = size(I_LRMS);
sz          = size(I_PAN);
Nways   = [sz, L];
opts = [];
opts.lambda = 0.0013;
opts.alpha    = 0.0;
opts.eta_1    = 0.04;
opts.eta_2    = 0.03;
opts.ratio     = 4;
opts.Nways  = Nways;
opts.sz     = sz;
opts.tol    = 2*1e-5;   
opts.maxit  = 200;
opts.sensor = sensor;
%% Return the priors to the fusing framwwork
disp('---------------------------------------Begin the Fusion algorithm---------------------------------------')
t0 = tic; 
[X_fin]    =  Fusion_VOFF_ada(I_LRMS, I_PAN, X_net, opts);
time = toc(t0);
fprintf('Time the algorithm is running:  %.2f seconds \n',time)
disp('-------------------------------------End of the Fusion algorithm run-------------------------------------')%% 

%% Plotting
close all
location = [65 85 5 25];

showRGB4(Ref_I_GT, Ref_I_GT, location);title('Orginal RGB');

showRGB4(Ref_I_GT, X_fin, location);title('Fusion by VOFF (RGB)');
%##########################################################