function [Breturn,Zm,Rm] = mapB( Re,Ri,T,d,Je,Zmax,Rmax,nb_pts_z,nb_pts_r )

% This function calculates the map of the flux density

% Inputs:          Re: External radius of the coils [m]
%                  Ri: Internal radius of the coils [m]
%                   T: Length of the coils [m]
%                   d: distance the coils [m]
%                  Je: Average current density inside the coil cross-section [A/m^2]
%                Zmax: Maximum z position for the calculation [m]
%                Rmax: Maximum R position for the calculation [m]
%                nb_pts_z: Number of calculation points on the z axis
%                nb_pts_r: Number of calculation points on the r axis

% Outputs:    Breturn: (k,l,3) matrix with the map of the flux density [T]
%                      (:,:,1): morm of B [T]
%                      (:,:,2): radial component of B [T]
%                      (:,:,3): axial component of B [T]
%             Zm: Vector with the z positions corresponding to mapB [m]
%             Rm: Vector with the r positions corresponding to mapB [m]

% Written by J. Leclerc Ph.D., University of Houston, Department of 
% Electrical and compute Engineering
%
% Last program modification: 9/20/2017

Zm=linspace(0,Zmax,nb_pts_z);
Rmin=Rmax./1E9; %Impossible to compute at r=0
Rm=linspace(Rmin,Rmax,nb_pts_r);

Bz=zeros(nb_pts_z,nb_pts_r);
Br=zeros(nb_pts_z,nb_pts_r);
magB=zeros(nb_pts_z,nb_pts_r);
h = waitbar(0,'Computing Magnetic Field...');
for i=1:length(Zm)
    Progress=i/nb_pts_z;
    waitbar(Progress)
    for j=1:length(Rm)
        M=[Rm(j),0,Zm(i)];
     
        B=Field_two_coils( M,Re,Ri,T,d,Je.*(Re-Ri).*T,Je.*(Re-Ri).*T);
        Bz(i,j)=B(3);
        Br(i,j)=B(1);
        magB(i,j)=sqrt(Bz(i,j).*Bz(i,j)+Br(i,j).*Br(i,j));
    end
end
close(h)
Breturn_temp=zeros(nb_pts_z,nb_pts_r,3);
Breturn_temp(:,:,1)=magB;
Breturn_temp(:,:,2)=Br;
Breturn_temp(:,:,3)=Bz;
Breturn=Breturn_temp;
end