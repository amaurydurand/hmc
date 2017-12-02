lw = 2
switch (d)
	case 1
		X_rwm = RWM(h,Delta,X0,N);
		fprintf("RWM done\n"); fflush(stdout);
		X_rwm = X_rwm(:,n0+1:N+1);
		
		X_hmc = HMC(U,dU,dt,L,X0,N);
		fprintf("HMC done\n"); fflush(stdout);
		X_hmc = X_hmc(:,n0+1:N+1);
		
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
		X_rwm = RWM(h,Delta,X0,N);
		fprintf("RWM done\n"); fflush(stdout);
		X_rwm = X_rwm(:,n0+1:N+1);
		
		X_hmc = HMC(U,dU,dt,L,X0,N);
		fprintf("HMC done\n"); fflush(stdout);
		X_hmc = X_hmc(:,n0+1:N+1);

		figure(1); clf;
		hold on;
		plot(abs(autocor(X_hmc(1, :))), ";HCM;", "color", "g", "linestyle", "-");
		plot(abs(autocor(X_rwm(1, :))), ";RWM;", "color", "r", "linestyle", "-");
		hold off;
		legend();
		title("absolute value of X's autocorrelation");
			
		figure(2); clf;
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
    
		x = linspace(-max(abs(X_hmc(:)))-1, max(abs(X_hmc(:)))+1, 50);
		y = linspace(-max(abs(X_hmc(:)))-1, max(abs(X_hmc(:)))+1, 50);
		[xx, yy] = meshgrid(x,y);
		F = reshape(U([xx(:) yy(:)]'), length(y), length(x));
		figure(3, "Position", get(0,"screensize")*0.7); clf;
		%figure(3); clf; 
		subplot(2,2,1)
		%axis off;
		hold on
		meshc(xx, yy, F);
		axis([min(x)-1 max(x)+1 min(y)-1 max(y)+1 min(F(:))-1 max(F(:))+1])
		% first plot to define the line
		p_rwm_old = plot3(X_rwm(1, 1), X_rwm(2, 1), 
				  -log(h1(X_rwm(:, 1))),
				  'color', 'r', 'linewidth', lw);              
		view([20, 60])
		hold off
		
		subplot(2,2,2)
		%axis off;
		hold on
		meshc(xx, yy, F);
		axis([min(x)-1 max(x)+1 min(y)-1 max(y)+1 min(F(:))-1 max(F(:))+1])
		% first plot to define the line
		p_hmc_old = plot3(X_hmc(1, 1), X_hmc(2, 1), 
				  -log(h1(X_hmc(:, 1))),
				  'color', 'g', 'linewidth', lw);
		view([20, 60])
		hold off
		
		subplot(2,2,3)
		%axis off;		
		hold on
		contour(xx, yy, F);
		% first plot to define the line
		pc_rwm_old = plot(X_rwm(1, 1), X_rwm(2, 1), 
				  'color', 'r', 'linewidth', lw);              
		hold off
    
		subplot(2,2,4)
		%axis off;
		hold on
		contour(xx, yy, F);
		% first plot to define the line
		pc_hmc_old = plot(X_hmc(1, 1), X_hmc(2, 1), 
				  'color', 'g', 'linewidth', lw);
		hold off
		pause(0.1); drawnow;
    
		% other iterations
		n_cycle = 2;
		deg = linspace(0, n_cycle*360, n);
		for t = 2:n
		  subplot(2,2,1)
		  title(sprintf("Random Walk Metropolis, t = %d", t));
		  hold on
		  cur_rwm_points = X_rwm(:, t-1:t);
		  interpol_rwm = [linspace(cur_rwm_points(1, 1), cur_rwm_points(1, 2), 50),
				  linspace(cur_rwm_points(2, 1), cur_rwm_points(2, 2), 50)
				  ];
			      
		  p_rwm = plot3(interpol_rwm(1,:), interpol_rwm(2,:), 
				-log(h1(interpol_rwm)),
				'color', 'r', 'linewidth', lw);
		  
		  %p_rwm = plot3(X_rwm(1, 1:t), X_rwm(2, 1:t), 
		  % 		-log(h1(X_rwm(:, 1:t))),
		  % 		'color', 'r', 'linewidth', 1);
		  view([20 - deg(t), 60])
		  hold off
		  subplot(2,2,2)
		  hold on
		  cur_hmc_points = X_hmc(:, t-1:t);
		  interpol_hmc = [linspace(cur_hmc_points(1, 1), cur_hmc_points(1, 2), 50),
				  linspace(cur_hmc_points(2, 1), cur_hmc_points(2, 2), 50)
				  ];
			      
		  p_hmc = plot3(interpol_hmc(1,:), interpol_hmc(2,:), 
				-log(h1(interpol_hmc)),
				'color', 'g', 'linewidth', lw);
		  

		  %p_hmc = plot3(X_hmc(1, 1:t), X_hmc(2, 1:t), 
		  % 		-log(h1(X_hmc(:, 1:t))),
		  % 		'color', 'g', 'linewidth', 1);
		  view([20 - deg(t), 60])
		  hold off
		  title(sprintf("Hamiltonian Monte Carlo, t = %d", t));

		  subplot(2,2,3)
		  hold on
		  pc_rwm = plot(X_rwm(1, 1:t), X_rwm(2, 1:t), 
				'color', 'r', 'linewidth', lw);              
		  hold off
      
		  subplot(2,2,4)
		  hold on
		  pc_hmc = plot(X_hmc(1, 1:t), X_hmc(2, 1:t), 
				'color', 'g', 'linewidth', lw);
		  hold off
		  
		  pause(0.05);      
		  %delete(p_rwm_old);
		  %p_rwm_old = p_rwm;
		  %delete(p_hmc_old);
		  %p_hmc_old = p_hmc;
		  delete(pc_rwm_old);
		  pc_rwm_old = pc_rwm;
		  delete(pc_hmc_old);
		  pc_hmc_old = pc_hmc;
		  drawnow;
    endfor
endswitch