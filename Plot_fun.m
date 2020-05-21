function Plot_fun(number,Population,FunctionValue)
    if(get_dimension(number) < 3)

        switch number
            case 1
                % F1: Five-Uneven-Peak Trap
                x=[0:0.1:30];
                y=zeros(size(x));
                for i=1:length(x)
                    y(i) = niching_func(x(i),1);
                end
                plot(x,y,'b-');hold on
                plot(Population(:,1),-FunctionValue,'.')
                title('Function 1')
                hold off
                drawnow

            case 2
                % F2: Equal Maxima
                x=[0:0.001:1];
                y=zeros(size(x));
                for i=1:length(x)
                    y(i) = niching_func(x(i),2);
                end
                plot(x,y,'b-');hold on
                plot(Population(:,1),-FunctionValue,'.')
                title('Function 2')
                hold off
                drawnow
            case 3
                % F3: Uneven Decreasing Maxima
                x=[0:0.001:1];
                y=zeros(size(x));
                for i=1:length(x)
                    y(i) = niching_func(x(i),3);
                end
                plot(x,y,'b-');hold on
                plot(Population(:,1),-FunctionValue,'.')
                title('Function 3')
                hold off
                drawnow
            case 4
                % F4: Himmelblau
                [X,Y] = meshgrid(-6:.05:6);
                Z=zeros(size(X));
                i=1;
                for x=-6:0.05:6
                    j=1;
                    for y=-6:0.05:6
                        Z(i,j) = niching_func([X(i,j) Y(i,j)],4);
                        j=j+1;
                    end
                    i=i+1;
                end
                surfc(X,Y,Z, 'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                axis([-6 6 -6 6 -2000 200])
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 4')
                hold off
                drawnow
            case 5
                % F5: Six-Hump Camel Back
                [X,Y] = meshgrid(linspace(-1.9,1.9,200),linspace(-1.1,1.1,200));
                Z=zeros(size(X));
                i=1;
                for x=linspace(-1.9,1.9,200)
                    j=1;
                    for y=linspace(-1.1,1.1,200)
                        Z(i,j) = niching_func([X(i,j) Y(i,j)],5);
                        j=j+1;
                    end
                    i=i+1;
                end
                surfc(X,Y,Z, 'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
    %             axis([-1.9 1.9 -1.1 1.1 -6 2])
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 5')
                hold off
                drawnow
            case 6
                % F6: Shubert
                [X,Y] = meshgrid(-10:0.1:10);
                Z=zeros(size(X));
                i=1;
                for x=-10:0.1:10
                    j=1;
                    for y=-10:0.1:10
                        Z(i,j) = niching_func([X(i,j) Y(i,j)],6);
                        j=j+1;
                    end
                    i=i+1;
                end
                surfc(X,Y,Z, 'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                %axis([-10 10 -10 10 -300 200])
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 6')
                hold off
                drawnow
            case 7
                % F7: Vincent
                [X,Y] = meshgrid(0.25:0.05:10);
                Z=zeros(size(X));
                i=1;
                for x=0.25:0.05:10
                    j=1;
                    for y=0.25:0.05:10
                        Z(i,j) = niching_func([X(i,j) Y(i,j)],7);
                        j=j+1;
                    end
                    i=i+1;
                end
                surfc(X,Y,Z, 'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                %axis([0.25 10 0.25 10 -1 1])
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 7')
                hold off
                drawnow

            case 8
                            % F6: Shubert
                [X,Y] = meshgrid(-10:0.1:10);
                Z=zeros(size(X));
                i=1;
                for x=-10:0.1:10
                    j=1;
                    for y=-10:0.1:10
                        Z(i,j) = niching_func([X(i,j) Y(i,j)],6);
                        j=j+1;
                    end
                    i=i+1;
                end
                surfc(X,Y,Z, 'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                %axis([-10 10 -10 10 -300 200])
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 8')
                hold off
                drawnow
            case 9
                            % F7: Vincent
                [X,Y] = meshgrid(0.25:0.05:10);
                Z=zeros(size(X));
                i=1;
                for x=0.25:0.05:10
                    j=1;
                    for y=0.25:0.05:10
                        Z(i,j) = niching_func([X(i,j) Y(i,j)],7);
                        j=j+1;
                    end
                    i=i+1;
                end
                surfc(X,Y,Z, 'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                %axis([0.25 10 0.25 10 -1 1])
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 9')
                hold off
                drawnow
            case 10
                % F8: Modified Rastrigin - All Global Optima
                [X,Y] = meshgrid(0:0.01:1);
                Z=zeros(size(X));
                i=1;
                for x=0:0.01:1
                    j=1;
                    for y=0:0.01:1
                        Z(i,j) = niching_func([X(i,j) Y(i,j)],10);
                        j=j+1;
                    end
                    i=i+1;
                end
                surfc(X,Y,Z, 'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                axis([0 1 0 1 -40 10])
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 10')
                hold off
                drawnow
            case 11
                % F9: Composition function 1
                x=-5:0.1:5; y=x;
                func_num = 11;

                L = length(x);
                f = zeros(L);

                for i=1:L
                    for j=1:L
                        f(j,i) = niching_func([x(i),y(j)],func_num);
                    end
                end

                surfc(x,y,f,'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                grid off;
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 11')
                hold off
                drawnow
            case 12
                % F10: Composition function 2
                x=-5:0.1:5; y=x;
                func_num = 12;

                L = length(x);
                f = zeros(L);

                for i=1:L
                    for j=1:L
                        f(j,i) = niching_func([x(i),y(j)],func_num);
                    end
                end

                surfc(x,y,f,'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                grid off;
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 12')
                hold off
                drawnow
            case 13
                % F11: Composition function 3
                x=-5:0.1:5; y=x;
                func_num = 13;

                L = length(x);
                f = zeros(L);

                for i=1:L
                    for j=1:L
                        f(j,i) = niching_func([x(i),y(j)],func_num);
                    end
                end

                surfc(x,y,f,'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                grid off;
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 13')
                hold off
                drawnow
            case 14
                % F11: Composition function 3
                x=-5:0.1:5; y=x;
                func_num = 14;

                L = length(x);
                f = zeros(L);

                for i=1:L
                    for j=1:L
                        f(i,j) = niching_func([x(i),y(j)],func_num);
                    end
                end

                surfc(x,y,f,'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                grid off;
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 14')
                hold off
                drawnow
            case 15
                % F12: Composition function 4
                x=-5:0.1:5; y=x;
                func_num = 15;

                L = length(x);
                f = zeros(L);

                for i=1:L
                    for j=1:L
                        f(j,i) = niching_func([x(i),y(j)],func_num);
                    end
                end

                surfc(x,y,f,'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                grid off;
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 15')
                hold off
                drawnow
           case 16
                           % F11: Composition function 3
                x=-5:0.1:5; y=x;
                func_num = 16;

                L = length(x);
                f = zeros(L);

                for i=1:L
                    for j=1:L
                        f(j,i) = niching_func([x(i),y(j)],func_num);
                    end
                end

                surfc(x,y,f,'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                grid off;
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 16')
                hold off
                drawnow
            case 17
                % F12: Composition function 4
                x=-5:0.1:5; y=x;
                func_num = 17;

                L = length(x);
                f = zeros(L);

                for i=1:L
                    for j=1:L
                        f(j,i) = niching_func([x(i),y(j)],func_num);
                    end
                end

                surfc(x,y,f,'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                grid off;
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 17')
                hold off
                drawnow
            case 18
                  % F11: Composition function 3
                x=-5:0.1:5; y=x;
                func_num = 18;

                L = length(x);
                f = zeros(L);

                for i=1:L
                    for j=1:L
                        f(j,i) = niching_func([x(i),y(j)],func_num);
                    end
                end

                surfc(x,y,f,'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                grid off;
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 18')
                hold off
                drawnow
            case 19
                % F12: Composition function 4
                x=-5:0.1:5; y=x;
                func_num = 19;

                L = length(x);
                f = zeros(L);

                for i=1:L
                    for j=1:L
                        f(j,i) = niching_func([x(i),y(j)],func_num);
                    end
                end

                surfc(x,y,f,'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                grid off;
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 19')
                hold off
                drawnow
            case 20
                % F12: Composition function 4
                x=-5:0.1:5; y=x;
                func_num = 20;

                L = length(x);
                f = zeros(L);

                for i=1:L
                    for j=1:L
                        f(j,i) = niching_func([x(i),y(j)],func_num);
                    end
                end

                surfc(x,y,f,'FaceColor','interp','FaceLighting','phong','EdgeColor','none');hold on
                grid off;
                plot3(Population(:,1),Population(:,2),-FunctionValue,'.')
                title('Function 20')
                hold off
                drawnow
        end
    end
end