%basic feasible solution
clc;
clear all;
A=[12 3 -11 4;1 2 6 -7];
B=[7;3];
C=[2 3 5 7];
%n= number of variables
%m = number of constraints
n=size(A,2);
m=size(A,1);
if n>m
    nCm=nchoosek(n,m)
    p=nchoosek(1:n,m) %making pairs(x1,x2),(x1,x3)
    sol=[]
    for i=1:nCm
        y=zeros(n,1)
        A1=A(:,p(i,:)) % if p is 1 that means X1,X2 is chosen and X3,X4=0
        X=inv(A1)*B
        if all(X>=0 & X~=inf & X~=-inf)
            y(p(i,:))=X
            sol=[sol,y]
        end
    end
else
    error('No. of constraints greater than number of variables')
end
Z=C*sol
[obj index]=max(Z)

bfs=sol(:,index) %values of x1,x2,x3,x4
optval=[bfs' , obj] %values of x1,x2,x3,x4,Z
array2table(optval,'VariableNames',{'X1','X2','X3','X4','Z'})%array to table