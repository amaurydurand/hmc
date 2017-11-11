function [x1,p1] = HMC_sautemouton(dU,dt,L,x0,p0)
%{
@param
	dU : gradient du potentiel U
	dt : pas
	L : nombre de pas
	x0,p0 : état initial
@return
	x1,p1 : état après avoir avancé selon l'hamiltonien U+K
%}
	x1 = x0;
	p1 = p0;
	
	p1 = p1 - dt*dU(x1)/2; % demi-pas en p
	for k = 1:L-1 % saute-mouton
		x1 += dt*p1;
		p1 -= dt*dU(x1);
	endfor
	x1 += dt*p1; % dernier pas en x
	p1 -= dt*dU(x1)/2; % demi-pas en p
endfunction