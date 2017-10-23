function [Breturn,Zm,Rm] = mapB_on_coil( Re,Ri,T,d,Je,Zmax,Rmax,nb_pts_z,nb_pts_r )
Zm=linspace(0,Zmax,nb_pts_z);
Rmin=Rmax./1E9; %Impossible to compute at r=0
Rm=linspace(Rmin,Rmax,nb_pts_r);

Bz=zeros(nb_pts_z,nb_pts_r);
Br=zeros(nb_pts_z,nb_pts_r);
magB=zeros(nb_pts_z,nb_pts_r);

for i=1:length(Zm)
    Progress=i/nb_pts_z*100;
    %disp(['Computing Magnetic Field Map: ',num2str(Progress),' %'])
    for j=1:length(Rm)
        
        if (Rm(j)>Ri)&&(Rm(j)<Re)&&(Zm(i)>d./2)&&(Zm(i)<d./2+T)
            M=[Rm(j),0,Zm(i)];
            B=Field_two_coils( M,Re,Ri,T,d,Je.*(Re-Ri).*T,Je.*(Re-Ri).*T);
            Bz(i,j)=B(3);
            Br(i,j)=B(1);
            magB(i,j)=sqrt(Bz(i,j).*Bz(i,j)+Br(i,j).*Br(i,j));
        else
            B=[0,0,0];
            Bz(i,j)=B(3);
            Br(i,j)=B(1);
            magB(i,j)=sqrt(Bz(i,j).*Bz(i,j)+Br(i,j).*Br(i,j));
        end
    end
end

Breturn_temp=zeros(nb_pts_z,nb_pts_r,3);
Breturn_temp(:,:,1)=magB;
Breturn_temp(:,:,2)=Br;
Breturn_temp(:,:,3)=Bz;
Breturn=Breturn_temp;
end

