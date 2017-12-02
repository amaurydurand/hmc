%% Plot parameters

animation = 0;

%% Numerical parameters

%n = 1000; % number of kept (plotted) data
%n0 = 100; % number of first forgotten data
n = 10000;
n0 = 0;
N = n+n0-1; % number of simulated data

d = 2; % dimension

X0 = 100*ones(d,1); % starting point
%X0 = zeros(d,1);

Delta = normrnd(0,1,d,N); % RWM steps

dt = 0.1; % leapfrog step
%L = 25*ones(1,N); % number of leapfrog steps
L = ceil(25*rand(1,N));



%% Aimed density
	% "g" : gaussian
	% "gm" : gaussian mixture
	% "lasso" : bayesian lasso
aimed_density = "g";
switch (aimed_density)
	case "g" % gaussian density
		switch (d)
			case 1
				mu = 0;
				sig = 0.35;
			case 2
				mu = [0;0];
%				sig = [0.4, 0.3 ; 0.3, 0.4];
				sig = [1, 0 ; 0, 1];
		endswitch

		invsig = inv(sig);
		h = @(x) exp(-sum((x-mu).*(invsig*(x-mu)), axis=1)*0.5);
		h1 = @(x) exp(-sum((x-mu).*(invsig*(x-mu)), axis=1)*0.5) / sqrt(2*pi*det(sig))^d;
		U = @(x) sum((x-mu).*(invsig*(x-mu))*0.5, axis=1);
		dU = @(x) invsig * (x-mu);

		X_th = mvnrnd(mu,sig,n)'; % exact sample
		
	case "gm" % gaussian mixture distribution
		mu1 = 2*ones(d,1); w1 = 0.5;
		mu2 = -2*ones(d,1); w2 = 1-w1;
		sig1 = eye(d);
		invsig1 = inv(sig1);
		sig2 = eye(d);
		invsig2 = inv(sig2);

		f1 = @(x) exp(-sum((x-mu1).*(invsig1*(x-mu1)), axis=1)*0.5) / sqrt(2*pi*det(sig1))^d;
		f2 = @(x) exp(-sum((x-mu2).*(invsig2*(x-mu2)), axis=1)*0.5) / sqrt(2*pi*det(sig2))^d;
		h = @(x) w1 * f1(x) + w2 * f2(x);
		h1 = @(x) h(x);
		U = @(x) -log(h(x));
		dU = @(x) (w1*(invsig1*(x-mu1)).*f1(x)+w2*(invsig2*(x-mu2)).*f2(x))./h(x);

		b = rand(1,500)<w1;
		X_th = b .* mvnrnd(mu1,sig1,500)' + (1-b) .* mvnrnd(mu2,sig2,500)';

	case "lasso" % bayesian lasso
		switch d
			case 1
				A = 1; b = 5;
			case 2
				A = [1 1;0 1]; b = [5;5];
		endswitch
		lambda = 1;
		
		%% a terminer
		
	% other densities
endswitch