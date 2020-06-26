function ax = plot_voxel_dist(x,y,z)
% x,y,and z are scalars

dirname = '\\hippocampus.usc.edu\SocialDevelopmentProject\fMRI\BrainSuite\Stats\subject_session';
T = readtable('\\hippocampus.usc.edu\socialdevelopmentproject\fMRI\BrainSuite\Stats\Common_subjects_paired.csv');
aa10=dir(dirname);
com = intersect(str2mat(aa10.name), T.subjID);
wave1 = com(contains(com,'_01'));
wave2 = com(contains(com,'_02'));

for sub =1:length(wave1)
    fname_dJac = sprintf('%s\\%s\\%s.svreg.inv.jacobian.smooth1.0mm.nii.gz',dirname,wave1{sub},wave1{sub});
    
    if exist(fname_dJac, 'file')
        djac = load_untouch_nii(fname_dJac);
        jac_stats{sub,1} = wave1{sub};
        thal_vox = djac.img(x,y,z);
        jac_stats{sub,2} = thal_vox;
        clear djac
        
    end
end

gender = categorical(T.sex(1:2:end));
%B = cell2mat(jac_stats(gender == '1',2));
%G = cell2mat(jac_stats(gender == '2',2));

c = zeros(size(gender,1),3);
c(find(gender == '1'), 3) = 1; % blue = male
c(find(gender == '2')) = 1; % red = female
figure;
ax = scatter(gender, cell2mat(jac_stats(:,2)), [], c);
ax.Parent.XTickLabel = {'male','female'};
ax.Parent.YLabel.String = {'\Delta_{2-1} Jacobian determinant'};
ax.Parent.Title.String = "Subject Distribution at (87, 191, 237)";
ax.Parent.FontSize = 16;


end
