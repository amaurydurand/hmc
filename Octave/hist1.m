function hist1(X)
%{
Plot an histogram with mass 1
@param
	X : sample
	m : number of bin
%}
	m = ceil(length(X)^0.35);
	[freq,val] = hist(X,m);
	w = val(2)-val(1);
	bar(val,freq/w/sum(freq),"hist");
endfunction