clc; clear;
X = [0 0 1;
    0 1 1;
    1 0 1;
    1 1 1];
D = [0; 0; 1; 1];
w = rand(1,3);
lr = 0.2;
for n = 1:100
    E(n) = 0;
    grad = [0 0 0];
    for i = 1:4
        y = 1/(1 + exp(-w * X(i,:)'));
        e = D(i) - y;
        grad = grad + e * y * (1-y) * X(i,:); % Delta rule (with derivative)
        E(n) = E(n) + e^2;
    end
    w = w + lr * grad; % batch update once per epoch
end
% ---------- plots ----------
subplot(121)
plot(E), grid on
title('Convergence curve')
subplot(122), hold on, grid on
plot(0,0,'bo',0,1,'bo')
plot(1,0,'rx',1,1,'rx')
x = -1:0.1:2;
plot(x, -(w(1)*x + w(3))/w(2), 'k')
axis([-1 2 -1 2]) % tighter axis so the boundary is readable
title('Boundary')