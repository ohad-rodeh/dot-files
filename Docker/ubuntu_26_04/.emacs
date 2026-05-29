;; setting up packages ---------------
;;(setq package-check-signature nil) ; Temporary workaround
;; OR a slightly more specific version:
;; (setq package-check-signature 'allow-unsigned)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Optional: also add the non-GNU ELPA archive
;;(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)

(package-initialize)

;; -----------------------------------

(use-package eglot
  :ensure nil ;; It's built-in to Emacs 29+
  :hook
  (c-mode . eglot-ensure)
  (c++-mode . eglot-ensure))

(setq eglot-stay-out-of '(flymake))
(setq eglot-format-on-save nil)
(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (setq-local eglot-format-on-save nil)
            (setq-local eglot-ontype-format nil)))
(setq eglot-ignored-server-capabilities '(:documentFormattingProvider
                                          :documentRangeFormattingProvider
                                          :onTypeFormattingProvider))

(use-package company
  :ensure t
  :init
  (global-company-mode)
  :config
  (setq company-idle-delay 0.1         ;; Delay until popup appears
        company-minimum-prefix-length 2 ;; Show after 2 characters
        company-selection-wrap-around t ;; Loop back to top of list
        company-tooltip-align-annotations t)

  ;; Use C-n and C-p to navigate the completion menu
  (with-eval-after-load 'company
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip ((t (:background "white" :foreground "black"))))
 '(company-tooltip-selection ((t (:background "blue" :foreground "white")))))


;; get rid of menu bar
(menu-bar-mode 0)

;; tabs to spaces
(setq-default indent-tabs-mode nil)

;; delete backward char with ctrl-h
(global-set-key [(control ?h)] 'delete-backward-char)

;; copy the ring buffer, but don't kill
(global-set-key [(?∑)] 'kill-ring-save)

;; erase word backwards
(global-set-key [(?∂)] 'kill-word)

;; shortcut for goto-line
(global-set-key [(meta ?g)] 'goto-line)

;; shortcut make
(global-set-key (kbd "<f9>") 'compile)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key [(control ?x) ?§] 'next-error)

(global-set-key (kbd "<end>") 'end-of-line)

;;(global-set-key (kbd "C- <deletechar>") 'kill-word)

;; remove extra white space. This works for all modes.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Show column numbers
(column-number-mode)

(add-to-list 'load-path "~/.emacs.d/elpa")

;; C/C++ modes
(setq c-default-style "stroustrup")
(setq c-basic-offset 4)

(defun my-c++-mode-hook ()
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)


;; Markdown mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Javascript
(setq js-indent-level 2)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(auto-complete cl-format command-log-mode company
                   gnu-elpa-keyring-update markdown-mode sbt-mode
                   scala-mode typescript-mode xcscope yaml-mode)))
