function numtest4()
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Numtest 4: Test porównawczy metod 4. rzędu.
% Porównuje metodę Klasyczną, Gilla oraz Regułę 3/8 pod kątem:
% - Dokładności (Błąd vs N)
% - Szybkości (Czas vs N)
% - Efektywności (Błąd vs Czas)
% Test przeprowadzany na równaniu Czebyszewa (n=4) na przedziale [-0.5,0/5].

fprintf("%70s\n%30sNumtest 4\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Porównanie metod: Klasyczna vs Gill vs Reguła 3/8.\n" + ...
    "Badanie dokładności i szybkości dla równania Czebyszewa (n=4).\n" + ...
    "Generowanie 3 wykresów diagnostycznych...\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

%% DEFINICJA PROBLEMU (Czebyszew n=4)
% Równanie: (1-x^2)y'' - xy' + 16y = 0
% Rozwiązanie dokładne: T4(x) = 8x^4 - 8x^2 + 1
n = 4;
b = @(x) 0;
a = { @(x) n^2, @(x) -x, @(x) 1 - x.^2 };
exact = @(x) 8*x.^4 - 8*x.^2 + 1;

% Przedział
x0 = -0.5;
xN = 0.5;

% Warunki początkowe
y0_val = exact(x0);
dy0_val = 32*x0^3 - 16*x0; 
y0 = [y0_val; dy0_val];

% Parametry pętli testowej
N_vals = [100, 200, 400, 800];
% Liczba powtórzeń do uśrednienia czasu
repeats = 25; 

% Inicjalizacja tablic wyników (wiersze: metody, kolumny: N)
% 1: Klasyczna, 2: Gill, 3: 3/8
times_avg = zeros(3, length(N_vals));
errors_max = zeros(3, length(N_vals));

names = ["Klasyczna", "Metoda Gilla", "Metoda 3/8"];
linespecs = ["ro-", "bs--", "g^:"]; 

%% GŁÓWNA PĘTLA POMIAROWA
fprintf("Rozpoczynanie pomiarów...\n");

for i = 1:length(N_vals)
    N = N_vals(i);
    h = (xN - x0)/N;
    
    fprintf("   Testowanie dla N = %d...\n", N);
    
    % --- Metoda 1: Klasyczna ---
    % Przedbieg
    P2Z45_KWO_classicRungeKutta(b, a, x0, xN, y0, N);
    
    % Pomiar właściwy
    tic;
    for r = 1:repeats
        y_c = P2Z45_KWO_classicRungeKutta(b, a, x0, xN, y0, N);
    end
    t_c = toc / repeats;
    
    % Błąd (Klasyczna)
    x_grid = x0:h:xN;
    y_ex = exact(x_grid);
    if isvector(y_c) && ~isrow(y_c); y_c = y_c'; end 
    if size(y_c,1) > 1; val_c = y_c(1,:); else; val_c = y_c; end
    err_c = max(abs(val_c - y_ex));
    
    times_avg(1, i) = t_c;
    errors_max(1, i) = err_c;
    
    % --- Metoda 2: Gilla ---
    % Przedbieg
    RKgill(b, a, x0, xN, y0, N);
    
    % Pomiar właściwy
    tic;
    for r = 1:repeats
        y_g = RKgill(b, a, x0, xN, y0, N);
    end
    t_g = toc / repeats;
    
    % Błąd (Gill)
    if isvector(y_g) && ~isrow(y_g); y_g = y_g'; end
    if size(y_g,1) > 1; val_g = y_g(1,:); else; val_g = y_g; end
    err_g = max(abs(val_g - y_ex));
    
    times_avg(2, i) = t_g;
    errors_max(2, i) = err_g;
    
    % --- Metoda 3: 3/8 ---
    % Przedbieg
    RK38(b, a, x0, xN, y0, N);
    
    % Pomiar właściwy
    tic;
    for r = 1:repeats
        y_38 = RK38(b, a, x0, xN, y0, N);
    end
    t_38 = toc / repeats;
    
    % Błąd (3/8)
    if isvector(y_38) && ~isrow(y_38); y_38 = y_38'; end
    if size(y_38,1) > 1; val_38 = y_38(1,:); else; val_38 = y_38; end
    err_38 = max(abs(val_38 - y_ex));
    
    times_avg(3, i) = t_38;
    errors_max(3, i) = err_38;
end

%% RYSOWANIE WYKRESÓW
figure('Name', 'Numtest 4 - Porównanie Metod', 'NumberTitle', 'off', 'Color', 'w');

% Wykres 1: Błąd vs N
subplot(1, 3, 1);
% Używamy gotowych stringów linespecs(1), linespecs(2) itd.
loglog(N_vals, errors_max(1,:), linespecs(1), 'LineWidth', 1.5); 
hold on;
loglog(N_vals, errors_max(2,:), linespecs(2), 'LineWidth', 1.5);
loglog(N_vals, errors_max(3,:), linespecs(3), 'LineWidth', 1.5);
title('1. Błąd vs N');
xlabel('Liczba kroków N'); ylabel('Max Błąd');
grid on; 
legend(names, 'Location', 'best');

% Wykres 2: Czas vs N
subplot(1, 3, 2);
loglog(N_vals, times_avg(1,:), linespecs(1), 'LineWidth', 1.5); 
hold on;
loglog(N_vals, times_avg(2,:), linespecs(2), 'LineWidth', 1.5);
loglog(N_vals, times_avg(3,:), linespecs(3), 'LineWidth', 1.5);
title('2. Czas vs N');
xlabel('Liczba kroków N'); ylabel('Czas obliczeń [s]');
grid on;
%legend(names, 'Location', 'best');

% Wykres 3: Błąd vs Czas
subplot(1, 3, 3);
loglog(times_avg(1,:), errors_max(1,:), linespecs(1), 'LineWidth', 1.5); 
hold on;
loglog(times_avg(2,:), errors_max(2,:), linespecs(2), 'LineWidth', 1.5);
loglog(times_avg(3,:), errors_max(3,:), linespecs(3), 'LineWidth', 1.5);
title('3. Błąd vs Czas');
xlabel('Czas obliczeń [s]'); ylabel('Max Błąd');
grid on;
%legend(names, 'Location', 'best');

end % function