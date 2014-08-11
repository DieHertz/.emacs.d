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

;; handy plugin for moving entire lines up/down (like C-S-ArrowUp/ArrowDown in Sublime Text)
(require 'move-text)
(move-text-default-bindings)

(require 'ido)
(ido-mode)
(setq ido-enable-flex-match)

(menu-bar-mode -1)
(tool-bar-mode -1)
(global-linum-mode)
(column-number-mode)
(show-paren-mode 1)
(setq make-backup-files nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
