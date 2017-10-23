function [ Jcc] = JccSearch( Re,Ri,T,d,Jc0,B0,k,FF,JccInit,Resolution_Z,Resolution_R)
%JCSEARCH Summary of this function goes here
%   Detailed explanation goes here
TolSearch=1000000;
global min_error
min_error=1;
hJcc = waitbar(0,'Computing Jcc...','position',[400 300 280 50]);
options = optimset('Maxiter',30,'TolFun', TolSearch.*TolSearch,'TolX', TolSearch,'Display','iter');
fun = @(x)Distance_From_Jc(x,Resolution_Z,Resolution_R,Jc0,B0,k,Re,Ri,T,d,FF);
x0 = [JccInit];
Jcc = fminsearch(fun,x0,options);
close(hJcc)

end

function error = Distance_From_Jc(J,Resolution_Z,Resolution_R,Jc0,B0,k,Re,Ri,T,d,FF)
global min_error
Je=J.*FF; %average current density over the coil section

Zmax=2.*T+d;
Rmax=1.5.*Re;
[resB,Zm,Rm]=mapB_on_coil( Re,Ri,T,d,Je,Zmax,Rmax,Resolution_Z,Resolution_R );
[resJc,Zm,Rm] = mapJc( resB,Zm,Rm,Jc0,B0,k );
mapJc_OnCoil=zero_out_of_coil(Re,Ri,T,d,resJc,Zm,Rm);

Jcc_temp=max(max(mapJc_OnCoil));
nb_pts=0;
for i=1:length(Zm)
    for j=1:length(Rm)
        if mapJc_OnCoil(i,j)>0
            nb_pts=nb_pts+1;
        end
    end
end
if nb_pts<4
    disp('WARNING: Not enough points for accurate computation')
end

for i=1:length(Zm)
    for j=1:length(Rm)
        if mapJc_OnCoil(i,j)<Jcc_temp && mapJc_OnCoil(i,j)>0
            Jcc_temp=mapJc_OnCoil(i,j);
        end
    end
end

error=(J/Jcc_temp-1).^2;
if error<min_error
    min_error=error;
end
Progress=exp(-sqrt(min_error.*Resolution_Z.*Resolution_R));
waitbar(Progress)
end