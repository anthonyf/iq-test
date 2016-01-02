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

(defparameter *moves* '((0 1 3) (3 1 0) (0 2 5) (5 2 0)
                        (1 3 6) (6 3 1) (1 4 8) (8 4 1)
                        (2 4 7) (7 4 2) (2 5 9) (9 5 2)
                        (3 4 5) (5 4 3) (3 7 12) (12 7 3)
                        (3 6 10) (10 6 3) (4 7 11) (11 7 4)
                        (4 8 13) (13 8 4) (5 8 12) (12 8 5)
                        (5 9 14) (14 9 5) (6 7 8) (8 7 6)
                        (7 8 9) (9 8 7) (10 11 12) (12 11 10)
                        (11 12 13) (13 12 11) (12 13 14) (14 13 12))
  "(A B C) -> A jumps B to get to C")

(defun make-board ()
  (make-array '(15) :initial-contents '(x x x x o x x x x x x x x x x)))

(defun print-board (board &optional from to)
  (apply #'format t "    ~A~%   ~A ~A~%  ~A ~A ~A~% ~A ~A ~A ~A~%~A ~A ~A ~A ~A~%"
         (loop for x from 0 below 15
            collect (cond ((and from (= x from)) 'A)
                          ((and to (= x to)) 'B)
                          (t (aref board x))))))

(defun valid-move-p (board from skip to)
  (and (eq 'x (aref board from))
       (eq 'x (aref board skip))
       (eq 'o (aref board to))))

(defun move (board from skip to)
  (setf (aref board from) 'o
        (aref board skip) 'o
        (aref board to) 'x))

(defun undo-move (board from skip to)
  (setf (aref board from) 'x
        (aref board skip) 'x
        (aref board to) 'o))

(defun solved-p (board)
  "The board is solved when it has exacty one pin."
  (= 1 (loop for x across board
          when (eq x 'x)
          sum 1)))

(defun print-solution (moves)
  (let ((board (make-board)))
    (print-board board)
    (loop for (from skip to) in moves
       do (progn
            (terpri)
            (move board from skip to)
            (print-board board from to)))
    (terpri)
    (print-board board)))

(defun solve ()
  (let ((board (make-board)))
    (labels ((-solve (moves)
               (cond ((solved-p board)
                      (print-solution (reverse moves))
                      (return-from solve))
                     (t (loop for (from skip to) in *moves*
                           when (valid-move-p board from skip to)
                           do (progn (move board from skip to)
                                     (-solve (cons (list from skip to) moves))
                                     (undo-move board from skip to)))))))
      (-solve nil))))



