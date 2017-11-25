function X = HMC(U,dU,dt,L,X0,N)
%{
@param
	U : log density
	dU : gradient of U
	dt : leapfrog step
	L : number of leapfrog steps
	X0 : starting point
	N : number of HMC steps
@return
	X : HMC walk
%}
	X = zeros(length(X0),N+1);
	X(:,1) = X0;
	for k = 1:N % HMC step
		Xk = X(:,k); Pk = stdnormal_rnd(size(Xk)); % at time k
		[Xp,Pp] = HMC_leapfrog(dU,dt,L,Xk,Pk); % proposed
		% Pp = -Pp; % we don't oppose Pp because K is even
		
		% energies
		Uk = U(Xk);
		Kk = norm(Pk)^2/2;
		Up = U(Xp);
		Kp = norm(Pp)^2/2;
		
		if rand(1) < exp(Uk-Up+Kk-Kp)
			X(:,k+1) = Xp; % accept
		else
			X(:,k+1) = Xk; % reject
		endif
	endfor
endfunction