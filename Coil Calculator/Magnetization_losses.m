function [ TotalLosses ] = Magnetization_losses( Re,Ri,T,d,Losses,Zm,Rm )
%TOTAL_LOSSES Summary of this function goes here
%   Detailed explanation goes here
dr=(Rm(length(Rm))-Rm(1))./(length(Rm)-1);
dz=(Zm(length(Zm))-Zm(1))./(length(Zm)-1);
TotalLosses=0;
for i=1:length(Zm)
    for j=1:length(Rm)
        if (Rm(j)>Ri)&&(Rm(j)<Re)&&(Zm(i)<d/2+T)&&(Zm(i)>d/2)
            TotalLosses=TotalLosses+Losses(i,j).*Rm(j).*2.*pi.*dr.*dz;
        end
        
    end
end


end

