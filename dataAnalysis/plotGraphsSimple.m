%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)
% 
% ------ Function to plot the graphs for same position tests ---------

function plotGraphsSimple(timestamp,H_x,H_y,H_z,OT_x,OT_y,OT_z,Error)
        figure(1);
        subplot(2,2,1);
        plot(timestamp,H_x,'b',...
             timestamp,OT_x,'r');
        legend('H','OT');
        title('Axis x');
        xlabel('time (sec)');
        ylabel('position (m)');

        subplot(2,2,2);
        plot(timestamp,H_y,'b',...
             timestamp,OT_y,'r');
        legend('H','OT');
        title('Axis y');
        xlabel('time (sec)');
        ylabel('position (m)');

        subplot(2,2,3);
        plot(timestamp,H_z,'b',...
             timestamp,OT_z,'r');
        legend('H','OT');
        title('Axis z');
        xlabel('time (sec)');
        ylabel('position (m)');

        subplot(2,2,4);
        plot(timestamp,Error);
        title('Error');
        xlabel('time (sec)');
        ylabel('position (m)');
        
end

