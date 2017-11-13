switch (d)
	case 1
		x = linspace(-5,5);
		y = h1(x);
		
		X_rwm = RWM(h,Delta,X0,N);
		X_rwm = X_rwm(:,n0+1:N+1);
		
		figure(2); clf;
		hold on
		plot(x,y,"r");
		hist(X_rwm,ceil(n^0.35),1);
		title("Random-walk Metropolis");
		legend("Densité théorique","Histogramme de la marche");
		hold off
		
		X_hmc = HMC(U,dU,dt,L,X0,N);
		X_hmc = X_hmc(:,n0+1:N+1);
		
		figure(3); clf;
		hold on
		plot(x,y,"r");
		hist(X_hmc,ceil(n^0.35),1);
		title("Hamiltonian Monte-Carlo");
		legend("Densité théorique","Histogramme de la marche");
		hold off
	case 2
		X_th = stdnormal_rnd(2,n); % si on simule N(0,1)
		X_rwm = RWM(h,Delta,X0,N);
		X_rwm = X_rwm(:,n0+1:N+1);
		X_hmc = HMC(U,dU,dt,L,X0,N);
		X_hmc = X_hmc(:,n0+1:N+1);
		
		figure(1); clf;
		subplot(2,2,1);
		plot(X_th(1,:),X_th(2,:),"+b");
		title([int2str(n) "-échantillon"]);
		subplot(2,2,2);
		plot(X_rwm(1,:),X_rwm(2,:),"+r");
		title("Random-walk Metropolis");
		subplot(2,2,3);
		plot(X_hmc(1,:),X_hmc(2,:),"+g");
		title("Hamiltonian Monte-Carlo");
endswitch