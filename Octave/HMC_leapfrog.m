function [x1,p1] = HMC_leapfrog(dU,dt,L,x0,p0)
%{
@param
	dU : gradient of the potential energy U
	dt : stepsize
	L : number of steps
	x0,p0 : initial state
@return
	x1,p1 : final state
%}
	x1 = x0;
	p1 = p0;
	
	p1 -= dt*dU(x1)/2; % half-step for p
	for k = 1:L-1 % leapfrog
		x1 += dt*p1;
		p1 -= dt*dU(x1);
	endfor
	x1 += dt*p1; % last step for x
	p1 -= dt*dU(x1)/2; % half-step for p
endfunction