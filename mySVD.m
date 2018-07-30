function [U,V,S] = mySVD(A)
A_T = transpose(A);
P = A*A_T;
Q = A_T*A;
s = size(A);
r = min(s(1),s(2));
[U1,S1] = eigs(P,r);
[V1,S2] = eigs(Q,r);
%[U1,S1] = eig(P)
%[V1,S2] = eig(Q)
ct = 1;
for i = 1:r
    if(S1(i,i) > 0.0001)
        ct = ct+1;
    end
end
ct = ct-1;
sS = [ct ct];
sU = [s(1) ct];
sV = [s(2) ct];
S = zeros(sS);
U = zeros(sU);
V = zeros(sV);
ct = 1;
for i = 1:r
    if(S1(i,i) > 0.0001)
        U(:,ct) = U1(:,i);
        S(ct,ct) = sqrt(S1(i,i));
        for j = 1:r
            if(abs(S2(j,j)-S1(i,i)) < 0.0001)
                break;
            end
        end
        V(:,ct) = V1(:,j);
        ct = ct+1;
    end
end
