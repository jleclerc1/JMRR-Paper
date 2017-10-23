function [mapJc,Zm,Rm] = mapJc( mapB,Zm,Rm,Jc0,B0,k )

% This function calculates the map of critical current density

% Inputs:          
%       mapB: (k,l,3) matrix with the map of the flux density [T]
%             (:,:,1): morm of B [T]
%             (:,:,2): radial component of B [T]
%             (:,:,3): axial component of B [T]
%                  Zm: Vector with the z positions corresponding to mapB [m]
%                  Rm: Vector with the r positions corresponding to mapB [m]
%          Jc0, B0, k: Parameters of the current density field
%                      dependance of the critical current density

% Outputs:      mapJc: matrix with the map of critical current density [A/m^2]
%                  Zm: Vector with the z positions corresponding to mapJc [m]
%                  Rm: Vector with the r positions corresponding to mapJc [m]

% Written by J. Leclerc Ph.D., University of Houston, Department of 
% Electrical and compute Engineering
%
% Last program modification: 9/20/2017

Br=mapB(:,:,2);
Bz=mapB(:,:,3);

Jc=zeros(length(Zm),length(Rm));

for i=1:length(Zm)
    for j=1:length(Rm)
        Jc(i,j)=JcOfB( Jc0, B0, k, Bz(i,j),Br(i,j));
    end
end
mapJc=Jc;
end

