clc; clear; close all;
X=[-1 -1;-1 1;1 -1;1 1];
T=[-1;-1;-1;1];
w=rand(2,1);
b=rand;
lr=0.1;
for e=1:100
    E(e)=0;

    for i=1:4
        y=sign(w'*X(i,:)'+b);
        if y==0, y=-1; end

        er=T(i)-y;

        w=w+lr*er*X(i,:)';
        b=b+lr*er;

        E(e)=E(e)+er^2;
    end
end
% Smooth convergence plot
plot(movmean(E,5),'LineWidth',2)
title('Error Curve')
grid on
% Decision boundary
figure
gscatter(X(:,1),X(:,2),T,'rg','o',8)
hold on
x=-2:0.1:2;
plot(x,-(w(1)*x+b)/w(2),'b','LineWidth',2)
title('Decision Boundary')
grid on