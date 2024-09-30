function [T]=contrast_stretch(img)

    img = double(img);
    r_max = max(img(:));
    r_min = min(img(:));
    %r = r_min:r_max;
    [x y] = size(img);
    T = zeros(x,y);
    for i = 1:x
        for j = 1:y
            T(i,j) = 255.*(((1/(r_max-r_min)).*img(i,j))-(r_min/(r_max-r_min)));
        end
    end
    T = uint8(T);
end