function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta.
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %

x = X(:,2);
h = theta(1) + (theta(2)*x);

mu    = mean(x);
sigma = std(x);

for i=1:columns(x)
  minusmu=x(:,i)-mu(i);
  X_norm(:,i) = minusmu/sigma(i);
endfor
x = X_norm;

theta0 = theta(1)-alpha*(1/m)*sum(h-y);
theta1 = theta(2)-alpha*(1/m)*sum((h-y).*x);

theta = [theta0; theta1];
    % ============================================================

    % Save the cost J in every iteration
    J_history(iter) = computeCost(X, y, theta);

end

end
