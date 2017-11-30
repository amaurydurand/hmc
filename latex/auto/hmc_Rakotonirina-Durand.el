(TeX-add-style-hook
 "hmc_Rakotonirina-Durand"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt" "a4paper")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "init"
    "defs"
    "color")
   (TeX-add-symbols
    "red")
   (LaTeX-add-labels
    "thm:ergodic"
    "algo:metropolis-hastings"
    "algo:metropolis"
    "eq:hamiltonian-dyn"
    "rque:edo"
    "eq:edo"
    "eq:canonical-dist"
    "eq:hyp"
    "prop:conservation"
    "lem:sol-inverse"
    "prop:rev"
    "prop:vol"
    "algo:leapfrog"
    "algo:HMC-ideal"
    "algo:HMC")
   (LaTeX-add-bibliographies
    "ref"))
 :latex)

