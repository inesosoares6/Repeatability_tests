function [MaxIdx_OT,MinIdx_OT,MaxIdx_HL,MinIdx_HL,delay] = calculateDelay(time_OT,position_OT,T_BA,D_BA)

    % find maxs and mins
    [~,MaxIdx_OT] = findpeaks(position_OT,'MinPeakProminence',0.1);
    [~,MaxIdx_HL] = findpeaks(D_BA,'MinPeakProminence',0.1);
    [~,MinIdx_OT] = findpeaks(-position_OT,'MinPeakProminence',0.1);
    [~,MinIdx_HL] = findpeaks(-D_BA,'MinPeakProminence',0.1);
    
    % verify if both max vectors and min vectors have the same size
    % sometimes findpeaks is not able to identify the first one
    if(size(MaxIdx_OT,1)~=size(MaxIdx_HL,1))
        error_max=MaxIdx_OT(1)-MaxIdx_HL(1);
        if error_max>20
            MaxIdx_HL(1)=[];
        elseif error_max<20
            MaxIdx_OT(1)=[];
        end
    elseif(size(MinIdx_OT,1)~=size(MinIdx_HL,1))
        error_min=MinIdx_OT(1)-MinIdx_HL(1);
        if error_min>20
            MinIdx_HL(1)=[];
        elseif error_min<20
            MinIdx_OT(1)=[];
        end
    else
        error_max_vec=MaxIdx_OT-MaxIdx_HL;
        for i=1:size(MaxIdx_OT,1)
            if abs(error_max_vec(i))>20
                MaxIdx_HL(i)=[];
                MaxIdx_OT(i)=[];
            end
        end
        error_min_vec=MinIdx_OT-MinIdx_HL;
        for i=1:size(MinIdx_OT,1)
            if abs(error_min_vec(i))>20
                MinIdx_HL(i)=[];
                MinIdx_OT(i)=[];
            end
        end
    end
    
    %calculate delay
    delay = (mean(T_BA(MinIdx_HL)-time_OT(MinIdx_OT))+mean(T_BA(MaxIdx_HL)-time_OT(MaxIdx_OT)))/2;
end

