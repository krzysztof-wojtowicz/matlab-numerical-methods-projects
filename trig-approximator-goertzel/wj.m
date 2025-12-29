function w = wj(f,N,n,f_tri)
% Projekt 1, zadanie 60
% Krzysztof Wójtowicz, 339108
%
% Oblicza N współczynników dla aproksymacji trygonometrycznej ciągłej
% dla podanej funkcji sin lub cos
% WEJŚCIE
%   f - uchwyt do funkcji f
%   N - rozmiar bazy trygonometrycznej, liczymy N współczynników
%   n - liczba podprzedziałów dla złożonej kwadratury trapezów
%   f_tri - uchwyt do funkcji trygonometrycznej (sin lub cos)
% WYJŚCIE
%   w - obliczone N współczynników dla f_tri

w = zeros(1,N);

% Liczymy po kolei współczynniki dla danej funkcji sin lub cos
for j = 1:N
    fj = @(x) f(x).*f_tri(j*x);
    % Całka ze wzoru na współczynniki
    w(j) = integral_trap(fj,n,0,2*pi)/pi;
end

end % function