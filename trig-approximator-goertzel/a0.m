function a = a0(f,n)
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Oblicza współczynnik a0 dla aproksymacji trygonometrycznej ciągłej
% WEJŚCIE
%   f - uchwyt do funkcji f
%   n - liczba podprzedziałów dla złożonej kwadratury trapezów
% WYJŚCIE
%   a - obliczony współczynnik a0

a = integral_trap(f,n,0,2*pi)/(2*pi);

end % function