function points = generateRanges(a,N)
% Zadanie ZR
% Krzysztof Wójtowicz, 339108
%
% Funkcja generuje N punktów z przedziału [-a,a]
% rozrzucając je w sposób logarytmiczny przy pomocy logspace()
% symetrycznie wokół 0 na osi liczbowej
% WEJŚCIE
%   a - górna granica przedziału punktów (-a oznacza dolną)
%   N - ilość punktów do zwrócenia
% WYJŚCIE
%   points - wektor rozrzuconych punktów o długości N

% Najlepsze wyniki program osiągał dla większego zagęszczenia
% punktów wokół zera:
percent = 99.9/100; % procent punktów pomiędzy startpoint i breakpoint
startpoint = -3.4; % 10^startpoint to początek
breakpoint = 3.3; % 10^breakpoint to granica zagęszczenia

% Żeby na koniec było N punktów w sumie to dzielimy N/2
% bo potem do wynikowego wektora wstawiamy odbicia lustrzane
% dla ujemnych wartości
n = N/2;

% Generujemy punkty od 10^startpoint do 10^breakpoint
x1 = logspace(startpoint,breakpoint,percent*n);
% Generujemy punkty od 10^(breakpoint + eps) do a
x2 = logspace(breakpoint+eps,log10(a),(1 - percent)*n);
% Dodajemy symetrczyne wartości ujemne i zwracamy N punktów
points = [-fliplr(x2),-fliplr(x1),x1,x2];

end % function