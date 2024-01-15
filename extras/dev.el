;;= Programming Stuff ==========================================================
;; Thanks to https://sr.ht/~ashton314/emacs-bedrock/
;; Author: Bhargav Kulkarni

(use-package emacs
  :config
  ;; Treesitter config

  ;; Tell Emacs to prefer the treesitter mode
  ;; You'll want to run the command `M-x treesit-install-language-grammar' before editing.
  ;;(setq major-mode-remap-alist
  ;;      '((yaml-mode . yaml-ts-mode)
  ;;        (bash-mode . bash-ts-mode)
  ;;        (js2-mode . js-ts-mode)
  ;;        (typescript-mode . typescript-ts-mode)
  ;;        (json-mode . json-ts-mode)
  ;;        (css-mode . css-ts-mode)
  ;;        (python-mode . python-ts-mode)))
  :hook
  ;; Auto parenthesis matching
  ((prog-mode . electric-pair-mode)))

;;- Version Control ------------------------------------------------------------

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;;- Project Management ---------------------------------------------------------

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

(add-hook 'olivetti-mode-on-hook (lambda () (olivetti-set-width 74)))

;;- Programming Modes ----------------------------------------------------------

(use-package markdown-mode
  :ensure t
  :hook ((markdown-mode . visual-line-mode)))

(use-package yaml-mode
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package racket-mode
  :ensure t)

(setopt racket-program "/Applications/Racket v8.11.1/bin/racket")

;;- LSP ------------------------------------------------------------------------

(use-package eglot
  ;; no :ensure t here because it's built-in

  ;; Configure hooks to automatically turn-on eglot for selected modes
  :hook
  (((racket-mode) . eglot))

  :custom
  (eglot-send-changes-idle-time 0.1)
  (eglot-extend-to-xref t)              ; activate Eglot in referenced non-project files

  :config
  (fset #'jsonrpc--log-event #'ignore)  ; massive perf boost---don't log every event
  ;; Sometimes you need to tell Eglot where to find the language server
  (add-to-list 'eglot-server-programs
               '(racket-mode . ("racket" "-l" "racket-langserver")))
  )
