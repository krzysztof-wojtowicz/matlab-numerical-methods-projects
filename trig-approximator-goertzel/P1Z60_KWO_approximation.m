function [c,s] = P1Z60_KWO_approximation(f,N,n)
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Aproksymacja trygonometryczna ciągła funkcji f na przedziale [0,2pi]
% WEJŚCIE
%   f - uchwyt do funkcji f
%   N - rozmiar bazy trygonometrycznej 2N + 1
%   n - liczba podprzedziałów dla złożonej kwadratury trapezów
% WYJŚCIE
%   c - współczynniki bazy trygonometrycznej dla cos, c(1) = a0
%   s - współczynniki bazy trygonometrczynej dla sin, s(1) nieużywane

% Inicjalizacja wektorów
c = zeros(1,N+1);
s = zeros(1,N+1);

% Policzenie współczynników
c(1) = a0(f,n);
c(2:N+1) = wj(f,N,n,@cos);
s(2:N+1) = wj(f,N,n,@sin);

end % function