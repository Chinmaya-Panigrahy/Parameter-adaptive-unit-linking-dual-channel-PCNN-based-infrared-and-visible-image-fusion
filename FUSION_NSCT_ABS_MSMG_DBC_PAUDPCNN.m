function [F]=FUSION_NSCT_ABS_MSMG_DBC_PAUDPCNN(A,B)
path(path,'nsct_toolbox')

pfilt = '9-7';
dfilt = 'pkva';
nlevs = [0,1,3,4,4];
scalemsmfm=5;
nsctA=nsctdec(A,nlevs,dfilt,pfilt); % NSCT Decompostion of A
nsctB=nsctdec(B,nlevs,dfilt,pfilt); % NSCT Decompostion of B

n = length(nsctA); %Number of 2nd dimension cell array
Fused=nsctA;          %Intialized with the coefficient size

%Fusion of low-pass sub-bands
ALow1=nsctA{1};
BLow1=nsctB{1};
AL=abs(ALow1);
BL=abs(BLow1);
map1=PAUDPCNNM(AL,BL); %PAUDPCNNM: PAUDPCNN to fuse low-pass sub-bands (Uses Multi-Scale Morphological Gradients)
Fused{1}=map1.*ALow1+~map1.*BLow1;
       

%Fusion of band-pass directional sub-bands
Ahigh=nsctA{2};
Bhigh=nsctB{2};
AH=abs(Ahigh);
BH=abs(Bhigh);
map=PAUDPCNN(AH,BH); % PAUDPCNN to fuse band-pass directional sub-bands (Uses Fractal Dimension)
Fused{2}=map.*Ahigh+~map.*Bhigh;                
for i = 3:n
    for d = 1:length(nsctA{i})
        Ahigh = nsctA{i}{d};
        Bhigh = nsctB{i}{d};
        AH=abs(Ahigh);
        BH=abs(Bhigh);
        map=PAUDPCNN(AH,BH); % PAUDPCNN to fuse band-pass directional sub-bands (Uses Fractal Dimension)
        Fused{i}{d}=map.*Ahigh+~map.*Bhigh;                                                           
    end
end
F=nsctrec(Fused, dfilt, pfilt);
end








