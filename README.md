Targe-Identification

This project is my tutor's assignment to me.
Its purpose is to detect the different images which have the same background 
and find the red circle targets in the images.

·7 functions
 fitellipse.m   -- Least squares method is used to fit an ellipse to 2-D data.
 fiterror.m     -- Calculate the error of the ellipse fitted and the return value is MSE.
 plotellipse.m  -- Plot the parametrically specified ellipse. 
 imgread.m      -- Read the images in batches.
 label.m        -- Label connected components in 2-D arrays.
 props.m        -- Get some important proporties of shapes extracted from the images.
 threeframe.    -- Use three frame difference method to filter target and get the background.
 
·1 script
 example_img2.m -- Take the img2 as an example
 
Note that in the line 47 of example_img2.m,the threshold(=0.53) of 'Canny Method' 
needs to be adjusted flexiably according to the different images.This is also one of my 
disadvantages of the assignment.
