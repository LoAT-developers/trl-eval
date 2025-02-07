(set-logic HORN)

(declare-fun f ( Int Int Int ) Bool)

(assert
 (forall ( (x Int) (y Int) (z Int) ) 
         (=>
          (and (<= x 0))
          (f x y z)
          )
         )
 )

(assert
 (forall ( (x Int) (xx Int) (y Int) (yy Int) (z Int) (zz Int) ) 
         (=>
          (and (f x y z) (or
                          (and (> y 0) (= xx (+ x 1)) (= yy (- y 1)) (= zz z))
                          (and (= y 0) (= xx x) (= yy z) (= zz z))
                          ))
          (f xx yy zz)
          )
         )
 )

(assert
 (forall ( (x Int) (y Int) (z Int) ) 
         (=>
          (and (>= x 1000) (f x y z))
          false
          )
         )
 )

(check-sat)
(exit)
