function [] = plot_Jc( Re,Ri,T,d,mapJc,Zm,Rm)

% This function plots the map of the critical current density

% Inputs: Re: External radius of the coils [m]
%         Ri: Internal radius of the coils [m]
%          T: Length of the coils [m]
%          d: Distance the coils [m]
%      mapJc: Map of the critical current density [A/m^2]
%         Zm: Vector with the z positions corresponding to mapB [m]
%         Rm: Vector with the r positions corresponding to mapB [m]

% Outputs:None

% Written by J. Leclerc Ph.D., University of Houston, Department of 
% Electrical and compute Engineering
%
% Last program modification: 9/20/2017

JctoPlot=[flip(flip(mapJc),2),flip(mapJc);flip(mapJc,2),mapJc];
ZmPlot=[flip(-Zm),Zm];
RmPlot=[flip(-Rm),Rm];
%plot of the module of B
figure(2)
imagesc(ZmPlot,RmPlot,JctoPlot');
set(gca,'Ydir','Normal')
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
title('Map of the critical current density')
ylabel('r (m)')
xlabel('Z (m)')
axis equal tight

end

