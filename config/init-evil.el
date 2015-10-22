(defgroup dotemacs-evil nil
  "Configuration options for evil-mode."
  :group 'dotemacs
  :prefix 'dotemacs-evil)

(defcustom dotemacs-evil/emacs-state-minor-modes
  '(git-commit-mode
    magit-blame-mode)
  "List of minor modes that when active should switch to Emacs state."
  :type '(repeat (symbol))
  :group 'dotemacs-evil)

(defcustom dotemacs-evil/emacs-cursor
  "SteelBlue1"
  "The color of the cursor when in Emacs state."
  :type 'color)


(setq evil-search-module 'evil-search)
(setq evil-magic 'very-magic)

(setq evil-emacs-state-cursor `(,dotemacs-evil/emacs-cursor box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))
(setq evil-emacs-state-tag " EMACS ")
(setq evil-normal-state-tag " NORMAL ")
(setq evil-visual-state-tag " VISUAL ")
(setq evil-insert-state-tag " INSERT ")
(setq evil-replace-state-tag " REPLACE ")
(setq evil-operator-state-tag " OPERATOR ")
(setq evil-motion-state-tag " MOTION ")

(require-package 'evil)
(require 'evil)

(unless (display-graphic-p)
  (evil-esc-mode))


(require-package 'evil-leader)
(global-evil-leader-mode t)


(require-package 'evil-commentary)
(evil-commentary-mode t)


(require-package 'evil-surround)
(global-evil-surround-mode t)


(require-package 'evil-exchange)
(evil-exchange-install)


(setq anzu-cons-mode-line-p nil)

(require-package 'evil-anzu)
(require 'evil-anzu)


(setq evil-jumper-auto-center t)
(setq evil-jumper-file (concat dotemacs-cache-directory "evil-jumps"))
(setq evil-jumper-auto-save-interval 3600)
(require-package 'evil-jumper)
(global-evil-jumper-mode t)


(require-package 'evil-matchit)
(defun evilmi-customize-keybinding ()
  (evil-define-key 'normal evil-matchit-mode-map
    "%" 'evilmi-jump-items))
(global-evil-matchit-mode t)


(require-package 'evil-indent-textobject)
(require 'evil-indent-textobject)


(require-package 'evil-visualstar)
(global-evil-visualstar-mode t)


(require-package 'evil-numbers)


(defun my-send-string-to-terminal (string)
  (unless (display-graphic-p) (send-string-to-terminal string)))

(defadvice evil-ex-search-next (after advice-for-evil-ex-search-next activate)
  (recenter))

(defadvice evil-ex-search-previous (after advice-for-evil-ex-search-previous activate)
  (recenter))

(after 'edebug
  (add-hook 'edebug-mode-hook (lambda ()
                                (if edebug-mode
                                    (evil-emacs-state)
                                  (evil-normal-state)))))

(after 'paren
  (ad-enable-advice #'show-paren-function 'around 'evil)
  (ad-activate #'show-paren-function))

(evil-mode t)

(provide 'init-evil)
