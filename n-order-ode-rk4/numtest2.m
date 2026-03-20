function numtest2()
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Numtest 2: Test dla funkcji tłumionej y = e^(-x)*sin(10x).
% Prezentuje wpływ gęstości siatki (N) na jakość odwzorowania
% funkcji oscylacyjnej tłumionej przez metodę RK4.
% Porównuje na jednym wykresie rozwiązanie dokładne oraz numeryczne
% dla różnych wartości N.

fprintf("%70s\n%30sNumtest 2\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Test wizualny dla funkcji: y = e^(-x)*sin(10x) na przedziale [0, 2pi].\n" + ...
    "Porównanie rozwiązań dla N = 40, N = 50 oraz N = 70.\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

%% DEFINICJA PROBLEMU
% Równanie: y'' + 2y' + 101y = 0 
% Warunki: y(0)=0, y'(0)=10
b = @(x) 0;
a = { @(x) 101, @(x) 2, @(x) 1 };
x0 = 0;
xN = 2*pi;
y0 = [0; 10];

% Wartości N do pętli
N_values = [40, 50, 70];
styles = ["-", "-", "-"];
colors = ["r", "m", "b"];
lines_width = [1.0, 1.0, 1.0];

%% RYSOWANIE WYKRESÓW
fprintf("Generowanie wykresu zbiorczego...\n");

figure('Name', 'Numtest 2 - Wpływ N na dokładność', 'NumberTitle', 'off', 'Color', 'w');
hold on; 
grid on;

% 1. Rysowanie rozwiązania dokładnego
x_exact = linspace(x0, xN, 2000);
y_exact = exp(-x_exact) .* sin(10 .* x_exact);
plot(x_exact, y_exact, 'g-', 'LineWidth', 2.0, 'DisplayName', 'Dokładne y=e^{-x}sin(10x)');

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
title('Analiza zbieżności dla y'''' + 2y'' + 101y = 0');
xlabel('x'); 
ylabel('y');
legend('show', 'Location', 'best');
axis([x0 xN -1.0 1.0]);
hold off;

end % function