(require-package 'flycheck)
(require 'flycheck)
(setq flycheck-check-syntax-automatically '(save mode-enabled)
      flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers)
      flycheck-checkers (delq 'html-tidy flycheck-checkers)
      flycheck-standard-error-navigation nil)

(global-flycheck-mode t)

(provide 'init-flycheck)
