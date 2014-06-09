function m = optical_flow(img)

    spacing = 2;                                        % the factor of downsample images
    f = fspecial('gaussian', [5 5], 1.5);
    m = [1,0,0, 0,1,0, 0,0,1];                          % the init param m0-m7
    gridLen = 16;                                       % the length of grid is 16
    interFun = 'cubic';                                 % use bilinear as interpolate function
    % uv = zeros(size(img, 1), size(img, 2), 2);        % the init uv
    
    pyramid_level = 1 + floor( log(min(size(img, 1),... % the octaves of images
        size(img,2))/16) / log(spacing) );
    pyramid_images    = compute_image_pyramid(img, f, ...   % the pyramid images we constructed
        pyramid_level, 1/spacing);
    
    %% now the we use a coarse-to-fine method to calculate uv
    for l = pyramid_level:-1:1                          % from coarse to fine
        display(['-Pyramid level: ', num2str(l), '/', num2str(pyramid_level)]);
        newsz = [size(pyramid_images{l}, 1), size(pyramid_images{l}, 2), 2];    % the new size
        newImg = pyramid_images{l};                     % image of this level
        
        m = levelOptimation(newImg, newsz, m, gridLen);
    end

end