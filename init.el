;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("marmalade" . "http://marmalade-repo.org/packages/")
;;                          ("melpa" . "http://melpa-stable.milkbox.net/packages/")))

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")

;; Langauage-specific
(load "setup-clojure.el")
(load "setup-js.el")
(load "setup-c.el")
(load "setup-python.el")
(load "setup-helm.el")
(load "setup-web.el")
(load "setup-php.el")


;**************************************************************************/
;************************ Custom Variables  *******************************/
;**************************************************************************/
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(org-startup-folded nil)
 '(tab-width 4))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "DeepPink4")))))



(let ((path (shell-command-to-string ". ~/.bash_profile; echo -n $PYTHONPATH")))
  (setenv "PYTHONPATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))


(let ((path (shell-command-to-string ". ~/.bash_profile; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))


;**************************************************************************/
;************************ Common Setting  *********************************/
;**************************************************************************/

; nyan-mode 
(setq-default nyan-animate-nyancat t)
;(setq-default nyan-wavy-trail t)
(nyan-mode)


; beautiful status bar 
(sml/setup) ; smart-mode-line ; auto recommended


; Flycheck
; enable flycheck
;(add-hook 'after-init-hook #'global-flycheck-mode)

;; Yasnippet
(require 'yasnippet)


; add yasnippet snippets
(setq yas-snippet-dirs
	  '("~/.emacs.d/snippets/yasnippet-snippets"
		"~/.emacs.d/snippets/customization"
		))

(yas-global-mode 1)


; 들여쓰기 공통 세팅

(setq-default indent-tabs-mode nil)
(smart-tabs-insinuate 'python)
(define-key global-map (kbd "RET") 'newline-and-indent)


; 자동 괄호 완성 (Auto-pair)
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers


;; encoding setting
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

  
;; (i-menu-list)  
;(imenu-list-minor-mode)
(global-set-key (kbd "C-'") #'imenu-list) ;; toggle


;; mysql
(setq sql-mysql-program "/usr/local/mysql/bin/mysqld")
(setq sql-user "root")
(setq sql-password "")
(setq sql-server "localhost:3307")

(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/local/bin/sbcl")



(defun set-alpha (alpha-num)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons alpha-num '(90))))


; Org-Mode
(add-hook 'org-mode-hook 'toggle-truncate-lines)



; install el-get
;; So the idea is that you copy/paste this code into your *scratch* buffer,
;; hit C-j, and you have a working el-get.
;; (url-retrieve
;;  "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el"
;;  (lambda (s)
;;    (goto-char (point-max))
;;    (eval-print-last-sexp)))
(require 'el-get)



; highlight-numbers
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

; highlight-symbol
(require 'highlight-symbol)

(highlight-symbol-mode)

(add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
(add-hook 'org-mode-hook (lambda () (highlight-symbol-mode)))

(setq highlight-symbol-idle-delay 0.2
      highlight-symbol-on-navigation-p t)

(global-set-key [(control shift mouse-1)]
                (lambda (event)
                  (interactive "e")
                  (goto-char (posn-point (event-start event)))
                  (highlight-symbol-at-point)))

(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)


;; A quick major mode help with discover-my-major
(global-unset-key (kbd "C-h h"))        ; original "C-h h" displays "hello world" in different languages
(define-key 'help-command (kbd "h m") 'discover-my-major)



