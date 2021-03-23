%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HoloLens2/HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)

% insert test number
test_number = 17;

if test_number == 17
    read_file = 'matlab_17.csv';
    max_HL = 4988;
    write_file = 'interpolated_17.csv';
elseif test_number == 18
    read_file = 'matlab_18.csv';
    max_HL = 4923;
    write_file = 'interpolated_18.csv';
elseif test_number ==19
    read_file = 'matlab_19.csv';
    max_HL = 4590;
    write_file = 'interpolated_19.csv';
else
    error("Insert valid test number")
end

% read and save data to arrays
data = readtable(read_file);
data_matrix = table2array(data);
time_HL = data_matrix(1:max_HL,1);
position_HL = data_matrix(1:max_HL,2);
time_OT = data_matrix(:,3);
position_OT = data_matrix(:,4);

% plot graphs with HL2 & OT data
figure(1);
subplot(3,2,1);
plot(time_HL,position_HL,'b')
title('HoloLens2')
xlabel('time (sec)')
ylabel('z position (m)')

subplot(3,2,2);
plot(time_OT,position_OT,'g')
title('OptiTrack')
xlabel('time (sec)')
ylabel('z position (m)')

subplot(3,2,[3,4]);
plot(time_HL,position_HL,'b',time_OT,position_OT,'g');
legend('HL2','OT')
title('HoloLens2 & OptiTrack')
xlabel('time (sec)')
ylabel('z position (m)')

% calculate interpolation
D_BA = zeros(size(position_OT));
T_BA = zeros(size(time_OT));
for i = 1:size(position_OT,1)
    for j = 1:size(position_HL,1)
        if time_HL(j) > time_OT(i)
            if j==1
                j0 = 1;
                jf = 2;
            else
                j0 = j-1;
                jf = j;
            end
            D_BA(i) = position_HL(j0)+(position_HL(jf)-position_HL(j0))/(time_HL(jf)-time_HL(j0))*(time_OT(i)-time_HL(j0));
            T_BA(i) = time_OT(i);
            break;
        elseif time_HL(j) == time_OT(i)
            D_BA(i) = position_HL(j);
            T_BA(i) = time_OT(i);
            break;
        end
    end
end

% plot graph interpolated
subplot(3,2,[5,6]);
plot(T_BA,D_BA,'b',time_OT,position_OT,'g');
legend('HL2interpolated','OT')
title('Interpolation')
xlabel('time (sec)')
ylabel('z position (m)')

% save to csv
matrix=[T_BA D_BA position_OT];
csvwrite(write_file,matrix);

error_0 = position_OT - D_BA;
error_5 = position_OT(1:size(D_BA,1)-4) - D_BA(5:size(D_BA,1));
error_10 = position_OT(1:size(D_BA,1)-9) - D_BA(10:size(D_BA,1));
error_15 = position_OT(1:size(D_BA,1)-14) - D_BA(15:size(D_BA,1));
error_20 = position_OT(1:size(D_BA,1)-19) - D_BA(20:size(D_BA,1));
error_25 = position_OT(1:size(D_BA,1)-24) - D_BA(25:size(D_BA,1));
error_30 = position_OT(1:size(D_BA,1)-29) - D_BA(30:size(D_BA,1));
error_35 = position_OT(1:size(D_BA,1)-34) - D_BA(35:size(D_BA,1));
error_40 = position_OT(1:size(D_BA,1)-39) - D_BA(40:size(D_BA,1));
error_45 = position_OT(1:size(D_BA,1)-44) - D_BA(45:size(D_BA,1));
error_50 = position_OT(1:size(D_BA,1)-49) - D_BA(50:size(D_BA,1));

figure(2);
plot(T_BA(1:size(D_BA,1)-29),position_OT(1:size(D_BA,1)-29),'r',...
     T_BA(1:size(D_BA,1)-39),D_BA(40:size(D_BA,1)),...
     T_BA(1:size(D_BA,1)-34),D_BA(35:size(D_BA,1)),...
     T_BA(1:size(D_BA,1)-29),D_BA(30:size(D_BA,1)),...
     T_BA(1:size(D_BA,1)-24),D_BA(25:size(D_BA,1)),...
     T_BA(1:size(D_BA,1)-19),D_BA(20:size(D_BA,1)),...
     T_BA(1:size(D_BA,1)-14),D_BA(15:size(D_BA,1)),...
     T_BA(1:size(D_BA,1)-9),D_BA(10:size(D_BA,1)),...
     T_BA(1:size(D_BA,1)-4),D_BA(5:size(D_BA,1)));
legend('OT','HL-40','HL-35','HL-30','HL-25','HL-20','HL-15','HL-10','HL-5');