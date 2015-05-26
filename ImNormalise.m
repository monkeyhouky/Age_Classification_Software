function [Normalised,ERROR,angle] = ImNormalise(Im)
        %This function returns the normalised, face cropped image by first
        %detecting eyes and rotating the image about the eyes. 

        %Assumes image is in grayscale
        %Detects and crops the face
        %Splits face into 2 sections - left and right
        %Detects eyes
        %Normalise and return image
        
Breakout = 0;
%Detect and Crop face
[CroppedFace,ERRORface] = CropFace(Im);     %Call function to crop face
if ERRORface == 1
    Breakout = 1;
end

if Breakout == 1 
    Normalised = 0;
    angle = 0;
    ERROR = 1;
else
    %Detect Centre Points of Eyes
    [ERROR,centreleftx,centrelefty,centrerightx,centrerighty] ...
        = DetectEyes(CroppedFace);      %Call function to find eyes
    if ERROR == 1
        Normalised = 0;
        angle = 0;
    else
        %Find angle and Normalise
        angle = asind((centrelefty-centrerighty)/(centreleftx-centrerightx));
        Normalised1 = imrotate(Im,angle,'crop');
        Normalised = CropFace(Normalised1);
        ERROR = 0;
    end
end
end

