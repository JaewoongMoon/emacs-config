;**************************************************************************/
;************************ For Python programming  ************************/
;**************************************************************************/
(require 'python-mode)

; editing
(add-hook 'python-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq index-level 4)
             (setq python-indent 4)
             (setq tab-width 4)
			 (py-toggle-shell "python3") ; python3 를 기본 인터프리터로 설정
			 ))

;; code-assist
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq ac-use-menu-map t) ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)


; execution & debugging
;; 버퍼 실행(C-c C-c) 시 화면분할은 양옆으로(horizontally) 나눠지도록
(setq-default py-split-windows-on-execute-function 'split-window-horizontally)


