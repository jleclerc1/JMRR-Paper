function [Wreturn,Zm,Rm] = mapLosses( mapB,mapJc,Zm,Rm,y,J )

% This function calculates the map of AC magnetization Losses

% Inputs:          
%       mapB: (k,l,3) matrix with the map of the flux density [T]
%             (:,:,1): morm of B [T]
%             (:,:,2): radial component of B [T]
%             (:,:,3): axial component of B [T]
%               mapJc: matrix with the map of critical current density [A/m^2]
%                  Zm: Vector with the z positions corresponding to mapB [m]
%                  Rm: Vector with the r positions corresponding to mapB [m]
%                   k: Parameter characterizing the anisotropy of the superconductor [no unit]
%                   J: Current density inside the superconducting wire [A/m^2]

% Outputs:    Wreturn: matrix with the map of the losses density [J.m^-3.cycle^-1]
%                  Zm: Vector with the z positions corresponding to mapJc [m]
%                  Rm: Vector with the r positions corresponding to mapJc [m]

% Written by J. Leclerc Ph.D., University of Houston, Department of 
% Electrical and compute Engineering
%
% Last program modification: 9/20/2017

magB=mapB(:,:,1);
Br=mapB(:,:,2);
Bz=mapB(:,:,3);

Losses=zeros(length(Zm),length(Rm));
J_Jc=zeros(length(Zm),length(Rm));

for i=1:length(Zm)
    for j=1:length(Rm)
        alfa=atan(Br(i,j)/Bz(i,j));
        J_Jc(i,j)=J/mapJc(i,j);
        Bp=4*pi*1e-7*0.00005*mapJc(i,j);
        
        Losses(i,j)=(2.*(Bp).*(Bp))/(3.*4.*pi.*1e-7)*((magB(i,j)./Bp).*(3+J_Jc(i,j).^2)-2.*(1-(J_Jc(i,j)).^3)+6.*(J_Jc(i,j).^2).*(((1-J_Jc(i,j)).^2)./((magB(i,j)./Bp)-J_Jc(i,j)))-4.*(J_Jc(i,j).^2).*(((1-J_Jc(i,j)).^3)./(((magB(i,j)./Bp)-J_Jc(i,j)).^2)));             
        W_alfa(i,j)=Losses(i,j).*sqrt((y.*y.*sin(alfa).*sin(alfa)+cos(alfa).*cos(alfa)));
    end
end
Wreturn=W_alfa;
end

