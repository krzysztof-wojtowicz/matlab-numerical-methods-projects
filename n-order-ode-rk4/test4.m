function test4()
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Test 4: Test ekstremalny dla równania bardzo wysokiego rzędu (k=100).
% Sprawdza, czy metoda RK4 poprawnie obsługuje duże układy równań
% (100 zmiennych stanu) oraz generuje wykres dla najlepszego przybliżenia.
fprintf("%70s\n%32sTest 4\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Test dla równania rzędu k=100.\n" + ...
    "Sprawdzenie zbieżności oraz wykres dla największego N.\n");
fprintf("%70s\n", repmat('-',1,70));
format short e;

%% DEFINICJA PROBLEMU (Rząd 100)
% Równanie: y^(100) - y = 0
% Zapis: 1*y^(100) + 0*y^(99) + ... + (-1)*y = 0
% Rozwiązanie dokładne: y(x) = exp(x)
% Przedział: [0, 1]
% Warunki początkowe: y(0)=1, y'(0)=1, ..., y^(99)(0)=1 (bo (e^x)' = e^x)

n_order = 100;
b = @(x) 0;

% Automatyczne generowanie współczynników a{1}...a{101}
% a{101}*y^(100) + ... + a{1}*y = 0
a = cell(1, n_order + 1);
[a{:}] = deal(@(x) 0);      % Wypełnij zerami
a{1} = @(x) -1;             % a{1} stoi przy y
a{n_order + 1} = @(x) 1;    % a{101} stoi przy y^(100)

x0 = 0;
xN = 1;
y0 = ones(n_order, 1);      % Warunki początkowe: wektor 100 jedynek
exact_sol = @(x) exp(x);

%% TEST ZBIEŻNOŚCI
N_vals = [10, 20, 40, 80];
iters = length(N_vals);
h_vals = zeros(iters, 1);
max_errors = zeros(iters, 1);
ratios = zeros(iters, 1);

% Zmienne do przechowywania wyników ostatniego (najdokładniejszego) przebiegu
last_x_grid = [];
last_y_num = [];
last_y_exact = [];

fprintf("Obliczanie dla rzędu %d... Może to chwilę potrwać.\n\n", n_order);

for i = 1:iters
    N = N_vals(i);
    
    % 1. Rozwiązanie numeryczne
    y_matrix = P2Z45_KWO_classicRungeKutta(b, a, x0, xN, y0, N);
    
    % y_matrix ma wymiar [100 x (N+1)]. Interesuje nas y(x), czyli pierwszy wiersz.
    y_num_val = y_matrix(1, :);
    
    % 2. Rozwiązanie dokładne
    h = (xN - x0) / N;
    x_grid = x0:h:xN;
    y_exact_val = exact_sol(x_grid);
    
    % 3. Błąd
    current_error = max(abs(y_num_val - y_exact_val));
    
    h_vals(i) = h;
    max_errors(i) = current_error;
    
    if i > 1
        ratios(i) = max_errors(i-1) / max_errors(i);
    end
    
    % Zapisz dane z ostatniej iteracji do wykresu
    if i == iters
        last_x_grid = x_grid;
        last_y_num = y_num_val;
        last_y_exact = y_exact_val;
    end
end

% Wyświetlenie tabeli
T = table(N_vals(:), h_vals, max_errors, ratios, ...
    'VariableNames', {'N', 'Krok h', 'Max Błąd', 'Iloraz błędu'});
disp(T);

%% RYSOWANIE WYKRESU (Dla największego N)
fprintf("\nGenerowanie wykresu dla N = %d...\n", N_vals(end));
figure('Name', 'Test 4 - Rzad 100', 'NumberTitle', 'off', 'Color', 'w');

% Wykres rozwiązania
subplot(2, 1, 1);
plot(last_x_grid, last_y_exact, 'k-', 'LineWidth', 1.5); hold on;
plot(last_x_grid, last_y_num, 'r--', 'LineWidth', 1.5);
title(sprintf('Rozwiązanie równania rzędu 100 (N=%d)', N_vals(end)));
xlabel('x'); ylabel('y');
legend('Dokładne e^x', 'Numeryczne RK4', 'Location', 'best');
grid on;

% Wykres błędu
subplot(2, 1, 2);
error_vals = abs(last_y_num - last_y_exact);
plot(last_x_grid, error_vals, 'b.-', 'LineWidth', 1.0);
title('Błąd bezwzględny |y_{num} - y_{dok}|');
xlabel('x'); ylabel('Błąd');
grid on;

fprintf("%70s\n", repmat('-',1,70));
fprintf("Zakończono. Wykres został wygenerowany.\n");
fprintf("%70s\n", repmat('-',1,70));

end