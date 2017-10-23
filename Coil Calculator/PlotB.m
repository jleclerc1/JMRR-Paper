function [] = PlotB( Re,Ri,T,d,mapB,Zm,Rm)

% This function plots the magnetic flux density

% Inputs: Re: External radius of the coils [m]
%         Ri: Internal radius of the coils [m]
%          T: Length of the coils [m]
%          d: distance the coils [m]
%       mapB: (k,l,3) matrix with the map of the flux density [T]
%             (:,:,1): morm of B [T]
%             (:,:,2): radial component of B [T]
%             (:,:,3): axial component of B [T]
%         Zm: Vector with the z positions corresponding to mapB [m]
%         Rm: Vector with the r positions corresponding to mapB [m]

% Outputs:None

% Written by J. Leclerc Ph.D., University of Houston, Department of 
% Electrical and compute Engineering
%
% Last program modification: 9/20/2017

magB=mapB(:,:,1);

BtoPlot=[flip(flip(magB),2),flip(magB);flip(magB,2),magB];
ZmPlot=[flip(-Zm),Zm];
RmPlot=[flip(-Rm),Rm];
%plot of the module of B
figure(1)
imagesc(ZmPlot,RmPlot,BtoPlot');
set(gca,'Ydir','Normal')
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
title('Module of B')
ylabel('r (m)')
xlabel('Z (m)')
axis equal tight

end

