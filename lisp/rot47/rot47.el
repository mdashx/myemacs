


;;; Code:

(defun rot47-create-leading-chars ()
  "Return a string of ASCII chars 0-31"
  (let ((str (make-string 32 0))
        (i 0))
    (while (< i 32)
      (aset str i i)
    (setq i (1+ i)))
    str
    ))

(defun rot47-create-trailing-chars ()
  "Return a string of ASCII chars 127-174."
  (let ((str (make-string 48 0))
        (offset 127)
        (i 0))
    (while (< i (length str))
      (aset str i (+ i offset))
      (setq i (1+ i)))
    str
    )
  )

(defun rot47-rotate-chars (idx shift limit)
  "Rotate position by shift within limit."
  ;; Should I enforce that the index be less than the limit?
  (% (+ idx shift) limit))


(defun rot47-rotated-chars ()
  "Rotate ASCII chars 33-126 by 47 places."
  (let ((str (make-string 94 0))
        (offset 33)
        (i 0))
    (while (< i 94)
      (aset str i (+ (rot47-rotate-chars i 47 94) offset))
      (setq i (1+ i)))
    str
    ))

(defun rot47-make-translate-table ()
  "Concat strings to create rot47 translate table."
      (let ((str (make-string 175 0))
            (i 0))
        (while (< i 175)
          (aset str i i)
          (setq i (1+ i)))
        (concat (rot47-create-leading-chars)
                (make-string 1 175)
                (rot47-rotated-chars)
                (rot47-create-trailing-chars)
                (make-string 1 32))
        ))

(defun rot47-replace-buffer ()
  "ROT47 encode buffer, plus substitute space chars."
  (interactive)
  (translate-region (point-min) (point-max)
                    (rot47-make-translate-table)))

(provide 'rot47)
