%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HoloLens2/HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)
% 
% -------------- ROTATE HTC CONTROLLER TESTS ---------------------

clear all;
%close all;

% insert test number
test_date = '17'; % 17
test_number = '3'; % 3
test_type = 'HTC'; % HTC

% read and save data to arrays
[time_HTC,HTC_x,HTC_y,HTC_z,time_OT,OT_x,OT_y,OT_z] = joinReadData(test_date,test_number,test_type);

% calculate interpolation
[T_BA_x, D_BA_x] = interpolate(time_OT,OT_x,time_HTC,HTC_x);
[T_BA_y, D_BA_y] = interpolate(time_OT,OT_y,time_HTC,HTC_y);
[T_BA_z, D_BA_z] = interpolate(time_OT,OT_z,time_HTC,HTC_z);

% calculate error
Error = sqrt((D_BA_x - OT_x).^2 + (D_BA_y - OT_y).^2 + (D_BA_z - OT_z).^2);

% plot graph (position in different axis and error)
graph_title = sprintf('Test #%s | %s.03.2021 | %s',test_number,test_date,test_type);
plotGraphsSimple(time_OT,D_BA_x,D_BA_y,D_BA_z,OT_x,OT_y,OT_z,Error);
suptitle(graph_title);

% divide the different segments
% find the points on edges
j=1;
for i=2:size(T_BA_x,1)
    error=D_BA_x(i)-D_BA_x(i-1);
    if error > 0.001 || error < -0.001
        array_points(j)=i;
        j=j+1;
    end
end

% eliminate noisy points
m=1;
for k=2:size(array_points,2)
    if T_BA_x(array_points(k))-T_BA_x(array_points(k-1)) > 10
        points(m)=array_points(k-1);
        m=m+1;
    end
end

% define initial and final points of each segment
for s=1:size(points,2)
    initial_points(s) = points(s) + 200;
    final_points(s) = points(s) - 600;
end
initial_points(1)=points(1)+30;
final_points(1)=[];
final_points(1)=points(1)+130;
final_points(size(final_points,2)+1)=points(size(points,2))+1500;

% plot the points on the graph
figure(2);
plot(T_BA_x,D_BA_x,'b',...
     T_BA_x(points),D_BA_x(points),'b*',...
     T_BA_x(initial_points),D_BA_x(initial_points),'r*',...
     T_BA_x(final_points),D_BA_x(final_points),'g*');
title('HTC Axis x');
xlabel('time (sec)');
ylabel('position (m)');
suptitle(graph_title);

% plot the different segments
N = size(final_points,2);
figure(3);
for z=1:N
    subplot(N/2,N/4,z);
    plot(time_OT(initial_points(z):final_points(z)),OT_x(initial_points(z):final_points(z)),...
         T_BA_x(initial_points(z):final_points(z)),D_BA_x(initial_points(z):final_points(z)));
    legend('HTC','OT');
    subplot_title = sprintf('Segment #%d',z);
    title(subplot_title);
    xlabel('time (sec)');
    ylabel('position (m)');
end
suptitle(graph_title);

% start displaying results
header = sprintf('\nTest date: %s.03.2021 \nTest number: %s',test_date,test_number);
disp(header);

% calculate accuracy
accuracy = zeros(N,1);
error_mean_x = zeros(N,1);
error_mean_y = zeros(N,1);
error_mean_z = zeros(N,1);
max_size=0;
for v=1:N
    error_mean_x(v) = mean(D_BA_x(initial_points(v):final_points(v)) - OT_x(initial_points(v):final_points(v)));
    error_mean_y(v) = mean(D_BA_y(initial_points(v):final_points(v)) - OT_y(initial_points(v):final_points(v)));
    error_mean_z(v) = mean(D_BA_z(initial_points(v):final_points(v)) - OT_z(initial_points(v):final_points(v)));
    accuracy(v) = sqrt(error_mean_x(v)^2 + error_mean_y(v)^2 + error_mean_z(v)^2);
    result_segment = sprintf('Accuracy Segment #%d: %f cm',v,accuracy(v)*100);
    disp(result_segment);
    if max_size < size(D_BA_z(initial_points(v):final_points(v)),1)
        max_size = size(D_BA_z(initial_points(v):final_points(v)),1);
    end
end

% calculate repeatability
l_bar = zeros(N,1);
st_dev = zeros(N,1);
repeatability = zeros(N,1);
v=1;
for b=1:N
    l_bar(b) = mean(sqrt((D_BA_x(initial_points(b):final_points(b))-mean(D_BA_x(initial_points(b):final_points(b)))).^2+...
                         (D_BA_y(initial_points(b):final_points(b))-mean(D_BA_y(initial_points(b):final_points(b)))).^2+...
                         (D_BA_z(initial_points(b):final_points(b))-mean(D_BA_z(initial_points(b):final_points(b)))).^2));
    st_dev(b) = sqrt(sum((sqrt((D_BA_x(initial_points(b):final_points(b))-mean(D_BA_x(initial_points(b):final_points(b)))).^2+...
                               (D_BA_y(initial_points(b):final_points(b))-mean(D_BA_y(initial_points(b):final_points(b)))).^2+...
                               (D_BA_z(initial_points(b):final_points(b))-mean(D_BA_z(initial_points(b):final_points(b)))).^2)-...
                               l_bar(b)).^2)/(size(sqrt((D_BA_x(initial_points(b):final_points(b))-mean(D_BA_x(initial_points(b):final_points(b)))).^2+...
                                                        (D_BA_y(initial_points(b):final_points(b))-mean(D_BA_y(initial_points(b):final_points(b)))).^2+...
                                                        (D_BA_z(initial_points(b):final_points(b))-mean(D_BA_z(initial_points(b):final_points(b)))).^2),1)-1));
    repeatability(b) = l_bar(b) + 3 * st_dev(b);
    result_segment = sprintf('Repeatability Segment #%d: %f cm',v,repeatability(b)*100);
    disp(result_segment);
end