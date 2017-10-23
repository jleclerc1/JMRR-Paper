function [] = JoverJc( Re,Ri,T,d,mapJc,Zm,Rm,J)


JctoPlot=[flip(flip(J./mapJc),2),flip(J./mapJc);flip(J./mapJc,2),J./mapJc];
ZmPlot=[flip(-Zm),Zm];
RmPlot=[flip(-Rm),Rm];
%plot of the module of B
figure(3)
imagesc(ZmPlot,RmPlot,JctoPlot');
set(gca,'Ydir','Normal')
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
title('Map of the critical current density ratio')
ylabel('r (m)')
xlabel('Z (m)')
axis equal tight

end

