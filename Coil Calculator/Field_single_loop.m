function [ B ] = Field_single_loop( M,I,a )

%This function computes the magnetic field produced by a single current
%loop in a cylindrical system. The calculation uses equations presented in
%:Simple Analytic Expressions for the Magnetic Field of a Circular Current
%Loop, Simpson, James C.; Lane, John E.; Immer, Christopher D.; Youngquist,
%Robert C, NASA/TM-2013-21791.

%a: radius of the current loop [m]
%I: Current in the circular loop [A]
%M: Vector containing the coordinates (r,theta,z) of the calculation point in the
%cylindrical system. ([m],[rad],[m])

%B: Magnetic flux density vector (Br,Btheta,Bz) in the cylindrical coordinate system [T].

mu0=4*pi()*1e-7; %vacuum permeability 

R=M(1); %radius position of the calculation point
Z=M(3); %Z position of the calculation points

%//////////////////////////////////////////////////////////
%////// Here starts the calculation of the magnetic field using the
%equations of the paper.
k=(4.*a.*R)./((a+R).*(a+R)+Z.*Z);
[I1,I2] = ellipke(k);
Br=((mu0.*I)./(2.*pi.*R)).*(Z./(sqrt((a+R).*(a+R)+Z.*Z))).*(-I1+((a.*a+R.*R+Z.*Z)./((a-R).*(a-R)+Z.*Z)).*I2);
Bz=((mu0.*I)./(2.*pi)).*(1./(sqrt((a+R).*(a+R)+Z.*Z))).*(I1+((a.*a-R.*R-Z.*Z)./((a-R).*(a-R)+Z.*Z)).*I2);
%End of the calculation of the magnetic field using the equations of the paper.
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

%There is cases where the result is NAN
%    at a=r and z=0: This point has no physical sens since the considered
%    wire is of infinitly small diameter
%    at r=0: The equations for Br returns NAN but the result is 0

%The following fix this problem:
% if isnan(Br)
%     Br=0;
% end
% if isnan(Bz)
%     Bz=0;
% end

if R==0
    Br=0;
end

if abs(a-R)<(a./100) && abs(Z)<(a./100)
    Br=0;
    Bz=0;
end

%return the result
B=[Br,0,Bz];
end

