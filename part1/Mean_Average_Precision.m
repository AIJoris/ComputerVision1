function [MAP] = Mean_Average_Precision(predictions)

MAP = zeros(1,length(predictions));

for i=1:length(predictions)
   m = sum(predictions{i}==i);
   P = 0;
   R = 0;
   for j=1:length(predictions{i})
        if predictions{i}(j) == i
           R = R+1;
           P = P+(R/j);
        end
   end
   MAP(i) = (1/m)*P;
end
MAP = mean(MAP);
end
