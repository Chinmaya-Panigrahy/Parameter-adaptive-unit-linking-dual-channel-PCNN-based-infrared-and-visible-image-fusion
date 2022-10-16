function R=PAUDPCNN(A,B)
%Code for PAUDPCNN
N=200;
%Absolute values can be used
stdA=std2(A);
stdB=std2(B);
rstd=sqrt(stdA*stdB);

alpha_u=log10(1.0/rstd); 
LA=max(A(:));
LB=max(B(:));

LAO=graythresh(A);
LBO=graythresh(B);

xA=LA/LAO;
xB=LB/LBO;
xy=sqrt(LAO*LBO);

lambda=(sqrt(xA*xB)-1.0)/6;

V_E=exp(-alpha_u)+sqrt(xA*xB);

Y=(1-exp(-3*alpha_u))/(1- exp(-alpha_u))+(sqrt(xA*xB)-1)*exp(-alpha_u);
alpha_e=log(V_E / (xy * Y));


betaA11=dbcbox(A,3);
mnbetaA11=min(betaA11(:));
betaA11=betaA11-mnbetaA11;
mxbetaA11=max(betaA11(:));
betaA1=-6+(12*betaA11)/mxbetaA11;
betaB11=dbcbox(B,3);
mnbetaB11=min(betaB11(:));
betaB11=betaB11-mnbetaB11;
mxbetaB11=max(betaB11(:));
betaB1=-6+(12*betaB11)/mxbetaB11;
betaA=1./(1+exp(-betaA1));
betaB=1./(1+exp(-betaB1));

%PAUDPCNN

[p,q]=size(A);
F1=abs(A);
F2=abs(B);
U=zeros(p,q);
Y=zeros(p,q);
E=ones(p,q);


W=[1 1 1;1 0 1;1 1 1];

for it=1:N
    K1 = conv2(Y,W,'same');
    K=(K1>0); 
    U1=F1.* (1 + betaA .* K);
    U2=F2.* (1 + betaB .* K);
    map=(U1>=U2);
    U3=map.*U1+~map.*U2;
    U = exp(-alpha_u) * U + U3;
    Y = im2double( U > E );
    E = exp(-alpha_e) * E + V_E * Y;
end
R =(U1>=U2);
end


