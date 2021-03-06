////////////////////////////////
//Densité et énergie à simuler//
////////////////////////////////

function y = h(x)
    y = exp(-x'*x/2); //N(0,1)
endfunction

function y = U(x)
    //    y = -log(h(x)); //cas général
    y = x'*x/2; //N(0,1)
endfunction

function y = dU(x)
    y = x; //N(0,1)
endfunction





//////////////
//Paramètres//
//////////////

n = 1001; //nombre de données à représenter
n0 = 0; //oublier les données jusqu'à n0 - 1
N = n+n0-1; //nombre de données totales à simuler
d = 2; //dimension de l'espace
X0 = 100*ones(d,1); //point initial éloigné de la masse
Delta = grand(d,N,'nor',0,1); //loi instrumentale pour RWM
dt = 0.1; //pas pour HMC
L = 100; //nombre de pas pour HMC





////////////////////////////
//Résultats en dimension 2//
////////////////////////////
X_th = grand(2,n,'nor',0,1); //N(0,1)
scf(1); clf(1);
plot(X_th(1,:),X_th(2,:),'+b');
title(string(n)+"-échantillon N(0,1)");

X_rwm = RWM(h,Delta,X0,N);
X_rwm = X_rwm(:,n0+1:N+1);
scf(2); clf(2);
plot(X_rwm(1,:),X_rwm(2,:),'+r');
title("Simulation N(0,1) par RWM (termes "+string(n0)+" à "+string(N)+")");

X_hmc = HMC(U,dU,dt,L,X0,N);
X_hmc = X_hmc(:,n0+1:N+1);
scf(3); clf(3);
plot(X_hmc(1,:),X_hmc(2,:),'+m');
title("Simulation N(0,1) par HMC (termes "+string(n0)+" à "+string(N)+")");
