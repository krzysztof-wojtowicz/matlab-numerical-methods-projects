function test2()
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Sprawdza, czy zaimplementowana złożona kwadratura trapezów jest
% zbieżna kwadratowo dla funkcji kwadratowych, czyli dla dwukrotnego
% zwiększenia n błąd powinien maleć 4-krotnie. Przedział to [0,1].

fprintf("%70s\n%32sTest 2\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Sprawdza, czy zaimplementowana złożona kwadratura trapezów" + ...
    " jest\nzbieżna kwadratowo dla funkcji kwadratowych, czyli dla" + ...
    " dwukrotnego\nzwiększenia n błąd powinien maleć 4-krotnie." + ...
    " Przedział to [0,1].\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

f0 = @(x) x.^2; % funkcja f(x) = x^2
f1 = @(x) (-3).*x.^2 + 2; % funkcja f(x) = -3 x^2 + 2
f2 = @(x) 4.*x.^2 + x - 1; % funkcja f(x) = 4 x^2 + x - 1

% Wyniki policzone analitycznie na przedziale [0,1]
expected_result = [1/3;1;5/6];

a = 0;
b = 1;

errors = zeros(3,3);
i = 1;

for n = [1,2,4]
    fprintf("%70s\n", repmat('-',1,70));
    fprintf("%30sdla n = %d\n",repmat(' ',1,30),n);
    fprintf("%70s\n\n", repmat('-',1,70));
    % Wyniki policzone przez kwadraturę
    calculated_result = [integral_trap(f0,n,a,b); ...
        integral_trap(f1,n,a,b); ...
        integral_trap(f2,n,a,b)];
    
    errors(:,i) = abs(expected_result - calculated_result);
    
    % Drukowanie wyników w tabelce
    T = table(calculated_result, expected_result, errors(:,i), ...
        'VariableNames', ...
        {'wynik obliczony', 'wynik spodziewany', 'błąd'}, ...
        'RowNames', {'x^2', '-3x^2+2', '4x^2+x-1'});
    
    disp(T);
    i = i + 1;
    disp('Naciśnij Enter...');
    pause;
end

% Podsumowanie ilu-krotnie zmieniały się błędy
fprintf("%70s\n", repmat('-',1,70));
fprintf("  Podsumowanie ilu-krotnie zmalał błąd względem poprzedniej" + ...
    " wartości\n");
fprintf("%70s\n\n", repmat('-',1,70));

e1 = errors(:,1) ./ errors(:,2);
e2 = errors(:,2) ./ errors(:,3);

T = table(e1, e2, 'VariableNames', ...
        {'błąd 1/błąd 2', 'błąd 2/błąd 3'}, ...
        'RowNames', {'x^2', '-3x^2+2', '4x^2+x-1'});

disp(T);
disp('Naciśnij Enter...');
pause;

end % function