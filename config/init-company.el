(when (eq dotemacs-completion-engine 'company)
  (defgroup dotemacs-company nil
    "Configuration options for company-mode."
    :group 'dotemacs
    :prefix 'dotemacs-company)

  (defcustom dotemacs-company/ycmd-server-command nil
    "The path to the ycmd package."
    :group 'dotemacs-company)

  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-show-numbers t
        company-tooltip-limit 20)

  (setq company-dabbrev-downcase nil
        company-dabbrev-ignore-case t)

  (setq company-dabbrev-code-ignore-case t
        company-dabbrev-code-everywhere t)

  (setq company-etags-ignore-case t)

  (setq company-global-modes
        '(not
          eshell-mode comint-mode org-mode erc-mode))

  (require-package 'company)
  (require 'company)

  (unless (face-attribute 'company-tooltip :background)
    (set-face-attribute 'company-tooltip nil :background "black" :foreground "gray40")
    (set-face-attribute 'company-tooltip-selection nil :inherit 'company-tooltip :background "gray15")
    (set-face-attribute 'company-preview nil :background "black")
    (set-face-attribute 'company-preview-common nil :inherit 'company-preview :foreground "gray40")
    (set-face-attribute 'company-scrollbar-bg nil :inherit 'company-tooltip :background "gray20")
    (set-face-attribute 'company-scrollbar-fg nil :background "gray40"))

  (defadvice company-complete-common (around advice-for-company-complete-common activate)
    (when (null (yas-expand))
      ad-do-it))

  (defun my-company-tab ()
    (interactive)
    (when (null (yas-expand))
      (company-select-next)))

  (when (executable-find "tern")
    (after "company-tern-autoloads"
      (add-to-list 'company-backends 'company-tern)))

  (when dotemacs-company/ycmd-server-command
    (setq ycmd-server-command `("python" ,dotemacs-company/ycmd-server-command))
    (require-package 'ycmd)
    (require 'ycmd)
    (global-ycmd-mode)

    (require-package company-ycmd)
    (require 'company-ycmd)
    (company-ycmd-setup))

  (global-company-mode)

  (require-package 'company-flx)
  (require 'company-flx)
  (company-flx-mode)

  )

(provide 'init-company)
