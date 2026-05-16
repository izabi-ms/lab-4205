clc; clear; close all
% Digits (5×5×5)
D(:,:,1)=[-1 1 1 -1 -1;-1 -1 1 -1 -1;-1 -1 1 -1 -1;-1 -1 1 -1 -1;-1 1 1 1 -1];
D(:,:,2)=[-1 1 1 1 -1;-1 -1 -1 1 -1;-1 1 1 1 -1;-1 1 -1 -1 -1;-1 1 1 1 -1];
D(:,:,3)=[-1 1 1 1 -1;-1 -1 -1 1 -1;-1 1 1 1 -1;-1 -1 -1 1 -1;-1 1 1 1 -1];
D(:,:,4)=[-1 1 -1 1 -1;-1 1 -1 1 -1;-1 1 1 1 -1;-1 -1 -1 1 -1;-1 -1 -1 1 -1];
D(:,:,5)=[-1 1 1 1 -1;-1 1 -1 -1 -1;-1 1 1 1 -1;-1 -1 -1 1 -1;-1 1 1 1 -1];
% Input + bias
X = [reshape(D,25,5); ones(1,5)];
T = eye(5);
% Train
W = randn(5,26)/10; eta = .1;
for k = 1:300
    E = T - W*X;
    W = W + eta*E*X'/5;
    if mean(E(:).^2) < 1e-5, break; end
end
% Plot
figure
for i = 1:5
    subplot(2,5,i), imagesc(D(:,:,i)), colormap gray, axis off
    subplot(2,5,i+5), bar(W*X(:,i)), ylim([-0.5 1.5]), grid on
end
