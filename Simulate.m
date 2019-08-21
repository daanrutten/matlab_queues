function Xt = Simulate(H, X, lambda, d, T)

N = size(H, 1);

% Setup arrivals and departures
nextArrival = exprnd(1 / (lambda * N));
departures = RedBlackTree();

for i = 1:N
    if X(i) > 0
        departures.Insert(exprnd(1), i);
    end
end

% Setup tracking process
Xt = zeros(N, T + 1);

Xt(:, 1) = X;
tstep = 1;

% Iterate
t = 0;
while t < T
    nextDeparture = departures.Minimum();
    t = min(nextDeparture.key, nextArrival);
    
    if t == nextArrival
        % Select one of the dispatchers
        j = ceil(unifrnd(0, 1) * N);
        
        if size(H{j}, 2) > 0
            % Sample d and select the minimum
            sample = randsample(H{j}, d, true);
            [~, i] = min(X(sample));
            i = sample(i);

            % Add a job
            if X(i) == 0
                departures.Insert(t + exprnd(1), i);
            end
            X(i) = X(i) + 1;
        end
        
        % Schedule the next arrival
        nextArrival = t + exprnd(1 / (lambda * N));
    else
        i = nextDeparture.value;
        departures.Delete(nextDeparture);
        
        % Remove a job
        X(i) = X(i) - 1;
        if X(i) > 0
            departures.Insert(t + exprnd(1), i);
        end
    end
    
    % Update the tracking process
    while t >= tstep && tstep <= T
        Xt(:, tstep + 1) = X;
        tstep = tstep + 1;
    end
end