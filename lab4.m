clc; clear;
X = [0 0 1;0 1 1;1 0 1;1 1 1];
t = [0;0;1;1];
wB = randn(3,1); wS = wB; eta = 0.1;
for i = 1:50
    % Batch
    e = t - X*wB;
    wB = wB + eta*(X'*e)/4;
    mseB(i) = mean(e.^2);
    % SGD
    for j = 1:4
        e = t(j) - X(j,:)*wS;
        wS = wS + eta*X(j,:)'*e;
    end
    mseS(i) = mean((t - X*wS).^2);
end
subplot(1,2,1)
plot(mseB), hold on, plot(mseS)
grid on, legend Batch SGD, title MSE
subplot(1,2,2)
plot(t,'k-o'), hold on
plot(X*wB,'b-o'), plot(X*wS,'r-o')
grid on, legend Target Batch SGD, title Output