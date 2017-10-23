function [ Jcc] = aSearch( Ri,d,Jc0,B0,y,FF,aInit,NbZ,NbR,Bobj)
%JCSEARCH Summary of this function goes here
%   Detailed explanation goes here
global min_error_a error_init
min_error_a=1;
error_init=-1;

ha = waitbar(0,'Searching Re and T...','position',[400 380 280 50]);
TolSearch=0.001;
options = optimset('Maxiter',30,'TolFun', TolSearch,'TolX', TolSearch,'Display','iter');
fun = @(x)Distance_From_B(x,NbZ,NbR,Jc0,B0,y,Ri,d,FF,Bobj);
x0 = [aInit];
Jcc = fminsearch(fun,x0,options);
close(ha)
end

function error = Distance_From_B(par,NbZ,NbR,Jc0,B0,y,Ri,d,FF,Bobj)
global min_error_a error_init
        if par<=0
            a=0;
        else
            a=par;
        end
        
        disp(['a=',num2str(a)])
        disp('Searching Coil Critical Current Density Jcc')
        Jcc=JccSearch( a+Ri,Ri,a,d,Jc0,B0,y,FF,Jc0./2,NbZ,NbR);
        disp('Done Searching Coil Critical Current Density Jcc')
        disp(['Coil Critical Current Density, Jcc=',num2str(Jcc),' A/m^2'])
        disp('Computing Magnetic Field Map')
        %[mapBRes,Zm,Rm]=mapB( a+Ri,Ri,a,d,Jcc.*FF,d+2.*a,1.5.*a,NbZ,NbR);
        M=[Ri./1E9,0,0];
        Bres=Field_two_coils( M,Ri+a,Ri,a,d,Jcc.*FF.*(Ri+a-Ri).*a,Jcc.*FF.*(Ri+a-Ri).*a);

error=(sqrt(Bres(1).^2+Bres(3).^2)-Bobj).^2;

if error_init<0
    error_init=error;
end

if error<min_error_a
    min_error_a=error;
end
Progress=exp(-sqrt(4.*(min_error_a./error_init)+min_error_a));
waitbar(Progress)
end