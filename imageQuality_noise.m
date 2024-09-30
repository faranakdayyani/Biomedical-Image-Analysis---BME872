function N = imageQuality_noise(img1)%,img2)
    
    % function with ONE input for both 2D & 3D images
    imgread2 = double(img1);
    
    if (size(imgread2,3)>1)
        [x y z] = size(imgread2);
        imgfilter = zeros(x,y,z);
        for k = 1:z
            slice = imgread2(:,:,k);
            imgfilter(:,:,k) = imnlmfilt(slice); %Filter the image slice to compute reference image
        end
        % Display the image
        figure;
        subplot(1,2,1);
        imshow(imgfilter(:,:,100),[]);
        title('Filtered (reference) image of a slice of Brain MRI');
        colorbar;
        subplot(1,2,2);
        histogram(imgfilter,'Normalization','probability');
        title('Histogram of filtered (reference) image of Brain MRI');
        xlabel('Intensity');
        ylabel('Normalized Number of Occurance (PDF)');
        
    else
        imgfilter = imnlmfilt(imgread2);
        
        % Display the image
        figure;
        subplot(1,2,1);
        imshow(imgfilter,[]);
        title('Filtered (reference) image of Lung CT');
        colorbar;
        subplot(1,2,2);
        histogram(imgfilter,'Normalization','probability');
        title('Histogram of filtered (reference) image of Lung CT');
        xlabel('Intensity');
        ylabel('Normalized Number of Occurance (PDF)');
    end
    
    img2 = int8(imgfilter); %convert to 8-bit signed integer 
    img1 = int8(imgread2);     
    A = img1;
    B = img2;
    %B = double(img2);
    mse = sum((A(:)-B(:)).^2) / prod(size(A)); %Calculate MSE
    psnrimg = 10*log10(255*255/mse); %Calculate PSNR
    N = psnrimg;
    disp('The noisyness of this image is: ');
    disp(N);

end 