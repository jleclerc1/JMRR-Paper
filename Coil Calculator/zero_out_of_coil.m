function [ new_mat ] = zero_out_of_coil(  Re,Ri,T,d,mat,Zm,Rm)
%ZERO_OUT_OF_COIL Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(Zm)
    for j=1:length(Rm)
        if Rm(j)<Ri
            mat(i,j)=0;
        end
        if Rm(j)>Re
            mat(i,j)=0;
        end
        if (Rm(j)<Re && Rm(j)>Ri)
            if Zm(i)<d/2
                mat(i,j)=0;
            end
            if Zm(i)>d/2+T
                mat(i,j)=0;
            end
        end
    end
end

new_mat=mat;


end

