function Pin = PinningFunc(x,y,type,a1x,a2x,a2y,Lx,Ly,R,w)
%This function returns the pinning function of a net of N vortecies in each 
% direction given configuration (defined under 'type')with given base 
%vectors a1, a2 on a 2D supoerconductor sample Lx x Ly in a given geometry. 
%(only square-has to be updated). 
%The vortecies have the radius defined in the vector R and anullus in w.
%(Actually the radius and annulus are kept constant now - gonna be updated)
%Remember, having more than 20 vortecies insists to have geometry at least
%20x20 in COMSOL.
%The base vector a1 is parallel to the side of the geometry

%---Error estimation-------------------------------------------------------
if(2*R+2*w<a1x)
    Pin=0; %overlapping of vortecies
end
%... and more others - in progres til 31.08.2025
%---Defining lattice of pins-----------------------------------------------
N1=0; N2=0;
temp = -Lx/2 +2*R;
while(temp>-Lx)
   temp = temp + a1x + a2x;
   if(temp<Lx/2-2*R) 
       break; 
   end
   N1 = N1 + 1; 
end
delx = (Lx-4*R - temp - a1x-a2x)/2; %last temp a;ready exceeds
temp = 0;
while(temp>-Ly)
   temp = temp + a2y;
   if(temp<Ly/2-2*R) 
       break; 
   end
   N2 = N2 + 1;
end
dely = (Ly-4*R - temp - a2y)/2;
x0 = zeros(N1,N2);
y0 = zeros(N1,N2);
if(type==1)
    for i=1:N1
        for j=1:N2
            x0(i,j) = -Lx+delx+2*R + i*a1x + j*a2x;
            y0(i,j) = -Ly+dely+2*R + j*a2y;
            x0(i+1,j) = -Lx+delx+2*R + (i+0.5)*a1x + (j+0.5)*a2x;
            y0(i+1,j) = -Ly+dely+2*R + j*a2y;
            x0(i+2,j) = -Lx+delx+2*R + i*a1x + j*a2x;
            y0(i+2,j) = -Ly+dely+2*R + (i+0.5)*a1y + (j+0.5)*a2y;
        end
    end
else
    for i=1:N1
        for j=1:N2
            x0(i) = -Lx+delx+2*R + j*a2x;
            y0(i) = -Ly+dely+2*R + i*a1y + j*a2y;
        end
    end
end
%---Calculating output function--------------------------------------------
dummy = 1;
for i=1:N1
	for j=1:N2
        dummy = dummy*tanh(( sqrt((x-x0(i,j))^2 + (y-y0(i,j))^2) - R)/w);
	end
end
Pin = dummy;


end






%-------------------------------------------------
% switch(type)
%     case 'square':
%         for i=1:N
%             for j=1:N
%                 x0(i) = i*a1(1) + j*a2(1);
%                 y0(i) = i*a1(2) + j*a2(2);
%             end
%         end
%     case 'triangle':
%         
%     case 'hexagonal':
%         
%     case 'kagome':
%         
%     otherwise
%         Pin = 0;
% end
