function [ B ] = Field_single_coil(M,Re,Ri,T,Itot )

%This function computes the magnetic field produced by a hollow cylindrical
%coil. Itot is the total current of the coil (current in the wire
%multiplied by the number of turns. The coil is centered in the cylindrical
%coordinate system and orientad along the z-axis. The field is calculated
%by discretising the coil into current loops. The total field is calculated
%by summing the field produced by each loop.

m=50;
n=50;

Rm=M(1);
Zm=M(3);

B_temp=[0,0,0];

for i=1:n
    for j=1:m
        aj=Ri+(Re-Ri)./n.*i-(Re-Ri)./(2.*n);
        Zj=T/m*j-T/(2*m)-T/2;
        if Rm==aj && Zm==Zj
            dB=0;
        
        else
           
            dB=Field_single_loop([Rm,0,Zm-Zj],Itot/(n*m),aj );
        end
        B_temp=dB+B_temp;
       
        
    end
end
B=B_temp;

end

