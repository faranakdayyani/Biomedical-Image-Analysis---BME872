function [img, info] = imageRead(path, imageFormat)

if (imageFormat == 'mhd')
    [img, info] = read_mhd(path);
elseif (imageFormat == 'dcm')
    img = dicomread(path);
    info = dicominfo(path);
elseif (imageFormat == 'mat')
    img = load(path);
    info = [];
elseif (imageFormat == 'png')
    img = imread(path);
    info = [];
elseif (imageFormat == 'pgm')
    img = imread(path);
    info = [];
elseif (imageFormat == 'tif')
    img = imread(path);
    info = [];
elseif (imageFormat == 'jpg')
    img = imread(path);
    info = [];
end


end