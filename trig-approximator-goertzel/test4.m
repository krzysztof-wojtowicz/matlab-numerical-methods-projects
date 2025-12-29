function test4()
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Sprawdza, czy zaimplementowany algorytm Goertzela poprawnie
% oblicza wartości funkcji zapisanej jako suma Fouriera. Dodatkowo
% sprawdza poprawność obliczania wartości przez zwykła sumę.

fprintf("%70s\n%32sTest 4\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Sprawdza, czy zaimplementowany algorytm Goertzela" + ...
    " poprawnie\noblicza wartości funkcji zapisanej jako" + ...
    " suma Fouriera. Dodatkowo\nsprawdza poprawność" + ...
    " obliczania wartości przez zwykła sumę.\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

f0 = @(x) sin(x); % f(x) = sinx
f1 = @(x) cos(2.*x); % f(x) = cos2x
f2 = @(x) sin(x) + cos(x); % f(x) = sinx + cosx

f_count = 3;
f = {f0,f1,f2};
titles = [...
    "f(x) = sin(x)", ...
    "f(x) = cos(2x)", ...
    "f(x) = sin(x) + cos(x)"];
spaces = [28,28,24];
N = 3;
n = 7; % maksymalny stopień dla N = 3 to 6, więc 7 > 6 jest ok
x_count = 6;
x = linspace(0,2*pi,x_count);
exact_vals = zeros(1,x_count);
goertzel_vals = zeros(1,x_count);
sum_vals = zeros(1,x_count);

for i = 1:f_count
    fprintf("%70s\n", repmat('-',1,70));
    fprintf("%s%s\n",repmat(' ',1,spaces(i)),titles(i));
    fprintf("%70s\n\n", repmat('-',1,70));
    % Obliczenie współczynników
    [c,s] = P1Z60_KWO_approximation(f{i},N,n);
    
    % Wartości funkcji
    exact_vals = f{i}(x);
    goertzel_vals = goertzel(c,s,x);
    sum_vals = fourier(c,s,x);
    errors_goertzel = abs(goertzel_vals - exact_vals);
    errors_sum = abs(sum_vals - exact_vals);

    % Wyświetlenie tabelki dla goertzela
    T = table(x(:), exact_vals(:), goertzel_vals(:), errors_goertzel(:), ...
        'VariableNames', ...
        {'x', 'f(x)', 'goertzel', 'błąd'});
    disp(T);
    disp('Naciśnij Enter...');
    pause;
     % Wyświetlenie tabelki dla zwykłej sumy
    T = table(x(:), exact_vals(:), sum_vals(:), errors_sum(:), ...
        'VariableNames', ...
        {'x', 'f(x)', 'zwykła suma', 'błąd'});
    disp(T);
    disp('Naciśnij Enter...');
    pause;
end

end % function