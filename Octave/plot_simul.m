switch (d)
  case 1
    figure(1); clf;
    subplot(1,2,1);
    hold on;
    x = linspace(min(X_rwm),max(X_rwm));
    plot(x,h1(x),"r");
    hist1(X_rwm);
    title("Random-walk Metropolis");
    legend("Theoretical density","Histogram of the walk");
    hold off
    
    subplot(1,2,2);
    hold on;
    x = linspace(min(X_hmc),max(X_hmc));
    plot(x,h1(x),"r");
    hist1(X_hmc);
    title("Hamiltonian Monte-Carlo");
    legend("Theoretical density","Histogram of the walk");
    hold off
  case 2
    figure(1); clf;
    hold on;
    plot(autocor(X_hmc(1, :))(1:50), ";HMC;", "color", "g", \
	 "linestyle", "-", "linewidth", 2);
    plot(autocor(X_rwm(1, :))(1:50), ";RWM;", "color", "r", \
	 "linestyle", "-", "linewidth", 2);
    plot(autocor(X_hmcL(1, :))(1:50), ";HMC random L;", "color", "b", \
	 "linestyle", "-", "linewidth", 2);
    hold off;
    legend();
    title("50th first terms of X's autocorrelation");
    
    figure(2); clf;
    subplot(2,2,1);
    plot(X_th(1,:),X_th(2,:),"+k");
    axis equal;
    title([int2str(n) "-sample"]);
    subplot(2,2,2);
    plot(X_rwm(1,:),X_rwm(2,:),"+r");
    axis equal;
    title("Random-walk Metropolis");
    subplot(2,2,3);
    plot(X_hmc(1,:),X_hmc(2,:),"+g");
    axis equal;
    title("Hamiltonian Monte-Carlo");
    subplot(2,2,4);
    plot(X_hmcL(1,:),X_hmcL(2,:),"+c");
    axis equal;
    title("Hamiltonian Monte-Carlo random L");
endswitch