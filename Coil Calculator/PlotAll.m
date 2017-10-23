function [] = PlotAll( Re,Ri,T,d,mapB,mapJc,mapLosses,J,Zm,Rm,Jcc,a)
% This function plots the map of the magnetic flux density, the map of the
% critical current density, the map of the magnetization losses and display
% calculated results. 

% Inputs: Re: External radius of the coils [m]
%         Ri: Internal radius of the coils [m]
%          T: Length of the coils [m]
%          d: distance the coils [m]
%       mapB: (k,l,3) matrix with the map of the flux density [T]
%             (:,:,1): morm of B [T]
%             (:,:,2): radial component of B [T]
%             (:,:,3): axial component of B [T]
%      mapJc: matrix with the map of critical current density [A/m^2]
%mapLosses: matrix with the map of the losses density [J.m^-3.cycle^-1]
%          J: Current density inside the superconducting wire [A/m^2]
%         Zm: Vector with the z positions corresponding to mapB [m]
%         Rm: Vector with the r positions corresponding to mapB [m]
%        Jcc: Coil critical current density [A/m^2]
%          a: Value found during the optimization of the geometry of the
%             coil. Set to 0 if no optimization was performed. [m]

% Outputs:None

% Written by J. Leclerc Ph.D., University of Houston, Department of 
% Electrical and compute Engineering
%
% Last program modification: 9/20/2017
magB=mapB(:,:,1);

BtoPlot=[flip(flip(magB),2),flip(magB);flip(magB,2),magB];
ZmPlot=[flip(-Zm),Zm];
RmPlot=[flip(-Rm),Rm];
%plot of the module of B
Q=figure('position',[50 50 1200 700]);
subplot(2,2,1)
imagesc(ZmPlot,RmPlot,BtoPlot');
c1=colorbar;
c1.Label.String = 'Flux Density Magnitude [T]';
hold on
set(gca,'Ydir','Normal')
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
line([-1.8.*d-T 1.8.*d+T ],[0 0],'color','red','LineStyle','-.')
title('Magnitude of B')
ylabel('r (m)')
xlabel('Z (m)')
axis equal tight

%Plot of J/Jc map
J_over_Jc=J./mapJc;
J_over_Jc_on_coil=zero_out_of_coil(Re,Ri,T,d,J_over_Jc,Zm,Rm);
J_over_Jc_to_plot=[flip(flip(J_over_Jc_on_coil),2),flip(J_over_Jc_on_coil);flip(J_over_Jc_on_coil,2),J_over_Jc_on_coil];
ZmPlot=[flip(-Zm),Zm];
RmPlot=[flip(-Rm),Rm];
%plot of J/Jc
subplot(2,2,2)
imagesc(ZmPlot,RmPlot,J_over_Jc_to_plot');
c2=colorbar;
c2.Label.String = 'J/Jc';
set(gca,'Ydir','Normal')
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
line([-1.8.*d-T 1.8.*d+T ],[0 0],'color','red','LineStyle','-.')
title('Critical Current Density Ratio')
ylabel('r (m)')
xlabel('Z (m)')
axis equal tight

%Plot of Losses map
Losses_on_coil=zero_out_of_coil(Re,Ri,T,d,mapLosses,Zm,Rm);
Losses_to_plot=[flip(flip(Losses_on_coil),2),flip(Losses_on_coil);flip(Losses_on_coil,2),Losses_on_coil];
ZmPlot=[flip(-Zm),Zm];
RmPlot=[flip(-Rm),Rm];
%plot of J/Jc
subplot(2,2,3)
imagesc(ZmPlot,RmPlot,Losses_to_plot');
c3=colorbar;
c3.Label.String = 'Losses Density [J.m^-3.cycle^-1]';
set(gca,'Ydir','Normal')
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T],[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri].*-1) %lines show the contours of the coil
line([d/2+T,d/2,d/2,d/2+T,d/2+T].*-1,[Ri,Ri,Re,Re,Ri]) %lines show the contours of the coil
line([-1.8.*d-T 1.8.*d+T ],[0 0],'color','red','LineStyle','-.')
title('Map of the Losses density')
ylabel('r (m)')
xlabel('Z (m)')
axis equal tight

%Add text with system data
figure('position',[100 100 500 300])
dim = [0.2 .5 .3 .3];
str = ['Flux density at system center: ',num2str(magB(1,1)),' T'];
annotation('textbox',dim,'String',str,'FitBoxToText','on');
Total_Magn_Losses=Magnetization_losses( Re,Ri,T,d,Losses_on_coil,Zm,Rm );
dim = [0.2 .4 .3 .3];
str = ['Coil Magnetization Losses: ',num2str(Total_Magn_Losses),' J/cycle'];
annotation('textbox',dim,'String',str,'FitBoxToText','on');

if Jcc>0
    dim = [0.2 .3 .3 .3];
    str = ['Coil Critical Current Density Jcc: ',num2str(Jcc),' A/m^2'];
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
end

if a>0
    dim = [0.2 .2 .3 .3];
    str = ['Re: ',num2str(Ri+a),' m'];
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
    dim = [0.2 .1 .3 .3];
    str = ['T: ',num2str(a),' m'];
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
end


end

