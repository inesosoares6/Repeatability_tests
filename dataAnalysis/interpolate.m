%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)
% 
% ----- Function to interpolate HL2/HTC data to match OptiTrack ------

function [T_BA, D_BA] = interpolate(time_OT,position_OT,time_HL,position_HL)
    D_BA = zeros(size(position_OT));
    T_BA = zeros(size(time_OT));
    for i = 1:size(position_OT,1)
        for j = 1:size(position_HL,1)
            if time_HL(j) > time_OT(i)
                if j==1
                    j0 = 1;
                    jf = 2;
                else
                    j0 = j-1;
                    jf = j;
                end
                D_BA(i) = position_HL(j0)+(position_HL(jf)-position_HL(j0))/(time_HL(jf)-time_HL(j0))*(time_OT(i)-time_HL(j0));
                T_BA(i) = time_OT(i);
                break;
            elseif time_HL(j) == time_OT(i)
                D_BA(i) = position_HL(j);
                T_BA(i) = time_OT(i);
                break;
            end
        end
    end
end

