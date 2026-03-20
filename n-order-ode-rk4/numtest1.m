function numtest1()
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Numtest 1: Test dla funkcji szybkozmiennej y = sin(100x).
% Prezentuje wpływ gęstości siatki (N) na jakość odwzorowania
% funkcji oscylacyjnej przez metodę RK4.
% Porównuje na jednym wykresie rozwiązanie dokładne oraz numeryczne
% dla różnych wartości N.

fprintf("%70s\n%30sNumtest 1\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Test wizualny dla funkcji: y = sin(100x) na przedziale [0, 1].\n" + ...
    "Porównanie rozwiązań dla N = 50, N = 100 oraz N = 150.\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

%% DEFINICJA PROBLEMU
% Równanie: y'' + 10000y = 0 
% Warunki: y(0)=0, y'(0)=100

b = @(x) 0;
a = { @(x) 10000, @(x) 0, @(x) 1 };
x0 = 0;
xN = 1;
y0 = [0; 100];

% Wartości N do pętli
N_values = [50, 100, 150];
styles = ["-", "-", "-"];
colors = ["r", "m", "b"];
lines_width = [1.0, 1.0, 1.0];

%% RYSOWANIE WYKRESÓW
fprintf("Generowanie wykresu zbiorczego...\n");

figure('Name', 'Numtest 1 - Wpływ N na dokładność', 'NumberTitle', 'off', 'Color', 'w');
hold on; 
grid on;

% 1. Rysowanie rozwiązania dokładnego
x_exact = linspace(x0, xN, 2000);
y_exact = sin(100 .* x_exact);
plot(x_exact, y_exact, 'g-', 'LineWidth', 2.0, 'DisplayName', 'Dokładne y=sin(100x)');

% 2. Pętla po wartościach N
for i = 1:length(N_values)
    N = N_values(i);
    fprintf("   Obliczanie dla N = %d...\n", N);
    
    % Rozwiązanie numeryczne
    y_num = P2Z45_KWO_classicRungeKutta(b, a, x0, xN, y0, N);
    
    % Przygotowanie wektora X dla danego N
    h = (xN - x0) / N;
    x_grid = x0:h:xN; 
    
    val_plot = y_num';
    
    % Rysowanie
    plot_name = sprintf('RK4 N=%d', N);
    plot(x_grid, val_plot, 'Color', colors(i), 'LineStyle', styles(i), ...
         'LineWidth', lines_width(i), 'DisplayName', plot_name);
end

% Kosmetyka wykresu
title('Analiza zbieżności dla y'''' + 10000y = 0');
xlabel('x'); 
ylabel('y');
legend('show', 'Location', 'best');
axis([x0 xN -1.5 1.5]);
hold off;

end % function