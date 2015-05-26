function [Output,ERROR] = CropFace(Im)

face_detector = vision.CascadeObjectDetector('FrontalFaceCART');
face = step(face_detector,Im);
if isempty(face)
    ERROR = 1;
    Output = 0;
else
    if size(face,1) > 1
        Crop1 = Im(face(1,2):face(1,2)+face(1,4),face(1,1):face(1,1)+face(1,3));  
        Crop2 = Im(face(2,2):face(2,2)+face(2,4),face(2,1):face(2,1)+face(2,3));
        if size(Crop1,1) < size(Crop2,1)
            CroppedFace = Crop2;
        else
            CroppedFace = Crop1;
        end
    else
        CroppedFace = Im(face(2):face(2)+face(4),face(1):face(1)+face(3),:);
    end
    %Remove Ears and forhead
    Cropped = CroppedFace(31:end,16:end-15,:);
    Output = uint8(imresize(Cropped,[90 90])); 
    
    %Error
    ERROR = 0;
end
end

