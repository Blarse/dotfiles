
;; packages

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(setq use-package-always-ensure t)
(straight-use-package 'use-package)


;; help packages
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-varibale-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key)
  )


;; counsel ivy swiper
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 ("C-c c" . counsel-compile)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)
	 :map counsel-find-file-map
	 ("C-l" . 'counsel-up-directory)
	 :map ivy-minibuffer-map
	 ("C-l" . 'counsel-up-directory))
  :config
  (ivy-mode 1)
  )

(use-package ivy-prescient
  :init (ivy-prescient-mode))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; projectile
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-switch-project-action #'projectile-dired)
  )

(setq projectile-project-search-path
      '(("~/data/dev/" . 2)
	("~/alt/gears/" . 1)
	("~/alt/fuzzing/" . 1)
	("~/data/projects/" . 1))
      )

(projectile-discover-projects-in-search-path)

;; magit
(use-package magit
  :bind (:map magit-mode-map
	      ("M-<return>" . magit-diff-visit-file-other-window)
	      ("C-M-<return>" . magit-diff-visit-worktree-file-other-window))
  :config
  (magit-add-section-hook
   'magit-status-sections-hook
   'magit-insert-recent-commits
   'magit-insert-staged-changes
   t)
  (magit-add-section-hook
   'magit-status-sections-hook
   'magit-insert-unpushed-to-upstream
   'magit-insert-unpushed-to-upstream-or-recent
   'replace)
  )

;;(use-package forge)

;; dired

(use-package dired
  :straight nil
  :ensure nil
  :bind (:map dired-mode-map
	      ("b" . dired-up-directory)
	      ("M-<return>" . dired-find-file-other-window))
  :commands (dired dired-jump)
  :custom ((dired-listing-switches "-al --group-directories-first")))

;; (use-package dired-single
;;   :bind (:map dired-mode-map
;; 	      ("")))

(use-package dired-x
  :straight nil
  :ensure nil
  :after dired)



(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))
  
  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))


(global-set-key [remap move-beginning-of-line]
		'smarter-move-beginning-of-line)




;; appearance

;; disable GUI components
(tooltip-mode	 0)
(tool-bar-mode	 0)
(menu-bar-mode	 0)
(scroll-bar-mode 0)
(setq ring-bell-function 'ignore)

(setq use-dialog-box nil)
(fset 'yes-or-no-p 'y-or-n-p)

;; show line numbers
(setq display-line-numbers-type 't)
(setq-default display-line-numbers-width 2)
(global-display-line-numbers-mode)

;; cursor
(blink-cursor-mode 0)
(set-cursor-color "green1")

;; font
					;(set-face-attribute 'default nil :font "" :height 90)

;; mod line
(size-indication-mode)
;;(display-time)
;;(setq display-time-day-and-date nil)

;; parens pairing
(electric-pair-mode 'toggle)
(setq electric-pair-preserve-balance nil
      electric-pair-delete-adjacent-pairs t
      electric-pair-open-newline-between-pairs nil
      electric-pair-skip-whitespace 'chomp)


;; backups(file~) and auto-save(#file#)
(defvar local/backup-directory (concat user-emacs-directory "backups/"))
(if (not (file-exists-p local/backup-directory))
    (make-directory local/backup-directory t))
(setq backup-directory-alist `((".*" . ,local/backup-directory)))
(setq make-backup-files t
      version-control t
      kept-new-versions 8
      kept-old-versions 4
      delete-old-versions t
      backup-by-copying t)

(defvar local/autosave-directory (concat user-emacs-directory "autosaves/"))
(if (not (file-exists-p local/autosave-directory))
    (make-directory local/autosave-directory t))
(setq auto-save-file-name-transforms `((".*" ,local/autosave-directory t)))
(setq auto-save-default t
      auto-save-timeout 20
      auto-save-interval 200)



;; startup
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "
#+BEGIN_SRC C
  
#+END_SRC

#+BEGIN_SRC python
    
#+END_SRC
")


(use-package persistent-scratch)
(persistent-scratch-setup-default)
(with-current-buffer "*scratch*" (persistent-scratch-mode))


(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map (kbd "C-t") 'other-window)
            ))
(global-set-key (kbd "C-t") 'other-window)



;; depelopment

;; lsp
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (python-mode . lsp)
  (c-mode . lsp)
  :config
  (lsp-enable-which-key-integration t))

;;(use-package lsp-ui
;;  :hook (lsp-mode . lsp-ui-mode))

(use-package lsp-ivy)

(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
	      ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))


;;(use-package dap)


;; c
(setq fill-column 109
      tab-width 4
      c-basic-offset 4
      indent-tabs-mode nil
      fill-column 80
      )

;; rust
(use-package rust-mode)

;; python
(use-package python-black)

;; yaml
(use-package yaml-mode)

;; docker
(use-package dockerfile-mode)
(put 'upcase-region 'disabled nil)


(use-package org)
;; org-roam
(use-package org-roam)

