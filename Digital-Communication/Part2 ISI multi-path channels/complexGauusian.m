function chFinal =complexGauusian(L,type)
    %Complex Gaussizn channel
    ch =1/2*(randn(L, 1) +1i*randn(L,1));
    %To verify That channel has zero mean and 1 variance with size 100 X 1
    ch = (ch-mean(ch))./sqrt(var(ch));
    if nargin < 2
        type = 1;
    end
    
    %Linear H
    if(type ==1)
        chFinal =[ch];
        for i=1:L-1
            linearSh=[zeros(i,1);ch(1:L-i)];
            chFinal =[chFinal linearSh];
        end
    else
        % circlant H
        chFinal = [];
        for i =1:L
            chFinal = [chFinal circshift(ch ,i-1)];
        end
    end
end