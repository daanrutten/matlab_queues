function Plot(Xt, ls)

N = size(Xt, 1);
T = size(Xt, 2);

% Aggregate
Q = zeros(4, T);

for i = 1:4
    Q(i, :) = sum(Xt >= i);
end

% Plot
h = plot(0:(T - 1), Q ./ N);
set(h, {"Color"}, {'b'; 'r'; 'g'; 'y'});
set(h, {"LineStyle"}, {ls; ls; ls; ls});

xlabel("Time");
legend("q1", "q2", "q3", "q4");