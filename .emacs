;; get rid of menu bar

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

(global-set-key (kbd "<end>") 'end-of-line)

;;(global-set-key (kbd "C- <deletechar>") 'kill-word)

;; remove extra white space. This works for all modes.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Show column numbers
(column-number-mode)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(add-to-list 'load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20160710.1544")
(add-to-list 'load-path "~/.emacs.d/elpa/wdl-mode-20180831.1946")
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/go")

;; C/C++ modes
(setq c-default-style "stroustrup")
(setq c-basic-offset 4)

(defun my-c++-mode-hook ()
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)


;; auto-complete mode
(require 'auto-complete-config)
(ac-config-default)

;; Markdown mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Javascript
(setq js-indent-level 2)
;;(setq js-indent-level 2)

;; Capnp mode
(require 'capnp-mode)
(add-to-list 'auto-mode-alist '("\\.capnp\\'" . capnp-mode))

;; scala
(setq scala-indent:step 2)
(setq scala-indent:align-parameters t)
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))

;; go mode
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; wdl mode
(autoload 'wdl-mode "wdl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.wdl\\'" . wdl-mode))

;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (command-log-mode typescript-mode ## yaml-mode xcscope scala-mode sbt-mode markdown-mode cl-format auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
