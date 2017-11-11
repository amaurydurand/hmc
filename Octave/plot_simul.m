switch (d)
	case 1
		x = linspace(-5,5);
		y = h1(x);
		
		X_rwm = RWM(h,Delta,X0,N);
		X_rwm = X_rwm(:,n0+1:N+1);
		
		figure(2); clf;
		hold on
		plot(x,y,'r');
		hist(X_rwm,ceil(n^0.35),1);
		hold off
		
		X_hmc = HMC(U,dU,dt,L,X0,N);
		X_hmc = X_hmc(:,n0+1:N+1);
		
		figure(3); clf;
		hold on
		plot(x,y,'r');
		hist(X_hmc,ceil(n^0.35),1);
		hold off
	case 2
		X_th = stdnormal_rnd(2,n); % si on simule N(0,1)
		figure(1); clf;
		plot(X_th(1,:),X_th(2,:),'+b');
		
		X_rwm = RWM(h,Delta,X0,N);
		X_rwm = X_rwm(:,n0+1:N+1);
		figure(2); clf;
		plot(X_rwm(1,:),X_rwm(2,:),'+r');
		
		X_hmc = HMC(U,dU,dt,L,X0,N);
		X_hmc = X_hmc(:,n0+1:N+1);
		figure(3); clf;
		plot(X_hmc(1,:),X_hmc(2,:),'+g');
endswitch