function [ T ] = rotz( gamma )

          
T = [cos(gamma), -sin(gamma), 0, 0;
               sin(gamma), cos(gamma), 0, 0;
               0, 0, 1, 0;
               0, 0, 0, 1];
end

