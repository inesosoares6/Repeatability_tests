function plotGraphsSimple(timestamp,HL_x,HL_y,HL_z,OT_x,OT_y,OT_z,Error)
        figure(1);
        subplot(2,2,1);
        plot(timestamp,HL_x,'b',...
             timestamp,OT_x,'r');
        legend('HL2','OT');
        title('Axis x');
        xlabel('time (sec)');
        ylabel('position (m)');

        subplot(2,2,2);
        plot(timestamp,HL_y,'b',...
             timestamp,OT_y,'r');
        legend('HL2','OT');
        title('Axis y');
        xlabel('time (sec)');
        ylabel('position (m)');

        subplot(2,2,3);
        plot(timestamp,HL_z,'b',...
             timestamp,OT_z,'r');
        legend('HL2','OT');
        title('Axis z');
        xlabel('time (sec)');
        ylabel('position (m)');

        subplot(2,2,4);
        plot(timestamp,Error);
        title('Error');
        xlabel('time (sec)');
        ylabel('position (m)');
end

