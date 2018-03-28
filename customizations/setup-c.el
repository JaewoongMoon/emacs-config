;**************************************************************************/
;************************ For C/C++ programming  ****************************/
;**************************************************************************/
;1. 편집 관련 설정
; 1) Indentation : C 모드의 들여쓰기는 스페이스 네 개로 한다.
(setq c-basic-offset 4)

; 2) Enter 키를 쳤을 때 indent가 되도록
(defun my-make-CR-do-indent ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-make-CR-do-indent)

; 3) 기본 스타일은 K&R 로 한다. 
(setq c-default-style "k&r")

; 4) 괄호 등을 닫았을 때 자동으로 인라인 처리가 되도록 auto-newline mode를 마이너 모드로 설정한다.
; 참고로 auto-newline mode가 켜지면 electric-mode 도 함께 켜진다.
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

; 5) 자동괄호 완성
;; autopair-mode 의 버그로 인해 제대로 작동하지 않는다. 
;; (add-hook 'c-mode-common-hook #'(lambda () (autopair-mode)))

;; (defun autopair-close-block (arg)
;;   (interactive "P")
;;   (cond
;;    (mark-active
;;     (autopair-close arg))
;;    ((not (looking-back "^[[:space:]]*"))
;;     (newline-and-indent)
;;     (autopair-close arg))
;;    (t
;;     (autopair-close arg))))

;; (add-hook 'c-mode-common-hook
;;               '(lambda ()
;;                  (local-set-key "(" 'autopair-insert)
;;                  (local-set-key ")" 'autopair-insert)
;;                  (local-set-key "{" 'autopair-insert)
;;                  (local-set-key "}" 'autopair-close-block)))



;; add c++
;; (smart-tabs-add-language-support c++ c++-mode-hook
;;   ((c-indent-line . c-basic-offset)
;;    (c-indent-region . c-basic-offset)))


;2. 빌드 관련 설정
; 컴파일 단축키
;Symbol's value as variable is void: c-mode-map
(add-hook 'c-mode-common-hook
          (lambda ()
            (define-key c-mode-base-map (kbd "C-c c") 'compile)
            (define-key c-mode-base-map (kbd "C-c d") 'gdb)
            ))


;3. 디버깅 관련 설정



; 참고 정보

; 공식 CC-mode 매뉴얼 페이지 
;http://cc-mode.sourceforge.net/html-manual/index.html

; github.io 의 C/C++ 개발환경 이야기. 비교적 최신버전이니 이 곳을 잘 참고하자.
;https://tuhdo.github.io/c-ide.html

