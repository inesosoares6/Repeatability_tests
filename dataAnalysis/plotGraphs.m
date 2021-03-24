function [debug] = plotGraphs(time_OT,position_OT,time_HL,position_HL,T_BA,D_BA)
    figure();
    subplot(3,2,1);
    plot(time_HL,position_HL,'b');
    title('HoloLens2');
    xlabel('time (sec)');
    ylabel('z position (m)');

    subplot(3,2,2);
    plot(time_OT,position_OT,'g');
    title('OptiTrack');
    xlabel('time (sec)');
    ylabel('z position (m)');

    subplot(3,2,[3,4]);
    plot(time_HL,position_HL,'b',time_OT,position_OT,'g');
    legend('HL2','OT');
    title('HoloLens2 & OptiTrack');
    xlabel('time (sec)');
    ylabel('z position (m)');

    subplot(3,2,[5,6]);
    plot(T_BA,D_BA,'b',time_OT,position_OT,'g');
    legend('HL2interpolated','OT');
    title('Interpolation');
    xlabel('time (sec)');
    ylabel('z position (m)');
    
    figure();
    plot(T_BA(1:size(D_BA,1)),position_OT(1:size(D_BA,1)),'r',...
         T_BA(1:size(D_BA,1)-19),D_BA(20:size(D_BA,1)),...
         T_BA(1:size(D_BA,1)-14),D_BA(15:size(D_BA,1)),...
         T_BA(1:size(D_BA,1)-9),D_BA(10:size(D_BA,1)),...
         T_BA(1:size(D_BA,1)-4),D_BA(5:size(D_BA,1)));
    legend('OT','HL-20','HL-15','HL-10','HL-5');
    title('Errors comparison');
    xlabel('time (sec)');
    ylabel('z position (m)');
    
    debug=1;
end

