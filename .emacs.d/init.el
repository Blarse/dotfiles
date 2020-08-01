(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(ggtags magit swiper ivy helm nasm-mode smex expand-region org-bullets ace-window htmlize which-key try use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 4.0 :foreground "#22FF22")))))

;; (org-babel-load-file (concat (file-name-directory (or buffer-file-name load-file-name)) "README.org"))


(require 'package)

(setq package-enable-at-startup nil)
(add-to-list 'package-archives
			 '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

;; ==============
;;	Get packages
;; ==============

(require 'cc-mode)
(require 'compile)
(require 'ido)
(require 'dired)

(use-package magit
	:ensure t)

(use-package helm
	:ensure t)

(use-package ggtags
	:ensure t)

;;(use-package ivy
;;	:ensure t)

;;(use-package swiper
;;	:ensure t)

(use-package helm
	:ensure t)

;;(use-package evil-mode
;;	:ensure t)

(use-package try
	:ensure t)

(use-package which-key
	:ensure t)

(use-package htmlize
	:ensure t)

(use-package ace-window
	:ensure t)

(use-package org-bullets
	:ensure t)

(use-package expand-region
	:ensure t)

(use-package nasm-mode
	:ensure t)

;; =================
;;	Config Packages
;; =================

;; Dired
(setq dired-recursive-deletes 'top)

;; Ido-Mode
(ido-mode 1)
(icomplete-mode t)
(setq ido-everywhere t)
(setq ido-virtual-buffers t)
(setq ido-enable-flex-matching t)
(defalias 'list-buffers 'ibuffer-other-window)

;; Which Key
(which-key-mode)

;; Expand Region
(global-set-key (kbd "C-=") 'er/expand-region)

;; Ace Window
(global-set-key [remap other-window] 'ace-window)

;; ================
;;	Emacs Settings
;; ================

(setq user-full-name	"Egor Inatov"
	  user-mail-address	"mail.egor.ignatov@gmail.com")

(defun is-linux()
	(string-equal system-type "gnu/linux"))

(defun is-windows()
	(string-equal system-type "windows-nt"))

;; Start Emacs Server
(when (is-linux)
	(require 'server)
	(unless (server-running-p)
		(server-start)))

;; Stop Emacs from losing information
(setq undo-limit 20000000
	  undo-strong-limit 40000000
	  kill-ring-max 1000)

(setq auto-save-default t
	  auto-save-timeout 20
	  auto-save-interval 200)

(defvar local/backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p local/backup-directory))
		(make-directory local/backup-directory t))
(setq backup-directory-alist `(("." . ,local/backup-directory)))

(setq make-backup-files t
	  version-control t
	  kept-new-versions 8
	  kept-old-versions 4
	  delete-old-versions t
	  backup-by-copying t)

;; UI Settings
(setq frame-resize-pixelwise t)

(tooltip-mode	 0)
(tool-bar-mode	 0)
(menu-bar-mode	 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(setq ingibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)

(display-time)
(setq display-time-day-and-date t)

(size-indication-mode)

(setq display-line-numbers-type 'visual)
(setq-default display-line-numbers-width 3)
(global-display-line-numbers-mode)

(show-paren-mode t)
(setq show-paren-style 'expression)

(global-hl-line-mode 1)

(setq require-final-newline t)

(setq select-enable-clipboard t)
(setq save-interprogram-paste-before-kill t)

;; Fringe
(fringe-mode '(8 . 8))
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)
(setq visual-line-fringe-indicators '(nil right-curly-arrow))

;; Display Settings
(setq scroll-step 1)
(setq scroll-margin 6)
(setq scroll-preserve-screen-position t)


(global-visual-line-mode -1)
(setq-default word-wrap nil)
(setq truncate-lines nil)



(electric-pair-mode 1)
(electric-indent-mode -1)


;; ==================
;;	Custom Functions
;; ==================

(defun yank-push ()
	(interactive)
	(yank-pop -1))

(defun format-current-buffer()
	(indent-region (point-min) (point-max)))

(defun tabify-current-buffer()
	(if (not (not indent-tabs-mode))
			(tabify (point-min) (point-max)))
	nil)

;; =======
;;	Hooks
;; =======

(add-hook 'before-save-hook 'format-current-buffer)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'tabify-current-buffer)

;; =====================
;;	Global Map Bindings
;; =====================

(global-unset-key [mouse-2])
(define-key global-map (kbd "M-Y") 'yank-push)

(define-key global-map (kbd "C-t") 'ace-window)
(define-key org-mode-map (kbd "C-t") 'ace-window)

(define-key global-map (kbd "M-b") 'ido-switch-buffer)
(define-key global-map (kbd "M-B") 'ido-switch-buffer-other-window)
(define-key global-map (kbd "M-f") 'ido-find-file)
(define-key global-map (kbd "M-F") 'ido-find-file-other-window)
(define-key global-map (kbd "M-s") 'save-buffer)
(define-key global-map (kbd "M-k") 'ido-kill-buffer)


;; =============
;;	Development
;; =============

(setq font-lock-maximum-decoration t)
(setq-default c-default-style "linux"
			  indent-tabs-mode t
			  c-basic-offset 4
			  tab-width 4
			  standart-indent 4
			  lisp-body-indent 4)


;; ================
;;	Faces Settings
;; ================
(setq solarized-base03	"#002b36"
	  solarized-base02	"#073642"
	  solarized-base01	"#586e75"
	  solarized-base00	"#657b83"
	  solarized-base0	"#839496"
	  solarized-base1	"#93a1a1"
	  solarized-base2	"#eee8d5"
	  solarized-base3	"#fdf6e3"
	  solarized-yellow	"#b58900"
	  solarized-orange	"#cb4b16"
	  solarized-red		"#dc322f"
	  solarized-magenta "#d33682"
	  solarized-violet	"#6c71c4"
	  solarized-blue	"#268bd2"
	  solarized-cyan	"#2aa198"
	  solarized-green	"#859900")

(add-to-list 'default-frame-alist '(font . "JetBrainsMono"))
(set-face-attribute 'default t :font "JetBrainsMono")


(set-background-color solarized-base03)
(set-foreground-color solarized-base0)
(set-face-attribute hl-line-face nil :background solarized-base02)
(set-face-attribute 'region nil :background solarized-base01)
(set-face-attribute 'highlight nil :background solarized-yellow)

(set-face-attribute 'line-number-current-line nil :foreground solarized-base1)
(set-face-attribute 'line-number nil :foreground solarized-base01)

(set-face-attribute font-lock-comment-face nil :foreground solarized-base01)
(set-face-attribute font-lock-doc-face nil :foreground solarized-base01)
(set-face-attribute font-lock-builtin-face nil :foreground solarized-cyan)
(set-face-attribute font-lock-reference-face nil :foreground solarized-orange)

(set-face-attribute font-lock-string-face nil :foreground solarized-green)
(set-face-attribute font-lock-keyword-face nil :foreground solarized-magenta)
(set-face-attribute font-lock-function-name-face nil :foreground solarized-blue)
(set-face-attribute font-lock-variable-name-face nil :foreground solarized-red)
(set-face-attribute font-lock-constant-face nil :foreground solarized-green)
(set-face-attribute font-lock-type-face nil :foreground solarized-violet)


;; ===========
;;	Encodings
;; ===========

(set-language-environment 'UTF-8)

(when (is-linux)
	(progn
		(setq default-buffer-file-coding-system 'utf-8)
		(setq-default coding-system-for-read 'utf-8)
		(setq file-name-coding-system 'utf-8)
		(set-selection-coding-system 'utf-8)
		(set-keyboard-coding-system 'utf-8)
		(set-terminal-coding-system 'utf-8)
		(prefer-coding-system 'utf-8)))

(when (is-windows)
	(progn
		(prefer-coding-system 'windows-1251)
		(set-terminal-coding-system 'windows-1251)
		(set-keyboard-coding-system 'windows-1251-unix)
		(set-selection-coding-system 'windows-1251)
		(setq file-name-coding-system 'windows-1251)
		(setq-default coding-system-for-read 'windows-1251)
		(setq default-buffer-file-coding-system 'windows-1251)))
