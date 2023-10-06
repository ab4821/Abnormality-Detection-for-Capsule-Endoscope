%% get dataset 
data5 = importdata ('Indentation5mm.csv');

clc; 
clear;

data5 = importdata ('Indentation5mm.csv');
x = data5(:,2);
time = data5(:,1);
plot(data5(:,1), x);
reading = data5(:,2);

% define number of levels to use
numLevels = 6;
% perform maximal overlap discrete wavelet transform (MODWT)
wt = modwt(reading, 'db4', numLevels);

%% COMPARE COEFFICENTS FOR ALL MODWT SCALES

% get number of Wavelet Scales
[numScales, ~] = size(wt);

% create figure
fig = figure(1);
fig.Units = 'normalized';
fig.Position = [0 0 1 1];

% plot original signal
subplot(numScales+1,1,1)
plot(reading, 'r-')
title('Orginal', 'FontSize', 14)
axis tight

% plot wavelet scale coefficents
for i=2:numScales+1
    
    subplot(numScales+1,1,i)
    plot(wt(i-1,:))
    title(strcat('Wavelet Scale 2^', string(i-2)), 'FontSize', 14)
    axis tight
end

xlabel('Time', 'FontSize', 14)

% print figure to file
print('waveletTransform_signal_decomposition', '-dpng');
%% RECONSTRUCT SIGNAL VIA INVERSE MODWT

% create figure
fig = figure(2);
fig.Units = 'normalized';
fig.Position = [0 0 1 1];

% initialize an array to store the coefficents corresponding to scale 2^4
recwt = zeros(size(wt));

% store coefficents corresponding to scale 4 in array
recwt(4,:) = wt(4,:);

% reconstruct signal using only scale 4 with inverse transform
recReading = imodwt(recwt,'db4');

% compare original signal and reconstructed
% plot original signal
subplot(2,1,1)
plot(reading, 'r-')
title('Orginal', 'FontSize', 16)
xlabel('Time', 'FontSize', 14)
axis tight
% plot reconstructed signal
subplot(2,1,2)
plot(recReading)
title('Reconstructed', 'FontSize', 16)
xlabel('Time', 'FontSize', 14)
axis tight

% print figure to file
print('waveletTransform_reconstructed_signal', '-dpng');
%% FIND R PEAKS USING RECONSTRUCTED SIGNAL

% define array of time indicies
t = 1:length(reading);

% square reconstructed signal
recReading = abs(recReading).^2;
% find peaks in squared reconstructed signal
[qrspeaks,locs] = findpeaks(recReading, t, 'MinPeakHeight', 0.1, 'MinPeakDistance',200);

% create figure
fig = figure(3);
fig.Units = 'normalized';
fig.Position = [0 0 1 1];

% plot signal with detected r peaks using reconstructed signal from DWT
plot(t,reading)
hold on
plot(locs,reading(locs),'ro', 'LineWidth',2)
xlabel('Time', 'FontSize', 14)
title('R Peaks Detected Using Reconstructed Signal from Wavelet Transform', ...
    'FontSize', 16)
axis tight
print('waveletTransform_rpeak_annotation', '-dpng');