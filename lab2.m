clc; clear;
X=[0 0 1;0 1 1;1 0 1;1 1 1];
D=[0;0;1;1];
w=rand(1,3);
lr=.2;
for n=1:100
    E(n)=0;
    for i=1:4
        y=1/(1+exp(-w*X(i,:)'));
        e=D(i)-y;
        w=w+lr*e*X(i,:);
        E(n)=E(n)+e^2;
    end
end
subplot(121)
plot(E),grid on,title('Covergence curve')
subplot(122),hold on,grid on
plot(0,0,'bo',0,1,'bo')
plot(1,0,'rx',1,1,'rx')
x=-1:.1:2;
plot(x,-(w(1)*x+w(3))/w(2),'k')
title('Boundary')