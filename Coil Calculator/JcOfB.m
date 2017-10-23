function [ Jc ] = JcOfB( Jc0, B0, y, Bpar,Bper  )
%This function calculates the critical current density of a superconducting
%tape for a given perpendicular field Bper and parallel flux density Bpar.
%Jc0 B0 and y are properties of the superconducting tape.

%Jc0[A.m-2]: Critical current density at zero Field 
%B0 [T]: Parameter controling the flux density denpendance of the critical
%current density.
%y []:
%Bpar [T]:
%Bper [T]:

%Jc [A.m-2]: Computed critical current density of the tape.

Jc=Jc0./(1+sqrt(Bpar.*Bpar+y.*y.*Bper.*Bper)./B0);

end

