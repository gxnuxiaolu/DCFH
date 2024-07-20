function [mu,s,u,x] = rpca(X,d)

mu = mean(X);

Xcov = cov(X, 'omitrows');
Xcov(isnan(Xcov)) = 0;
[u,s,~] = svd(Xcov);
X = X - mu;
x = X * u;
x = x(:,1:d);
end


