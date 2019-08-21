% Parameters
N = 10000;
type = "ERGlog";

if type == "clique"
    G = ones(N, N);
elseif type == "ERGlog"
    G = ERG(N, log(N) / N);
else
    error("Unknown graph type");
end

H = Adjacency(G);
X = zeros(N, 1);

lambda = 0.3;
d = 2;
T = 20;

% Simulate
Xt = Simulate(H, X, lambda, d, T);

% Plot
Plot(Xt, "-");

% Save
save(type + "_N" + N + "_lambda" + lambda + "_d" + d + ".mat", "N", "G", "lambda", "d", "T", "Xt");