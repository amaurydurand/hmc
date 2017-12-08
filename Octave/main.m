#{
TO DO :
	- animate the leapfrog evolution ?
#}
pkg load statistics
clear all;
def_param;
run_algo;
if plots;
  plot_simul;
endif
if animation;
  anim;
endif