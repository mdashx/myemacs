;; http://stackoverflow.com/questions/2284703/emacs-how-to-disable-file-changed-on-disk-checking
;; Ignore modification-time-only changes in files, i.e. ones that
;; don't really change the contents.  This happens often with
;; switching between different VC buffers.

;; (defun update-buffer-modtime-if-byte-identical ()
;;   (let* ((size      (buffer-size))
;;          (byte-size (position-bytes size))
;;          (filename  buffer-file-name))
;;     (when (and byte-size (<= size 1000000))
;;       (let* ((attributes (file-attributes filename))
;;              (file-size  (nth 7 attributes)))
;;         (when (and file-size
;;                    (= file-size byte-size)
;;                    (string= (buffer-substring-no-properties 1 (1+ size))
;;                             (with-temp-buffer
;;                               (insert-file-contents filename)
;;                               (buffer-string))))
;;           (set-visited-file-modtime (nth 5 attributes))
;;           t)))))

;; (defun verify-visited-file-modtime--ignore-byte-identical (original &optional buffer)
;;   (or (funcall original buffer)
;;       (with-current-buffer buffer
;;         (update-buffer-modtime-if-byte-identical))))
;; (advice-add 'verify-visited-file-modtime :around #'verify-visited-file-modtime--ignore-byte-identical)

;; (defun ask-user-about-supersession-threat--ignore-byte-identical (original &rest arguments)
;;   (unless (update-buffer-modtime-if-byte-identical)
;;     (apply original arguments)))
;; (advice-add 'ask-user-about-supersession-threat :around #'ask-user-about-supersession-threat--ignore-byte-identical)

;; Looks like I gotta go this route:
;; (defun ask-user-about-supersession-threat (fn)
;;   "blatantly ignore files that changed on disk"
;;   )
;; (defun ask-user-about-lock (file opponent)
;;   "always grab lock"
;;   t)


