function X = RWM(h,Delta,X0,N)
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
	X(:,1) = X0;
	for k = 1:N
		Y = X(:,k) + Delta(:,k);
		hx = h(X(:,k));
		if rand(1)*hx < min(hx,h(Y))
			X(:,k+1) = Y;
		else
			X(:,k+1) = X(:,k);
		endif
	endfor
endfunction