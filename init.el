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
(set-face-attribute 'default nil :height 100)

;; handy plugin for moving entire lines up/down (like C-S-ArrowUp/ArrowDown in Sublime Text)
(require 'move-text)
(move-text-default-bindings)

(require 'indent-guide)
(indent-guide-global-mode)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-l") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(when mc/keymap
  (define-key mc/keymap (kbd "<return>") 'newline))

(require 'fiplr)
(global-set-key (kbd "C-x f") 'fiplr-find-file)

(require 'ido)
(ido-mode)
(setq ido-enable-flex-matching t)

(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(global-linum-mode)
(column-number-mode)
(show-paren-mode 1)
(setq make-backup-files nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
