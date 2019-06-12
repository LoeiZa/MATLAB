function [Chinese] = isChinese3(ch)
% 对于GB2312的字符（就是我们平时所说的区位），一个汉字对应于两个字节。 每个字节都是大于A0（十六进制,即160），
% 倘若，第一个字节大于A0，而第二个字节小于A0，那么它应当不是汉字（仅仅对于GB2312)
ChineseMat=[];
EnglishMat=[];
for i=1:length(ch)
    x=ch(i);
    info = unicode2native(x,'GB2312');
    bytes = size(info,2);
    Chinese = 0;
    
    if (bytes == 2)
        if(info(1)>160 & info(2)>160)
            ReturnC = 1;
            ChineseMat=[ChineseMat,ReturnC];
        else
            ReturnC=0;
            ChineseMat=[ChineseMat,ReturnC];
            EnglishMat=[EnglishMat,isletter(x)];
        end
    elseif bytes ~= 2
        EnglishMat=[EnglishMat,isletter(x)];
    end
end


if sum(ChineseMat)==length(ch)
    Chinese=1;
elseif sum(EnglishMat)==length(ch)&&sum(ChineseMat)~=length(ch)
    Chinese=0;
elseif sum(EnglishMat)~=length(ch)&&sum(ChineseMat)~=length(ch)
    Chinese=2;
    
end

disp(ChineseMat);
disp(EnglishMat);
%         elseif i==length(ch)
%             if sum(isletter(ch))==length(ch)
%                 Chinese=0;
%             else
%                 Chinese=2;
%             end
%         end

end