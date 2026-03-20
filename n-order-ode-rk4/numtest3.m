function numtest3()
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Numtest 3: Test stabilności dla równania y' = -100y.
% Prezentuje ograniczenia metody RK4. Jeśli krok h jest zbyt duży
% w stosunku do dynamiki równania, metoda traci stabilność
fprintf("%70s\n%30sNumtest 3\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Test wizualny dla równania: y' = -100y na przedziale [0, 0.5].\n" + ...
    "Porównanie dla N = 16, N = 18 oraz N = 23.\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

%% DEFINICJA PROBLEMU
% Równanie: y' + 100y = 0 
% Warunki: y(0)=1
% Rozwiązanie dokładne: y(x) = e^(-100x) (szybki zanik do zera)

b = @(x) 0;
a = { @(x) 100, @(x) 1 }; % 100*y + 1*y' = 0
x0 = 0;
xN = 0.5;
y0 = 1;

N_values = [16, 17, 18, 23];
styles = ["-", "-", "-", "-"];
colors = ["r", "m", "b", "k"];
lines_width = [1.0, 1.0, 1.0, 1.0];

%% RYSOWANIE WYKRESÓW
fprintf("Generowanie wykresu zbiorczego...\n");

figure('Name', 'Numtest 3 - Test Stabilności', 'NumberTitle', 'off', 'Color', 'w');
hold on; 
grid on;

% 1. Rysowanie rozwiązania dokładnego
x_exact = linspace(x0, xN, 2000);
y_exact = exp(-100 .* x_exact);
plot(x_exact, y_exact, 'g-', 'LineWidth', 2.0, 'DisplayName', 'Dokładne y=e^{-100x}');

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
    plot_name = sprintf('RK4 N=%d (h=%.5f)', N, h);
    plot(x_grid, val_plot, 'Color', colors(i), 'LineStyle', styles(i), ...
         'LineWidth', lines_width(i), 'DisplayName', plot_name);
end

% Kosmetyka wykresu
title('Analiza stabilności dla y'' + 100y = 0');
xlabel('x'); 
ylabel('y');
legend('show', 'Location', 'best');

% Ograniczamy osie, bo niestabilne rozwiązania mogą uciekać do +/- nieskończoności
axis([x0 xN -0.3 6]); 
hold off;

end % function