function [mu, delta] = expectation(n_steps, n_simulations)
sigma = std(n_steps);         % smerodatna odchylka poctu krokov
alpha = 0.05;                 % hladina vyznamnostis

%% Ocakavana stredna hodnota a jej chyba
mu    = 1/n_simulations*sum(n_steps);         % aritmeticky priemer poctu krokov
delta = sigma/sqrt(n_simulations*alpha);      % chyba strednej hodnoty
end