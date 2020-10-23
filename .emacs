(setq lexical-binding t)

(setq gc-cons-threshold 100000000)

(setq use-package-always-ensure t)

;; see https://nixos.org/nixos/manual/index.html#module-services-emacs

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; optional. makes unpure package unavailable
					;(setq package-archives nil)
					;(setq package-enable-at-startup nil)
(package-initialize)

(setq
 ;; No need to see GNU agitprop.
 inhibit-startup-screen t
 ;; No need to remind me what a scratch buffer is.
 initial-scratch-message nil
 ;; Double-spaces after periods is morally wrong.
 sentence-end-double-space nil
 ;; Never ding at me, ever.
 ring-bell-function 'ignore
 ;; Prompts should go in the minibuffer, not in a GUI.
 use-dialog-box nil
 ;; Fix undo in commands affecting the mark.
 mark-even-if-inactive nil
 ;; Let C-k delete the whole line.
 kill-whole-line t
 ;; search should be case-sensitive by default
 case-fold-search nil
 )

(defalias 'yes-or-no-p 'y-or-n-p) ; Accept 'y' in lieu of 'yes'.

(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(delete-selection-mode t)
(global-display-line-numbers-mode t)
(column-number-mode)

;; email
(require 'notmuch)
(setq user-full-name "Gunnar Þór Magnússon")
(setq user-mail-address "gunnar@magnusson.io")
(setq mail-user-agent 'message-user-agent)
(setq mail-specify-envelope-from t)
(setq sendmail-program "msmtp"
      mail-specify-envelope-from t
      mail-envelope-from 'header
      message-sendmail-envelope-from 'header)

(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

(require 'hl-line)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'text-mode-hook #'hl-line-mode)
(set-face-attribute 'hl-line nil :background "gray21")

(require 'use-package)

;; tramp via ssh
(setq tramp-default-method "ssh")

;; color theme
(require 'solarized)
(load-theme 'solarized-dark t)

;; syntax highlight and autoformat
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'format-all-mode)

;; paredit for all the lisp I write
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)

;; graphviz
(use-package graphviz-dot-mode
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4))
					;(use-package company-graphviz-dot)

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(setq require-final-newline t)

(use-package undo-tree
  :diminish
  :bind (("C-c _" . undo-tree-visualize))
  :config
  (global-undo-tree-mode +1)
  (unbind-key "M-_" undo-tree-map))

(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

(setq read-process-output-max (* 1024 1024)) ; 1mb

;; visual line mode
(add-hook 'visual-line-mode-hook #'visual-fill-column-mode)
(setq visual-fill-column-center-text t)
(set-fill-column 80)
(add-hook 'org-mode-hook 'visual-line-mode)

;; company mode
(add-hook 'after-init-hook 'global-company-mode)

;; access user path from emacs
(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(use-package magit
  :bind (("C-c g" . #'magit-status)))

;; helm
(require 'helm-config)
(require 'helm-projectile)
(helm-projectile-on)

;; projectile
(use-package projectile
  :commands projectile-mode
  :bind-keymap* (("C-c p" . projectile-command-map)
                 ("s-p" . projectile-command-map))
  :bind (("C-c C-f" . projectile-find-file))
  :preface
					;(autoload 'projectile-project-vcs "projectile")
					;(autoload 'projectile-project-root "projectile")
					;(autoload 'easy-menu-define "easymenu" "" nil 'macro)
  :demand
  :config
  (projectile-mode))

;; direnv
(use-package direnv
  :config (direnv-mode))

;; ocaml
(autoload 'merlin-mode "merlin" "Merlin mode" t)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(add-hook 'caml-mode-hook 'merlin-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "13a8eaddb003fd0d561096e11e1a91b029d3c9d64554f8e897b2513dbf14b277" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" default)))
 '(global-display-line-numbers-mode t)
 '(package-selected-packages (quote (libgit company-graphviz-dot neuron-mode)))
 '(send-mail-function (quote sendmail-send-it))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 143 :width normal)))))
