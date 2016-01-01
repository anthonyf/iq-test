;;;; iq-test.lisp

(in-package #:iq-test)

;;;     x
;;;    x x
;;;   x o x
;;;  x x x x
;;; x x x x x

;;;          0
;;;        1   2
;;;      3   4   5
;;;    6   7   8   9
;;; 10  11  12  13  14

(defparameter *moves* '((0 1 3) (3 1 0)
                        (0 2 5) (5 2 0)
                        (1 3 6) (6 3 1)
                        (1 4 8) (8 4 1)
                        (2 4 7) (7 4 2)
                        (2 5 9) (9 5 2)
                        (3 4 5) (5 4 3)
                        (3 7 12) (12 7 3)
                        (3 6 10) (10 6 3)
                        (4 7 11) (11 7 4)
                        (4 8 13) (13 8 4)
                        (5 8 12) (12 8 5)
                        (5 9 14) (14 9 5)
                        (6 7 8) (8 7 6)
                        (7 8 9) (9 8 7)
                        (10 11 12) (12 11 10)
                        (11 12 13) (13 12 11)
                        (12 13 14) (14 12 13))
  "(A B C) -> A jumps B to get to C")

(defparameter *board* (make-array '(15) :initial-contents '(x x x x o x x x x x x x x x x)))

(defun print-board (board)
  (format t "    ~A~%"
          (aref board 0))
  (format t "   ~A ~A~%"
          (aref board 1)(aref board 2))
  (format t "  ~A ~A ~A~%"
          (aref board 3)(aref board 4)(aref board 5))
  (format t " ~A ~A ~A ~A~%"
          (aref board 6)(aref board 7)(aref board 8)(aref board 9))
  (format t "~A ~A ~A ~A ~A~%"
          (aref board 10)(aref board 11)(aref board 12)(aref board 13)(aref board 14)))

(print-board *board*)
