%% Densit� cible

% cas gaussien
h = @(x) exp(-x.'*x/2);
h1 = @(x) exp(-x.^2/2) / sqrt(2*pi); % h normalis� 1d
U = @(x) x.'*x/2;
dU = @(x) x;

% autres cas ?



%% Autres param�tres

n = 500; % nombre de donn�es � garder
n0 = 0; % oublier les donn�es jusqu'� n0-1
N = n+n0-1; % nombre de donn�es � simuler

d = 1; % dimension

X0 = 1*ones(d,1); % point initial
%X0 = zeros(d,1);

Delta = normrnd(0,1,d,N); % pas pour RWM

dt = 0.1; % pas pour leapfrog
L = 100; % nombre de pas pour leapfrog