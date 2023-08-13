function sierpinski_triangle_animation_to_mp4()

    % Useful Parameters
    L = 10; % Side length
    it = 7; % Number of iterations
    video_fps = 60; % Desired FPS for the video
    frame_pause = 1/video_fps;

    % Support initialization
    sop_x = [0 L/2 L];
    sop_y = [0 sqrt(3*(L^2)/4) 0];
    figure; % Create a new figure
    axis equal;
    axis off;
    hold on;
    
    % Create a VideoWriter object
    writerObj = VideoWriter('sierpinski_animation.mp4', 'MPEG-4');
    writerObj.FrameRate = video_fps; % Set the desired video FPS
    open(writerObj);

    % Iteration >0
    if(it > 0)
        side = L/2;
        it0_x = [side/2 side 3*side/2];
        it0_y = [sqrt(3*(side^2)/4) 0 sqrt(3*(side^2)/4)];
        fill(it0_x, it0_y, 'w'); 
        plot(it0_x([1, 2, 3, 1]), it0_y([1, 2, 3, 1]), 'k');
        frame = getframe(gcf);
        writeVideo(writerObj, frame);
        hold on;

        % Initialization of cells that will contain the triangles coordinates
        coor{1,1} = it0_x; 
        coor{2,1} = it0_y; 

        % Next iterations
        for i = 1:1:it
            temp = {};
            side = side/2;
            for n = 1:1:size(coor,2)
                h = sqrt(3*(side^2)/4);

                % Relative right triangle
                x_r = [coor{1,n}(2)+side/2 coor{1,n}(2)+side coor{1,n}(2)+3*side/2];
                y_r = [coor{2,n}(2)+h coor{2,n}(2) coor{2,n}(2)+h];
                fill(x_r, y_r, 'w'); 
                plot(x_r([1, 2, 3, 1]), y_r([1, 2, 3, 1]), 'k');
                frame = getframe(gcf);
                writeVideo(writerObj, frame);
                pause(frame_pause * 0.5); % Reduce pause for faster animation
                hold on;

                % Relative above triangle
                x_u = [coor{1,n}(1)+side/2 coor{1,n}(1)+side coor{1,n}(1)+3*side/2];
                y_u = [coor{2,n}(1)+h coor{2,n}(1) coor{2,n}(1)+h];
                fill(x_u, y_u, 'w'); 
                plot(x_u([1, 2, 3, 1]), y_u([1, 2, 3, 1]), 'k');
                frame = getframe(gcf);
                writeVideo(writerObj, frame);
                pause(frame_pause * 0.5); % Reduce pause for faster animation
                hold on;

                % Relative left triangle
                x_l = [coor{1,n}(2)-3*side/2 coor{1,n}(2)-side coor{1,n}(2)-side/2];
                y_l = [coor{2,n}(2)+h coor{2,n}(2) coor{2,n}(2)+h];
                fill(x_l, y_l, 'w'); 
                plot(x_l([1, 2, 3, 1]), y_l([1, 2, 3, 1]), 'k');
                frame = getframe(gcf);
                writeVideo(writerObj, frame);
                pause(frame_pause * 0.5); % Reduce pause for faster animation
                hold on;

                % New triangles coordinates storage
                l = size(temp,2);
                temp{1,l+1} = x_r; temp{2,l+1} = y_r;
                temp{1,l+2} = x_u; temp{2,l+2} = y_u;
                temp{1,l+3} = x_l; temp{2,l+3} = y_l;
            end
            % Cleaning up temporal cells
            coor = temp;
            clear('temp');
        end
        hold off; 
    end
    
    % Close the VideoWriter object
    close(writerObj);
    title(['Sierpinski Triangle Animation (' num2str(it) ' iterations)']);
end
