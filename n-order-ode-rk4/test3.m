function test3()
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Test 3: Test dla równań wysokich rzędów (Order 5 i Order 20).
% Sprawdza skalowalność i stabilność metody przy dużych układach równań.
fprintf("%70s\n%32sTest 3\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Test rzędu zbieżności dla równań WYSOKICH RZĘDÓW.\n" + ...
    "Sprawdzenie poprawności działania dla rzędu k=5 oraz k=20.\n" + ...
    "Mimo dużej liczby zmiennych (macierze 20x20), iloraz błędu\n" + ...
    "nadal powinien dążyć do 16 (zbieżność 4. rzędu).\n");
fprintf("%70s\n", repmat('-',1,70));
format short e;

%% Przypadek 1: Równanie V rzędu (Wielomian)
% Równanie: y^(5) = 120
% Zapis: 1*y^(5) + 0*y^(4) + ... + 0*y = 120
% Rozwiązanie dokładne: y(x) = x^5
% Przedział: [0, 1], Warunki początkowe w zerze: y(0)=0, y'(0)=0... y''''(0)=0
fprintf("\n%70s\n", repmat('-',1,70));
fprintf("PRZYPADEK 1: Równanie V rzędu: y^(5) = 120\n" + ...
        "Rozwiązanie dokładne: y(x) = x^5\n" + ...
        "RK4 jest dokładna dla wielomianów st. 4, tu (st. 5) powinien wystąpić błąd.\n");
fprintf("%70s\n", repmat('-',1,70));

% Definicja współczynników dla rzędu 5
% a{6}*y^(5) + ... + a{1}*y = b
n_order = 5;
a1 = cell(1, n_order + 1);
[a1{:}] = deal(@(x) 0); % Wypełnij zerami
a1{n_order + 1} = @(x) 1; % Współczynnik przy najwyższej pochodnej y^(5)

b1 = @(x) 120; % Prawa strona (5! = 120)

x0_1 = 0;
xN_1 = 1;
y0_1 = zeros(n_order, 1); % Warunki początkowe: same zera
exact_sol_1 = @(x) x.^5;

% Parametry testu
N_values = [10, 20, 40, 80, 160];
run_convergence_test(b1, a1, x0_1, xN_1, y0_1, exact_sol_1, N_values);
disp('Naciśnij Enter, aby przejść do testu rzędu 20...');
pause;

%% Przypadek 2: Równanie XX rzędu (Wysoki rząd)
% Równanie: y^(20) - y = 0
% Zapis: 1*y^(20) + 0*y^(19) + ... + (-1)*y = 0
% Rozwiązanie dokładne: y(x) = exp(x)
% Przedział: [0, 1]
% Warunki początkowe: y(0)=1, y'(0)=1, ... (bo pochodna e^x to e^x, a e^0=1)
fprintf("\n%70s\n", repmat('-',1,70));
fprintf("PRZYPADEK 2: Równanie XX rzędu: y^(20) - y = 0\n" + ...
        "Przedział [0,1], Warunki pocz.: wektor 20 jedynek\n" + ...
        "Rozwiązanie dokładne: y(x) = exp(x)\n");
fprintf("%70s\n", repmat('-',1,70));

% Definicja współczynników dla rzędu 20
% a{21}*y^(20) + ... + a{1}*y = 0
n_order_20 = 20;
a2 = cell(1, n_order_20 + 1);
[a2{:}] = deal(@(x) 0); % Wypełnij zerami
a2{1} = @(x) -1;        % Współczynnik przy y
a2{n_order_20 + 1} = @(x) 1; % Współczynnik przy najwyższej pochodnej y^(20)

b2 = @(x) 0;

x0_2 = 0;
xN_2 = 1;
y0_2 = ones(n_order_20, 1); % Warunki początkowe: same jedynki
exact_sol_2 = @(x) exp(x);

% Parametry testu
run_convergence_test(b2, a2, x0_2, xN_2, y0_2, exact_sol_2, N_values);

fprintf("\n%70s\n", repmat('-',1,70));
fprintf(" KONIEC TESTU 3\n");
fprintf("%70s\n", repmat('-',1,70));
end % function

function run_convergence_test(b, a, x0, xN, y0, exact_func, N_vals)
    % Funkcja pomocnicza wykonująca pętlę po N i drukująca tabelę
    % Identyczna jak w test2.m
    
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
        
        % Uwaga: y_num może przyjść jako wektor wierszowy lub kolumnowy
        % lub jako macierz (dla układów). Nas interesuje pierwszy wiersz/kolumna
        % (czyli funkcja y(x), a nie jej pochodne).
        if size(y_num, 1) > 1 && size(y_num, 2) > 1
             % Jeśli to macierz stanu (wiersze=zmienne, kolumny=czas)
             % to y(x) jest zazwyczaj w 1. wierszu
             val_to_compare = y_num(1, :);
        elseif length(y_num) == length(y_exact)
             val_to_compare = y_num;
        else
             % Fallback, gdyby struktura wyjścia była inna
             val_to_compare = y_num(1,:); 
        end
        
        % Upewnij się, że wymiary się zgadzają do odejmowania
        val_to_compare = val_to_compare(:);
        y_exact = y_exact(:);

        % 3. Obliczenie błędu maksymalnego
        current_error = max(abs(val_to_compare - y_exact)); 
        
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