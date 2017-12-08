function [X, all_leapfrog, accepted] = HMC(U,dU,dt,L,X0,N)
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
	accepted = zeros(1, N);
	all_leapfrog = {};
	X(:,1) = X0;
	for k = 1:N % HMC step
	        %waitbar(k/N)
		Xk = X(:,k); Pk = stdnormal_rnd(size(Xk)); % at time k
		[Xp, Pp, all_cur_leapX] = HMC_leapfrog(dU,dt,L(k),Xk,Pk); % proposed
		all_leapfrog(end+1) = all_cur_leapX;
		% Pp = -Pp; % we don't oppose Pp because K is even
		
		% energies
		Uk = U(Xk);
		Kk = norm(Pk)^2/2;
		Up = U(Xp);
		Kp = norm(Pp)^2/2;
		
		if rand(1) < exp(Uk-Up+Kk-Kp)
		        accepted(k) = 1;
			X(:,k+1) = Xp; % accept
		else
			X(:,k+1) = Xk; % reject
		endif
	endfor
endfunction