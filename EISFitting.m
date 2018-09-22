classdef EISFitting
    properties
        Sample
        SampleType
        Density             %Sample percent density
        FitParams           %Equivalent circuit fit parameters
        Sigma
    end
    properties
        ohmcm2              %factor to normalize to ohm*cm2
        File_Names          %Names (including relative locations) of all files associated with the sample
        DataFolder
        FileName
        Electrode_Type      %Working/Counter Electrode (WE and CE)
        Num_fit_points      %Number of points to use in the fit ie. 75
        Data                %Data for each EIS run. Data{eis_run}
        Zohmic
        Zsemicircle
        Ztotal              %Total impedance (not normalized)
        Cinterface          %Interface capacitance
        Cbulk               %Bulk capacitance
        Time                %Starting time of each EIS measurement in seconds
        LineColor           %Color for lines in plots 
        LineType            %Line type for the plots, solid line for working electrode, dashed line for counter
    end
    
    methods
        %Initialize values get filenames, sort data, and calculate densities
        function obj = EISFitting(Sample, SampleType,DataDirectory ,DataFolder, FileName, Size, Electrode_Type)
            if nargin > 0
                if isnumeric([Size])
                    disp([Sample ' ' SampleType])
                    obj.Sample = Sample;
                    obj.SampleType = SampleType;
                    obj.DataFolder = strcat(DataDirectory, '/', DataFolder);
                    obj.FileName = FileName;
                    obj.Electrode_Type = Electrode_Type;
                    obj.ohmcm2=Size;
                    SetLineType = '.-';
                    switch Electrode_Type
                        case 'WE'
                            SetLineType = '-';
                        case 'CE'
                            SetLineType = '--';
                    end
                    obj.LineType = SetLineType;
                    
                    filename=strcat(obj.DataFolder,'\',obj.FileName,'.mpt');
                    fid = fopen(filename,'r');
                    s = textscan(fid, '%s', 'delimiter', '\n');
                    firstLine = find(strncmp(s{1}, 'freq',4), 1, 'first');
                    fclose(fid);
                    allData = dlmread(filename,'\t',firstLine,0);
                    
                    fLast=inf;
                    freqIterator=1;
                    newRun(freqIterator)=0;
                    for j=1:length(allData(:,1))
                        f=allData(j,1);
                        if f>fLast
                            freqIterator=freqIterator+1;
                            newRun(freqIterator)=j-1;
                        end
                        fLast=f;
                    end
                    newRun(freqIterator+1)=length(allData(:,1));
                    
                    for j=1:freqIterator
                        obj.Data{end+1}=allData(newRun(j)+1:newRun(j+1),:);
                        obj.Time(end+1)=obj.Data{end}(1,6);
                    end
                    obj.File_Names = filename;
                    obj = SetLineColor(obj);
                    obj = runFit(obj);
                else
                    error('Value must be numeric')
                end
                
            end
            
        end
        
        %get's fit paramaters for the quivalent circuit
        function obj = runFit(obj)
            circuit='s(R1,p(R1,E2))';%element in the circuit followed by number of parameters. i.e. E2 is a CPE which has two parameters (C and alpha)
            if obj.Electrode_Type == 'WE'
                RE = 2;
                IM = 3;
            else
                RE = 19;
                IM = 20;
            end
            switch obj.SampleType
                otherwise
                    lastpoint = length(obj.Data{1})-10;
                    LBstart = max(obj.Data{1}(5,RE)-500,0);
                    LBend = max(obj.Data{1}(lastpoint,RE)-5000,0);
                    param=[obj.Data{1}(5,RE),   obj.Data{1}(lastpoint,RE), 1e-6,.7];
                    LB=   [LBstart,  LBend, 1e-8,.6];
                    UB=   [obj.Data{1}(5,RE)+500,   obj.Data{1}(lastpoint,RE)+10000, 1e-5,1];
            end
            
            for i=1:length(obj.Data)
                switch obj.SampleType
                    otherwise
                        points=10:(length(obj.Data{i})-8);%which points to use. (Starting at 1 being the highest frequency point). empty vector uses all points
                end
                temp(:,1)=obj.Data{i}(:,1); %set the R values
                temp(:,2)=obj.Data{i}(:,RE);
                temp(:,3)=-obj.Data{i}(:,IM);
                obj.FitParams(i,:)=Zfit(temp,'z',circuit,param,points,'fitNP',LB,UB);
                
                
                obj.Zohmic(i)=obj.FitParams(i,1);
                obj.Zsemicircle(i)=obj.FitParams(i,2);
                obj.Ztotal(i)=obj.FitParams(i,1)+obj.FitParams(i,2);
                drawnow
                
            end
        end
        
        %get line color
        function obj = SetLineColor(obj)
            numberOfSampleTypes=7;
            map=lines(numberOfSampleTypes);
            lineColor='black';
            switch obj.SampleType
                case 'Li-as recieved 1'
                    lineColor=map(1,:);
                case 'Li-as recieved 2'
                    lineColor=map(2,:);
                case 'Li-as recieved 4'
                    lineColor=map(3,:);
                case 'Li-as recieved 5'
                    lineColor=map(4,:);
                case 'Li-as recieved 6'
                    lineColor=map(5,:);
                case 'Li-as recieved 7'
                    lineColor=map(6,:);
            end
            obj.LineColor=lineColor;
            
        end
        
        %Make Nyquist Plot normalized to Ohm cm2
        function NyquistPlotOhmcm2(obj)
            figure
            hold on
            linecolors = jet(length(obj.Data));
            for i=1:1:length(obj.Data)
                plot(obj.Data{i}(4:end,2)*obj.ohmcm2,obj.Data{i}(4:end,3)*obj.ohmcm2,obj.LineType,'DisplayName',strcat(int2str(int16(obj.Data{i}(1,6)/60)),' min'),'color',linecolors(i,:))
            end
            xlabel('Z_R_e (\Omega cm^{2})')
            ylabel('-Z_I_m (\Omega cm^{2})')
            legend('show')
            title(strcat(obj.SampleType,"   |   ",obj.Sample), 'interpreter', 'none')
            hold off
        end
        
        
        %Plot total impedance vs time in ohm cm2
        function TotalImpedanceOhmcm2(obj)
            plot(obj.Time/60,obj.Ztotal*obj.ohmcm2,obj.LineType,'Color',obj.LineColor,'LineWidth',1.5,'DisplayName',obj.SampleType);
            xlabel('Time (min)')
            ylabel('Impedance (\Omega cm^{2})')
            legend('show')
            title('Total Impedance vs Time')
            obj.Ztotal(2)*obj.ohmcm2;
        end
        
        %Plot semicircle impedance vs time in ohm cm2
        function SemicircleImpedanceOhmcm2(obj)
            plot(obj.Time/60,obj.Zsemicircle*obj.ohmcm2,obj.LineType,'Color',obj.LineColor,'LineWidth',1.5,'DisplayName',obj.SampleType)
            xlabel('Time (min)')
            ylabel('Impedance (\Omega cm^{2})')
            legend('show')
            title('Semicircle Impedance vs Time')
        end
        
        %Plot semicircle impedance vs time in ohm cm2
        function OhmicImpedanceOhmcm2(obj)
            plot(obj.Time/60,obj.Zohmic*obj.ohmcm2,obj.LineType,'Color',obj.LineColor,'LineWidth',1.5,'DisplayName',obj.SampleType)
            xlabel('Time (min)')
            ylabel('Impedance (\Omega cm^{2})')
            legend('show')
            title('Ohmic Impedance vs Time')
        end
        
        function ChangeSemicircleImpedanceOhmcm2(obj)
            DeltaZsemicircle = obj.Zsemicircle - obj.Zsemicircle(1);
            plot(obj.Time/60,DeltaZsemicircle*obj.ohmcm2,obj.LineType,'Color',obj.LineColor,'LineWidth',1.5,'DisplayName',obj.SampleType)
            xlabel('Time (min)')
            ylabel('Delta Impedance (\Omega cm^{2})')
            legend('show')
            title('Change in Semicircle Impedance vs Time')
        end
        
        function GetSampleType(obj)
            disp(obj.SampleType);
        end
    end
    
end