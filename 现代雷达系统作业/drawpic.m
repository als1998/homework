function  picdata=drawpic(inputArg1)
    rawdata = inputArg1;
    picsize=size(rawdata);
    rawdata=fix((rawdata+abs(min(min(rawdata)))).*picsize(1)./(max(max(rawdata))-min(min(rawdata))));
    picdata=zeros(picsize);
    %%将每一列中的数字换算成每一行中所对应位置处的像素
    for j=1:picsize(2)
        for i=1:picsize(1)
            picdata(max(max([rawdata(i,j),1])),j)=picdata(max(max([rawdata(i,j),1])),j)+1;
        end
    end
    picdata=picdata.*255./(max(max(rawdata))-min(min(rawdata)));
    picdata=fix(picdata);
    figure();
    imshow(picdata);
end

