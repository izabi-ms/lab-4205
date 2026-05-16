x=[0.05;0.10]; t=[0.01;0.99]; a=0.5;
Wih=[0.15 0.25;0.20 0.30]; bh=[0.35;0.35];
Who=[0.40 0.50;0.45 0.55]; bo=[0.60;0.60];
sig=@(z)1./(1+exp(-z));
for i=1:1e4
    h=sig(Wih'*x+bh);
    y=sig(Who'*h+bo);
    E=0.5*sum((t-y).^2);
    if E<1e-7, break, end
    dy=(y-t).*y.*(1-y);
    dh=(Who*dy).*h.*(1-h);
    Who=Who-a*h*dy';
    bo=bo-a*dy;
    Wih=Wih-a*x*dh';
    bh=bh-a*dh;
    fprintf('ep=%d E=%.6f y=[%.4f %.4f]\n',i,E,y(1),y(2));
end