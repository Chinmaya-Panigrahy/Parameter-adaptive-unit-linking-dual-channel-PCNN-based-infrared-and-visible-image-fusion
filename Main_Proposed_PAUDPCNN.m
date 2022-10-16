%If you use this code, Please cite our Paper "Parameter adaptive unit-linking dual-channel PCNN based infrared and visible image fusion"  
%in Neurocomputing, vol. 514, pp. 21-38, 2022, doi: 10.1016/j.neucom.2022.09.157


clear all
img1=imread('I_1.png'); %Infrared Image
img2=imread('V_1.png'); %Visible Image
tic
img1= double(img1)/255;
img2= double(img2)/255;
Fc=FUSION_NSCT_ABS_MSMG_DBC_PAUDPCNN(img1,img2);
F=uint8(Fc*255);
toc
figure, imshow(F)
        
        
        
        
        
        

        
        
  
        
  
        
        

         

