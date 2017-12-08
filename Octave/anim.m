lw = 2;
figure(3, "Position", get(0,"screensize")*0.9); clf;
set(0, 'defaultfigurevisible', 'off');

x = linspace(-max(abs(X_hmc(:)))-1, max(abs(X_hmc(:)))+1, 100);
y = linspace(-max(abs(X_hmc(:)))-1, max(abs(X_hmc(:)))+1, 100);
[xx, yy] = meshgrid(x,y);
F = reshape(U([xx(:) yy(:)]'), length(y), length(x));
% first plot RWM
subplot(2,3,1)
hold on
meshc(xx, yy, F);
axis([min(x)-1 max(x)+1 min(y)-1 max(y)+1 min(F(:))-1 max(F(:))+1])
scatter3(X_rwm(1, 1), X_rwm(2, 1), U(X_rwm(:, 1)), 'm', 'filled');              
p_rwm_old = plot3(X_rwm(1, 1), X_rwm(2, 1), U(X_rwm(:, 1)),  'color', 'r', 'linewidth', lw);              
view([20, 60])
hold off

% first plot HMC
subplot(2,3,2)
hold on
meshc(xx, yy, F);
axis([min(x)-1 max(x)+1 min(y)-1 max(y)+1 min(F(:))-1 max(F(:))+1])
scatter3(X_hmc(1, 1), X_hmc(2, 1), U(X_hmc(:, 1)), 'm', 'filled');
p_hmc_old = plot3(X_hmc(1, 1), X_hmc(2, 1), U(X_hmc(:, 1)), 'color', 'g', 'linewidth', lw);
view([20, 60])
hold off

% first plot HMC random L
subplot(2,3,3)			
hold on
meshc(xx, yy, F);
axis([min(x)-1 max(x)+1 min(y)-1 max(y)+1 min(F(:))-1 max(F(:))+1])
scatter3(X_hmcL(1, 1), X_hmcL(2, 1), U(X_hmcL(:, 1)), 'm', 'filled');
p_hmcL_old = plot3(X_hmcL(1, 1), X_hmcL(2, 1),  U(X_hmcL(:, 1)), 'color', 'b', 'linewidth', lw);
view([20, 60])
hold off

% first plot RWM 2D
subplot(2,3,4)
hold on
contour(xx, yy, F);
scatter(X_rwm(1, 1), X_rwm(2, 1), 'm', 'filled');              
pc_rwm_old = plot(X_rwm(1, 1), X_rwm(2, 1), 'color', 'r', 'linewidth', lw);              
hold off

% first plot HMC 2D
subplot(2,3,5)
hold on
contour(xx, yy, F);
scatter(X_hmc(1, 1), X_hmc(2, 1),  'm', 'filled');   
pc_hmc_old = plot(X_hmc(1, 1), X_hmc(2, 1), 'color', 'g', 'linewidth', lw);
hold off

% first plot HMC random L 2D
subplot(2,3,6)
hold on
contour(xx, yy, F);
scatter(X_hmcL(1, 1), X_hmcL(2, 1),  'm', 'filled');   
pc_hmcL_old = plot(X_hmcL(1, 1), X_hmcL(2, 1), 'color', 'c', 'linewidth', lw);
hold off

drawnow;

input('START','s');

    
% other iterations
n_cycle = N/200;
deg = linspace(0, n_cycle*360, N);
cur_rwm_points = X_rwm(:, 1);

for t = 1:N
  % set titles
  subplot(2,3,1)
  title(sprintf("Random Walk Metropolis, t = %d", t));
  view([20 - deg(t), 60])
  
  subplot(2,3,2)
  view([20 - deg(t), 60])
  title(sprintf("Hamiltonian Monte Carlo, t = %d", t));

  subplot(2,3,3)
  view([20 - deg(t), 60])
  title(sprintf("Hamiltonian Monte Carlo random L, t = %d", t));


  % sub animation for leapfrog and random walk
  cur_lp = leapfrog_hmc{t};
  cur_lpL = leapfrog_hmcL{t};
  num_lp_steps = length(cur_lp);
  if length(cur_lpL) != length(cur_lp)
    if length(cur_lpL) < length(cur_lp)
      num_lp_steps = length(cur_lp);
      for i = 1:length(cur_lp)-length(cur_lpL)
	cur_lpL = [cur_lpL  cur_lpL(:, end)];
      endfor
    else
      num_lp_steps = length(cur_lpL);
      for i = 1:length(cur_lpL)-length(cur_lp)
	cur_lp = [cur_lp cur_lp(:, end)];
      endfor
    endif
  endif
  cur_U = U(cur_lp);
  cur_UL = U(cur_lpL);
  		 
  cur_rwm_points = [cur_rwm_points(:, end) proposed_rwm(:, t)];
  interpol_rwm = [linspace(cur_rwm_points(1, 1), cur_rwm_points(1, 2), num_lp_steps); linspace(cur_rwm_points(2, 1), cur_rwm_points(2, 2), num_lp_steps)];
  cur_U_rwm = U(interpol_rwm);
  
  for j = 1:size(cur_lp,2)-1
    % plot proposed motion for rwm
    subplot(2,3,1)
    hold on
    prop_plot = scatter3(interpol_rwm(1,j), interpol_rwm(2,j), \
			 cur_U_rwm(j), 'k', 'filled');
    hold off
    subplot(2,3,4)
    hold on
    prop_cplot = scatter(interpol_rwm(1,j), interpol_rwm(2,j), \
			 'k', 'filled');
    hold off
    % plot proposed motion for hmc
    subplot(2,3,2)
    hold on
    lp_plot = scatter3(cur_lp(1,j), cur_lp(2,j), 
		       cur_U(j),
		       'k', 'filled');
    hold off
    subplot(2,3,5)
    hold on
    lp_cplot = scatter(cur_lp(1,j), cur_lp(2,j), 
		       'k', 'filled');
    hold off
    
    % plot proposed motion for hmc random L
    subplot(2,3,3)
    hold on
    lpL_plot = scatter3(cur_lpL(1,j), cur_lpL(2,j), cur_UL(j), 'k', 'filled');
    hold off
    subplot(2,3,6)
    hold on
    lpL_cplot = scatter(cur_lpL(1,j), cur_lpL(2,j), 
		       'k', 'filled');
    hold off
    
    pause(0.001)
  
    delete(prop_plot)
    delete(prop_cplot)
    delete(lp_plot)
    delete(lp_cplot)
    delete(lpL_plot)
    delete(lpL_cplot)
  endfor

  % plot if accepted and go back to beginning if not
  if accept_rwm(t)
    subplot(2,3,1)
    hold on
    p_rwm = plot3(interpol_rwm(1,:), interpol_rwm(2,:), 
		  cur_U_rwm,
		  'color', 'r', 'linewidth', lw);
    point_rwm = plot3(interpol_rwm(1,end), interpol_rwm(2,end), cur_U_rwm(end),
		  'r+');
    
    hold off
    subplot(2,3,4)
    hold on
    pc_rwm = plot(interpol_rwm(1,:), interpol_rwm(2,:), 
		  'color', 'r', 'linewidth', lw);
    pointc_rwm = plot(interpol_rwm(1,end), interpol_rwm(2,end), 
		  'r+');
    
    hold off
  else
    cur_rwm_points(:, end) = cur_rwm_points(:, 1);
  endif
      
  if accept_hmc(t)
    subplot(2,3,2)
    hold on
    p_hmc = plot3(cur_lp(1,:), cur_lp(2,:), 
   		  cur_U,
   		  'color', 'g', 'linewidth', lw);
    point_hmc = plot3(cur_lp(1,end), cur_lp(2,end), cur_U(end),
		  'g+');
    hold off
    subplot(2,3,5)
    hold on
    pc_hmc = plot(cur_lp(1,:), cur_lp(2,:), 
   		  'color', 'g', 'linewidth', lw);
    pointc_hmc = plot(cur_lp(1,end), cur_lp(2,end), 'g+');
    
    hold off
  endif

  if accept_hmcL(t)
    subplot(2,3,3)
    hold on
    p_hmcL = plot3(cur_lpL(1,:), cur_lpL(2,:), 
   		  cur_UL,
   		  'color', 'c', 'linewidth', lw);
    point_hmcL = plot3(cur_lpL(1,end), cur_lpL(2,end), cur_UL(end),
		  'y+');
    hold off
    subplot(2,3,6)
    hold on
    pc_hmcL = plot(cur_lpL(1,:), cur_lpL(2,:), 
   		  'color', 'c', 'linewidth', lw);
    pointc_hmcL = plot(cur_lpL(1,end), cur_lpL(2,end), 'y+');
    
    hold off
  endif
  
  %subplot(2,3,4)
  %hold on
  %pc_rwm = plot(X_rwm(1, 1:t), X_rwm(2, 1:t), 
  % 		'color', 'r', 'linewidth', lw);              
  %hold off
  pause(0.001);      
  %delete(pc_rwm_old);
  %pc_rwm_old = pc_rwm;		
  %drawnow;

endfor

		