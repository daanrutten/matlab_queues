function H = Adjacency(G)

N = size(G, 1);
H = cell(N, 1);

for i = 1:N
    H{i} = find(G(i, :));
end