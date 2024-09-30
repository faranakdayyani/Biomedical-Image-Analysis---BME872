function C = imageQuality_contrast(img)

    imgread2 = double(img);
    % normalizing the image
    if (size(imgread2,3)>1)
        [x y z] = size(imgread2);
        img_p = zeros(x,y,z);
        img_norm = zeros(x,y,z);
        for k = 1:z
            slice = imgread2(:,:,k);
            a = min(slice(:));
            img_p(:,:,k) = abs(a)+slice;
            b = img_p(:,:,k);
            maximg = max(b(:));
            if (a~=b)
                img_norm(:,:,k) = b./maximg;
            end
        end
        % Display the image
        figure;
        subplot(1,2,1);
        imshow(img_norm(:,:,100), []);
        axis on;
        title('A slice of Brain MRI Image');
        colorbar;
        subplot(1,2,2);
        histogram(img_norm,'Normalization','probability');
        title('Histogram of Brain MRI volume');
        xlabel('Intensity');
        ylabel('Normalized Number of Occurance (PDF)');
    else
        slice = imgread2;
        a = min(slice(:));
        img_p = abs(a)+slice;
        b = img_p;
        maximg = max(b(:));
        img_norm = b./maximg;
        
        % Display the image
        figure;
        subplot(1,2,1);
        imshow(img_norm, []);
        axis on;
        title('Lung CT Image');
        colorbar;
        subplot(1,2,2);
        histogram(img_norm,'Normalization','probability');
        title('Histogram of Lung CT slice');
        xlabel('Intensity');
        ylabel('Normalized Number of Occurance (PDF)');
    end
    
    % masuring the image quality of contrast
    C = rms(img_norm(:)); %Calculate RMS
    disp('The contrast of this image is: ');
    disp(C);
    
end