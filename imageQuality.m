function imageQuality(N, C, E)

    if (N > 30) & (50 > N) %Justify the noise quality of the image
        disp('Image is not Noisy');
    else
        disp('Image is Noisy');
    end
    
    if (0.46291 > C) %Justify the contrast quality of the image
        disp('Image is dark');
    elseif (C > 0.5537)
        disp('Image is bright');
    else
        disp('Image Contrast quality is high');
    end
    
    if (E > 0.014922) %Justify the edge quality of the image
        disp('Image has strong Edges');
    else 
        disp('Image has weak Edges');
    end
    
     
end