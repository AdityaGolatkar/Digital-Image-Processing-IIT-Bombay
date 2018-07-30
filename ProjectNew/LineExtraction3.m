function [image_op] = LineExtraction3(sigma_m,sigma_c)
img = imread('einstein.jpg');
sz = size(img);
sigma_s = 1.6*sigma_c;
%T = floor(10*sigma_c);
%S = floor(10*sigma_m);
S = 10;
T = 5;
max_ST = max(S,T);
win = 2*max_ST + 1;
winby2 = floor(win/2);
[t,image] = ETF(img,win);
%image = imgaussfilt(image,0.5);
sz2 = size(image);
%[Tx, Ty, image] = myETF(img,win,0.2);
%sz_t = size(Tx);
%s_t = [sz_t(1) sz_t(2) 2];
%t = zeros(s_t);
%t(:,:,1) = Tx;
%t(:,:,2) = Ty;
%[image , t(:,:,1),t(:,:,2)] = myETF(img,11,1);
tau1 = 0.7;
tau2 = 0;
rho = 0.99;
g(:,:,1) = t(:,:,2);
g(:,:,2) = -t(:,:,1);

[gmag ,gdir] = imgradient(g(:,:,1),g(:,:,2));
[tmag ,tdir] = imgradient(t(:,:,1),t(:,:,2));
        
for run = 1:3
    H_g = zeros(size(image));
    for v= winby2+1: winby2+sz(2)
        for u = winby2+1:winby2+sz(1)
            angle = gdir(u,v);
            sum_t = 0;
                
            if ((angle >= -22.5) && (angle <= 22.5))
                for q = -T:T
                    f_t = normpdf(q,0,sigma_c) - rho*normpdf(q,0,sigma_s);
                    sum_t = sum_t + image(u+q,v)*f_t;
                end
                
            elseif ((angle <=-157.5) || (angle >= 157.5)) 
                for q = -T:T
                    f_t = normpdf(q,0,sigma_c) - rho*normpdf(q,0,sigma_s);
                    sum_t = sum_t + image(u-q,v)*f_t;
                end
                
            elseif ((angle >= 22.5) && (angle <= 67.5))
                for q = -T:T
                    f_t = normpdf(q,0,sigma_c) - rho*normpdf(q,0,sigma_s);
                    sum_t = sum_t + image(u+q,v+q)*f_t;
                end
                
            elseif ((-157.5 <= angle) && (angle  <= -112.5))
                for q = -T:T
                    f_t = normpdf(q,0,sigma_c) - rho*normpdf(q,0,sigma_s);
                    sum_t = sum_t + image(u-q,v-q)*f_t;
                end

            elseif ((angle >= 67.5) && (angle <= 112.5))
                 for q = -T:T
                    f_t = normpdf(q,0,sigma_c) - rho*normpdf(q,0,sigma_s);
                    sum_t = sum_t + image(u,v+q)*f_t;
                 end
                 
            elseif ((angle <= -67.5) && (angle >= -112.5))
                 for q = -T:T
                    f_t = normpdf(q,0,sigma_c) - rho*normpdf(q,0,sigma_s);
                    sum_t = sum_t + image(u,v-q)*f_t;
                end

            elseif ((112.5 <= angle) && (angle <= 157.5))
                 for q = -T:T
                    f_t = normpdf(q,0,sigma_c) - rho*normpdf(q,0,sigma_s);
                    sum_t = sum_t + image(u-q,v+q)*f_t;
                 end
                 
            elseif ((angle >= -67.5) && (angle <= -22.5))
                for q = -T:T
                    f_t = normpdf(q,0,sigma_c) - rho*normpdf(q,0,sigma_s);
                    sum_t = sum_t + image(u+q,v-q)*f_t;
                 end
            end;
            H_g(u,v) = sum_t;
        end
    end
    imshow(H_g);
    H_e = zeros(size(image));
    for v= max_ST+1:sz2(2)-max_ST-1
        for u = max_ST+1:sz2(1)-max_ST-1
            u2 = u;
            v2 = v;
            %xc = u;
            %yc = v;
            sum_s = 0;
            
            for f = 1:S+1
                angle = tdir(u2,v2);
                g_s = normpdf(f-1,0,sigma_m);
                sum_s = sum_s + H_g(u2,v2)*g_s;
                
                if ((angle >= -22.5) && (angle <= 22.5))
                        %sum_s = sum_s + H_g(u2+1,v2)*g_s;
                        u2 = u2+1;
                        
                elseif ((angle <=-157.5) || (angle >= 157.5))
                        %sum_s = sum_s + H_g(u2-1,v2)*g_s;
                        u2 = u2-1;
                        
                elseif ((angle >= 22.5) && (angle <= 67.5))
                        %sum_s = sum_s + H_g(u2+1,v2+1)*g_s;
                        u2 = u2+1;
                        v2 = v2+1;

                elseif (-157.5 <= angle <= -112.5)
                        %sum_s = sum_s + H_g(u2-1,v2-1)*g_s;
                        u2 = u2-1;
                        v2 = v2-1;
                        
                elseif ((angle >= 67.5) && (angle <= 112.5))   
                        %sum_s = sum_s + H_g(u2,v2+1)*g_s;
                        v2 = v2+1;
                        
                elseif ((angle <= -67.5) && (angle >= -112.5))
                        %sum_s = sum_s + H_g(u2,v2-1)*g_s;
                        v2 = v2-1;
                        
                elseif ((angle >= -67.5) && (angle <= -22.5)) 
                        %sum_s = sum_s + H_g(u2+1,v2-1)*g_s;
                        u2 = u2+1;
                        v2 = v2-1;
                        
                elseif (112.5 <= angle && angle <= 157.5)
                        %sum_s = sum_s + H_g(u2-1,v2+1)*g_s;
                        u2 = u2-1;
                        v2 = v2+1;
                end;
            end
            
            u2 = u;
            v2 = v;
            
            for f = 2:S+1
                angle1 = tdir(u2+1,v2);
                angle2 = tdir(u2+1,v2+1);
                angle3 = tdir(u2,v2+1);
                angle4 = tdir(u2-1,v2+1);
                angle5 = tdir(u2-1,v2);
                angle6 = tdir(u2-1,v2-1);
                angle7 = tdir(u2,v2-1);
                angle8 = tdir(u2+1,v2-1);
                
                g_s = normpdf(1-f,0,sigma_m);
                d_min = 22.5;
                un = u2;
                vn = v2;
                if ((angle1 <= -157.5) || (angle1 >= 157.5))
                        if(angle1 > 0 && (180-angle1) < d_min)
                            un = u2+1;
                            d_min = 180-angle1;
                        elseif(angle1 < 0 && (angle1-180) < d_min)
                            un = u2+1;
                            d_min = angle1-180;
                        end
                        %sum_s = sum_s + H_g(u2+1,v2)*g_s;
                        %u2 = u2+1;
                end 
                        
                if ((angle2 <=-112.5) && (angle2 >= -157.5))
                        if(abs(angle2 + 135) < d_min)
                            un = u2+1;
                            vn = v2+1;
                            d_min = abs(angle2+135);
                        end
                        %sum_s = sum_s + H_g(u2+1,v2+1)*g_s;
                        %u2 = u2+1;
                        %v2 = v2+1;
                end
                        
                if ((angle3 <= -67.5) && (angle3 >= -112.5))
                        if(abs(angle3 + 90) < d_min)
                            vn = v2+1;
                            d_min = abs(angle3 + 90);
                        end
                        %sum_s = sum_s + H_g(u2,v2+1)*g_s;
                        %v2 = v2-1;
                end
                
                if (-67.5 <= angle4 <= -22.5)
                        if(abs(angle4 + 45) < d_min)
                            un = u2-1;
                            vn = v2+1;
                            d_min = abs(angle4 + 45);
                        end
                        %sum_s = sum_s + H_g(u2-1,v2+1)*g_s;
                        %u2 = u2-1;
                        %v2 = v2+1;
                end 
                
                if ((angle5 >= -22.5) && (angle5 <= 22.5))
                        if(abs(angle5) < d_min)
                            un = u2-1;
                            d_min = abs(angle5);
                        end
                        %sum_s = sum_s + H_g(u2-1,v2)*g_s;
                        %u2 = u2-1;
                end
                
                if ((angle6 <= 67.5) && (angle6 >= 22.5))
                        if(abs(angle6-45) < d_min)
                            un = u2-1;
                            vn = v2-1;
                            d_min = abs(angle6-45);
                        end
                        %sum_s = sum_s + H_g(u2-1,v2-1)*g_s;
                        %u2 = u2-1;
                        %v2 = v2-1;
                end
                        
                if ((angle7 >= 67.5) && (angle7 <= 112.5))
                        if(abs(angle7-90) < d_min)
                            vn = v2-1;
                            d_min = abs(angle7-90);
                        end
                        %sum_s = sum_s + H_g(u2,v2-1)*g_s;
                        %v2 = v2-1;
                end
                
                if (112.5 <= angle8 && angle8 <= 157.5)
                        if(abs(angle8-135) < d_min)
                            un = u2+1;
                            vn = v2-1;
                            %d_min = abs(angle8-135);
                        end
                        %sum_s = sum_s + H_g(u2+1,v2-1)*g_s;
                        %u2 = u2+1;
                        %v2 = v2-1;
                end
                sum_s = sum_s + H_g(un,vn)*g_s;
                u2 = un;
                v2 = vn;
                %d_min = 22.5;
            end
            
            H_e(u,v) = sum_s;
        end
    end
    %imshow(H_e);
    linedimg = zeros(size(image));
    for v= winby2 +1: winby2 +sz(2)
        for u = winby2+1:winby2+sz(1)
            if((H_e(u,v) < 0 ) && (1+tanh(H_e(u,v)) < tau1))
            %if((H_e(u,v) < 0 ) || (tanh(H_e(u,v)) < tau2))
                linedimg(u,v) = 0;
            else
                linedimg(u,v) = 255;
            end
        end
    end
    
    image = (image.*linedimg)/255;
end
s = size(img);
image_op = zeros(s);
i = 1:s(1);
j = 1:s(2);
image_op(i,j) = linedimg(i+winby2,j+winby2);
%imshow(uint8(image_op));


