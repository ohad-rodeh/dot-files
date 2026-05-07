(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/xcscope.el")


;; auto-complete mode
(require 'auto-complete-config)
(ac-config-default)

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
(global-set-key [(control ?c) ?c] 'compile)
(global-set-key [(control ?x) ?§] 'next-error)

(global-set-key (kbd "<end>") 'end-of-line)

;;(global-set-key (kbd "C- <deletechar>") 'kill-word)

;; remove extra white space. This works for all modes.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Show column numbers
(column-number-mode)

;; C/C++ modes
(setq c-default-style "stroustrup")
(setq c-basic-offset 4)

;; setup for cscope
(require 'xcscope)
(cscope-setup)

(defun my-c++-mode-hook ()
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; Markdown mode
;(autoload 'markdown-mode "markdown-mode"
;  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Javascript
(setq js-indent-level 2)
;;(setq js-indent-level 2)

;; wdl mode
(autoload 'wdl-mode "wdl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.wdl\\'" . wdl-mode))

;; enable auto-complete in rust mode
(add-to-list 'ac-modes 'rust-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(auto-complete markdown-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
