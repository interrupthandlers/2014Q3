%% TIINCO 1st Hand in Assignment
% A description of the functions used can be found in the Appendix
%% 1.3 
% Calculate the source entropy, the transinformation I (X, Y) and the
% capacity of the BSC defined in Figure P.1.1.

%%
% 
% <<pictures/P.1.1.PNG>>
% 

p = 0.25;
alpha = 0.2;

%%
% Source entropy H(X)
H_X = omega(alpha)

%%
% Average mutual information (transinformation) I(X,Y)
I_XY = omega(alpha + p -2*alpha*p) - omega(p) 

%%
% Channel capacity C
C = 1 - omega(p)


%% 1.6
% What is the capacity of the cascade of BSCs as given in Figure P.1.2?
%%
% 
% <<pictures/P.1.2.PNG>>
% 

p_cascade = 2 * (0.1 * 0.9)

C_cascade = 1 - omega(p_cascade)

%% 1.8
% Find the conditional probabilities P(xi/yj) of the BEC with an erasure probability of 0.469, when the source probabilities are 0.25 and 0.75. Hence find the equivocation, transinformation and capacity of the channel.

p = 0.469;
alpha = 0.25;
P_X0 = 0.25;
P_X1 = 0.75;

%%
% Output probabilities

P_Y0 = P_X0 * (1 - p);

P_Yerror = p;

P_Y1 = P_X1 * (1 - p);

%%
% Conditional probabilities (backward) P(xi/yj) 

P_X0Y0 = ((1 - p) * P_X0)/P_Y0

P_X0Yerror = (p * P_X0)/P_Yerror

P_X1Yerror = (p * P_X1)/P_Yerror

P_X1Y1 = ((1 - p) * P_X1)/P_Y1


%%
% Transinformation
I_XY = (1-p) * omega(alpha)

%%
% Equivocation H(X/Y)

% Source entropy 
H_X = P_X0 * log2(1/P_X0) + P_X1 * log2(1/P_X1);

H_XY = H_X - I_XY


%%
% Capacity
C = 1 - p

%% Appendix
% function o = omega(x)
%%
% o = x * log2(1/x) + (1-x) * log2(1/(1-x)); 


