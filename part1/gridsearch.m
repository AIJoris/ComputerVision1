%% baseline
n_base = 20;
r_base = 0.5;
k_base = 40;
method_base = 'sift';

main(n_base, r_base, k_base, method_base, 0)

% %% vary n, compare to baseline
% name = 1;
% for n=[50,100,400]
%     main(n, r_base, k_base, method_base,name)
%     name = name + 1;
% end
% 
% %% vary r, compare to baseline
% for r=[0.15, 0.3]
%     main(n_base, r, k_base, method_base,name)
%     name = name + 1;
% end
% 
% %% vary k, compare to baseline
% for k=[800, 1600, 2000, 4000]
%     main(n_base, r_base, k, method_base, name)
%     name = name + 1;
% end
% 
% %% vary method, compare to baseline
% for method={'dsift', 'RGBsift', 'rgbsift', 'opsift'}
%     main(n_base, r_base, k_base, method, name)
%     name = name + 1;
% end

        


% main(400, 0.5, 800, 'opsift', 13)
% main(400, 0.5, 4000, 'opsift', 14)
% main(400, 0.1, 800, 'opsift', 15)





