function test2()
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Test zbieżności metody RK4. Sprawdza, czy dla równań o zmiennych
% współczynnikach (zależnych od x) błąd maleje proporcjonalnie do h^4.
% Przy dwukrotnym zwiększeniu N, błąd powinien zmaleć ok. 16-krotnie.

fprintf("%70s\n%32sTest 2\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Test rzędu zbieżności metody (oczekiwany rząd 4).\n" + ...
    "Dla 'trudnych' równań ze współczynnikami zależnymi od x.\n" + ...
    "Kolumna 'Iloraz błędu' powinna dążyć do wartości 16 (2^4).\n" + ...
    "Jest to iloraz poprzedni błąd/aktualny błąd.\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

%% Przypadek 1: Równanie I rzędu o zmiennych współczynnikach
% Równanie: y' - 2xy = 0
% Zapis: -2x*y + 1*y' = 0
% Rozwiązanie dokładne: y(x) = exp(x^2)
% Przedział: [0, 1], y(0) = 1

fprintf("\n%70s\n", repmat('-',1,70));
fprintf("PRZYPADEK 1: Równanie I rzędu: y' - 2xy = 0\n" + ...
        "Przedział [0,1], x0 = 0, y0 = 1\n" + ...
        "Rozwiązanie dokładne: y(x) = exp(x^2)\n");
fprintf("%70s\n", repmat('-',1,70));

% Definicja równania
b1 = @(x) 0;
a1 = { @(x) -2*x, @(x) 1 }; % a{1} przy y, a{2} przy y'
x0_1 = 0;
xN_1 = 1;
y0_1 = 1;
exact_sol_1 = @(x) exp(x.^2);

% Parametry testu
N_values = [10, 20, 40, 80, 160];
run_convergence_test(b1, a1, x0_1, xN_1, y0_1, exact_sol_1, N_values);

disp('Naciśnij Enter...');
pause;

%% Przypadek 2: Równanie II rzędu o zmiennych współczynnikach
% Równanie: y'' + 4x^2*y = 2cos(x^2)
% Zapis: 4x^2*y + 0*y' + 1*y'' = 2cos(x^2)
% Rozwiązanie dokładne: y(x) = sin(x^2)
% Przedział: [0, 2], y(0) = 0, y'(0) = 0

fprintf("\n%70s\n", repmat('-',1,70));
fprintf("PRZYPADEK 2: Równanie II rzędu: y'' + 4x^2*y = 2cos(x^2)\n" + ...
        "Przedział [0,2], x0 = 0, y0 = [0,0]\n" + ...
        "Rozwiązanie dokładne: y(x) = sin(x^2)\n");
fprintf("%70s\n", repmat('-',1,70));

% Definicja równania
b2 = @(x) 2*cos(x.^2);
a2 = { @(x) 4*x.^2, @(x) 0, @(x) 1 }; % a{1} przy y, a{2} przy y', a{3} przy y''
x0_2 = 0;
xN_2 = 2;
y0_2 = [0; 0]; % y(0)=0, y'(0)=0
exact_sol_2 = @(x) sin(x.^2);

% Parametry testu
run_convergence_test(b2, a2, x0_2, xN_2, y0_2, exact_sol_2, N_values);

fprintf("\n%70s\n", repmat('-',1,70));
fprintf(" KONIEC TESTU\n");
fprintf("%70s\n", repmat('-',1,70));

end % function

function run_convergence_test(b, a, x0, xN, y0, exact_func, N_vals)
    % Funkcja pomocnicza wykonująca pętlę po N i drukująca tabelę
    
    iters = length(N_vals);
    h_vals = zeros(iters, 1);
    max_errors = zeros(iters, 1);
    ratios = zeros(iters, 1);
    
    for i = 1:iters
        N = N_vals(i);
        
        % 1. Rozwiązanie numeryczne
        y_num = P2Z45_KWO_classicRungeKutta(b, a, x0, xN, y0, N);
        
        % 2. Rozwiązanie dokładne na siatce
        h = (xN - x0) / N;
        x_grid = x0:h:xN;
        y_exact = arrayfun(exact_func, x_grid);
        
        % 3. Obliczenie błędu maksymalnego
        current_error = max(abs(y_num - y_exact)); 
        
        h_vals(i) = h;
        max_errors(i) = current_error;
        
        % 4. Obliczenie ilorazu błędu
        if i > 1
            ratios(i) = max_errors(i-1) / max_errors(i);
        end
    end
    
    % Wyświetlenie tabeli
    T = table(N_vals(:), h_vals, max_errors, ratios, ...
        'VariableNames', {'N', 'Krok h', 'Max Błąd', 'Iloraz błędu'});
    disp(T);

end % function