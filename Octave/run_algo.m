switch (d)
  case 1
    L = 25*ones(1,N); % number of leapfrog steps
    L_rand = ceil(25*rand(1,N));

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
    
    time_in = time();
    X_hmcL = HMC(U,dU,dt,L_rand,X0,N);
    time_out = time();
    fprintf("HMC random L done (%fs)\n",time_out-time_in); fflush(stdout);
    X_hmcL = X_hmcL(:,n0+1:N+1);
  case 2
    L = 25*ones(1,N); % number of leapfrog steps
    L_rand = ceil(25*rand(1,N));
    
    time_in = time();
    [X_rwm, proposed_rwm, accept_rwm] = RWM(h,Delta,X0,N);
    time_out = time();
    fprintf("RWM done (%fs)\n",time_out-time_in); fflush(stdout);
    X_rwm = X_rwm(:,n0+1:N+1);
    
    time_in = time();
    [X_hmc, leapfrog_hmc, accept_hmc] = HMC(U,dU,dt,L,X0,N);
    time_out = time();
    fprintf("HMC done (%fs)\n",time_out-time_in); fflush(stdout);
    X_hmc = X_hmc(:,n0+1:N+1);
    
    time_in = time();
    [X_hmcL, leapfrog_hmcL, accept_hmcL] = HMC(U,dU,dt,L_rand,X0,N);
    time_out = time();
    fprintf("HMC random L done (%fs)\n",time_out-time_in); fflush(stdout);
    X_hmcL = X_hmcL(:,n0+1:N+1);
    
endswitch