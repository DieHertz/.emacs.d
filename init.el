
(require 'package)

(setq package-archives '(
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("elpa" . "http://tromey.com/elpa/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("org" . "http://orgmode.org/elpa/")))

;; ensure every single package installed via Package.el is loaded in ready to be customized
(package-initialize)

(add-to-list 'load-path user-emacs-directory)
(require 'dependencies)

(defconst custom-file-path (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file-path) (write-region "" nil custom-file-path))

(setq custom-file custom-file-path)
(load custom-file-path)

;; my once-and-for-all favourite theme
(require 'monokai-theme)
(load-theme 'monokai)

(set-default-font "Source Code Pro")
(set-face-attribute 'default nil :height 90)

;; handy plugin for moving entire lines up/down (like C-S-ArrowUp/ArrowDown in Sublime Text)
(require 'move-text)
(move-text-default-bindings)

(require 'indent-guide)
(indent-guide-global-mode)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-l") 'mc/edit-lines)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this)
(when mc/keymap
  (define-key mc/keymap (kbd "<return>") 'newline))

(require 'fiplr)
(global-set-key (kbd "C-x f") 'fiplr-find-file)

(require 'expand-region)
;; there be smart function to alternate between expand-region and mc/mark-next-like-this
(defun expand-or-mark-next-like-this () (interactive) (if (use-region-p)
	      (mc/mark-next-like-this 1)
	    (er/expand-region 1)))
(global-set-key (kbd "C->") 'expand-or-mark-next-like-this)

;; incremental search auto wrap
(defadvice isearch-repeat (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-repeat 'after 'isearch-no-fail)
    (ad-activate 'isearch-repeat)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-repeat 'after 'isearch-no-fail)
    (ad-activate 'isearch-repeat)))

(require 'auto-complete)
(auto-complete-mode)

(require 'ido)
(ido-mode)
(ido-everywhere)
(setq ido-enable-flex-matching t)

(setq tab-stop-list (number-sequence 4 120 4))
(setq inhibit-startup-screen t)
(menu-bar-mode nil)
(tool-bar-mode nil)
(scroll-bar-mode nil)
(global-linum-mode)
(column-number-mode)
(show-paren-mode)
(setq make-backup-files nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
