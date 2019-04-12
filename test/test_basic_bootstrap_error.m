
data=rand([1e3,1]);
anal_opp=@(x) mean(x);
real_samp_se=std(data,1)/sqrt(numel(data));
real_dist_ste=sqrt((1/12))/sqrt(numel(data));
%unifrm distributions give an oversetimated error in the SE

fignum=10;
boot=bootstrap_se(anal_opp,data,...
    'plots',true,...
    'replace',true,...
    'samp_frac_lims',[0.005,0.9],...
    'num_samp_frac',1e2,...
    'num_samp_rep',1e2,...
    'plot_fig_num',fignum,...
    'true_dist_se',real_dist_ste,...
    'true_samp_se',real_samp_se,...
    'mean_se_for_se_se',1)

%histogram the residuals to see if the moemnt based error is roughly correct
sfigure(2);
hist(abs((boot.se_opp-boot.opp_frac_est_se(:,2))./boot.opp_frac_est_se(:,3)),1e2)
%compare the error in the SE found using the moments to that computed using the spread in data 
(boot.se_se_opp)/boot.se_se_opp_unweighted
%find the fraction error in the error estimation
(real_dist_ste-boot.se_opp)/real_dist_ste
%find the number of estimated SD the real value is away
(real_dist_ste-boot.se_opp)/boot.se_se_opp

%%

data=num2cell(rand([1e2,2]),2);
d_flat=cell2mat(data);
d_flat=d_flat(:);
real_samp_se=std(d_flat,1)/sqrt(numel(d_flat));
real_dist_ste=sqrt((1/12))/sqrt(numel(d_flat));
%unifrm distributions give an oversetimated error in the SE

fignum=10;
boot=bootstrap_se(@(x) mean(mean(cell2mat(x))),data,...
    'plots',true,...
    'replace',true,...
    'samp_frac_lims',[0.005,0.9],...
    'num_samp_frac',1e1,...
    'num_samp_rep',1e2,...
    'plot_fig_num',fignum,...
    'true_dist_se',real_dist_ste,...
    'true_samp_se',real_samp_se)

%histogram the residuals to see if the moemnt based error is roughly correct
figure(2)
hist(abs((boot.se_opp-boot.opp_frac_est_se(:,2))./boot.opp_frac_est_se(:,3)),1e2)
%compare the error in the SE found using the moments to that computed using the spread in data 
(boot.std_se_opp-boot.std_se_opp_unweighted)/...
    min(boot.std_se_opp_unweighted)
%find the fraction error in the error estimation
(real_dist_ste-boot.se_opp)/real_dist_ste
%find the number of estimated SD the real value is away
(real_dist_ste-boot.se_opp)/boot.std_se_opp

%%

data=num2cell(rand([1e2,2]),2);
d_flat=cell2mat(data);
d_flat=d_flat(:,1);
real_samp_se=std(d_flat,1)/sqrt(numel(d_flat));
real_dist_ste=sqrt((1/12))/sqrt(numel(d_flat));
%unifrm distributions give an oversetimated error in the SE

fignum=10;
boot=bootstrap_se(@first_elm_avg,data,...
    'plots',true,...
    'replace',true,...
    'samp_frac_lims',[0.005,0.9],...
    'num_samp_frac',1e2,...
    'num_samp_rep',1e2,...
    'plot_fig_num',fignum,...
    'true_dist_se',real_dist_ste,...
    'true_samp_se',real_samp_se,...
    'save_multi_out',1)

%histogram the residuals to see if the moemnt based error is roughly correct
figure(2)
clf
hist(abs((boot.se_opp-boot.opp_frac_est_se(:,2))./boot.opp_frac_est_se(:,3)),1e2)
%compare the error in the SE found using the moments to that computed using the spread in data 
(boot.std_se_opp-boot.std_se_opp_unweighted)/...
    min(boot.std_se_opp_unweighted)
%find the fraction error in the error estimation
(real_dist_ste-boot.se_opp)/real_dist_ste
%find the number of estimated SD the real value is away
(real_dist_ste-boot.se_opp)/boot.std_se_opp


function [out1,out2]=first_elm_avg(in) 
    d_all=cell2mat(in);
    out1=mean(d_all(:,1));
    out2=mean(d_all(:,2));
end

function out=both_elm_avg(in) 
    d_flat=cell2mat(in);
    d_flat=d_flat(:);
    out=mean(d_flat);
end