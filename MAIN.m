%%% Main Script

% load data 
data;
x1 = data(:,1);
y1 = data(:,2);
st = 10;
max_step = 1000;
points = length(x1);

% choose method of edge correction
method = ChooseEdgeCorrection();

% perform NDF analysis 
if method == 1 % NDF with edge corrections 
    [ndf, std_ndf] = ndf_ew(x1, y1, st, max_step, points);
else % without edge corrections 
    [ndf, std_ndf] = ndf_nocorr(x1, y1, st, max_step, points);
end

% display the NDF vector 
disp('NDF vector:');
disp(ndf(:,1));
