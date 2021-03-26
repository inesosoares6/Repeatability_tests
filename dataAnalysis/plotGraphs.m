function plotGraphs(opt,time_OT,pos_OT,time_H,pos_H,T_BA,D_BA,cell_delay,MaxIdx_OT,MinIdx_OT,MaxIdx_H,MinIdx_H)
    N = size(time_OT,1);
    if(opt==1)
        figure(1);
        
        subplot(3,2,1);
        plot(time_H,pos_H,'b');
        title('HoloLens2 / HTC Vive');
        xlabel('time (sec)');
        ylabel('position (m)');

        subplot(3,2,2);
        plot(time_OT,pos_OT,'g');
        title('OptiTrack');
        xlabel('time (sec)');
        ylabel('position (m)');

        subplot(3,2,[3,4]);
        plot(time_H,pos_H,'b',time_OT,pos_OT,'g');
        legend('H','OT');
        title('Position');
        xlabel('time (sec)');
        ylabel('position (m)');

        subplot(3,2,[5,6]);
        plot(T_BA,D_BA,'b',time_OT,pos_OT,'g');
        legend('Hinterpolated','OT');
        title('Interpolation');
        xlabel('time (sec)');
        ylabel('position (m)');
    
   elseif(opt==2)
        figure(2);
        
        plot(time_OT,pos_OT,'r',...
             time_OT(MaxIdx_OT),pos_OT(MaxIdx_OT),'r*',...
             time_OT(MinIdx_OT),pos_OT(MinIdx_OT),'r*',...
             T_BA,D_BA,'b',...
             T_BA(MaxIdx_H),D_BA(MaxIdx_H),'b*',...
             T_BA(MinIdx_H),D_BA(MinIdx_H),'b*');
        title('Find maxs & mins');
        xlabel('time (sec)');
        ylabel('position (m)');
        legend('OT','OT_{max}','OT_{min}','H','H_{max}','H_{min}');
        
    elseif(opt==3)
        figure(3);
        
        subplot(2,1,1);
        plot(time_OT,pos_OT,'r',...
             T_BA,D_BA,'b');
        legend('OT','H');
        title('Initial result');
        xlabel('time (sec)');
        ylabel('position (m)');

        subplot(2,1,2);
        plot(time_OT(1:N-cell_delay),pos_OT(1:N-cell_delay),'r',...
             T_BA(1:N-cell_delay),D_BA(cell_delay+1:N),'b');
        legend('OT','H_{modified}');
        title('Final result');
        xlabel('time (sec)');
        ylabel('position (m)');
    else
        error('Select a correct option to plot graphs');
    end
end

