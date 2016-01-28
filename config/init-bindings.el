(defmacro bind (&rest commands)
  "Convenience macro which creates a lambda interactive command."
  `(lambda ()
     (interactive)
     ,@commands))


(require-package 'which-key)
(setq which-key-idle-delay 0.2)
(which-key-mode)
(add-to-list 'which-key-description-replacement-alist '("*hydra/" . ""))

(after 'ivy
  (define-key ivy-mode-map [escape] (kbd "C-g")))

(after "magit-autoloads"
  (global-set-key (kbd "C-x g") 'magit-dispatch-popup))


(after "project-explorer-autoloads"
  (global-set-key [f2] 'project-explorer-open)
  (autoload 'pe/show-file "project-explorer")
  (global-set-key [f3] 'pe/show-file))

(after "multiple-cursors-autoloads"
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-unset-key (kbd "M-<down-mouse-1>"))
  (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click))

(after 'comint
  (define-key comint-mode-map [up] 'comint-previous-input)
  (define-key comint-mode-map [down] 'comint-next-input))


(after 'auto-complete
  (define-key ac-completing-map (kbd "C-n") 'ac-next)
  (define-key ac-completing-map (kbd "C-p") 'ac-previous))


(after 'company
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "<tab>") 'my-company-tab)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
  (after "helm-company-autoloads"
    (define-key company-mode-map (kbd "<C-return>") 'helm-company)
    (define-key company-active-map (kbd "<C-return>") 'helm-company)))


(after "expand-region-autoloads"
  (global-set-key (kbd "C-=") 'er/expand-region))


(after 'web-mode
  (after "angular-snippets-autoloads"
    (define-key web-mode-map (kbd "C-c C-d") 'ng-snip-show-docs-at-point)))


;; mouse scrolling in terminal
(unless (display-graphic-p)
  (global-set-key [mouse-4] (bind (scroll-down 1)))
  (global-set-key [mouse-5] (bind (scroll-up 1))))


(after 'eshell
  (add-hook 'eshell-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c h") (bind (eshell/h))))))

(after 'help-mode
  (define-key help-mode-map (kbd "n") 'next-line)
  (define-key help-mode-map (kbd "p") 'previous-line))

(global-set-key [prior] 'previous-buffer)
(global-set-key [next] 'next-buffer)

(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c s") 'my-goto-scratch-buffer)
(global-set-key (kbd "C-c e") 'my-eval-and-replace)
(global-set-key (kbd "C-c t") 'my-new-eshell-split)

(global-set-key (kbd "C-x c") 'calculator)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)

(global-set-key (kbd "C-x p") 'proced)
(after "vkill-autoloads"
  (autoload 'vkill "vkill" nil t)
  (global-set-key (kbd "C-x p") 'vkill))

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-r") 'isearch-backward)


;; have no use for these default bindings
(global-unset-key (kbd "C-x m"))


;; replace with [r]eally [q]uit
(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-x C-c") (bind (message "Thou shall not quit!")))

(provide 'init-bindings)
