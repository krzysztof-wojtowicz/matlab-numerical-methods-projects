function test1()
% Projekt 2, zadanie 45
% Krzysztof Wójtowicz, 339108
%
% Sprawdza poprawność działania funkcji dF (liczącej pochodne).
% Testuje równania rzędu 1, 2 oraz 3, porównując wynik funkcji
% z analitycznie wyznaczonymi wartościami pochodnych.

fprintf("%70s\n%32sTest 1\n%70s\n",repmat('-',1,70),repmat(' ',1,32), ...
    repmat('-',1,70));
fprintf("Sprawdza poprawność wyznaczania wektora pochodnych dY\n" + ...
    "dla zadanych wektorów Y w trzech różnych przypadkach\n" + ...
    "(różne rzędy równań).\n");
fprintf("%70s\n", repmat('-',1,70));

format short e;

%% PRZYPADEK 1: Równanie 1. rzędu y' = 2x
% Postać ogólna: 1*y' + 0*y = 2x
% Y = [x; y]
% Oczekiwane dY = [1; 2x]

a1 = { @(x)0, @(x)1 }; % a{1} przy y, a{2} przy y'
b1 = @(x) 2*x;
k1 = 1;
Y1 = [2; 5]; % x = 2, y = 5
dY1_expected = [1; 4]; % x' = 1, y' = 2*2 = 4

%% PRZYPADEK 2: Równanie 2. rzędu y'' = -y
% Postać ogólna: 1*y'' + 0*y' + 1*y = 0
% Y = [x; y; y']
% Oczekiwane dY = [1; y'; -y]

a2 = { @(x)1, @(x)0, @(x)1 }; % przy y, y', y''
b2 = @(x) 0;
k2 = 2;
Y2 = [pi/2; 1; 0]; % x=pi/2, y=1, y'=0
dY2_expected = [1; 0; -1]; % x'=1, y'' = y' = 0, y'' = -y = -1

%% PRZYPADEK 3: Równanie 3. rzędu y''' = 6x
% Postać ogólna: 1*y''' + 0*y'' + 0*y' + 0*y = 6x
% Y = [x; y; y'; y'']
% Oczekiwane dY = [1; y'; y''; 6x]

a3 = { @(x)0, @(x)0, @(x)0, @(x)1 };
b3 = @(x) 6*x;
k3 = 3;
Y3 = [0.5; 10; 20; 30]; % x=0.5
dY3_expected = [1; 20; 30; 3]; % ostatni element: 6*0.5 = 3

%% Pętla testująca
cases_a = {a1, a2, a3};
cases_b = {b1, b2, b3};
cases_k = [k1, k2, k3];
cases_Y = {Y1, Y2, Y3};
cases_exp = {dY1_expected, dY2_expected, dY3_expected};
titles = ["y' = 2x (Rząd 1)", "y'' = -y (Rząd 2)", "y''' = 6x (Rząd 3)"];

for i = 1:3
    fprintf("\n%70s\n", repmat('-',1,70));
    fprintf(" PRZYPADEK %d: %s\n", i, titles(i));
    fprintf("%70s\n\n", repmat('-',1,70));
    
    Y_in = cases_Y{i};
    dY_exp = cases_exp{i};
    
    % Wywołanie funkcji
    dY_calc = dF(Y_in, cases_b{i}, cases_a{i}, cases_k(i));
    
    % Błąd
    err = abs(dY_calc - dY_exp);
    
    % Opisy wierszy tabeli
    row_names = cell(length(Y_in), 1);
    row_names{1} = 'x';
    row_names{2} = 'y';
    for j = 3:length(Y_in)
        row_names{j} = sprintf('y%s', repmat('''',1,j-2));
    end
    
    % Tabela wyników
    T = table(Y_in, dY_calc, dY_exp, err, ...
        'VariableNames', {'Y', 'Obliczone', 'Oczekiwane', 'Błąd'}, ...
        'RowNames', row_names);
    
    disp(T);
    disp('Naciśnij Enter...');
    pause;
end

fprintf("\n%70s\n", repmat('-',1,70));
fprintf(" KONIEC TESTU\n");
fprintf("%70s\n", repmat('-',1,70));

end % function