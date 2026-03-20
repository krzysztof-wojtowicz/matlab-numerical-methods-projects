function y = RKgill(b,a,x0,xN,y0,N)
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Metoda Rungego - Kutty (Gilla, 4-go rzędu) dla liniowych równań 
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

% Pierwiastek z dwóch
s2 = sqrt(2);

% Iteracyjny Runge-Kutta, metoda Gilla
for i = 1:N
    % Liczymy 4 kroki
    K0 = dF(Y,b,a,k);
    K1 = dF(Y + 0.5*h*K0,b,a,k);
    K2 = dF(Y + 0.5*h*((s2 - 1)*K0 + (2 - s2)*K1),b,a,k);
    K3 = dF(Y + h*((-1)*s2/2*K1 + (1 + s2/2)*K2),b,a,k);

    % Liczymy nowy wektor Y
    Y = Y + (h/6) * (K0 + (2 - s2)*K1 + (2 + s2)*K2 + K3);
    
    % Zapisujemy kolejne y do wektora wynikowego
    y(i+1) = Y(2);
end

end % function