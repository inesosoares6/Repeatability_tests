%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HoloLens2 & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)
% 
% -------------- EXIT & ENTRY FIELD VISION TESTS ---------------------

clear all;
close all;

% insert test number
test_date = '16'; % 16
test_number = '16'; % 16
test_type = 'HL'; % HL

% read and save data to arrays
[time_HL,HL_x,HL_y,HL_z,time_OT,OT_x,OT_y,OT_z] = joinReadData(test_date,test_number,test_type);

% calculate interpolation
[T_BA_x, D_BA_x] = interpolate(time_OT,OT_x,time_HL,HL_x);
[T_BA_y, D_BA_y] = interpolate(time_OT,OT_y,time_HL,HL_y);
[T_BA_z, D_BA_z] = interpolate(time_OT,OT_z,time_HL,HL_z);

Error = sqrt((D_BA_x - OT_x).^2 + (D_BA_y - OT_y).^2 + (D_BA_z - OT_z).^2);

graph_title = sprintf('Test #%s | %s.03.2021 | %s',test_number,test_date,test_type);
plotGraphsSimple(time_OT,D_BA_x,D_BA_y,D_BA_z,OT_x,OT_y,OT_z,Error);
suptitle(graph_title);

[~,MaxIdx_OT] = findpeaks(OT_y,'MinPeakProminence',0.1);
[~,MaxIdx_HL] = findpeaks(D_BA_y,'MinPeakProminence',0.1);
[~,MinIdx_OT] = findpeaks(-OT_y,'MinPeakProminence',0.1);
[~,MinIdx_HL] = findpeaks(-D_BA_y,'MinPeakProminence',0.1);

figure(2);
plot(time_OT,OT_y,'r',...
     time_OT(MaxIdx_OT),OT_y(MaxIdx_OT),'r*',...
     time_OT(MinIdx_OT),OT_y(MinIdx_OT),'r*',...
     T_BA_y,D_BA_y,'b',...
     T_BA_y(MaxIdx_HL),D_BA_y(MaxIdx_HL),'b*',...
     T_BA_y(MinIdx_HL),D_BA_y(MinIdx_HL),'b*');
title('Find maxs & mins');
xlabel('time (sec)');
ylabel('position (m)');
legend('OT','OT_{max}','OT_{min}','HL','HL_{max}','HL_{min}');

%calculate delay
delay = mean(T_BA_y(MinIdx_HL)-time_OT(MinIdx_OT));