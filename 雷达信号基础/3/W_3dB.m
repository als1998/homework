function [value] = W_3dB(x)
Len = length(x);
M=max(x)-3;
x_mid = find(x==max(x));
    for ix = x_mid+1:Len-1
        if (x(ix-1)>=M)&&(x(ix+1)<=M)
            right=ix;
               break;
         end
    end
for ix = x_mid-1:-1:2
    if (x(ix)-1<=M)&&(x(ix+1)>=M)
        left=ix;
        break;
    end
end
value=right-left+1;
end
