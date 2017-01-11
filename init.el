;;关闭工具栏

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t))

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar my/packages '(
	       ;; --- Auto-completion ---
	       company
	       ;; --- Better Editor ---
	       hungry-delete
	       swiper
	       counsel
	       smartparens
	       ;; --- Major Mode ---
	       js2-mode
	       ;; --- Minor Mode ---
	       nodejs-repl
	       exec-path-from-shell
	       ;; --- Themes ---
	       ;;monokai-them
	       zenburn-theme
	       ;; solarized-theme
	       ) "Default packages")

(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
    (loop for pkg in my/packages
	  when (not (package-installed-p pkg)) do (return nil)
	  finally (return t)))

(unless (my/packages-installed-p)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg my/packages)
      (when (not (package-installed-p pkg))
	(package-install pkg))))

;; Find Executable Path on OS X
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;在org-mode下面语法高亮
(require 'org)
(setq org-src-fontify-natively t)

;;显示最近打开的文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 10)
;;这个快捷键后面会用counsel 代替
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;;这个配置让我们替换双击选中的内容
(delete-selection-mode 1)

;;这些快捷来代替常用的函数
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(tool-bar-mode -1)

;;关闭文件滑动控件
(scroll-bar-mode -1)

;;显示行号
(global-linum-mode 1)

;;关闭启动画面
(setq inhibit-splash-screen 1)
;;切换逛遍的样式为bar
(setq-default cursor-type 'bar)

;;设置默认 Org Agenda 文件目录
(setq org-agenda-files '("~/org"))
;;设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)


;;不自动生成备份文件,保存buffer时
(setq make-backup-files nil)

(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;;快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;;将行数open-init-file 绑定到<f2>键上
;;M-x eval-buffer 执行当前缓冲区的所有lisp命令
(global-set-key (kbd "<f2>") 'open-init-file)

;;当前行高亮
(global-hl-line-mode 1)

;;设置括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;开启全局company补全
(global-company-mode 1)

;;自动补全成双的符号,有些例外
(require 'smartparens-config)
(smartparens-global-mode 1)

;;开启多个空格一次删除完
(require 'hungry-delete)
(global-hungry-delete-mode)

;;加载主题
(load-theme 'zenburn t)

;;增强M-x的补全
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)

;;开启时全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 1)
 '(package-selected-packages (quote (company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
