function X = HMC(U,dU,dt,L,X0,N)
%{
@param
	U : log densité
	dU : gradient de U
	dt : pas pour Hamilton discret
	L : nombre de pas Hamilton discret
	X0 : point initial
	N : nombre de pas du HMC
@return
	X : marche HMC
%}
	X = zeros(length(X0),N+1);
	X(:,1) = X0;
	for k = 1:N % un pas de HMC
		Xk = X(:,k); Pk = stdnormal_rnd(size(Xk)); % au temps k
		[Xp,Pp] = HMC_sautemouton(dU,dt,L,Xk,Pk); % proposé
		% Pp = -Pp; % ici K pair donc inutile d'opposer Pp
		
		% énergies
		Uk = U(Xk);
		Kk = norm(Pk)^2/2;
		Up = U(Xp);
		Kp = norm(Pp)^2/2;
		
		if rand(1) < exp(Uk-Up+Kk-Kp)
			X(:,k+1) = Xp; % accepter
		else
			X(:,k+1) = Xk; % rejeter
		endif
	endfor
endfunction