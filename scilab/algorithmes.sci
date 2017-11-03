//////////////////////////////////////////////////////
//Fonctions pour l'algorithme Random-walk Metropolis//
//////////////////////////////////////////////////////

function X = RWM(h,U,X0,N)
    //X = (X0, ..., XN) marche obtenue par Random-walk Metropolis
    //h proportionnel à la densité à simuler
    //U N-échantillon de la loi instrumentale
    X = zeros(size(X0,1),N+1);
    X(:,1) = X0;
    for k = 1:N
        Y = X(:,k) + U(k);
        accepter = 1*(grand(1,1,'unf',0,1) < min(1,h(y) ./ h(X(:,k))));
        X(:,k+1) = accepter*Y + (1-accepter)*X(:,k);
    end
endfunction





///////////////////////////////////
//Fonctions pour l'algorithme HMC//
///////////////////////////////////

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

function X2 = HMC_step(U,dU,dt,L,X1)//faire un pas de l'algorithme HMC
    V1 = grand(size(X1,1),size(X1,2),'nor',0,1);
    [x2,v2] = Hamilton_leapfrog(dU,dt,L,X1,V1);
    // on devrait faire v2 = -v2 mais ici K est pair
    
    //énergies de l'état actuel
    U1 = U(X1);
    K1 = sum(V1.^2)/2;
    //énergies de l'état proposé
    U2 = U(x2);
    K2 = sum(v2.^2)/2;
    
    accepter = 1*(grand(1,1,'unf',0,1) < exp(U1-U2+K1-K2));
    X2 = accepter*x2 + (1-accepter)*X1;
endfunction

function X = HMC(U,dU,dt,L,X0,N)
    //X = (X0, ..., XN) marche obtenue par HMC
    X = zeros(size(X0,1),N+1);
    X(:,1) = X0;
    for k = 1:N
        X(:,k+1) = HMC_step(U,dU,dt,L,X(k,:));
    end
endfunction
