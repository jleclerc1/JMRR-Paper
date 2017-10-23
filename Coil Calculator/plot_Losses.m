function [] = plot_Losses( Re,Ri,T,d,mapLosses,Zm,Rm)


LossestoPlot=[flip(flip(mapLosses),2),flip(mapLosses);flip(mapLosses,2),mapLosses];
ZmPlot=[flip(-Zm),Zm];
RmPlot=[flip(-Rm),Rm];
%plot of the module of B
figure(4)
imagesc(ZmPlot,RmPlot,LossestoPlot');
set(gca,'Ydir','Normal')
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
title('Map of the AC Losses [J.m^{-3}.cycle^{-1}')
ylabel('r (m)')
xlabel('Z (m)')
axis equal tight

end

