(ert-deftest rot47-test-create-leading-chars ()
    "All of the chars should be in the correct position and the
string should be the correct length"
    (should (equal (length (rot47-create-leading-chars)) 32))
    (should (equal (aref (rot47-create-leading-chars) 0) 0))
    (should (equal (aref (rot47-create-leading-chars) 31) 31))
    (should (equal (aref (rot47-create-leading-chars)
                         (- (length (rot47-create-leading-chars)) 1))
                   31)))

(ert-deftest rot47-test-create-trailing-chars ()
    "All of the chars should be in the correct position and the
string should be the correct length"
    (should (equal (length (rot47-create-trailing-chars)) 48))
    (should (equal (aref (rot47-create-trailing-chars) 0) 127))
    (should (equal (aref (rot47-create-trailing-chars) 1) 128))
    (should (equal (aref (rot47-create-trailing-chars) 47) 174))
    (should (equal (aref (rot47-create-trailing-chars)
                         (- (length (rot47-create-trailing-chars)) 1))
                   174)))

(ert-deftest rot47-test-rotate-chars ()
  "Make sure chars wrap boundaries correctly."
  (should (equal (rot47-rotate-chars 0 47 94) 47))
  (should (equal (rot47-rotate-chars 1 47 94) 48))
  (should (equal (rot47-rotate-chars 46 47 94) 93))
  (should (equal (rot47-rotate-chars 47 47 94) 0))
  (should (equal (rot47-rotate-chars 48 47 94) 1))
  (should (equal (rot47-rotate-chars 94 47 94) 47)))

(ert-deftest rot47-test-rotated-chars ()
    "All of the chars should be in the correct position and the
string should be the correct length"
    (should (equal (length (rot47-rotated-chars)) 94))
    (should (equal (aref (rot47-rotated-chars) 0) (+ 33 47)))
    (should (equal (aref (rot47-rotated-chars) 1) (+ 34 47)))
    (should (equal (aref (rot47-rotated-chars) 46) 126))
    (should (equal (aref (rot47-rotated-chars) 47) 33))
    (should (equal (aref (rot47-rotated-chars) 48) 34))
    (should (equal (aref (rot47-create-trailing-chars)
                         (- (length (rot47-create-trailing-chars)) 1))
                   174)))
(ert-deftest rot47-test-translate-tables ()
    "All of the chars should be in the correct position and the
string should be the correct length"
    (should (equal (length (rot47-make-translate-table)) 176))
    (should (equal (aref (rot47-make-translate-table) 0) 0))
    (should (equal (aref (rot47-make-translate-table) 31) 31))
    (should (equal (aref (rot47-make-translate-table) 32) 175))
    (should (equal (aref (rot47-make-translate-table) 33) 80))    
    (should (equal (aref (rot47-make-translate-table) 80) 33))
    (should (equal (aref (rot47-make-translate-table) 127) 127))
    (should (equal (aref (rot47-make-translate-table) 175) 32)))
