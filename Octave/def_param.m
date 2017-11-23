%% Densit� cible

% cas gaussien
mu = [0, 0];
sig = [0.4, 0.3 ; 0.3, 0.4];
%sig = [1, 0 ; 0, 1];
invsig = inv(sig);
h = @(x) exp(-x.'*x./2);
h = @(x) exp(-sum(x.*(invsig*x), axis=1)*0.5);
h1 = @(x) exp(-x.^2/2) / sqrt(2*pi); % h normalis� 1d
h2 = @(x) exp(-sum(x.*(invsig*x), axis=1)*0.5) / sqrt(2*pi*det(sig)^2); % h normalis� 2d
U = @(x) sum(x.*(invsig*x)*0.5, axis=1);
dU = @(x) invsig * x;

% autres cas ?



%% Autres param�tres

n = 500; % nombre de donn�es � garder
n0 = 0; % oublier les donn�es jusqu'� n0-1
N = n+n0-1; % nombre de donn�es � simuler

d = 2; % dimension

X0 = 8*ones(d,1); % point initial
%X0 = zeros(d,1);

Delta = normrnd(0,1,d,N); % pas pour RWM

dt = 0.1; % pas pour leapfrog
L = 100; % nombre de pas pour leapfrog


X_th = mvnrnd(mu,sig, 500)'; % vraies valeurs simulees
