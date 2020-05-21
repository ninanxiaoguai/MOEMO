function [res,labels] = cluster(data,num,f)
    %mean shift �
    [m,n]=size(data);
    GD =  pdist2(data, data); 
    GD(logical(eye(m))) = 1e20;
    GD_s = sort(GD,2,'ascend');
    for i = 1
        if(~isempty(find(GD_s(i,:)>0.06,1)))
            a = GD_s(i,find(GD_s(i,:)>0.06,1));
        else
            a = max(GD_s(:,1));
        end
    end
    ra = a;
    S = max(GD_s(:,1));
    if(f == 0)
        radius = (ra+S*2)/3;
        radius = radius*1;
    else
        radius = ra;
    end
    index=1:m;
    
    stopthresh=1e-2*radius;
    visitflag=zeros(m,1);
    count=[];
    clustern=0;
    clustercenter=[];

    while ~isempty(index)
        cn=ceil((length(index)-1e-6)*rand);
        center=data(index(cn),:);
        this_class=zeros(m,1);
        Flag = 0;
        while 1
            dis=pdist2(center,data);
            radius2=radius;
            innerS=find(dis<radius2);
            if(isempty(innerS))
                clustern=clustern+1;
                clustercenter(clustern,:)=center;
                count(:,clustern)=this_class;
                visitflag(index(cn))=1;
                Flag = 1;
                break
            end
            visitflag(innerS)=1;
            this_class(innerS)=this_class(innerS)+1;
            newcenter=zeros(1,n);
            sumweight=0;
            for i=1:length(innerS)
                w=(1/(radius2*sqrt(2*pi)))*exp(-0.5*dis(innerS(i))*dis(innerS(i))/(radius2*radius2));
                sumweight=w+sumweight;
                newcenter=newcenter+w*data(innerS(i),:);
            end
            newcenter=newcenter./sumweight;

            if norm(newcenter-center) <stopthresh
                break;
            end
            center=newcenter;
        end
        mergewith=0;
        for i=1:clustern
            betw=norm(center-clustercenter(i,:));
            if betw<radius/2
                mergewith=i; 
                break;
            end
        end
        if(Flag == 0)
            if mergewith==0           
                clustern=clustern+1;
                clustercenter(clustern,:)=center;
                count(:,clustern)=zeros(m,1);
            else                      
                clustercenter(mergewith,:)=0.5*(clustercenter(mergewith,:)+center);
                count(:,mergewith)=count(:,mergewith)+this_class;  
            end
        end
        
        index=find(visitflag==0);
    end%�����������ݵ����


    res  =clustercenter;
    distt = pdist2(data,clustercenter);
    [~,labels] = min(distt,[],2);
end