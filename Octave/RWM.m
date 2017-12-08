function [X, all_prop, accepted] = RWM(h,Delta,X0,N)
%{
@param
	h : proportionnal to the aimed density
	Delta : N-sample of the instrumental law
	X0 : starting point
	N : number of steps
@return
	X : (X0,...,XN) random-walk Metropolis
%}
	X = zeros(length(X0),N+1);
	all_x = zeros(length(X0),N+1);
	accepted = zeros(1,N);
	X(:,1) = X0;
	for k = 1:N
	        %waitbar(k/N)
		Y = X(:,k) + Delta(:,k);
		hx = h(X(:,k));
		if rand(1)*hx < min(hx,h(Y))
		        accepted(k) = 1;
			X(:,k+1) = Y;
		else
			X(:,k+1) = X(:,k);
		endif
		all_prop(:, k) = Y;
	endfor
endfunction