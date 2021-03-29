%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)
% 
% ----- Function to calculate the average speed in speed tests -------

function [velocity] = calculateVelocity(T_BA,D_BA,MaxIdx_H,MinIdx_H)
    samples = (size(MaxIdx_H,1)+size(MinIdx_H,1))-1;
    velocity=zeros(samples,1);
    m=1;
    for l=1:2:samples
        if(l==samples)
            velocity(l)= abs((D_BA(MaxIdx_H(m))-D_BA(MinIdx_H(m))) / (T_BA(MinIdx_H(m))-T_BA(MaxIdx_H(m))));
        elseif(MaxIdx_H(1) < MinIdx_H(1))
            velocity(l)= abs((D_BA(MaxIdx_H(m))-D_BA(MinIdx_H(m))) / (T_BA(MinIdx_H(m))-T_BA(MaxIdx_H(m))));
            velocity(l+1)= abs((D_BA(MaxIdx_H(m+1))-D_BA(MinIdx_H(m))) / (T_BA(MinIdx_H(m))-T_BA(MaxIdx_H(m+1))));
        elseif(MaxIdx_H(1) > MinIdx_H(1))
            velocity(l)= abs((D_BA(MaxIdx_H(m))-D_BA(MinIdx_H(m))) / (T_BA(MinIdx_H(m))-T_BA(MaxIdx_H(m))));
            velocity(l+1)= abs((D_BA(MaxIdx_H(m))-D_BA(MinIdx_H(m+1))) / (T_BA(MinIdx_H(m+1))-T_BA(MaxIdx_H(m))));
        end
        m=m+1;
    end
end

