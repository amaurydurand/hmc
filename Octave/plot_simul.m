switch (d)
	case 1
		time_in = time();
		X_rwm = RWM(h,Delta,X0,N);
		time_out = time();
		fprintf("RWM done (%fs)\n",time_out-time_in); fflush(stdout);
		X_rwm = X_rwm(:,n0+1:N+1);
		
		time_in = time();
		X_hmc = HMC(U,dU,dt,L,X0,N);
		time_out = time();
		fprintf("HMC done (%fs)\n",time_out-time_in); fflush(stdout);
		X_hmc = X_hmc(:,n0+1:N+1);
		
		figure(2); clf;
		
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
		time_in = time();
		X_rwm = RWM(h,Delta,X0,N);
		time_out = time();
		fprintf("RWM done (%fs)\n",time_out-time_in); fflush(stdout);
		X_rwm = X_rwm(:,n0+1:N+1);
		
		time_in = time();
		X_hmc = HMC(U,dU,dt,L,X0,N);
		time_out = time();
		fprintf("HMC done (%fs)\n",time_out-time_in); fflush(stdout);
		X_hmc = X_hmc(:,n0+1:N+1);
		
		figure(1); clf;
			subplot(2,2,1);
				plot(X_th(1,:),X_th(2,:),"+b");
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
				plot(X_th(1,:),X_th(2,:),"+b",
					X_rwm(1,:),X_rwm(2,:),"+r",
					X_hmc(1,:),X_hmc(2,:),"+g");
				axis equal;
				title("All simulations");
    
		if animation
			figure(2); clf;
			x = linspace(-10,10,50);
			y = linspace(-10,10,50);
			[xx, yy] = meshgrid(x,y);
			F = reshape(-log(h([xx(:) yy(:)]')), length(y), length(x));

			subplot(2,2,1)
			hold on
			meshc(xx, yy, F);
			axis([min(x) max(x) min(y) max(y) min(F(:)) max(F(:))])
			% first plot to define the line
			p_rwm_old = plot3(X_rwm(1, 1), X_rwm(2, 1), 
										-log(h1(X_rwm(:, 1))),
										'color', 'r', 'linewidth', 2);              
			view([20, 56])
			hold off
			
			subplot(2,2,2)
			hold on
			meshc(xx, yy, F);
			axis([min(x) max(x) min(y) max(y) min(F(:)) max(F(:))])
			% first plot to define the line
			p_hmc_old = plot3(X_hmc(1, 1), X_hmc(2, 1), 
											-log(h1(X_hmc(:, 1))),
											'color', 'g', 'linewidth', 2);
			view([20, 56])
			hold off
			
			subplot(2,2,3)
			hold on
			contour(xx, yy, F);
			% first plot to define the line
			pc_rwm_old = plot(X_rwm(1, 1), X_rwm(2, 1), 
										'color', 'r', 'linewidth', 2);              
			hold off
			
			subplot(2,2,4)
			hold on
			contour(xx, yy, F);
			% first plot to define the line
			pc_hmc_old = plot(X_hmc(1, 1), X_hmc(2, 1), 
											'color', 'g', 'linewidth', 2);
			hold off
			pause(0.1); drawnow;
			
			% other iterations
			for t = 2:n
				subplot(2,2,1)
				title(sprintf('Random Walk Metropolis, t = %d', t));
				hold on
				p_rwm = plot3(X_rwm(1, 1:t), X_rwm(2, 1:t), 
											-log(h1(X_rwm(:, 1:t))),
											'color', 'r', 'linewidth', 2);              
				hold off
				subplot(2,2,2)
				hold on
				p_hmc = plot3(X_hmc(1, 1:t), X_hmc(2, 1:t), 
												-log(h1(X_hmc(:, 1:t))),
												'color', 'g', 'linewidth', 2);
				hold off
				title(sprintf('Hamiltonian Monte Carlo, t = %d', t));

				subplot(2,2,3)
				hold on
				pc_rwm = plot(X_rwm(1, 1:t), X_rwm(2, 1:t), 
											'color', 'r', 'linewidth', 2);              
				hold off
				
				subplot(2,2,4)
				hold on
				pc_hmc = plot(X_hmc(1, 1:t), X_hmc(2, 1:t), 
											'color', 'g', 'linewidth', 2);
				hold off
				
				pause(0.05);      
				delete(p_rwm_old);
				p_rwm_old = p_rwm;
				delete(p_hmc_old);
				p_hmc_old = p_hmc;
				delete(pc_rwm_old);
				pc_rwm_old = pc_rwm;
				delete(pc_hmc_old);
				pc_hmc_old = pc_hmc;
				drawnow;
			endfor
    endif
endswitch