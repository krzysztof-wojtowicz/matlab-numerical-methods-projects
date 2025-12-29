function y = goertzel(c,s,x)
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Funkcja liczy wartość dla funkcji wyznaczonej przez sumę Fouriera
% dla współczynników c i s, używa do tego algorytmu Goertzela.
% WEJŚCIE
%   c - współczynniki bazy trygonometrycznej dla cos, c(1) = a0
%   s - współczynniki bazy trygonometrczynej dla sin, s(1) = 0
%   x - węzły do obliczenia wartości
% WYJŚCIE
%   y - wartości funkcji, wektor poziomy

% Policzenie wartości, później używanych
cos_val = cos(x);
sin_val = sin(x);
p = 2 .* cos_val;
q = -1; 

% Wielkość bazy trygonometrycznej
N = length(c) - 1;

% Wartości startowe dla b
% Odpowiednio dla cos i sin
bc_next = ones(size(x)).*c(end);
bc_next2 = zeros(size(x));

bs_next = ones(size(x)).*s(end);
bs_next2 = zeros(size(x));

for k = N:-1:2
    % Rekurencja dla cosinusów
    bc_current = c(k) + p .* bc_next + q .* bc_next2;
    
    % Przesunięcie zmiennych
    bc_next2 = bc_next;
    bc_next = bc_current;
    
    % Rekurencja dla sinusów
    bs_current = s(k) + p .* bs_next + q .* bs_next2;
    
    % Przesunięcie zmiennych
    bs_next2 = bs_next;
    bs_next = bs_current;
end

% Obliczenie wyniku końcowego (Re dla cos, Im dla sin)
% c(1) to a_0
u = c(1) + cos_val .* bc_next + q .* bc_next2;
v = sin_val .* bs_next;

% Wynikowy wektor y
y = u + v;

end % function