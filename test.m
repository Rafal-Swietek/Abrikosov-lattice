clear all
clc

Lx = 20;
Ly = 20;
R = 0.2;
w = 0.05;
n = length(-Lx:0.01:Lx);
z = zeros(n,n);
ii = 1;
for x=-Lx:0.01:Lx
    j = 1;
    for y=-Ly:0.01:Ly
        z(ii,j) = PinningFunc(x,y,2,1,0.5,sqrt(3)/2,2*Lx,2*Ly,R,w);
        j = j +1;
    end
    ii = ii+1;
end
mesh(z);
axis([0 800 0 800 -2 2]);