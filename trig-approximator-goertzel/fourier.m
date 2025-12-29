function y = fourier(c,s,x)
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Funkcja liczy wartość dla funkcji wyznaczonej przez sumę Fouriera
% dla współczynników c i s, liczy zwykłą sumę.
% WEJŚCIE
%   c - współczynniki bazy trygonometrycznej dla cos, c(1) = a0
%   s - współczynniki bazy trygonometrczynej dla sin, s(1) = 0
%   x - węzły do obliczenia wartości
% WYJŚCIE
%   y - wartości funkcji

N = length(c) - 1;
y = c(1) * ones(size(x));

% Liczymy wartość przez zwykłą sumę
for j = 1:N
    y = y + c(j + 1) * cos(j * x) + s(j + 1) * sin(j * x);
end

end % function