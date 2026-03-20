function dY = dF(Y,b,a,k)
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Przekształca wektor Y do Y' (Y' = dF(Y))
% WEJŚCIE
%   Y - wektor Y do przekształcenia
%   b - uchwyt na funkcję b(x) z równania
%   a - tablica komórkowa uchwytów do funkcji a{i}(x) z równania
%   k - rząd równania
% WYJŚCIE
%   dY - otrzymany wektor Y'

% Tworzymy wektor pochodnych:
%   1. dla x0 pochodna to zawsze 1,
%   2. dla y pochodne to kolejne elementy wektora Y,
%   3. ostatni element liczymy z równania niżej.
dY = [1; Y(3:end); 0];

% Liczymy ostatni element dY
%   Bierzemy x oraz tworzymy nSum
x = Y(1);
nSum = 0;

% Policzenie sumy z licznika
%   suma = a{1}(x)*y + a{2}(x)*y' + ... + a{k}(x)*y^(k-1)
for i = 1:k
    nSum = nSum + a{i}(x) * Y(i+1);
end

% Policzenie całego ułamka (najwyższej pochodnej)
%   y^(k) = ( b(x) - Suma ) / a{k+1}(x)
dY(end) = (b(x) - nSum) ./ a{end}(x);

end % function