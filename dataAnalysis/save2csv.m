%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)
% 
% ----- Function to save the interpolated & synchronized data -------

function save2csv(write_file,time_OT,D_BA_x,D_BA_y,D_BA_z,OT_x,OT_y,OT_z)

    matrix =[time_OT D_BA_x D_BA_y D_BA_z OT_x OT_y OT_z];
    T = array2table(matrix);
    T.Properties.VariableNames(1:7) = {'time','HL_x','HL_y','HL_z','OT_x','OT_y','OT_z'};
    writetable(T,write_file);
    
end

