function [x] = rwhitening(X,mu,s,u,d)

    x = (X - mu) * u;
    epsilon = 1*10^(-5);

[~,k] = size(X);
if d/k <= 1/8
    c = 3;
elseif d/k > 1/8
    c = 4;
end
xPCAWhite = x * diag(1./((diag(s)+epsilon) .^ (1/c)));
xPCAWhite(isnan(xPCAWhite)) = 0;
x = xPCAWhite(:,1:d);

end

