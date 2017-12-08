function [x1,p1,all_x] = HMC_leapfrog(dU,dt,L,x0,p0)
%{
@param
	dU : gradient of the potential energy U
	dt : stepsize
	L : number of steps
	x0,p0 : initial state
@return
	x1,p1 : final state
				%}
	all_x = zeros(length(x0), L+1);
	x1 = x0;
	p1 = p0;
	all_x(:, 1) = x1;
	
	p1 -= dt*dU(x1)/2; % half-step for p
	for k = 1:L-1 % leapfrog
		x1 += dt*p1;
		p1 -= dt*dU(x1);
		all_x(:, k+1) = x1;
	endfor
	x1 += dt*p1; % last step for x
	p1 -= dt*dU(x1)/2; % half-step for p
	all_x(:, L+1) = x1;
endfunction