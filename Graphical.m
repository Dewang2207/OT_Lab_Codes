%graphical method
clc;
clear all;
A = [1 2;1 1;0 1];
B = [2000;1500;600];
C = [3 5]; %cost function
X =  0:max(B);
Z1=(B(1)-A(1,1)*X)/A(1,2);
Z2=(B(2)-A(2,1)*X)/A(2,2);
Z3=(B(3)-A(3,1)*X)/A(3,2);
plot(X,max(0,Z1),"blue",X,max(0,Z2),"green",X,max(0,Z3),"red")
 
%finding points with axes
%CX1 return the indices where X=0 in X=0:MAX(B)|
%C1 returns indices where Z1=0 from vector with values calculated after
%inserting X in Z1 EQUATION
CX1=find(X==0);
C1=find(Z1==0);
%returning values from X and Z1 vector at C1 & CX1
line1=[X([C1 CX1]);Z1([C1 CX1])]'
C2=find(Z2==0);
line2=[X([C2 CX1]);Z2([C2 CX1])]'
C3=find(Z3==0);
line3=[X([C3 CX1]);Z3([C3 CX1])]'
corpt=unique([line1; line2; line3], "rows")
 
Pt=[0;0]
for i =1:size(A,1) %interate over the rows
    %doing in loop and verifying x and y by taking every 2 equations
    %possible
    for j=i+1:size(A,1)
        A1=A([i,j],:)
        B1=B([i,j])
        X=inv(A1)*B1
        Pt=[Pt,X]
    end
end
Ptt=Pt'

%finding unique points from all points (including intersection with axes
%and intersection of lines)
allpt=[Ptt;corpt]
points=unique(allpt,"rows")

%finding feasible region
for i=1:size(points,1)
    const1(i)=A(1,1)*points(i,1)+A(1,2)*points(i,2)-B(1) %written inequality in form ax+by<=c to ax+by-c<=0
    const2(i)=A(2,1)*points(i,1)+A(2,2)*points(i,2)-B(2)
    const3(i)=A(3,1)*points(i,1)+A(3,2)*points(i,2)-B(3)
    s1=find(const1>0)
    s2=find(const2>0)
    s3=find(const3>0)
end

s=unique([s1 s2 s3]) %found feasible region
points(s,:)=[] %[] means deletin points 
value=points*C' %finding cost values

table=[points value]
[obj index]=max(value); %defining obj here
X1=points(index,1)
X2=points(index,2)
fprintf("obj:value %f at (%f,%f)",obj,X1,X2)