filename=hmc_Rakotonirina-Durand

bib:
	bibtex ${filename}||true

nomencl:
	makeindex ${filename}.nlo -s nomencl.ist -o ${filename}.nls -t ${filename}.nlg

lilypond:
	lilypond-book --pdf ${filename}.lytex

pdf:
	pdflatex -shell-escape -synctex=1 -interaction=nonstopmode ${filename}.tex


read:
	evince ${filename}.pdf &

clean:
	rm -f ${filename}.{ps,log,aux,out,dvi,bbl,blg}
	rm -f tmp*
	rm -f *.ly

all:
	make pdf	
	make pdf
	make bib
	make pdf
	make pdf
	make clean
	make read	

