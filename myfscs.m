function [RESULT]=myfscs(IMAGE)
    min_i = min(IMAGE);
    A = min(min_i);
    max_i = max(IMAGE);
    B = max(max_i);
    P = (255/B-A);
    L=(-A)*(255/B-A);
    RESULT=P*IMAGE+L;    
end