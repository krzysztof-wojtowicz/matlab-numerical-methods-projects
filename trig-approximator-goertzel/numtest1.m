function numtest1()
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Sprawdza, jak liczba podprzedziałów n wpływa na dokładność całek
% dla danych funkcji okresowych na przedziale [0,2pi].

fprintf("%70s\n%30sNumtest 1\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Sprawdza, jak liczba podprzedziałów n wpływa na dokładność" + ...
    " całek\ndla danych funkcji okresowych na przedziale [0,2pi].\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

f0 = @(x) sin(x).*sin(x); % sinx*sinx
f1 = @(x) (2*sin(x) + 3*cos(3.*x)).*cos(3.*x); % (2sinx + 3cos3x)*cos3x
f2 = @(x) sin(5.*x).*sin(5.*x); % sin5x*sin5x

f_count = 3;
f = {f0,f1,f2};
titles = [...
    "f(x) = sin(x)*sin(x)", ...
    "f(x) = (2sin(x) + 3cos(3x))*cos(3x)", ...
    "f(x) = sin(5x)*sin(5x)"];
spaces = [25,18,23];
expected_values = [pi, 3*pi, pi];

n_count = 11;
n = 1:11;
errors = zeros(1,n_count);
values = zeros(1,n_count);

% Przedział
a = 0;
b = 2*pi;

% Dla każdej funkcji
for i = 1:f_count
    fprintf("%70s\n", repmat('-',1,70));
    fprintf("%s%s\n",repmat(' ',1,spaces(i)),titles(i));
    fprintf("%70s\n\n", repmat('-',1,70));
    
    % Obliczamy całkę dla różnych ilości podprzedziałów i zapisujemy błąd
    for j = 1:n_count
        values(j) = integral_trap(f{i},n(j),a,b);
        errors(j) = abs(expected_values(i) - values(j));
    end

    % Wyświetlenie tabelki
    temp = repmat(expected_values(i), n_count, 1);
    T = table(n(:), errors(:), values(:), temp, ...
        'VariableNames', ...
        {'n', 'błąd', 'wartość obliczona', 'oczekiwana'});

    disp(T);
    disp('Naciśnij Enter...');
    pause;
end

end % function