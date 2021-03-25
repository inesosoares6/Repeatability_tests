function [velocity] = calculateVelocity(T_BA,D_BA,MaxIdx_HL,MinIdx_HL)
    samples = (size(MaxIdx_HL,1)+size(MinIdx_HL,1))-1;
    velocity=zeros(samples,1);
    m=1;
    for l=1:2:samples
        if(l==samples)
            velocity(l)= abs((D_BA(MaxIdx_HL(m))-D_BA(MinIdx_HL(m))) / (T_BA(MinIdx_HL(m))-T_BA(MaxIdx_HL(m))));
        elseif(MaxIdx_HL(1) < MinIdx_HL(1))
            velocity(l)= abs((D_BA(MaxIdx_HL(m))-D_BA(MinIdx_HL(m))) / (T_BA(MinIdx_HL(m))-T_BA(MaxIdx_HL(m))));
            velocity(l+1)= abs((D_BA(MaxIdx_HL(m+1))-D_BA(MinIdx_HL(m))) / (T_BA(MinIdx_HL(m))-T_BA(MaxIdx_HL(m+1))));
        elseif(MaxIdx_HL(1) > MinIdx_HL(1))
            velocity(l)= abs((D_BA(MaxIdx_HL(m))-D_BA(MinIdx_HL(m))) / (T_BA(MinIdx_HL(m))-T_BA(MaxIdx_HL(m))));
            velocity(l+1)= abs((D_BA(MaxIdx_HL(m))-D_BA(MinIdx_HL(m+1))) / (T_BA(MinIdx_HL(m+1))-T_BA(MaxIdx_HL(m))));
        end
        m=m+1;
    end
end

