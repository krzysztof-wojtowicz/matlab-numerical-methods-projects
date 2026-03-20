function [k,h,y,Y] = setup(a,x0,xN,y0,N)
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Początkowe odczytanie potrzebnych wartości oraz inicjalizacja 
% zmiennych do funkcji głównej
% WEJŚCIE (analogicznie do funkcji głównej)
%   a - tablica komórkowa uchwytów do funkcji a{i}
%   x0, xN - końce przedziału całkowania równania różniczkowego
%   y0 - wartość początkowa lub wektor wartości początkowych
%   N - liczba kroków (podprzedziałów [x0,xN])
% WYJŚCIE
%   k - rząd podanego równania różniczkowego
%   h - wartość kroku
%   y - zainicjalizowany wektor wynikowy
%   Y - wektor wartości początkowych używany do przekształcenia równania

% Rząd równania k
k = length(a) - 1;

% Wartość kroku h
h = (xN - x0) / N;

% Inicjalizacja wektora wynikowego y
y = zeros(1,N+1);

% Stworzenie wektora Y
Y = [x0; y0(:)];

end % function