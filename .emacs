;; turn off menubar for good
(menu-bar-mode 0)

;; turn on show paren mode
(show-paren-mode t)

;; highlight entire bracket expression
;;(setq show-paren-style 'expression)

;; display column numbers
(column-number-mode 1)

;;improve up frame title bar
;; (setq frame-title-format
;;       (list (format "%s %%S: %%j " (system-name))
;;         '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; show the file path in the header line
(defmacro with-face (str &rest properties)
  `(propertize ,str 'face (list ,@properties)))

(defun sl/make-header ()
  ""
  (let* ((sl/full-header (abbreviate-file-name buffer-file-name))
         (sl/header (file-name-directory sl/full-header))
         (sl/drop-str "[...]"))
    (if (> (length sl/full-header)
           (window-body-width))
        (if (> (length sl/header)
               (window-body-width))
            (progn
              (concat (with-face sl/drop-str
                                 :background "blue"
                                 :weight 'bold
                                 )
                      (with-face (substring sl/header
                                            (+ (- (length sl/header)
                                                  (window-body-width))
                                               (length sl/drop-str))
                                            (length sl/header))
                                 ;; :background "red"
                                 :weight 'bold
                                 )))
          (concat (with-face sl/header
                             ;; :background "red"
                             :foreground "#8fb28f"
                             :weight 'bold
                             )))
      (concat (with-face sl/header
                         ;; :background "green"
                         ;; :foreground "black"
                         :weight 'bold
                         :foreground "#8fb28f"
                         )
              (with-face (file-name-nondirectory buffer-file-name)
                         :weight 'bold
                         ;; :background "red"
                         )))))

(defun sl/display-header ()
  (setq header-line-format
        '("" ;; invocation-name
          (:eval (if (buffer-file-name)
                     (sl/make-header)
                   "%b")))))

(add-hook 'buffer-list-update-hook
          'sl/display-header)


;;If the buffer name would be the same add the parent directory after the name
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;; Make script files executable automatically
(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

;; automatically always end a file with a newline
(setq require-final-newline 'query)

;; move backup files from current dir to one central location
(setq backup-directory-alist `(("." . "~/.saves")))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;;buffer navigation with arrow keys - this one's great
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Electricity / Automicity
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; automatically generate and keep track of parens and other open close characters (){}
(electric-pair-mode 1)

;; automatics return and indent
(electric-indent-mode 1)

;; turn on Company Mode "Complete Anything mode"
(add-hook 'after-init-hook 'global-company-mode)

;; IDO Mode auto complete of file paths with fewer keystrokes
(ido-mode t)
(setq ido-enable-flex-matching t) ; fuzzy matching is a must have

;; Anything = Quicksilver for emacs
;; (add-to-list 'load-path "~/halo-www")
;; (require 'anything-match-plugin)
;; (require 'anything-config)

;; highlight text selection
(transient-mark-mode 1)

;; delete seleted text when typing
;;(delete-selection-mode 1)

;; just spaces
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

;; 4 spaces
(setq standard-indent 4)
(setq default-tab-width 4)

;; PSR-2
(setq c-default-style "bsd"
      c-basic-offset 4)

(defun indent-file (file)
  "prompt for a file and indent it according to its major mode"
  (interactive "fWhich file do you want to indent: ")
  (find-file file)
  ;; uncomment the next line to force the buffer into a c-mode
  ;; (c-mode)
    (indent-region (point-min) (point-max)))


;; use unix line endings, why wouldn't you?
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)



;;Highlight Line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable highlighting of current line
(global-hl-line-mode 1)

;; Line Numbers Mode
(global-linum-mode 1) ; display line numbers in margin.
(setq linum-format "%d  ")
;; (set-face-attribute 'linum nil :background "#CCC"))
;; (set-face-background 'linum "black")
;; (set-face-foreground 'linum "brightblack")
(set-face-background 'linum "white")
(set-face-foreground 'linum "brightwhite")

;; (set-face-foreground 'linum "blue")
;; (set-face-attribute 'linum nil :bold t)

;;(set-face-background 'highlight "white")
;;(set-face-background 'highlight "blue")
;;(set-face-background 'highlight "purple")

;;(set-face-background 'highlight "black")
;;(set-face-background 'highlight "white")

(set-face-background 'highlight "white")
;; (set-face-background 'highlight "black")
(set-face-foreground 'highlight nil)

;; (set-face-background 'highlight nil)
;; (set-face-foreground 'highlight nil)
;; (set-face-attribute hl-line-face nil :underline t)


;;Mode Line
;; (set-face-foreground 'mode-line "black")
;; (set-face-background 'mode-line "blue")

;; (set-face-foreground 'mode-line "#000")
;; (set-face-background 'mode-line "#FFF")


;; Mattz Macros
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'kill-yank-comment-yank
   "\C-k\C-y\C-j\C-a\C-y\C-p\C-a//")
(global-set-key (kbd "C-c #") 'kill-yank-comment-yank)

;; Shortcut Keys
;;;;;;;;;;;;;;;;
(global-set-key [f6]  'start-kbd-macro)
(global-set-key [f7]  'call-last-kbd-macro)
(global-set-key [f8]  'end-kbd-macro)

;; use control h as a delete key
;; (global-set-key [?\C-h] 'delete-backward-char)
(global-set-key [?\C-g] 'delete-backward-char)
(global-set-key [?\C-x ?h] 'help-command) ;; overrides mark-whole-buffer
(global-set-key [?\C-x ?m] 'goto-line) ;; overrides mark-whole-buffer
(global-set-key [?\M-g] 'goto-line)

;; hippie expand
(global-set-key "\M-\\" 'hippie-expand) ;; set hippie expand to Meta BackSlash
;;(global-set-key "\M-\/" 'hippie-expand) ;; set hippie expand to Meta Slash

;;scroll other buffer
(global-set-key [A-prior]  'scroll-other-window-down) ; Alt-pagedown scrolls the OTHER window
(global-set-key [A-next] 'scroll-other-window)       ; Alt-pageup scroll the OTHER window

;; alternative meta
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;;open up a shell
(global-set-key "\C-c\1" 'shell)
(global-set-key "\C-c\!" 'shell)

;;(global-set-key "\M-<right>" 'next-buffer)
;;(global-set-key "\M-<left>"'previous-buffer)
;;defaults
;;(global-set-key "\C-x <right>" 'next-buffer)
;;(global-set-key "\C-x <left>"'previous-buffer)


;;next/prev frame -- not a real thing
;; (global-set-key "\C-0 >" 'next-frame)
;; (global-set-key "\C-9 >" 'previous-frame)

;; comment region
;;(global-set-key "\C-c\/" 'comment-region)
;;(global-set-key "\C-c\?" 'uncomment-region)
;; this is actually alread taken care of by selecting a region and using M-; which is dwim "Do What I Mean"

;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
        If no region is selected and current line is not blank and we are not at the end of the line,
        then comment current line.
        Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key "\M-;" 'comment-dwim-line)

;;use mouse scrollwheel ;;unfortunately disables copy paste between terminals and makes things generally unusable
;; (require 'mouse) (xterm-mouse-mode t) (defun track-mouse (e))

;; (unless window-system
;;   (xterm-mouse-mode 1)
;;   (global-set-key [mouse-4] '(lambda ()
;;                                (interactive)
;;                                (scroll-down 1)))
;;   (global-set-key [mouse-5] '(lambda ()
;;                                (interactive)
;;                                (scroll-up 1))))


(defun google ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
                           (buffer-substring (region-beginning) (region-end))
                                (read-string "Google: "))))))

(global-set-key (kbd "C-c g") 'google)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Modes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-path (cons "~/.emacs.d" load-path))
(let ((default-directory "~/.emacs.d/elpa/"))
        (normal-top-level-add-subdirs-to-load-path))

;; Smart Mode Line
;;(require 'smart-mode-line)
;; (if after-init-time (sml/setup)
;;   (add-hook 'after-init-hook 'sml/setup))

;; move buffers around
(require 'buffer-stack)
(global-set-key [(f9)] 'buffer-stack-bury)
(global-set-key [(control f9)] 'buffer-stack-bury-and-kill)
(global-set-key [(f10)] 'buffer-stack-up)
(global-set-key [(f11)] 'buffer-stack-down)
(global-set-key [(f12)] 'buffer-stack-track)
(global-set-key [(control f12)] 'buffer-stack-untrack)


;; RTM
;;;;;;;;
;;(autoload 'simple-rtm-mode "simple-rtm" "Interactive mode for Remember The Milk" t)

;;(add-to-list 'load-path "~/.emacs.d/nav-35")
;;Emacs Navigation Mode
;; @ https://github.com/travisjeffery/emacs-nav
;;(autoload 'nav "emacs-nav" "Emacs Nav mode sidebar" t)
;;(require 'nav)

;; PHP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'php-mode "php-mode" "PHP editing mode" t)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php5\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php4\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php3\\'" . php-mode))

(setq php-mode-force-pear 1) ;; use PEAR coding standards ;Unfortunately no option is available for Symfony

(autoload 'php-getter-setter "php-getter-setter" "GetSet Generation" t)

(add-hook 'php-mode-hook 'my-php-mode-stuff)

(defun my-php-mode-stuff ()
  (local-set-key (kbd "<f2>") 'my-php-symbol-lookup))


(defun my-php-symbol-lookup ()
  (interactive)
  (let ((symbol (symbol-at-point)))
    (if (not symbol)
        (message "No symbol at point.")

      (browse-url (concat "http://php.net/manual-lookup.php?pattern="
                          (symbol-name symbol))))))


(defun my-php-function-lookup ()
  (interactive)
  (let* ((function (symbol-name (or (symbol-at-point)
                                    (error "No function at point."))))
         (buf (url-retrieve-synchronously (concat "http://php.net/manual-lookup.php?pattern=" function))))
    (with-current-buffer buf
      (goto-char (point-min))
        (let (desc)
          (when (re-search-forward "<div class=\"methodsynopsis dc-description\">\\(\\(.\\|\n\\)*?\\)</div>" nil t)
            (setq desc
              (replace-regexp-in-string
                " +" " "
                (replace-regexp-in-string
                  "\n" ""
                  (replace-regexp-in-string "<.*?>" "" (match-string-no-properties 1)))))

            (when (re-search-forward "<p class=\"para rdfs-comment\">\\(\\(.\\|\n\\)*?\\)</p>" nil t)
              (setq desc
                    (concat desc "\n\n"
                            (replace-regexp-in-string
                             " +" " "
                             (replace-regexp-in-string
                              "\n" ""
                              (replace-regexp-in-string "<.*?>" "" (match-string-no-properties 1))))))))

          (if desc
              (message desc)
            (message "Could not extract function info. Press C-F1 to go the description."))))
    (kill-buffer buf)))


;; Hide-Show Mode
;; (hs-minor-mode) with default keybinding C-c @ C-c to trigger the folding.
(add-hook 'php-mode-hook (lambda () (hs-minor-mode t)))


;;Which Function Mode
(require 'which-func)
(add-to-list 'which-func-modes 'php-mode)
(add-to-list 'which-func-modes 'python-mode)
(add-to-list 'which-func-modes 'ruby-mode)
(which-func-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Flymake Static Analysis
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'flymake) ;; enable flymake minor mode

;; I don't like the default colors :)
;;;;ERROR
(set-face-background 'flymake-errline "red4")
(set-face-foreground 'flymake-errline "black")
;;;;WARN
(set-face-background 'flymake-warnline "dark slate blue")
(set-face-foreground 'flymake-warnline "black")

;;enable for commonly used languages
(add-hook 'php-mode-hook (lambda () (flymake-mode t)))
(add-hook 'python-mode-hook (lambda () (flymake-mode t)))
(add-hook 'perl-mode-hook (lambda () (flymake-mode t)))



;; (require 'flymake-phpcs)

;; If flymake_phpcs isn't found correctly, specify the full path
;;(setq flymake-phpcs-command "~/projects/emacs-flymake-phpcs/bin/flymake_phpcs")
;; (setq flymake-phpcs-command "/Users/matthew/.emacs.d/elpa/flymake-phpcs-1.0.5/bin/flymake_phpcs")

;; Customize the coding standard checked by phpcs
;; (setq flymake-phpcs-standard "~/pear/share/pear/Symfony2")
;; (setq flymake-phpcs-standard "~/pear/share/pear/PSR2")
;;      "~/projects/devtools/php_codesniffer/MyCompanyStandard")


;; Show the name of sniffs in warnings (eg show
;; "Generic.CodeAnalysis.VariableAnalysis.UnusedVariable" in an unused
;; variable warning)
;; (setq flymake-phpcs-show-rule t)



;; White Space Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nuke trailing whitespaces when writing to a file
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; display only tails of lines longer than 80 columns, tabs and
;; trailing whitespaces
;; (setq whitespace-line-column 80
;;             whitespace-style '(tabs trailing lines-tail))
(setq whitespace-line-column 80
            whitespace-style '(face tabs trailing lines-tail))

(add-hook 'php-mode-hook (lambda () (whitespace-mode t)))


;;Markdown Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdwn\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))


;; Themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/themes")



;; Solarized
;; (add-to-list 'load-path "~/.emacs.d/themes/color-theme-solarized.el")
;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-solarized)


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;; (when
;;     (load
;;      (expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (package-initialize))


(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/") ) )
