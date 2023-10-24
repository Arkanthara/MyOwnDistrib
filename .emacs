(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(dracula))
 '(custom-safe-themes
   '("75fb82e748f32de807b3f9e8c72de801fdaeeb73c791f405d8f73711d0710856" "f25f174e4e3dbccfcb468b8123454b3c61ba94a7ae0a870905141b050ad94b8f" default))
 '(org-babel-load-languages '((C . t)))
 '(package-selected-packages
   '(color-identifiers-mode catppuccin-theme markdown-mode ein dracula-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight semi-bold :height 128 :width normal)))))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(set-frame-parameter nil 'alpha-background 70)

(add-to-list 'default-frame-alist '(alpha-background . 70))

(setq ein:output-area-inlined-images t)

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(setq-default c-basic-offset 8
  tab-width 8
  indent-tabs-mode nil)

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(org-babel-do-load-languages 'org-babel-load-languages
    '(
        (shell . t)
    )
)

(setq org-cycle-separator-lines -1)

;; fontify code in code blocks
;; (setq org-src-fontify-natively t)

;; Often Markdown gets added to a LaTeX project, too. So I eventually
;; need a LaTeX export.
;; (defun as/markdown-region-to-latex (start end)
;;   (interactive "r")
;;   (goto-char start)
;;   (save-restriction
;;     (let (in-list skip-to)
;;       (narrow-to-region start end)
;;       (while (re-search-forward "\\*\\|\n\\|\\`" nil t)
;; 	(goto-char (match-beginning 0))
;; 	(if (= (point) (match-end 0))
;; 	    (setq skip-to (1+ (point)))
;; 	  (setq skip-to (match-end 0)))
;; 	(cond ((looking-at "\\*\\*\\b\\([^*]*?\\)\\b\\*\\*")
;; 	       (replace-match "\\\\textbf{\\1}"))
;; 	      ((looking-at "\\*\\b\\([^*]*?\\)\\b\\*")
;; 	       (replace-match "\\\\textit{\\1}"))
;; 	      ((looking-at "^# \\(.*\\)")
;; 	       (replace-match "\\\\section{\\1}"))
;; 	      ((looking-at "^## \\(.*\\)")
;; 	       (replace-match "\\\\subsection{\\1}"))
;; 	      ((looking-at "^### \\(.*\\)")
;; 	       (replace-match "\\\\subsubsection{\\1}"))
;; 	      ((looking-at "^\\* ")
;; 	       (replace-match (if in-list "\\\\item " "\\\\begin{itemize}\n\\\\item "))
;; 	       (setq in-list "itemize"))
;; 	      ((looking-at "^[0-9]+\\. ")
;; 	       (replace-match (if in-list "\\\\item " "\\\\begin{enumerate}\n\\\\item "))
;; 	       (setq in-list "enumerate"))
;; 	      ((and in-list (looking-at "^"))
;; 	       (replace-match (format "\\\\end{%s}\n" in-list))
;; 	       (setq in-list nil))
;; 	      (t (goto-char skip-to)))))))
