%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HoloLens2/HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)
% 
% -------------------- FREQUENCY ANALYSIS ----------------------------

clear all;
close all;

% insert test number
test_date = '17'; % 09 | 11 | 16 | 17
test_number = '19'; % 4 | 4_1 | 5 | 5_1 | 6 | 6_1 | 17 | 18 | 19 | 21_1 | 21_2 | 21_3 | 21_4 | 21_5 | 23
test_type = 'HL'; % HL | HTC

% read and save data to arrays
[time_H,H_x,H_y,H_z,time_OT,OT_x,OT_y,OT_z] = joinReadData(test_date,test_number,test_type);

% calculate the delta_t and eliminate the values equal to zero
delta_t = time_H(2:end)-time_H(1:end-1);
array_zeros = find(delta_t==0);
for i=1:size(array_zeros,1)
    delta_t(array_zeros(i)-i+1)=[];
end

% calculate frquency (vector, mean, max, min)
frequency = 1./(delta_t);
mean_freq = mean(frequency);
max_freq = max(frequency);
min_freq = min(frequency);

% display the results
result = sprintf('\nTest date: %s.03.2021 \nTest number: %s\nMean Freq: %f Hz \nMax Freq: %f Hz \nMin Freq: %f Hz \n',test_date,test_number,mean_freq,max_freq,min_freq);
disp(result);

% plot delta_t and frequency graphs
figure(1);
subplot(1,2,1);
plot(delta_t);
title('Delta t (s)');
xlabel('Sample #');
ylabel('Delta t (s)');

subplot(1,2,2);
plot(frequency);
title('Frequency (Hz)');
xlabel('Sample #');
ylabel('Frequency (Hz)');

graph_title = sprintf('Test #%s | %s.03.2021 | %s',test_number,test_date,test_type);
suptitle(graph_title);