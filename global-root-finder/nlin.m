function r = nlin(f)
% Zadanie ZR
% Krzysztof Wójtowicz, 339108
% Total minipoints score: 815.6
%
% Funkcja przyjmuje wskaźnik na funkcję i zwraca wektor zawierający
% jej znalezione miejsca zerowe (możliwie jak największą ilość)
% WEJŚCIE
%   f - wskaźnik na funkcję
% WYJŚCIE
%   r - wektor znalezionych miejsc zerowych

% Granica przedziału funkcji
a = realmax;
% Liczba punktów podziału na przedziały
N = 6.3e5;
% Generujemy rozkład punktów
points = generateRanges(a,N);

% Wzięcie tylko punktów dla rzeczywistych wartości funkcji f
fp = f(points);
realMask = imag(fp) == 0;
fp = fp(realMask);
points = points(realMask);

% Sprawdzenie gdzie f zmienia znak
temp = fp(1:end-1).*fp(2:end);
mask = temp < 0;

% Wzięcie początków i końców przedziałow oraz ich wartości f
startR = points(1:end-1);
endR = points(2:end);
fs = fp(1:end-1);
fe = fp(2:end);

% Bisekcja na przedziałach, gdzie f zmienia znak
r = bisection(f,startR(mask),endR(mask),fs(mask),fe(mask));

end % function