function B=findB(yt,A)

cccc=max(yt);
y=cccc-A;
[~,y]=min(yt-y);
B=max(y)-min(y);

end