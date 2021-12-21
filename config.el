
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
(setq doom-font (font-spec :family "Source Code Pro" :size 14 )
       doom-variable-pitch-font (font-spec :family "sans" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type t)

;; sets the projectile search path
(setq
projectile-project-search-path '("~/Nextcloud3/GuDocs/NoteBook/" "C:/Users/b0628/Documents/Notebooks/Emacs/Admin/")
)
(setq projectile-sort-order 'recently-active)

;;#################C++/Arduino############################


;; edit ino files with adruino mode.
(add-to-list 'auto-mode-alist '("\\.ino$" . cpp-mode))

;; Enable irony for all c++ files, and platformio-mode only
;; when needed (platformio.ini present in project root).
(add-hook 'c++-mode-hook (lambda ()
                        (irony-mode)
                        (irony-eldoc)
                        (platformio-conditionally-enable)))

(setq org-ditaa-jar-path "C:/Users/b0628/ditaa")
(require 'yasnippet)
;;(yas/global-mode 1)
(add-to-list 'yas-snippet-dirs "C:/Users/b0628/.doom.d/snippets/org-mode")
(define-key yas-minor-mode-map [(tab)] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t))) ; this line activates ditaa

(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1)
;org bullets related
;(require 'org-bullets)
;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; different bullet point
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))


;latex export related
;(add-hook 'org-mode-hook 'org-fragtog-mode) ;; in config.el

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
(setq org-latex-listings 'minted)

(setq org-latex-pdf-process
      '("pdflatex -f -pdf -%latex -shell-escape -interaction=nonstopmode -output-directory=%o %f"))
;        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
;("latexmk -f -pdf -%latex -interaction=nonstopmode -output-directory=%o %f")


 (add-to-list 'org-latex-packages-alist '("" "tikz" t))

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
