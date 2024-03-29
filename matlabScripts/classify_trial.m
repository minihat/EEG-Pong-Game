%% Pass to this function the unfiltered, uncropped signal with all 8 channels after the trial. 
%It should output the trial type!!!
function type = classify_trial(eeg_uf)

    cow = load('transformLeft.mat');
    W = cow.W_left

%   W = ones(2, 16);

    fs=1000;
    cutoff = [6 15];
    [num,den] = butter(2,cutoff*2/fs, 'bandpass');
    eeg = filtfilt(num, den, transpose(eeg_uf));

    size(eeg)
    Z = W*transpose(eeg);
    
    %% Differentiation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     threshold = 0;
%     theta = 1;
%     type = sign(theta*log10(var(transpose(Z(:,1))) + threshold));
    
    %% Differentiation II %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Using Left Transformation Matrix means first row is left type and if
    %this row has the lower activity it means left movement so...
    x = Z(1,:)*(Z(1,:))';
    y = Z(2,:)*(Z(2,:))';
    
    class = x / y;
    if class <=.5
        type = -1;   %move left
    elseif class > .5 && class <1.5
        type = 0;    %none
    elseif class >= 1.5
        type = 1;    %move right
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end


