(defmacro keychain-defun (name key)
  "Creates the function for mapping"
  `(defun ,name ()
     (interactive)
     (let ((keychain-mode nil))
       (call-interactively
        (key-binding ,key)))))

(defun keychain-define-key (key1 key2 alias)
  "Used to map a key to another key"
  (let ((fname (intern (concat "keychain/" alias))))
    (keychain-defun fname key2)
    `(define-key keychain-mode-map ,key1 ,fname)))

(define-minor-mode keychain-mode
  "Mode to rebind keys to other keys"
  :global t
  :keymap (let ((map (make-sparse-keymap)))
            map))

(provide 'keychain-mode)
