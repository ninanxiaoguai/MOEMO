clc,clear
% report 中的插图
x = load('fig/F2x.mat');
y = load('fig/F2y.mat');
subplot(3,2,1)
if(size(x.First_x,2) == 1)
    plot(x.First_x,-y.First_y,'k.')
else
    plot3(x.First_x(:,1),x.First_x(:,2),-y.First_y,'k.')
end
%%%%%%%%%%%%%
x = load('fig/F3x.mat');
y = load('fig/F3y.mat');
subplot(3,2,2)
if(size(x.First_x,2) == 1)
    plot(x.First_x,-y.First_y,'k.')
else
    plot3(x.First_x(:,1),x.First_x(:,2),-y.First_y,'k.')
end
%%%%%%%%%%%%%
x = load('fig/F4x.mat');
y = load('fig/F4y.mat');
subplot(3,2,3)
if(size(x.First_x,2) == 1)
    plot(x.First_x,-y.First_y,'k.')
else
    plot3(x.First_x(:,1),x.First_x(:,2),-y.First_y,'k.')
end
%%%%%%%%%%%%%
x = load('fig/F6x.mat');
y = load('fig/F6y.mat');
subplot(3,2,4)
if(size(x.First_x,2) == 1)
    plot(x.First_x,-y.First_y,'k.')
else
    plot3(x.First_x(:,1),x.First_x(:,2),-y.First_y,'k.')
end
%%%%%%%%%%%%%
x = load('fig/F7x.mat');
y = load('fig/F7y.mat');
subplot(3,2,5)
if(size(x.First_x,2) == 1)
    plot(x.First_x,-y.First_y,'k.')
else
    plot3(x.First_x(:,1),x.First_x(:,2),-y.First_y,'k.')
end
%%%%%%%%%%%%%
x = load('fig/F10x.mat');
y = load('fig/F10y.mat');
subplot(3,2,6)
if(size(x.First_x,2) == 1)
    plot(x.First_x,-y.First_y,'k.')
else
    plot3(x.First_x(:,1),x.First_x(:,2),-y.First_y,'k.')
end


