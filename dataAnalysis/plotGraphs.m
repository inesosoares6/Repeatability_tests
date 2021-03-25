function plotGraphs(opt,time_OT,position_OT,time_HL,position_HL,T_BA,D_BA,cell_delay,MaxIdx_OT,MinIdx_OT,MaxIdx_HL,MinIdx_HL)
    N = size(time_OT,1);
    if(opt==1)
        figure(1);
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
    
   elseif(opt==2)
        figure(2);
        plot(time_OT,position_OT,'r',...
             time_OT(MaxIdx_OT),position_OT(MaxIdx_OT),'r*',...
             time_OT(MinIdx_OT),position_OT(MinIdx_OT),'r*',...
             T_BA,D_BA,'b',...
             T_BA(MaxIdx_HL),D_BA(MaxIdx_HL),'b*',...
             T_BA(MinIdx_HL),D_BA(MinIdx_HL),'b*');
        title('Find maxs & mins');
        xlabel('time (sec)');
        ylabel('z position (m)');
        legend('OT','OT_{max}','OT_{min}','HL','HL_{max}','HL_{min}');
       
        figure(3);
        subplot(2,1,1);
        plot(time_OT,position_OT,'r',...
             T_BA,D_BA,'b');
        legend('OT','HL');
        title('Initial result');
        xlabel('time (sec)');
        ylabel('z position (m)');

        subplot(2,1,2);
        plot(time_OT(1:N-cell_delay),position_OT(1:N-cell_delay),'r',...
             T_BA(1:N-cell_delay),D_BA(cell_delay+1:N),'b');
        legend('OT','HL_{modified}');
        title('Final result');
        xlabel('time (sec)');
        ylabel('z position (m)');
    else
        error('Select a correct option to plot graphs');
    end
end

