function numtest4(Nmax, jump)
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Sprawdza, jak zwiększenie wielkości bazy funkcji wpływa na błąd
% średniokwadratowy dla funkcji y = x^2 (funkcja nie okresowa)
% Drukuje wartości błędów średniokwadratowych i obrazuje funkcje
% aproksymujące na wykresie. Można podać jako argument maksymalną
% wielkość bazy oraz skok -> numtest4(Nmax,jump)
% (zaczyna się od 1 -> 1:jump:Nmax)

if nargin < 1
    Nmax = 12;
end

if nargin < 2
    jump = 3;
end

fprintf("%70s\n%30sNumtest 4\n%70s\n",repmat('-',1,70),repmat(' ',1,30), ...
    repmat('-',1,70));
fprintf("Sprawdza, jak zwiększenie wielkości bazy funkcji wpływa na" + ...
    " błąd\nśredniokwadratowy dla funkcji y = x^2 (funkcja nie okre" + ...
    "sowa)\nDrukuje wartości błędów średniokwadratowych i obrazuje" + ...
    " funkcje\naproksymujące na wykresie. Można podać jako argument" + ...
    " maksymalną\nwielkość bazy oraz skok -> numtest4(Nmax,jump)" + ...
    "\n(zaczyna się od 1 -> 1:jump:Nmax)\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

f1 = @(x) x.^2; % f(x) = x^2

fprintf("%70s\n", repmat('-',1,70));
fprintf("%s%s\n",repmat(' ',1,30),'f(x) = x^2');
fprintf("%70s\n\n", repmat('-',1,70));

n = 1e4;
N = 1:jump:Nmax;
N_count = length(N);
x = linspace(0,2*pi,1e4);
y_exact = f1(x);
mse = zeros(1,N_count);
y_approx = zeros(N_count,1e4);
errors = zeros(N_count,1e4);
i = 1;

for Nf = N
    % Obliczenie współczynników
    [c,s] = P1Z60_KWO_approximation(f1,Nf,n);
    
    y_approx(i,:) = goertzel(c,s,x);
    errors(i,:) = abs(y_approx(i,:) - y_exact);
    mse(i) = sqrt(mean(errors(i,:)));
    i = i + 1;
end


T = table(N(:), mse(:), ...
            'VariableNames', ...
            {'N', 'błąd średniokwadratowy'});
disp(T);

% Wykres

figure;
% Wykresy funkcji aproksymujących
for j = 1:i-1
    plot(x, y_approx(j,:),'LineWidth', 2, 'DisplayName', sprintf('N = %d', N(j)));
    hold on;
end
legend show;
legend('Location','northwest');
plot(x, y_exact, '-g','LineWidth', 2, 'DisplayName', 'y = x^2');
xlabel('x');
ylabel('f(x)');
title('Wykresy funkcji aproksymujących');
grid on;

end % function