function [E] = imageQuality_edge(img)
    
    imgread2 = double(img);
    % Normalizing the image
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
    else
        slice = imgread2;
        a = min(slice(:));
        img_p = abs(a)+slice;
        b = img_p;
        maximg = max(b(:));
        img_norm = b./maximg;
    end
    
    % Calculating the Image Sharpness using FM algorithm
    if (size(imgread2,3)>1)
        [x y z] = size(img_norm);
        E = zeros(1,z);
        for k = 1:z
            slice = img_norm(:,:,k);
            % Step 1
            F = fft2(slice); %Compute frequency spectrum
            % Step 2
            fft1_shifted = fftshift(F); %Shift the frequency spectrum
            % Step 3
            fft1_mag = abs(fft1_shifted); %Compute the magnitude frequency
            fft1_mag_log = log(1+fft1_mag); %Compute Logarithimc shape of the amgnitude spectrum for displaying the plot
            % Step 4    
            M = max(fft1_mag(:)); %Compute maximum possible value in the magnitude frequency
            % Step 5
            thres = M/1000; %Compute the threshold
            % Step 6
            %Compute the total number of pixels with intensity greater than the threshold
            T = 0;
            [x y] = size(F);
            for i = 1:x
                for j = 1:y
                    pixel = F(i,j);
                    if (pixel > thres)
                        T = T + 1;
                    end
                end
            end
            % Step 7
            [M N] = size(slice); 
            E(k) = T/(M*N); %Comput image sharpness
        end
        E = sum(E)/z;
        
        % Display Magnitude Frequency
        F = fft2(img(:,:,100));
        fft1_shifted = fftshift(F);
        fft1_mag = abs(fft1_shifted);
        fft1_mag_log = log(1+fft1_mag);
        figure;
        imshow(fft1_mag_log,[]);
        title('Frequency magnitude of a slice of Brain MRI image volume');
        colorbar;
    else
        slice = img_norm;
        % Step 1
        F = fft2(slice);
        % Step 2
        fft1_shifted = fftshift(F);
        % Step 3
        fft1_mag = abs(fft1_shifted);
        fft1_mag_log = log(1+fft1_mag);
        % Step 4    
        M = max(fft1_mag(:));
        % Step 5
        thres = M/1000;
        % Step 6
        T = 0;
        [x y] = size(F);
        for i = 1:x
            for j = 1:y
                pixel = F(i,j);
                if (pixel > thres)
                    T = T + 1;
                end
            end
        end
        % Step 7
        [M N] = size(img_norm); 
        E = T/(M*N);
        
        % Display Magnitude Frequency
        figure;
        imshow(fft1_mag_log,[]);
        title('Frequency magnitude of Lung CT image');
        colorbar;
    end

    disp('The sharpness of this image is: ');
    disp(E);
    
end