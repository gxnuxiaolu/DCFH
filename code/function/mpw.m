function [X,Q] = mpw(XText,XTrain,XQ,d)

    XText = normalize(XText,2,'norm');
    XTrain = normalize(XTrain,2,'norm');


    [ mu, s, u, ~] = rpca (XTrain, d);
    X = rwhitening (XText, mu, s, u, d);
    X = normalize(X,2,'norm');
    

    XQ = normalize(XQ,2,'norm');
    Q = rwhitening (XQ, mu, s, u, d);
    Q = normalize(Q,2,'norm');
end

