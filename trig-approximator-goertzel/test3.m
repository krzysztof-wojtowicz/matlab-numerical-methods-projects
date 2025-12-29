function test3()
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Sprawdza, czy zaimplementowana metoda aproksymacji trygonometrycznej
% ciągłej poprawnie wyznacza współczynniki dla funkcji składających
% się z elementów bazy. Weźmiemy n = 11 dla kwadratury trapezów.

fprintf("%70s\n%32sTest 3\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Sprawdza, czy zaimplementowana metoda aproksymacji" + ...
    " trygonometrycznej\nciągłej poprawnie wyznacza współczynniki" + ...
    " dla funkcji składających\nsię z elementów bazy. Weźmiemy" + ...
    " n = 11 dla kwadratury trapezów.\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

f0 = @(x) sin(x); % f(x) = sinx
f1 = @(x) cos(2.*x); % f(x) = cos2x
f2 = @(x) 2*sin(x) + 3*cos(3.*x); % f(x) = 2sinx + 3cos3x
f3 = @(x) sin(5.*x); % f(x) = sin5x
f4 = @(x) 3*sin(2.*x) + 5*sin(3.*x) + 2; % f(x) = 3sin2x + 5sin3x + 2

f = {f0,f1,f2,f3,f4};
titles = [...
    "f(x) = sin(x)", ...
    "f(x) = cos(2x)", ...
    "f(x) = 2sin(x) + 3cos(3x)", ...
    "f(x) = sin(5x)", ...
    "f(x) = 3sin(2x) + 5sin(3x) + 2"];
spaces = [28,28,23,28,20];
N = 5;
n = 11; % maksymalny stopień dla N = 5 to 10, więć 11 > 10 jest ok

for i = 1:5
    fprintf("%70s\n", repmat('-',1,70));
    fprintf("%s%s\n",repmat(' ',1,spaces(i)),titles(i));
    fprintf("%70s\n\n", repmat('-',1,70));
    % Obliczenie współczynników
    [c,s] = P1Z60_KWO_approximation(f{i},N,n);
    % Wyświetlenie tabelki
    T = table(c(:), s(:), ...
        'VariableNames', ...
        {'cos', 'sin'}, ...
        'RowNames', {'a0', 'x', '2x', '3x', '4x', '5x'});
    disp(T);
    disp('Naciśnij Enter...');
    pause;
end

end % function