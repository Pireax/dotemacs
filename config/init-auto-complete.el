(when (eq dotemacs-completion-engine 'auto-complete)
  (setq ac-auto-show-menu t
        ac-auto-start t
        ac-comphist-file (concat dotemacs-cache-directory "ac-comphist.dat")
        ac-quick-help-delay 0.3
        ac-quick-help-height 30
        ac-show-menu-immediately-on-auto-complete t)

  (require-package 'auto-complete)
  (require 'auto-complete)

  (dolist (mode '(vimrc-mode html-mode stylus-mode))
    (add-to-list 'ac-modes mode))

  (require 'auto-complete-config)
  (ac-config-default)

  (after 'linum
    (ac-linum-workaround))

  (after 'yasnippet
    (add-hook 'yas-before-expand-snippet-hook (lambda () (auto-complete-mode -1)))
    (add-hook 'yas-after-exit-snippet-hook (lambda () (auto-complete-mode t)))
    (defadvice ac-expand (before advice-for-ac-expand activate)
      (when (yas-expand)
        (ac-stop))))

  (setq ac-etags-requires 1)
  (require-package 'ac-etags)
  (require 'ac-etags)
  (after 'etags
    (ac-etags-setup))

  )

(provide 'init-auto-complete)
