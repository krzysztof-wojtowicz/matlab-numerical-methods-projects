function s = integral_trap(f,n,a,b)
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Obliczanie całki na przedziale [a,b] dla funkcji podcałkowej f
% WEJŚCIE
%   f - uchwyt do funkcji podcałkowej f
%   n - liczba podprzedziałów dla złożonej kwadratury trapezów
%   a - początek przedziału całkowania
%   b - koniec przedziału całkowania
% WYJŚCIE
%   s - obliczona wartość całki na [a,b]

% szerokość podprzedziałów
h = (b - a)/n;

% liczymy elementy sumy ze wzoru
k = 1:n-1;
y = f(a + k.*h);

% wzór na S(f) złożoną metodą trapezów
s = h*(f(a) + f(b) + 2*sum(y))/2;

end % function