function [] = UI()

% This function generates the graphical User Interface

% Inputs:None

% Outputs:None

% Written by J. Leclerc Ph.D., University of Houston, Department of 
% Electrical and compute Engineering
%
% Last program modification: 9/20/2017

%/////////////////////////////////////////////////////////////////////////

%Define initial Values for parameters
Jc0=500E6;
B0=3;
k=10;
Bmin=0;
Bmax=1;
Ri=0.1;
Re=0.2;
T=0.1;
d=0.1;
FF=0.8;
tetha=0;
J=10E6;
NbZ=20;
NbR=20;
Bobj=1.875;

Oz=-280; %Offset for graphic elements position
Oz2=-300; %Another offset for graphic elements position

    f = figure('Visible','off');
    set(gcf,'position',[100,50,920,700])


    txt_Conductor = uicontrol('Style','text',...
        'Position',[10 515+140 300 30],...
        'FontSize',14,...
        'String','Superconductor characteristics');
    
    txt_Coils = uicontrol('Style','text',...
        'Position',[10 130 300 30],...
        'FontSize',14,...
        'String','Coils characteristics');
    
     txt_Comp1 = uicontrol('Style','text',...
        'Position',[400 515+140+Oz2 450 30],...
        'FontSize',14,...
        'String','Compute Data for User Specified Current Density');
     
    txt_Comp2 = uicontrol('Style','text',...
        'Position',[400 515+Oz2+30 450 50],...
        'FontSize',14,...
        'String','Compute Coil Critical Current Density Jcc and compute data for this current density value');
    txt_CompParam = uicontrol('Style','text',...
        'Position',[400 75 450 30],...
        'FontSize',14,...
        'String','Computation Parameters');    
    
    txt_OptimA = uicontrol('Style','text',...
        'Position',[420 390+Oz2+60 400 50],...
        'FontSize',14,...
        'String','Search Re and T to produce a user defined flux density Bu with Re-Ri=T at J=Jcc');  
    
   %Create push button
    comp = uicontrol('Style', 'pushbutton', 'String', 'Compute',...
        'Position', [650 618+Oz2 120 20],...
        'Callback', @Temp_call_comp);
    
    comp2 = uicontrol('Style', 'pushbutton', 'String', 'Compute',...
        'Position', [570 480+Oz2+35 120 20],...
        'Callback', @Temp_call_comp2);
    
    comp3 = uicontrol('Style', 'pushbutton', 'String', 'Compute',...
        'Position', [600 350+Oz2+70 120 20],...
        'Callback', @Temp_call_comp3);
    
    txt_J = uicontrol('Style','text',...
        'Position',[500-100 608+8+Oz2 120 20],...
        'String','J [A/m^2]:');

    J_t = uicontrol('Style', 'edit',...
        'Position', [600-100 500+100+10+8+Oz2 120 20],...
        'string',J,...
        'Callback', @Temp_call_J);
    
    txt_Bobj = uicontrol('Style','text',...
        'Position',[500-80 120 120 20],...
        'String','Bu [T]:');

    Bobj_t = uicontrol('Style', 'edit',...
        'Position', [600-100 120 80 20],...
        'string',Bobj,...
        'Callback', @Temp_call_Bobj);
    
    txt_NbZ = uicontrol('Style','text',...
        'Position',[500 200+130+Oz 120 30],...
        'String','Number of calculation points along the Z axis:');

    NbZ_t = uicontrol('Style', 'edit',...
        'Position', [500 180+130+Oz 120 20],...
        'string',NbZ,...
        'Callback', @Temp_call_NbZ);
    
    txt_NbR = uicontrol('Style','text',...
        'Position',[650 200+130+Oz 120 30],...
        'String','Number of calculation points along the R axis:');

    NbR_t = uicontrol('Style', 'edit',...
        'Position', [650 180+130+Oz 120 20],...
        'string',NbR,...
        'Callback', @Temp_call_NbR);
    
    txt_Jc0 = uicontrol('Style','text',...
        'Position',[0 515+100+10 120 20],...
        'String','Jc0 [A/mm^2]');

    jc0 = uicontrol('Style', 'edit',...
        'Position', [10 500+100+10 120 20],...
        'string',Jc0,...
        'Callback', @Temp_call_Jc0);
    
    txt_B0 = uicontrol('Style','text',...
        'Position',[0 500-30+100+10 120 20],...
        'String','B0 [T]');

    B0_t = uicontrol('Style', 'edit',...
        'Position', [10 485-30+100+10 120 20],...
        'string',B0,...
        'Callback', @Temp_call_B0);
    
   txt_k = uicontrol('Style','text',...
        'Position',[0 500-30-45+100+10 120 20],...
        'String','y');

    k_t = uicontrol('Style', 'edit',...
        'Position', [10 485-30-45+100+10 120 20],...
        'string',k,...
        'Callback', @Temp_call_k);
    
    txt_Bmax = uicontrol('Style','text',...
        'Position',[210 500-350+100-30 120 20],...
        'String','Bmax [T]');

    Bmax_t = uicontrol('Style', 'edit',...
        'Position', [200 485-350+100-30 120 20],...
        'string',Bmax,...
        'Callback', @Temp_call_Bmax);
    
   txt_Bmin = uicontrol('Style','text',...
        'Position',[90-30 500-350+100-30 120 20],...
        'String','Bmin [T]');

    Bmin_t = uicontrol('Style', 'edit',...
        'Position', [100-30 485-350+100-30 120 20],...
        'string',Bmin,...
        'Callback', @Temp_call_Bmin);
    
    txt_plotfor = uicontrol('Style','text',...
        'Position',[10 195 50 30],...
        'String','Plot for: ');
    
    
%\\\\\\\\\\Inputs for coil properties\\\\\\\\\\\\\\\\\\\\\\\\\\

    Offset=-500; %Offset for graphic elements position
    txt_Ri = uicontrol('Style','text',...
        'Position',[0 515+100+Offset 120 20],...
        'String','Ri [m]');

    Ri_t = uicontrol('Style', 'edit',...
        'Position', [10 500+100+Offset 120 20],...
        'string',Ri,...
        'Callback', @Temp_call_Ri);
    
    txt_Re = uicontrol('Style','text',...
        'Position',[0 500-30+100+Offset 120 20],...
        'String','Re [m]');

    Re_t = uicontrol('Style', 'edit',...
        'Position', [10 485-30+100+Offset 120 20],...
        'string',Re,...
        'Callback', @Temp_call_Re);
    
   txt_T = uicontrol('Style','text',...
        'Position',[0 500-30-45+100+Offset 120 20],...
        'String','T [m]');

    T_t = uicontrol('Style', 'edit',...
        'Position', [10 485-30-45+100+Offset 120 20],...
        'string',T,...
        'Callback', @Temp_call_T);

    XOffset=150; %Offset for graphic elements position
    
    txt_d = uicontrol('Style','text',...
        'Position',[0+XOffset 515+100+Offset 120 20],...
        'String','d [m]');

    d_t = uicontrol('Style', 'edit',...
        'Position', [10+XOffset 500+100+Offset 120 20],...
        'string',d,...
        'Callback', @Temp_call_d);
    
    txt_FF = uicontrol('Style','text',...
        'Position',[0+XOffset 500-30+100+Offset 120 20],...
        'String','FF [] (Filling Factor)');

    FF_t = uicontrol('Style', 'edit',...
        'Position', [10+XOffset 485-30+100+Offset 120 20],...
        'string',FF,...
        'Callback', @Temp_call_FF);
    
    txt_tetha = uicontrol('Style','text',...
        'Position',[0+50 170+5 120 20],...
        'String','Alpha [rad]');

    tetha_t = uicontrol('Style', 'edit',...
        'Position', [100+50 175+5 120 20],...
        'string',tetha,...
        'Callback', @Temp_call_tetha);
    
    %////////////////////////////////////////////////////////////

    P=axes('Units','pixels','position',[70,290,300,200])
    h=plot([1,2,3],[1,2,3])
    showParam(h)
    ylabel('Critical Current Density [A/m^2]')
    xlabel('Flux density magnitude [T]')
    grid on
    
     P2=axes('Units','pixels','position',[135,530,150*2,50*1.9]);
     img=imread('equation.png');
     image(img)
     axis off
     
     
     P3=axes('Units','pixels','position',[440,395,2000*0.23,1300*0.23]);
     img=imread('Coils.png');
     image(img)
     axis off
     f.Visible = 'on';
    
%\\\\\\\\\\\\\\ Define Callback functions \\\\\\\\\\\\\\\\\\\\\\\\\\\\

    function Temp_call_Jc0(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        Jc0=str2num(str);
        showParam(h);
    end
    function Temp_call_B0(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        B0=str2num(str);
        showParam(h);
    end
    function Temp_call_k(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        k=str2num(str);
        showParam(h)
    end
    function Temp_call_Bmin(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        Bmin=str2num(str);
        showParam(h)
    end
    function Temp_call_Bmax(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        Bmax=str2num(str);
        showParam(h)
    end  
    function Temp_call_tetha(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        tetha=str2num(str);
        showParam(h)
    end 
    function showParam(h)
        B=linspace(Bmin,Bmax,100);
        Jc=zeros(1,100);
        
        for i=1:100
            
            Jc(i) = JcOfB( Jc0, B0, k, B(i).*cos(tetha),B(i).*sin(tetha));
        end
        axes(P)
        set(h,'ydata',Jc,'xdata',B);
    end
    function Temp_call_T(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        T=str2num(str);
        
    end
    function Temp_call_FF(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        FF=str2num(str);
        
    end
    function Temp_call_d(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        d=str2num(str);
        
    end
    function Temp_call_Bobj(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        Bobj=str2num(str);
        
    end
    function Temp_call_Re(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        Re=str2num(str);
        
    end
    function Temp_call_Ri(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        Ri=str2num(str);
        
    end
    function Temp_call_comp(~,~)
        disp('Computing Magnetic Field Map')
        [mapBRes,Zm,Rm]=mapB( Re,Ri,T,d,J,d+2.*T,1.5.*Re,NbZ,NbR);
        disp('Done Computing Magnetic Field Map')
        disp('Computing Critical Current Density Map')
        [mapJcRes,Zm,Rm] = mapJc( mapBRes,Zm,Rm,Jc0,B0,k );
        disp('Done Computing Critical Current Density Map')
        disp('Computing Losses Density Map')
        mapLossesRes=mapLosses(mapBRes,mapJcRes,Zm,Rm,k,J);
        disp('Done Computing Losses Density Map')
        PlotAll( Re,Ri,T,d,mapBRes,mapJcRes,mapLossesRes,J,Zm,Rm,-1,-1)
    end
    function Temp_call_J(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        J=str2num(str);
        
    end
   function Temp_call_NbZ(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        NbZ=str2num(str);
        
   end
   function Temp_call_NbR(src,~)
        str=get(src,'string');
        if isempty(str2num(str))
            set(src,'string','0');
            warndlg('Input must be numerical');
        end
        NbR=str2num(str);
        
   end
    function Temp_call_comp2(~,~)
        disp('Searching Coil Critical Current Density Jcc')
        Jcc=JccSearch( Re,Ri,T,d,Jc0,B0,k,FF,Jc0./2,NbZ,NbR);
        disp('Done Searching Coil Critical Current Density Jcc')
        disp(['Coil Critical Current Density, Jcc=',num2str(Jcc),' A/m^2'])
        disp('Computing Magnetic Field Map')
        [mapBRes,Zm,Rm]=mapB( Re,Ri,T,d,Jcc.*FF,d+2.*T,1.5.*Re,NbZ,NbR);
        disp('Done Computing Magnetic Field Map')
        disp('Computing Critical Current Density Map')
        [mapJcRes,Zm,Rm] = mapJc( mapBRes,Zm,Rm,Jc0,B0,k );
        disp('Done Computing Critical Current Density Map')
        disp('Computing Losses Density Map')
        mapLossesRes=mapLosses(mapBRes,mapJcRes,Zm,Rm,k,Jcc);
        disp('Done Computing Losses Density Map')
        PlotAll( Re,Ri,T,d,mapBRes,mapJcRes,mapLossesRes,Jcc,Zm,Rm,Jcc,-1)

    end
    function Temp_call_comp3(~,~)
        disp('Searching Re and T')
        a=aSearch( Ri,d,Jc0,B0,k,FF,Ri./4,NbZ,NbR,Bobj);
        disp('Done Searching Re and T')
        disp(['Re=',num2str(a+Ri),'[m]'])
        disp(['T=',num2str(a),'[m]'])
        disp('Searching Coil Critical Current Density Jcc')
        Jcc=JccSearch( Ri+a,Ri,a,d,Jc0,B0,k,FF,Jc0./2,NbZ,NbR);
        disp('Done Searching Coil Critical Current Density Jcc')
        disp(['Coil Critical Current Density, Jcc=',num2str(Jcc),' A/m^2'])
        disp('Computing Magnetic Field Map')
        [mapBRes,Zm,Rm]=mapB( Ri+a,Ri,a,d,Jcc.*FF,d+2.*a,1.5.*Re,NbZ,NbR);
        disp('Done Computing Magnetic Field Map')
        disp('Computing Critical Current Density Map')
        [mapJcRes,Zm,Rm] = mapJc( mapBRes,Zm,Rm,Jc0,B0,k );
        disp('Done Computing Critical Current Density Map')
        disp('Computing Losses Density Map')
        mapLossesRes=mapLosses(mapBRes,mapJcRes,Zm,Rm,k,Jcc);
        disp('Done Computing Losses Density Map')
        PlotAll( a+Ri,Ri,a,d,mapBRes,mapJcRes,mapLossesRes,Jcc,Zm,Rm,Jcc,a)
        
    end

end