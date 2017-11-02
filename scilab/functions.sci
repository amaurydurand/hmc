function [x2,v2] = Hamilton_leapfrog(dU,dt,L,x1,v1) //avancer selon la dynamique hamiltonienne avec le saute-mouton
    //dU le gradient de U
    //dt le pas
    //L le nombre de pas
    //X la position initiale
    //V la vitesse initiale
    x2 = x1;
    v2 = v1;
    
    //demi-pas en vitesse
    v2 = v2 - dt * dU(x2)/2;
    
    //saute-mouton
    for k = 1:L-1
        x2 = x2 + dt*v2;
        v2 = v2 - dt * dU(x2);
    end
    
    //dernier pas en position, demi-pas en vitesse
    x2 = x2 + dt*v2;
    v2 = v2 - dt * dU(x2)/2;
endfunction

function X2 = HMC_step(U,dU,dt,L,X)//faire un pas de l'algorithme HMC
    V = grand(size(X,1),size(X,2),'nor',0,1);
    [x2,v2] = Hamilton_leapfrog(dU,dt,L,X,V);
    // on devrait faire v2 = -v2 mais ici K est pair
    
    //énergies de l'état actuel
    U1 = U(X);
    K1 = sum(V.^2)/2;
    //énergies de l'état proposé
    U2 = U(x2);
    K2 = sum(v2.^2)/2;
    
    alpha = exp(U1-U2+K1-K2);
    U = grand(1,1,'unf',0,1);
    X2 = (U<alpha)*x2 + (U>=alpha)*X;
endfunction

function X = HMC(U,dU,dt,L,X0,N) //X0, ..., XN par HMC
    X = zeros(size(X0,1),N+1);
    X(:,1) = X0;
    for k = 1:N
        X(:,k+1) = HMC_step(U,dU,dt,L,X(k,:));
    end
endfunction
