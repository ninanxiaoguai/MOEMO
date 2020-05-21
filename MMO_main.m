%NSGA-II
function [res] = MMO_main(fun_name,Run,showfig,show_results)
close all;clc;tic;

%参数设定
[~, ~, FEs, N, ~,percent_evalu] =  Fun_info(fun_name);
%-----------------------------------------------------------------------------------------
%算法开始
%初始化
t1 = toc;
[Population,Boundary] = Initialization(fun_name,N);
PopObj = Fun_value(fun_name,Population);
t2 = toc;
all_x = [Population];    % 记录所有历史记录
all_f = [PopObj(:,1)];
First_x = [];  % 记录每一代中的Pareto第一层
First_y = [];
First_time = [];
% Parameters
% 在多目标优化中的evaluation的百分比
Iter = percent_evalu*ceil(FEs/N)-1;
Eva = 1:N;    % 与Popluation同步的代数
Times = linspace(t1,t2,N);
First_eva = []; % 与所有的front同步的代数
%%%%%%%%%%%%%%%%%%%%%%%%% MOEA %%%%%%%%%%%%%%%%%%%%%
for iter = 1 : Iter
   now_eva = ((iter)*N+1:(iter+1)*N);
   t3 = toc;
   MatingPool = MatingSelection(Population);
   t4 = toc;
   now_time = linspace(t3,t4,N);
   Offspring = Reproduction(MatingPool,Boundary,N);
   PopObj = Fun_value(fun_name,[Population;Offspring]);
   [Population, PopObj,front_f,Eva,Times] = EnvironmentalSelection([Population;Offspring],PopObj,N,[Eva now_eva],[Times now_time]);

    all_x = [all_x; Population];
    all_f = [all_f; PopObj(:,1)];
    if(iter == Iter)
        First_x = [First_x; Population(front_f,:)];
        First_y = [First_y ;PopObj(front_f,1)];
        First_eva = [First_eva Eva(front_f)];
        First_time = [First_time Times(front_f)];
    else
        First_x = [First_x; Population(front_f==1,:)];
        First_y = [First_y ;PopObj(front_f==1,1)];
        First_eva = [First_eva Eva(front_f==1)];
        First_time = [First_time Times(front_f==1)];
    end
    clc; 
    fprintf('Function : %s \nNo.%s times \n',num2str(fun_name),num2str(Run));
    fprintf('MOEAs: %s / %s \n',num2str(iter),num2str(Iter));
end


%%%#######################################################################################

if(showfig == 1)
    if(size(all_x,2) == 1)
        plot(First_x,-First_y,'k.')
        nam = ['All the rank-1 Individuals in Function ' num2str(fun_name)];
        title(nam)
    else
        plot3(First_x(:,1),First_x(:,2),-First_y,'k.')
        nam = ['All the rank-1 Individuals in Function ' num2str(fun_name)];
        title(nam)
    end
end

if(showfig == 1)
    if(size(all_x,2) == 1)
        plot(all_x,-all_f,'k.')
        nam = ['All the Individuals in Function ' num2str(fun_name)];
        title(nam)
    else
        plot3(all_x(:,1),all_x(:,2),-all_f,'k.')
        nam = ['All the Individuals in Function ' num2str(fun_name)];
        title(nam)
    end
end

%%%#######################################################################################
A1 = [];
A2 = [];
optimal_numbs = [2 5 1 4 2 18 36 81 216 12 6 8 6 6 8 6 8 6 6 8];
epsilon = [1e-1 1e-2 1e-3 1e-4 1e-5];
func_num = fun_name;

if(show_results == 1)
    fprintf('\nin the last Population\n')
    for i = 1:length(epsilon)
        [count, ~] = count_goptima(Population(front_f==1,:), func_num, epsilon(i));
        A1 = [A1 count];
        fprintf('Peak Ratio (epsilon = %1.0e): %s/%s  %s\n',epsilon(i),num2str(count),num2str(optimal_numbs(func_num)), num2str(count/optimal_numbs(func_num)));
    end
end

Y = -First_y;
F = Y > (max(Y) - 0.05*(max(Y)-min(Y)));
% F = Y > (max(Y) - 1);
if(show_results == 1)
    fprintf('\nin the all First Front\n')
    for i = 1:length(epsilon)
        [count, ~] = count_goptima(First_x(F,:), func_num, epsilon(i));
        A2 = [A2 count];
        fprintf('Peak Ratio (epsilon = %1.0e): %s/%s  %s\n',epsilon(i),num2str(count),num2str(optimal_numbs(func_num)), num2str(count/optimal_numbs(func_num)));
    end
    fprintf('the number of all First Front is %s\n',num2str(sum(F)));
end



Good_x = First_x(F,:);
Good_y = Y(F);
Good_eva = First_eva(F);
Good_time = First_time(F);
[centers ,labels] = cluster(Good_x,fun_name,0);

if(show_results == 1)
    fprintf('the number of peaks is %s\nPeak Detection... \n',num2str(size(centers,1)));
end
if(showfig == 1)
    if(size(Good_x,2) == 1)
        plot(Good_x,Good_y,'k.')
        nam = ['Function ' num2str(fun_name)];
        title(nam)
    else
        plot3(Good_x(:,1),Good_x(:,2),Good_y,'k.')
        nam = ['Function ' num2str(fun_name)];
        title(nam)
    end
end

center_numbs = size(centers,1);
num = 1:size(Good_x,1);
local_point = [];
local_value = [];

for i = 1:center_numbs
    choose = labels == i;
    if(isempty(choose))
        continue
    end
    idx = num(choose);
    y = Good_y(idx);
    [temp,id] = max(y);
    local_point = [local_point;Good_x(idx(id),:)];
    local_value = [local_value temp];
end
if(showfig == 1)
    figure
    if(size(all_x,2) == 1)
        sizes = 10*ones(1,size(Good_x,1));
        color = labels/center_numbs;
       scatter(Good_x(:,1),Good_y,sizes,color,'filled');
       hold on
       scatter(local_point(:,1),local_value,200*ones(1,size(local_point,1)),(1:size(local_point,1))/size(local_point,1),'filled');
       title('cutting part of all the First front and center of cluster')
       nam = ['Centers in Function ' num2str(fun_name)];
       title(nam)
    else
        sizes = 10*ones(1,size(Good_x,1));
        color = labels/center_numbs;
        scatter3(Good_x(:,1),Good_x(:,2),Good_y,sizes,color,'filled');
        hold on
        scatter3(local_point(:,1),local_point(:,2),local_value,200*ones(1,size(local_point,1)),(1:size(local_point,1))/size(local_point,1),'filled');
        title('cutting part of all the First front and center of cluster')
        nam = ['Centers in Function ' num2str(fun_name)];
        title(nam)
    end
end


K = length(local_value); 
fes = floor((1 - percent_evalu)*FEs/K);
local = [];
start_eva = percent_evalu*ceil(FEs/N)*N;
ttt1 = [];
ttt2 = [];
for k = 1:K
    
    offset =  0.025*(Boundary(1,:) - Boundary(2,:))';
    lbounds = max(Boundary(2,:)', local_point(k,:)' - offset);
    ubounds = min(Boundary(1,:)', local_point(k,:)' + offset);
    
    % local optimization using CSO
    seedx = local_point(k,:);
    [bestx, bestf,e] = CSO(seedx, fun_name, fes, lbounds, ubounds);
    t5 = toc;
    Population = [Population; bestx];
    Eva = [Eva e+start_eva+fes*(k-1)];

    local = [local; bestx];
    
    Good_x = [Good_x; bestx];
    Good_y = [Good_y; -bestf];
    Good_eva =[Good_eva e+start_eva+fes*(k-1)];
    Good_time = [Good_time t5];
    ttt1 = [ttt1 t5];
    ttt2 = [ttt2 e+start_eva+fes*(k-1)];
end

if(show_results == 1)
    fprintf('\nin the last Population\n')
    for i = 1:length(epsilon)
        fprintf('Peak Ratio (epsilon = %1.0e): %s/%s  %s\n',epsilon(i),num2str(A1(i)),num2str(optimal_numbs(func_num)), num2str(A1(i)/optimal_numbs(func_num)));
    end

    fprintf('\nin the all First Front\n')
    for i = 1:length(epsilon)
        fprintf('Peak Ratio (epsilon = %1.0e): %s/%s  %s\n',epsilon(i),num2str(A2(i)),num2str(optimal_numbs(func_num)), num2str(A2(i)/optimal_numbs(func_num)));
    end
end

Final_f = Good_y > (max(Good_y) - 2);
Good_x = Good_x(Final_f,:);
Good_y = Good_y(Final_f,:);
Good_eva = Good_eva(Final_f);
Good_time = Good_time(Final_f);
if(show_results ==1)
    fprintf('\nin the output \n')
    for i = 1:length(epsilon)
        [count, ~] = count_goptima(Good_x, func_num, epsilon(i));
        fprintf('Peak Ratio (epsilon = %1.0e): %s/%s  %s\n',epsilon(i),num2str(count),num2str(optimal_numbs(func_num)), num2str(count/optimal_numbs(func_num)));
    end
    fprintf('the number of outputs is %s\n',num2str(size(Good_x,1)));
    fprintf('the number of peaks is %s\n',num2str(size(centers,1)));
end

if(show_results == 1)
    fprintf('\nthe number of peaks is %s\n',num2str(size(centers,1)));
    fprintf('\nthe results of local search\n')
    for i = 1:length(epsilon)
        [count, ~] = count_goptima(local, func_num, epsilon(i));
        fprintf('Peak Ratio (epsilon = %1.0e): %s/%s  %s\n',epsilon(i),num2str(count),num2str(optimal_numbs(func_num)), num2str(count/optimal_numbs(func_num)));
    end
    
end

  
flags = Good_y > (max(Good_y) - 1);
if(length(flags) >= k)
    flags((end-K+1):end) = true;
end
outputs_x = Good_x(flags,:);
outputs_y = Good_y(flags);
outputs_e = Good_eva(flags);
outputs_t = Good_time(flags);

Remains = false(1,size(outputs_x,1));
if(length(Remains) >= k)
    Remains((end-K+1):end) = true;
end

if(size(outputs_x,1) > 1)
    [Centers ,Labels] = cluster(outputs_x,fun_name,1);

    center_numbs = size(Centers,1);
    num = 1:size(outputs_x,1);
    
    for i = 1:center_numbs
        choose = Labels == i;
        if(isempty(choose))
            continue
        end
        idx = num(choose);
        y = outputs_y(idx);
        [~,id] = sort(y,'descend');
        Remains(idx(id(1:min(2,length(id))))) = true;
    end
    outputs_x = outputs_x(Remains,:);
    outputs_y = outputs_y(Remains);
    outputs_e = Good_eva(Remains);
    outputs_t = Good_time(Remains);
end

fprintf('\n')
res = [];
for i = 1:length(epsilon)
    [count, ~] = count_goptima(outputs_x, func_num, epsilon(i));
    res = [res count];
    fprintf('Peak Ratio (epsilon = %1.0e): %s/%s  %s\n',epsilon(i),num2str(count),num2str(optimal_numbs(func_num)), num2str(count/optimal_numbs(func_num)));
end
fprintf('\nthe number of res is %s\n',num2str(size(outputs_x,1)));
res = [func_num optimal_numbs(func_num),size(outputs_x,1) res];
        
 Print(fun_name,Run,outputs_e,outputs_t,outputs_x,outputs_y);

end
