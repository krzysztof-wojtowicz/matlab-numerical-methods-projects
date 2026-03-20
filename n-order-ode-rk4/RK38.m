function y = RK38(b,a,x0,xN,y0,N)
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Metoda Rungego - Kutty (3/8, 4-go rzędu) dla liniowych równań 
% różniczkowych dowolnego rzędu, równanie postaci:
% a{k+1}(x)y^(k) + ... + a{2}(x)y' + a{1}(x)y = b(x)
% WEJŚCIE
%   b - wskaźnik na funkcję b(x)
%   a - tablica komórkowa uchwytów do funkcji a{i}
%   x0, xN - końce przedziału całkowania równania różniczkowego
%   y0 - wartość początkowa lub wektor wartości początkowych
%   N - liczba kroków (podprzedziałów [x0,xN])
% WYJŚCIE
%   y - wektor obliczonych przybliżeń wartości rozwiązania różniczkowego

% Rząd równania k, skok h, wektor wynikowy y i wektor Y do metody 
[k,h,y,Y] = setup(a,x0,xN,y0,N);

% Pierwsza wartość (y0)
y(1) = Y(2);

% Iteracyjny Runge-Kutta, metoda 3/8
for i = 1:N
    % Liczymy 4 kroki
    K0 = dF(Y,b,a,k);
    K1 = dF(Y + (1/3)*h*K0,b,a,k);
    K2 = dF(Y + h*((-1)/3*K0 + K1),b,a,k);
    K3 = dF(Y + h*(K0 - K1 + K2),b,a,k);

    % Liczymy nowy wektor Y
    Y = Y + (h/8) * (K0 + 3*K1 + 3*K2 + K3);
    
    % Zapisujemy kolejne y do wektora wynikowego
    y(i+1) = Y(2);
end

end % function