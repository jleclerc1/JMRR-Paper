function [ B ] = Field_two_coils( M,Re,Ri,T,d,Itot1,Itot2 )

%This function computes the magnetic field produced by two hollow cylindrical
%coil. Itot1 and Itot2 are the total current of the coil 1 and 2 respectively (current in the wire
%multiplied by the number of turns). The coils are oriented toward the same axis. 
%Their axis is colinear to the axis z of a cylindrical coordinate system. The point at z=0
%is situated in the middle of the two coils. Each coil produce a positive Bz on the z axis 
% when a positive current circulates inside it. Coil1 is placed in the positive z, coil 2 in the negative x.
%The total field is calculated
%by summing the field produced by each coil.
%M: coordinates of the calculation point 
%d: distance between the two coils

%field produced by coil 1
B1=Field_single_coil([M(1),M(2),M(3)-d/2-T/2],Re,Ri,T,Itot1 );

%field produced by coil 2
B2=Field_single_coil([M(1),M(2),M(3)+(d/2)],Re,Ri,T,Itot2 );

%Total field

B=B1+B2;






end

