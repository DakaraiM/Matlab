function plot_ROI(stats,roi_num,T,roi,type)
% T contains participant information
% ROI is the vector of avaialbe ROI's
% roi_num is the specific ROI of choice
% type is the binary statistical map
% stats is a cell structure

% GET: ROI look up table for names. 

if type == "WM"
    type_num = 2;
elseif type == "GM"
    type_num = 3;
elseif type == "subcortical"
    type_num = 4;
else
    msg = "Choose type to be WM, GM, or subcortical";
    error(msg);
end


ROI = find(roi == roi_num);
gender = categorical(T.sex(1:2:end));
B = cell2mat(stats(gender == '1',type_num));
G = cell2mat(stats(gender == '2',type_num));
figure;
scatter(gender(gender == '1'), B(:,ROI));
hold on; scatter(gender(gender=='2'), G(:,ROI))

% use ROI look up table to get name. 
title(sprintf("Average %s in %s ",type, num2str(roi_num)))


% coord: 88 191 230
% option to print all
% for i = roi
%     ROI = find(roi == i);
%     gender = categorical(T.sex(1:2:end));
%     B = cell2mat(stats(gender == '1',type_num));
%     G = cell2mat(stats(gender == '2',type_num));
%     figure;
%     scatter(gender(gender == '1'), B(:,ROI));
%     hold on; scatter(gender(gender=='2'), G(:,ROI))
% end
end