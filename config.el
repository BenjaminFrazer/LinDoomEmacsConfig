
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ben Frazer"
      user-mail-address "benjamin.frazer.1997@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(doom/set-frame-opacity 95)
(setq doom-font (font-spec :family "Source Code Pro" :size 16 :weight 'semi-light)
        doom-variable-pitch-font (font-spec :family "Ubuntu") ; inherits `doom-font''s :size
        doom-unicode-font (font-spec :family "JetBrainsMono Nerd Font" :size 11)
        doom-unicode-font (font-spec :family "Ubuntu" :size 12))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!


;;#################### org roam #########################################################
(setq org-directory "~/notes/")
(setq org-roam-directory (file-truename "~/notes/"))
;;The file-truename function is only necessary when you
;; use symbolic links inside org-roam-directory: Org-roam
;; does not resolve symbolic links. One can however instruct
;; Emacs to always resolve symlinks, at a performance cost:
(setq find-file-visit-truename t)

(use-package! org-roam-bibtex
  :after org-roam
  :config
  (require 'org-ref)) ; optional: if using Org-ref v2 or v3 citation links

(autoload 'ivy-bibtex "ivy-bibtex" "" t)
;; ivy-bibtex requires ivy's `ivy--regex-ignore-order` regex builder, which
;; ignores the order of regexp tokens when searching for matching candidates.
;; Add something like this to your init file:
(setq ivy-re-builders-alist
      '((ivy-bibtex . ivy--regex-ignore-order)
        (t . ivy--regex-plus)))

;; ############################# ivy ###################################################
(setq ivy-sort-max-size 16000)
(setq prescient-sort-full-matches-first t)
(setq prescient-aggressive-file-save t)


;; this allows you to wrap lines for variable pitch fonts
;; (add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'mixed-pitch-mode)
(add-hook 'org-mode-hook 'org-fragtog-mode) ;; in config.el
(add-hook 'org-mode-hook 'org-babel-ansi-colors-mode) ;; in config.el

;; This determines the style of line numbers in effect. If set to `nil', line
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5 :weight semi-bold))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.3 :weight semi-bold))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.2 :weight semi-bold))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.0 :weight semi-bold))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)
;; (set-face-attribute 'default nil :height 140)
(after! flycheck
(setq! org-image-actual-width 400))
(setq org-ellipsis " v")
(setq org-cycle-separator-lines 3) ;; stops the ellipsis miss-displaying
(setq org-latex-image-default-width "0.8\\textwidth")
(setq org-latex-default-figure-position "H")
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type t)

;; sets the projectile search path
(setq
projectile-project-search-path '("~/Nextcloud3/GuDocs/NoteBook/" "C:/Users/b0628/Documents/Notebooks/Emacs/Admin/")
)
(setq projectile-sort-order 'recently-active)
(setq projectile-globally-ignored-files '(".*\\.tex\\..*")
      )

(setq display-line-numbers-type nil)
;; (setq display-line-numbers-type 'relative)


(setq org-link-file-path-type 'relative)

;; ################ file template ########################
(set-file-template! "/*\\.org$" :trigger "__default.org" :mode 'org-mode)

(use-package! org-ref
        :after org
        :init
        (setq
        bibtex-completion-bibliography '("~/bibtex/My-Library.bib")
        bibtex-completion-library-path '("/home/benjaminf/Literature/")
        bibtex-completion-notes-path "~/Dropbox/emacs/bibliography/notes/"
        bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"

        org-ref-insert-cite-key "SPC i c"
        org-latex-prefer-user-labels t

        bibtex-completion-additional-search-fields '(keywords)
        bibtex-completion-pdf-field "file"
        bibtex-completion-display-formats
        '((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
                (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
                (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
                (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
                (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
        bibtex-completion-pdf-open-function
        (lambda (fpath)
          (call-process "open" nil 0 nil fpath))
        ))
;;########################org download################################

(require 'org-download)

;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)
(setq org-download-screenshot-method "flameshot gui --raw > %s")
;;#################C++/Arduino############################


;; edit ino files with adruino mode.
(add-to-list 'auto-mode-alist '("\\.ino$" . cpp-mode))

;; Enable irony for all c++ files, and platformio-mode only
;; when needed (platformio.ini present in project root).
(add-hook 'c++-mode-hook (lambda ()
                        ;;(irony-mode)
                        ;;(irony-eldoc)
                        (platformio-conditionally-enable)))

(setq org-ditaa-jar-path "C:/Users/b0628/ditaa")
(require 'yasnippet)
;;(yas/global-mode 1)
;;(add-to-list 'yas-snippet-dirs "C:/Users/b0628/.doom.d/snippets/org-mode")
(define-key yas-minor-mode-map [(tab)] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

;;####################org mode ###########################################
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)) ; this line activates ditaa
 '((maxima . t)) ; this line activates maxima
 '((asymptote. t)) ; this line activates maxima
 '((jupyter . t))
 )

(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))

(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 2)
;org bullets related
(setq org-superstar-headline-bullets-list '(" " " " "◉" "○"))
;(require 'org-bullets)
;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


(add-hook 'dired-mode-hook 'dired-hide-details-mode)


(add-to-list 'load-path "/usr/share/emacs/site-lisp/maxima/")
(autoload 'maxima-mode "maxima" "Maxima mode" t)
(autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
(autoload 'maxima "maxima" "Maxima interaction" t)
(autoload 'imath-mode "imath" "Imath mode for math formula input" t)
(setq imaxima-use-maxima-mode-flag t)
(add-to-list 'auto-mode-alist '("\\.ma[cx]\\'" . maxima-mode))
(setq org-babel-default-header-args:maxima '((:results . "raw")
                                                (:exports . "results")
                                                (:wrap)
                                                (:prologue . "fpprintprec:4; sind(x) := sin(x*%pi/180); cosd(x) := cos(x*%pi/180);set_tex_environment_default(\"\\\\begin{align}\", \"\\\\end{align}\");")
                                            ))
(setq org-babel-default-header-args:jupyter-python '((:kernel . "python3")
                                                        ;; (:wrap)
                                                        ;; (:results . "replace raw")
                                                        (:async . "no")
                                                        (:pandoc . "t")
                                                        (:prologue . "from sympy import *\n")

                                            ))
;; (defvar org-babel-default-inline-header-args
;;   '((:session . "none") (:results . "replace")
;;     (:exports . "results") (:hlines . "yes"))
;; different bullet point
;; (require 'org-superstar)
;; (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))


;;####################calender##################################
;; (require 'org-gcal)
;; (setq org-gcal-client-id "your-id-foo.apps.googleusercontent.com"
;;       org-gcal-client-secret "your-secret"
;;       org-gcal-file-alist '(("your-mail@gmail.com" .  "~/schedule.org")
;;                             ("another-mail@gmail.com" .  "~/task.org")))

;latex export related

;(eval-after-load 'org-fragtog-mode
    ;(add-to-list 'org-latex-packages-alist '("" "steinmetz" t)))
;;(setq org-latex-pdf-process
        ;;'("pdflatex -interaction nonstopmode -output-directory %o %f"
      ;;"bibtex %b"
      ;;"pdflatex -interaction nonstopmode -output-directory %o %f"
    ;;  "pdflatex -interaction nonstopmode -output-directory %o %f"))

(require 'org)
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted" nil))
(add-to-list 'org-latex-packages-alist '("" "tikz" t))
(add-to-list 'org-latex-packages-alist '("" "circuitikz" t))
(add-to-list 'org-latex-packages-alist '("" "gensymb" t))

(setq org-latex-listings 'minted)

(setq org-latex-pdf-process
      '("pdflatex -f -pdf -%latex -shell-escape -interaction=nonstopmode -output-directory=%o %f"
       "bibtex %b"
       "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
       "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
;("latexmk -f -pdf -%latex -interaction=nonstopmode -output-directory=%o %f")

(setq org-latex-toc-command "\\tableofcontents \\clearpage")
(add-to-list 'org-latex-classes
             '("IEEEtran"
               "\\documentclass{IEEEtran}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("thesis"
               "\\documentclass{MastersDoctoralThesis}"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; ############## tkiz previews  ##############################################################
;;(set-frame-font (font-spec :family "Ubuntu" :size 30))

; The following configuration make Org Mode use imagemagick for processing images.
;
; This was retrieved from this question (https://emacs.stackexchange.com/questions/60696) I posted.

;;(setq org-preview-latex-default-process 'dvisvgm) # doesnt work as well as imagemagic causes kind of coruped pngs to be created

; The following configuration disables the confirmation prompt whenever code blocks are evaluated.

(setq org-confirm-babel-evaluate nil)

; The following hook make images to be shown after code blocks are executed.

(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
(add-hook 'org-babel-after-execute-hook  'org-latex-preview)
(add-hook 'org-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
; The following configuration allows code blocks whose language is latex to be evaluated

(org-babel-do-load-languages 'org-babel-load-languages
                 '((latex . t)))
;; ############## window managment ##############################################################
(after! 'org)
(setq display-buffer-alist
      `(("\\(^\\*shell\\**\\)|\\(^\\*Python\\*$\\)"
                ;;(+popup-buffer)
                ;;(actions)
                (side . bottom)
                ;;(size . 0.15)
                ;;(window-width . 40)
                (window-height . 5)
                ;;(slot)
                ;;(vslot . -5)
                ;;(window-parameters
                        ;;(ttl)
                        ;;(select . t)
                        ;;(modeline)
                        ;;(autosave))
        )))

(defun my/babel-ansi ()
  (when-let ((beg (org-babel-where-is-src-block-result nil nil)))
    (save-excursion
      (goto-char beg)
      (when (looking-at org-babel-result-regexp)
	(let ((end (org-babel-result-end))
	      (ansi-color-context-region nil))
	  (ansi-color-apply-on-region beg end))))))

(define-minor-mode org-babel-ansi-colors-mode
  "Apply ANSI color codes to Org Babel results."
  :global t
  :after-hook
  (if org-babel-ansi-colors-mode
      (add-hook 'org-babel-after-execute-hook #'my/babel-ansi)
    (remove-hook 'org-babel-after-execute-hook #'my/babel-ansi)))

;;############################zen mode ######################
;; (add-hook 'matlab-mode-hook (lambda () (zencoding-mode 1)))


;;############################ MATLAB ########################
 (autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
 (add-to-list
  'auto-mode-alist
  '("\\.m$" . matlab-mode))
 (setq matlab-indent-function t)
 (setq matlab-shell-command "matlab")

;;######################### LSP ##################################
(with-eval-after-load 'lsp-mode
(lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
                     :major-modes '(c++-mode)
                     :remote? t
                     :server-id 'c++-remote))
)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
