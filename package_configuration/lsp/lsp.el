;;; package_configuration/lsp/lsp.el -*- lexical-binding: t; -*-

(setq lsp-ui-doc-enable nil)
(setq lsp-lens-enable nil)
(setq lsp-ui-sideline-enable nil)
(setq lsp-enable-indentation nil)
(after! lsp-java
	(setq lsp-java-vmargs '("-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Dsun.zip.disableMemoryMapping=true" "-Xmx4G" "-Xms100m")))
(setq lsp-enable-file-watchers nil)
(after! lsp
	(setq lsp-disabled-clients '( (csharp-mode . csharp-roslyn)
																(csharp-mode . csharp-roslyn-stdio)
																(csharp-mode . omnisharp) ))
	)
(after! csharp-mode
	(setq lsp-disabled-clients '( (csharp-mode . csharp-roslyn)
																(csharp-mode . csharp-roslyn-stdio)
																(csharp-mode . omnisharp) ))
	)
;; (setq lsp-disabled-clients '((python-mode . pylsp)))
(setq read-process-output-max (* 1024 1024))
;; (setq lsp-completion-provider :capf)
;; (add-to-list 'lsp-language-id-configuration '("\\.tpl$" . "smarty"))
(after! lsp
	(add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\flake-inputs")
	)

;;; csharp-roslyn via nixpkgs roslyn-ls (stdio) — lighter than omnisharp
;; lsp-roslyn.el is Windows/named-pipe centric (pins 4.13); nixpkgs
;; roslyn-ls 5.7 requires explicit --stdio and speaks plain LSP there.
;; (after! lsp-mode
;;   (require 'lsp-mode)
;;   (lsp-register-client
;;    (make-lsp-client
;;     :new-connection (lsp-stdio-connection
;;                      '("/run/current-system/sw/bin/Microsoft.CodeAnalysis.LanguageServer" "--stdio"))
;;     :activation-fn (lsp-activate-on "csharp")
;;     :server-id 'csharp-roslyn-stdio
;;     :priority 5
;;     :multi-root t)))
