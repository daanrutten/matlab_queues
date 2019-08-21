% Parameters
N = 1000;
lambda = 0.3;
d = 2;

% Compare ERG with clique
type = "ERGlog";
load(type + "_N" + N + "_lambda" + lambda + "_d" + d + ".mat");
Plot(Xt, "-");

hold on;

type = "clique";
load(type + "_N" + N + "_lambda" + lambda + "_d" + d + ".mat");
Plot(Xt, "--");
