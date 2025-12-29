function r = bisection(f,startR,endR,fs,fe)
% Zadanie ZR
% Krzysztof Wójtowicz, 339108
%
% Funkcja wykonuje bisekcję dla funkcji f i przedziałów wejściowych
% WEJŚCIE
%   f - wskaźnik na funkcję
%   startR, endR - wektory początków i końców przedziałów
%   fs, fe - wektory wartości funkcji dla tych początków i końców
% WYJŚCIE
%   r - wektor znalezionych miejsc zerowych

% Prealokacja wektora r
l = length(startR);
r = zeros(1,l);
rSize = 0;

while ~isempty(startR)
    % Liczymy wartości w środkach przedziałów
    v = (startR + endR)./2;
    fv = f(v);
    
    % Sprawdzamy szerokość przedziałów
    c = checkPrecision(startR,endR,v);
    
    % Bierzemy wartości ze zbyt małych przedziałów
    newV = v(c);
    newQ = length(newV);
    r(rSize + 1:rSize + newQ) = newV;
    rSize = rSize + newQ;
    
    % Usunięcie zbyt małych przedziałów
    startR = startR(~c);
    endR = endR(~c);
    fs = fs(~c);
    fe = fe(~c);
    fv = fv(~c);
    v = v(~c);
    
    % Jeśli nie ma już przedziałów to koniec
    if isempty(startR)
        break;
    end

    % Sprawdzanie która połowa ma miejsce zerowe
    mask1 = fs.*fv < 0;
    mask2 = fv.*fe < 0 & ~mask1;
    
    % Bierzemy połowy które mają zmianę znaku
    startR = [startR(mask1),v(mask2)];
    endR = [v(mask1),endR(mask2)];
    fs = [fs(mask1),fv(mask2)];
    fe = [fv(mask1),fe(mask2)];
end

% Zwracamy r odpowiedniej długości
r = r(1:rSize);

end % function