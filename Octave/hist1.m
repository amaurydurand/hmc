function hist1(X)
%{
Trace un histogramme de probabilit�
@param
	X : �chantillon
	m : nombre de barres
%}
	m = ceil(length(X)^0.35);
	[freq,val] = hist(X,m);
	l = val(2)-val(1);
	bar(val,freq/l/sum(freq),"hist");
endfunction