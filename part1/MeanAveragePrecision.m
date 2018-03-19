function [AP, MAP] = MeanAveragePrecision(predictions)

AP = zeros(1,length(predictions));

for i=1:length(predictions)
   m = sum(predictions{i}==i);
   P = 0;
   R = 0;
   % Calculate average precision
   for j=1:length(predictions{i})
        if predictions{i}(j) == i
           R = R+1;
           P = P+(R/j);
        end
   end
   if (1/m)*P > 0
       AP(i) = (1/m)*P;
   else
       AP(i) = 0;
   end
end
% Calculate mean average precision
MAP = mean(AP);
end