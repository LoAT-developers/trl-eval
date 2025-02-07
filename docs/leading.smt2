(set-logic HORN)

(declare-fun f ( Int Int Int ) Bool)

(assert
 (forall ( (w Int) (x Int) (y Int) ) 
         (=>
          ;;(and (= x y))
          (and (= x y 0))
          (f w x y)
          )
         )
 )

(assert
 (forall ( (w Int) (ww Int) (x Int) (xx Int) (y Int) (yy Int) ) 
         (=>
          (and (f w x y) (or
                          (and (= w 0) (= xx (+ x 1)) (= yy (+ y 1)))
                          (and (= w ww 1) (= xx (- x 1)) (= yy (- y 1)) )
                          ))
          (f ww xx yy)
          )
         )
 )

(assert
 (forall ( (w Int) (x Int) (y Int) ) 
         (=>
          (and (= w 1) (<= x 0) (> y 0) (f w x y))
          false
          )
         )
 )

(check-sat)
(exit)
