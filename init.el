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

;**************************************************************************/
;************************ Clojure Setting  ********************************/
;**************************************************************************/

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-ubiquitous

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; git integration
    magit))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


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

;**************************************************************************/
;************************ For web programming  ****************************/
;**************************************************************************/

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;**************************************************************************/
;************************ For Python programming  ************************/
;**************************************************************************/
(require 'python-mode)

; indent setting
(add-hook 'python-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq index-level 4)
             (setq python-indent 4)
             (setq tab-width 4)))

; Code Jumping : ctags
(setq tags-table-list '("~/python-cipher-hack"))
;(require 'helm-etags+)


; auto-complete
;(require 'auto-complete-config)
;(ac-config-default)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)    ; optional
(setq ac-use-menu-map t) ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)

; function list
(imenu-list-minor-mode)
(global-set-key (kbd "C-'") #'imenu-list-minor-mode) ;; toggle


;**************************************************************************/
;***************************** For C programming  ************************/
;**************************************************************************/
; Basic offset
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode t)

; default style
(setq c-default-style "k&r")


; Indentation
;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent) ;doesn't work 
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))


; Auto-complete parenthesis


;**************************************************************************/
;************************* For Java programming  **************************/
;**************************************************************************/

; 만약 이클립스 등으로 작성한 코드라면 기본 들여쓰기 넓이가 8로 되어있을 텐데,
; 그런 경우를 대비해서  아래와 같이 설정한다.
(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 4 ; tab 키를 눌렀을 때 4 스페이스 만큼의 넓이를 띄운다.
                                  tab-width 4 ; 소스파일에서 탭 캐릭터가 발견되면 4 스페이스 만큼의 넓이를 띄워서 표시한다.
                                  indent-tabs-mode t ; 탭을 눌렀을 때 스페이스 캐릭터가 아니라 탭 캐릭터가 저장되도록 한다.
                                 )))

; Jenkins
(setq jenkins-api-token "a00407be4aa2ac5d31b25e3f7b3f50dd")
(setq jenkins-url "http://localhost:8080/jenkins/")
(setq jenkins-username "jwmoon")
(setq jenkins-colwidth-name 35)


; Highlighting Java .properties Files.
;; (add-hook 'conf-javaprop-mode-hook
;; 		  '(lambda () (conf-quote-normal nil))) ; doesn't work


;**************************************************************************/
; *********************** For Perl Programming ****************************/
;**************************************************************************/
(fset 'perl-mode 'cperl-mode)
(setq cperl-indent-level 4)


;**************************************************************************/
;************************* For PHP programming  ***************************/
;**************************************************************************/
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;***************************************************************************/
;************************* For Ruby programming  ***************************/
;**************************************************************************/
(add-to-list 'auto-mode-alist
			 '("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
			 '("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;***************************************************************************/
;********************* For Common Lisp programming  ************************/
;**************************************************************************/
;(eval-when-compile (require 'cl))

; SLIME setting

;; Set your lisp system and, optionally, some contribs
;(setq inferior-lisp-program "/opt/sbcl/bin/sbcl")
;(setq slime-contribs '(slime-fancy))


;; Setup load-path, autoloads and your lisp system
;(add-to-list 'load-path "~/.emacs.d/elpa/slime-20161109.640")
;(require 'slime-autoloads)
;; Also setup the slime-fancy contrib
;(add-to-list 'slime-contribs 'slime-fancy)


; 참고: https://gist.github.com/jteneycke/7947353
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/bin/sbcl")



; 이 아래부터는 이맥스 공통세팅
;************************ For Emacs-Helm  *********************************/
;**************************************************************************/

;(add-to-list 'load-path "~/.emacs.d/helm")
;(add-to-list 'load-path "~/.emacs.d/emacs-async")
(require 'helm)
(require 'helm-config)

; Extended config

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we 
;; cannot change 'helm-command-prefix-key' once 'helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action ); rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action) ;list actions using C-z


(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))


(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))


(setq helm-split-window-in-side-p t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp t ; search for library in 'require' and 'declare-funciton' sexp.
      helm-scroll-amount 8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-M-x-fuzzy-match t ; optional fuzzy matching for helm-M-x
      helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t
)

;(helm-mode 1)  ; This line may conflict with clojure setting 


;; For Helm-Projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
;(setq projectile-indexing-method 'alien) ; speed up settting just for windows emacs user

;**************************************************************************/
;************************ Custom Setting  *********************************/
;**************************************************************************/


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
	("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "dark gray" :slant italic))))
 '(hl-line ((t (:background "cyan4")))))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setenv "PATH"
        (concat '"/home/jwmoon/.local/bin:" (getenv "PATH")))

; ---------------------------------------------------------------------------
; 모든 파일에 대해서 자동 들여쓰기 설정 
(define-key global-map (kbd "RET") 'newline-and-indent)


;***************************************************************************/
;********************* For Common Setting  ************************/
;**************************************************************************/
;; smart mode-line
(sml/setup)

;; nyan-mode
(setq-default nyan-animate-nyancat t)
(setq-default nyan-wavy-trail t)
(nyan-mode)


;; Flycheck : 문법체크
; enable flycheck all the time
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Yasnippet
(require 'yasnippet)

; add yasnippet snippets
; 이 설정으로 인해 기본 메이저 모드에서 사용할 수 있는 스니펫들은 사용할 수 없어진다.
; 따라서, 주석처리하거나 아니면 내가 정의한 스니펫과 병용해서 사용할 수 있는 방법을 더 찾아봐야 할 듯...
;; (setq yas-snippet-dirs
;; 	  '("~/.emacs.d/snippets/yasnippet-snippets"
;; 		"~/.emacs.d/snippets/customization"
;; 		))

(yas-global-mode 1)


; Shift + Enter short cut for move to new line
;; (defun end-of-line-and-indented-new-line ()
;;   (interactive)
;;   (end-of-line)
;;   (newline-and-indent))




