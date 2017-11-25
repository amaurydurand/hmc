%% Numerical parameters

n = 1000; % nombre de donn�es � garder
n0 = 100; % oublier les donn�es jusqu'� n0-1
% n = 500;
% n0 = 0;
N = n+n0-1; % nombre de donn�es � simuler

d = 1; % dimension

X0 = 8*ones(d,1); % point initial
%X0 = zeros(d,1);

Delta = normrnd(0,1,d,N); % pas pour RWM

dt = 0.1; % pas pour leapfrog
L = 100; % nombre de pas pour leapfrog



%% Aimed density

% gaussian density
switch (d)
	case 1
		mu = 0;
		sig = 0.35;
	case 2
		mu = [0, 0];
		sig = [0.4, 0.3 ; 0.3, 0.4];
		%sig = [1, 0 ; 0, 1];
endswitch
invsig = inv(sig);
h = @(x) exp(-sum((x-mu).*(invsig*(x-mu)), axis=1)*0.5);
h1 = @(x) exp(-sum((x-mu).*(invsig*(x-mu)), axis=1)*0.5) / sqrt(2*pi*det(sig));
U = @(x) sum((x-mu).*(invsig*(x-mu))*0.5, axis=1);
dU = @(x) invsig * (x-mu);


X_th = mvnrnd(mu,sig, 500)'; % vraies valeurs simulees

% autres cas