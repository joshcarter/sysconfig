;;__________________________________________________________________________
;;;;    Programming - Clojure

(defvar clj-root (concat (expand-file-name "~") "/Library/Clojure/"))
(add-to-list 'load-path (concat clj-root "clojure-mode"))
(add-to-list 'load-path (concat clj-root "swank-clojure"))
(add-to-list 'load-path (concat clj-root "slime"))

(require 'clojure-mode)

(require 'swank-clojure-autoload)
(swank-clojure-config
 (setq swank-clojure-jar-path (concat clj-root "clojure/clojure.jar"))
 (setq swank-clojure-extra-classpaths
       (list (concat clj-root "clojure/clojure-contrib.jar"))))

(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))))

(require 'slime)
(slime-setup)
