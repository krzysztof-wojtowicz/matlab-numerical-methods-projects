function c = checkPrecision(startR, endR, v)
% Zadanie ZR
% Krzysztof Wójtowicz, 339108
%
% Funkcja sprawdza, czy dany przedział ma oczekiwaną szerokość przy
% której następuje koniec szukania pierwiastka.
% WEJŚCIE
%   startR, endR - wektory początków i końców przedziałów
%   v - wektor punktów środkowych przedziałów
% WYJŚCIE
%   c - wektor logiczny z wartościami 1 dla spełniających przedziałów

% Generujemy maskę, dla wartości abs(v) < 1
c = false(size(v));
mask = abs(v) < 1;

% Zwracamy wektor logiczny czy warunek spełniony dla danego v
c(mask)  = abs(endR(mask) - startR(mask)) < 1000*eps;
c(~mask) = abs(endR(~mask) - startR(~mask)) < 1000*eps.*abs(v(~mask));

end % function