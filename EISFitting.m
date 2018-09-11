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
        FileNameBeforeNumber
        FileNameAfterNumber
        EIS_File_Numbers    %Numbers in the filenames for each PEIS run
        Num_fit_points      %Number of points to use in the fit ie. 75
        Data                %Data for each EIS run. Data{eis_run}
        Zohmic
        Zsemicircle
        Ztotal              %Total impedance (not normalized)
        Cinterface          %Interface capacitance
        Cbulk               %Bulk capacitance
        Time                %Starting time of each EIS measurement in seconds
        LineColor           %Color for lines in plots
    end
    
    methods
        %Initialize values get filenames, sort data, and calculate densities
        function obj = EISFitting(Sample, SampleType,DataDirectory ,DataFolder, FileNameBeforeNumber, FileNameAfterNumber, Size, EIS_file_numbers)
            if nargin > 0
                if isnumeric([Size])
                    disp([Sample ' ' SampleType])
                    obj.Sample = Sample;
                    obj.SampleType = SampleType;
                    obj.DataFolder = strcat(DataDirectory, '/', DataFolder);
                    obj.FileNameBeforeNumber = FileNameBeforeNumber;
                    obj.FileNameAfterNumber = FileNameAfterNumber;
                    obj.EIS_File_Numbers = EIS_file_numbers;
                    obj.ohmcm2=Size;
                    
                    for i=1:length(obj.EIS_File_Numbers) %Get data from each of the files
                        filename=strcat(obj.DataFolder,'\',obj.FileNameBeforeNumber,int2str(obj.EIS_File_Numbers(i)),obj.FileNameAfterNumber);
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
                        obj.File_Names{i}=filename;
                    end
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
            switch obj.SampleType
                otherwise
                    lastpoint = length(obj.Data{1})-15;
                    param=[obj.Data{1}(5,23),   obj.Data{1}(lastpoint,23), 1e-6,.7];
                    LB=   [obj.Data{1}(5,23)-150,   obj.Data{1}(lastpoint,23)-400, 1e-8,.6];
                    UB=   [obj.Data{1}(5,23)+100,   obj.Data{1}(lastpoint,23)+5000, 1e-5,1];
            end
            
            for i=1:length(obj.Data)
                switch obj.SampleType
                    otherwise
                        points=10:(length(obj.Data{i})-10);%which points to use. (Starting at 1 being the highest frequency point). empty vector uses all points
                end
                temp(:,1)=obj.Data{i}(:,1); %set the R values
                temp(:,2)=obj.Data{i}(:,23); %working
                temp(:,3)=-obj.Data{i}(:,24); %working
%                 temp(:,2)=obj.Data{i}(:,19); %counter
%                 temp(:,3)=-obj.Data{i}(:,20); %counter
                obj.FitParams(i,:)=Zfit(temp,'z',circuit,param,points,'fitNP',LB,UB);
                
                
                obj.Zohmic(i)=obj.FitParams(i,1);
                obj.Zsemicircle(i)=obj.FitParams(i,2);
                obj.Ztotal(i)=obj.FitParams(i,1)+obj.FitParams(i,2);
                drawnow
                
            end
        end
        
        %get line color
        function obj = SetLineColor(obj)
            numberOfSampleTypes=6;
            map=lines(numberOfSampleTypes);
            lineColor='black';
            switch obj.SampleType
                case 'LTO1'
                    lineColor=map(1,:);
                case 'LTO2'
                    lineColor=map(2,:);
                case 'Li-as recieved'
                    lineColor=map(3,:);
                case 'Li-compressed'
                    lineColor=map(4,:);
                case '160x alumina'
                    lineColor=map(5,:);
                case '160x alumina-compressed'
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
                plot(obj.Data{i}(4:end,2)*obj.ohmcm2,obj.Data{i}(4:end,3)*obj.ohmcm2,'DisplayName',strcat(int2str(int16(obj.Data{i}(1,6)/60)),' min'),'color',linecolors(i,:))
            end
            xlabel('Z_R_e (\Omega cm^{2})')
            ylabel('-Z_I_m (\Omega cm^{2})')
            legend('show')
            title(strcat(obj.SampleType,"   |   ",obj.Sample), 'interpreter', 'none')
            hold off
        end
        
        
        %Plot total impedance vs time in ohm cm2
        function TotalImpedanceOhmcm2(obj)
            plot(obj.Time/60,obj.Ztotal*obj.ohmcm2,'Color',obj.LineColor,'LineWidth',1.5,'DisplayName',obj.SampleType);
            xlabel('Time (min)')
            ylabel('Impedance (\Omega cm^{2})')
            legend('show')
            title('Total Impedance vs Time')
            obj.Ztotal(2)*obj.ohmcm2;
        end
        
        %Plot semicircle impedance vs time in ohm cm2
        function SemicircleImpedanceOhmcm2(obj)
            plot(obj.Time/60,obj.Zsemicircle*obj.ohmcm2,'Color',obj.LineColor,'LineWidth',1.5,'DisplayName',obj.SampleType)
            xlabel('Time (min)')
            ylabel('Impedance (\Omega cm^{2})')
            legend('show')
            title('Semicircle Impedance vs Time')
        end
        
        %Plot semicircle impedance vs time in ohm cm2
        function OhmicImpedanceOhmcm2(obj)
            plot(obj.Time/60,obj.Zohmic*obj.ohmcm2,'Color',obj.LineColor,'LineWidth',1.5,'DisplayName',obj.SampleType)
            xlabel('Time (min)')
            ylabel('Impedance (\Omega cm^{2})')
            legend('show')
            title('Ohmic Impedance vs Time')
        end
        
        function ChangeSemicircleImpedanceOhmcm2(obj)
            DeltaZsemicircle = obj.Zsemicircle - obj.Zsemicircle(1);
            plot(obj.Time/60,DeltaZsemicircle*obj.ohmcm2,'Color',obj.LineColor,'LineWidth',1.5,'DisplayName',obj.SampleType)
            xlabel('Time (min)')
            ylabel('Delta Impedance (\Omega cm^{2})')
            legend('show')
            title('Change in Semicircle Impedance vs Time')
        end
        
    end
    
end