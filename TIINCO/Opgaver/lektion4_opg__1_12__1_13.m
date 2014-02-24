%% Exercise 1.12 and 1.13 
%% 1.12
% Consider transmission over a telephone line with a bandwidth B = 3 kHz. 
% This is an analogue channel which can be considered as perturbed by AWGN, 
% and for which the power signal-to-noise ratio is at least 30 dB.
clear; clc;

B = 3000;

SNR = 30;

%%
% (a) What is the capacity of this channel, in the above conditions?

% Calculate the signal-to-noise ratio in gain (power)
SNRgain = 10 ^ (SNR/10);

% Capacity formula
C = B * log2(1+SNRgain)

%%
% (b) What is the required signal-to-noise ratio to transmit an M-ary signal able to
% carry 19,200 bps?

Creq = 19200;

% Calculate the reguired gain (power)
SNRgainReq = 2^(Creq/B)-1;

% Convert to dB
SNRreq = 10*log10(SNRgainReq)


%% 1.13
% An analogue channel perturbed by AWGN has a bandwidth B = 25 kHz and a
% power signal-to-noise ratio SNR of 18 dB. What is the capacity of this channel
% in bits per second?

B = 25000;
SNR = 18;
SNRgain = 10^(SNR/10);

C = B * log2(1+SNRgain)