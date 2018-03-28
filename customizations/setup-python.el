;**************************************************************************/
;************************ For Python programming  ************************/
;**************************************************************************/
(require 'python-mode)

; python indent setting
(add-hook 'python-mode-hook
          '(lambda ()
;             (setq indent-tabs-mode nil)
             (setq index-level 4)
             (setq python-indent 4)
             (setq tab-width 4)))


; auto-complete

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq ac-use-menu-map t) ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)
