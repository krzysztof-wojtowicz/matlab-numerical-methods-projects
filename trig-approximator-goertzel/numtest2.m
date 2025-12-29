function numtest2()
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Sprawdza, jak zwiększenie wielkości bazy funkcji wpływa na błąd
% średniokwadratowy dla bardziej skomplikowanych funkcji okresowych.
% Drukuje dla danego N wartości dokładne i przybliżone.

fprintf("%70s\n%30sNumtest 2\n%70s\n",repmat('-',1,70),repmat(' ',1,30), ...
    repmat('-',1,70));
fprintf("Sprawdza, jak zwiększenie wielkości bazy funkcji wpływa na" + ...
    " błąd\nśredniokwadratowy dla bardziej skomplikowanych funkcji" + ...
    " okresowych.\nDrukuje dla danego N wartości dokładne" + ...
    " i przybliżone.\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

f0 = @(x) exp(sin(x));% f(x) = exp(sinx) 
f1 = @(x) (2/pi)*asin(sin(x)); % f(x) = 2/pi * arcsin(sinx)
f2 = @(x) sin(x).^3; % f(x) = (sinx)^3

f = {f0,f1,f2};
titles = [...
    "f(x) = exp(sin(x))", ...
    "f(x) = 2/pi * arcsin(sinx)", ...
    "f(x) = (sinx)^3"];
spaces = [26,22,27];

n = 10000; % liczba podprzedziałów trapezów
m = 6; % liczba punktów do tablicowania
x = linspace(0,2*pi,m)';

for i = 1:3
    fprintf("%70s\n", repmat('-',1,70));
    fprintf("%s%s\n",repmat(' ',1,spaces(i)),titles(i));
    fprintf("%70s\n\n", repmat('-',1,70));
    
    y_exact = f{i}(x);
    error = zeros(1,3);
    j = 1;

    for N = 2:5:17
        fprintf("%70s\n", repmat('-',1,70));
        fprintf("%30sdla N = %d\n",repmat(' ',1,30),N);
        fprintf("%70s\n\n", repmat('-',1,70));
        % Obliczenie współczynników
        [c,s] = P1Z60_KWO_approximation(f{i},N,n);

        y_calc = goertzel(c,s,x);
        errors = abs(y_calc - y_exact);

        % Liczenie błędu średniokwadratowego
        error(j) = sqrt(mean(errors.^2));
        j = j + 1;

        % Wyświetlenie tabelki
        T = table(x, y_exact, y_calc, errors, ...
            'VariableNames', ...
            {'x', 'f(x)', 'f*(x)', 'błąd'});
        disp(T);
        disp('Naciśnij Enter...');
        pause;
    end
    
    fprintf("%70s\n\n", repmat('-',1,70));
    % Wyświetlenie błędów średniokwadratowych dla danego N
    N = 2:5:17;
    T = table(N(:),error(:), ...
            'VariableNames', ...
            {'N', 'błąd średniokwadratowy'});
    
    disp(T);
    
    disp('Naciśnij Enter...');
    pause;
end

end % function