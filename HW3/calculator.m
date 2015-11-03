function [precision, recall, f_measure] = calculator(predict, test, mode)
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    if mode == 1%class 1 is positive class
        predict = 2 - predict;
        test = 2 - test;
    elseif mode == 2%class 2 is positive class
        predict = predict - 1;
        test = test -1;
    end
    for i = 1:length(predict)
        if predict(i) == test(i) && predict(i) == 1
            a = a + 1;
        end
        if predict(i) ~= test(i) && predict(i) == 0
            b = b + 1;
        end
        if predict(i) ~= test(i) && predict(i) == 1
            c = c + 1;
        end
        if predict(i) == test(i) && predict(i) == 0
            d = d + 1;
        end
        
        precision = a/(a + c);
        recall    = a/(a + b);
        f_measure = 2*a/(2*a+b+c);
    end
end