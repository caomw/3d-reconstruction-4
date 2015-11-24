function [ camMat ] = computeCamMat (proj_pts, real_pts)
%ComputeCamMat Computes Camera Matrix and saves to workspace
%   Detailed explanation goes here
    
    all_mean = mean2([mean2(proj_pts) mean2(real_pts)]);
    all_sd =  std2([std2(proj_pts) std2(real_pts)]);
    
    proj_pts = ((proj_pts - all_mean)/ all_sd) * sqrt(2)
    real_pts = ((real_pts - all_mean)/ all_sd) * sqrt(2)
    
%     add ones
    proj_pts = [ proj_pts ones(6,1) ];
    real_pts = [ real_pts ones(6,1) ];

    camMat = [0 0 0 0 -proj_pts(1 , 3) * real_pts(1,:) proj_pts(1, 2) *  real_pts(1,:);
                  proj_pts(1 , 3) * real_pts(1,:) 0 0 0 0 -proj_pts(1, 1) *  real_pts(1,:) ] ; 
              
    for i = 2: length(proj_pts)
        camMat =  [camMat ;  0 0 0 0 -proj_pts(i , 3) * real_pts(i,:) proj_pts(i, 2) *  real_pts(i,:);
                  proj_pts(i , 3) * real_pts(i,:) 0 0 0 0 -proj_pts(i, 1) *  real_pts(i,:) ];
    end;
    
    [U S V] = svd(A);
    P = V(:, end);
    camMat = reshape(P, 4,3);
%   TODO unnormalize the points here
end

