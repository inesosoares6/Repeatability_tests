function [MaxIdx_OT,MinIdx_OT,MaxIdx_H,MinIdx_H,delay] = calculateDelay(time_OT,pos_OT,T_BA,D_BA)

    % find maxs and mins
    [~,MaxIdx_OT] = findpeaks(pos_OT,'MinPeakProminence',0.1);
    [~,MaxIdx_H] = findpeaks(D_BA,'MinPeakProminence',0.1);
    [~,MinIdx_OT] = findpeaks(-pos_OT,'MinPeakProminence',0.1);
    [~,MinIdx_H] = findpeaks(-D_BA,'MinPeakProminence',0.1);
    
    % verify if both max vectors and min vectors have the same size
    % sometimes findpeaks is not able to identify the first or last one
    if(size(MaxIdx_OT,1)~=size(MaxIdx_H,1))
        error_max_begin=MaxIdx_OT(1)-MaxIdx_H(1);
        error_max_last=MaxIdx_OT(size(MaxIdx_OT,1))-MaxIdx_H(size(MaxIdx_H,1));
        if error_max_begin>50
            MaxIdx_H(1)=[];
        elseif error_max_begin<-50
            MaxIdx_OT(1)=[];
        elseif error_max_last>50
            MaxIdx_OT(size(MaxIdx_OT,1))=[];
        elseif error_max_last<-50
            MaxIdx_H(size(MaxIdx_H,1))=[];
        end
    elseif(size(MinIdx_OT,1)~=size(MinIdx_H,1))
        error_min_begin = MinIdx_OT(1)-MinIdx_H(1);
        error_min_last = MinIdx_OT(size(MinIdx_OT,1))-MinIdx_H(size(MinIdx_H,1));
        if error_min_begin>50
            MinIdx_H(1)=[];
        elseif error_min_begin<-50
            MinIdx_OT(1)=[];
        end
        if error_min_last>50
            MinIdx_OT(size(MinIdx_OT,1))=[];
        elseif error_min_last<-50
            MinIdx_H(size(MinIdx_H,1))=[];
        end   
    else
        error_max_vec=MaxIdx_OT-MaxIdx_H;
        for i=1:size(MaxIdx_OT,1)
            if abs(error_max_vec(i))>50
                MaxIdx_H(i)=[];
                MaxIdx_OT(i)=[];
            end
        end
        error_min_vec=MinIdx_OT-MinIdx_H;
        for i=1:size(MinIdx_OT,1)
            if abs(error_min_vec(i))>50
                MinIdx_H(i)=[];
                MinIdx_OT(i)=[];
            end
        end
    end
    %calculate delay
    delay = (mean(T_BA(MinIdx_H)-time_OT(MinIdx_OT))+mean(T_BA(MaxIdx_H)-time_OT(MaxIdx_OT)))/2;
end

