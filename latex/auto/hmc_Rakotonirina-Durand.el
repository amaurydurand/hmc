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
    "eq:canonical-dist")
   (LaTeX-add-bibliographies
    "ref"))
 :latex)

