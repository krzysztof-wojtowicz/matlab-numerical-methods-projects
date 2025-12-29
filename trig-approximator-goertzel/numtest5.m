function numtest5()
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Sprawdza czas działania algorytmu Geortzela względem zwykłego
% sumowania. 

fprintf("%70s\n%30sNumtest 5\n%70s\n",repmat('-',1,70),repmat(' ',1,30), ...
    repmat('-',1,70));
fprintf("Sprawdza czas działania algorytmu Geortzela względem zwykłego" + ...
    "\nsumowania.\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

f0 = @(x) exp(sin(x));% f(x) = exp(sinx) 
f1 = @(x) (2/pi)*asin(sin(x)); % f(x) = 2/pi * arcsin(sinx)
f2 = @(x) sin(x).^3; % f(x) = (sinx)^3

f = {f0,f1,f2};
titles = [...
    "exp(sin(x))", ...
    "2/pi * arcsin(sinx)", ...
    "(sinx)^3"];

n = 1e4; % liczba podprzedziałów trapezów
x = linspace(0,2*pi,1e6);
N = 1e2;

times_sum = zeros(1,3);
times_goe = zeros(1,3);

for i = 1:3
    [c,s] = P1Z60_KWO_approximation(f{i},N,n);
    
    % Liczenie wartości przez sumę (nieoptymalne)
    tic;
    
    y = fourier(c,s,x);

    times_sum(i) = toc;

    % Liczenie wartości przy użyciu algorytmu Goertzela
    tic

    y = goertzel(c,s,x);

    times_goe(i) = toc;
end

T = table(titles(:), times_sum(:), times_goe(:), ...
            'VariableNames', ...
            {'funkcja', 'czas dla sumy', 'czas dla Goertzela'});
    
disp(T);

format short;
mean_time = mean(times_sum./times_goe);
fprintf("Algorytm Goertzela jest średnio %d był szybszy.\n", mean_time);

end % function