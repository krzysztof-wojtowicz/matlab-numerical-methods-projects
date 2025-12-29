function test1()
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Sprawdza, czy zaimplementowana złożona kwadratura trapezów ma rząd
% równy 2, dla dowolnego n błąd dla funkcji rzędu conajwyżej 1 powinien
% wynosić 0. Przedział to [0,1].

fprintf("%70s\n%32sTest 1\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Sprawdza, czy zaimplementowana złożona kwadratura trapezów" + ...
    " ma rząd\nrówny 2, dla dowolnego n błąd dla funkcji rzędu" + ...
    " conajwyżej 1 powinien\nwynosić 0. Przedział to [0,1].\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

f0 = @(x) 1 + 0.*x; % funkcja stała f(x) = 1
f1 = @(x) x.*1; % funkcja liniowa f(x) = x
f2 = @(x) x.^2; % funkcja f(x) = x^2
f3 = @(x) x.^3; % funkcja f(x) = x^3
f4 = @(x) x.^4; % funkcja f(x) = x^4

% Wyniki policzone analitycznie na przedziale [0,1]
expected_result = [1; 0.5; 1/3; 0.25; 0.2];

a = 0;
b = 1;

for n = 1
    fprintf("%70s\n", repmat('-',1,70));
    fprintf("%30sdla n = %d\n",repmat(' ',1,30), n);
    fprintf("%70s\n\n", repmat('-',1,70));
    % Wyniki policzone przez kwadraturę
    calculated_result = [integral_trap(f0,n,a,b); ...
        integral_trap(f1,n,a,b); ...
        integral_trap(f2,n,a,b); ...
        integral_trap(f3,n,a,b); ...
        integral_trap(f4,n,a,b)];
    
    errors = abs(expected_result - calculated_result);
    
    % Drukowanie wyników w tabelce
    T = table(calculated_result, expected_result, errors, ...
        'VariableNames', ...
        {'wynik obliczony', 'wynik spodziewany', 'błąd'}, ...
        'RowNames', {'1', 'x', 'x^2', 'x^3', 'x^4'});
    
    disp(T);
    disp('Naciśnij Enter...');
    pause;
end

end % function