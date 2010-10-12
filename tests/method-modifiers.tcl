package require nx; namespace import ::nx::*
::nx::configure defaultMethodCallProtection false
package require nx::test

Test parameter count 10

Class create C {
  # methods
  :method plain_method {} {return [current method]}
  :public method public_method {} {return [current method]}
  :protected method protected_method {} {return [current method]}

  # forwards
  :forward plain_forward %self plain_method
  :public forward public_forward %self public_method
  :protected forward protected_forward %self protected_method

  # setter
  :setter plain_setter 
  :public setter public_setter 
  :protected setter protected_setter 

  # alias
  :alias plain_alias [C info method handle plain_method]
  :public alias public_alias [C info method handle public_method]
  :protected alias protected_alias [C info method handle protected_method]
  
  # object
  :class-object method plain_object_method {} {return [current method]}
  :public class-object method public_object_method {} {return [current method]}
  :protected class-object method protected_object_method {}  {return [current method]}
  :class-object forward plain_object_forward %self plain_object_method
  :public class-object forward public_object_forward %self public_object_method
  :protected class-object forward protected_object_forward %self protected_object_method
  :class-object setter plain_object_setter 
  :public class-object setter public_object_setter 
  :protected class-object setter protected_object_setter 
  :class-object alias plain_object_alias [:class-object info method handle plain_object_method]
  :public class-object alias public_object_alias [:class-object info method handle public_object_method]
  :protected class-object alias protected_object_alias [:class-object info method handle protected_object_method]
}
C create c1 {
  # methods
  :method plain_object_method {} {return [current method]}
  :public method public_object_method {} {return [current method]}
  :protected method protected_object_method {} {return [current method]}

  # forwards
  :forward plain_object_forward %self plain_object_method
  :public forward public_object_forward %self public_object_method
  :protected forward protected_object_forward %self protected_object_method

  # setter
  :setter plain_object_setter 
  :public setter public_object_setter 
  :protected setter protected_object_setter 

  # alias
  :alias plain_object_alias [:info method handle plain_object_method]
  :public alias public_object_alias [:info method handle public_object_method]
  :protected alias protected_object_alias [:info method handle protected_object_method]
}
C public setter s0
C protected setter s1
? {c1 s0 0} 0
? {::nsf::dispatch c1 s1 1} 1
C class-object setter s3
? {C s3 3} 3

# create a fresh object (different from c1)
C create c2
# test scripted class level methods
Test case scripted-class-level-methods {
  ? {c2 plain_method} "plain_method"
  ? {c2 public_method} "public_method"
  ? {catch {c2 protected_method}} 1
  ? {::nsf::dispatch c2 protected_method} "protected_method"
}

# class level forwards
Test case class-level-forwards {
  ? {c2 plain_forward} "plain_method"
  ? {c2 public_forward} "public_method"
  ? {catch {c2 protected_forward}} 1
  ? {::nsf::dispatch c2 protected_forward} "protected_method"
}

# class level setter
Test case class-level-setter {
  ? {c2 plain_setter 1} "1"
  ? {c2 public_setter 2} "2"
  ? {catch {c2 protected_setter 3}} 1
  ? {::nsf::dispatch c2 protected_setter 4} "4"
}

# class level alias ....TODO: wanted behavior of [current method]? not "plain_alias"?
Test case class-level-alias {
  ? {c2 plain_alias} "plain_method"
  ? {c2 public_alias} "public_method"
  ? {catch {c2 protected_alias}} 1
  ? {::nsf::dispatch c2 protected_alias} "protected_method"
}

###########

# scripted class-object level methods
Test case scripted-class-object-level {
  ? {C plain_object_method} "plain_object_method"
  ? {C public_object_method} "public_object_method"
  ? {catch {C protected_object_method}} 1
  ? {::nsf::dispatch C protected_object_method} "protected_object_method"
}

# class-object level forwards
Test case class-object-level-forwards {
  ? {C plain_object_forward} "plain_object_method"
  ? {C public_object_forward} "public_object_method"
  ? {catch {C protected_object_forward}} 1
  ? {::nsf::dispatch C protected_object_forward} "protected_object_method"
}

# class-object level setter
Test case class-object-level-setter {
  ? {C plain_object_setter 1} "1"
  ? {C public_object_setter 2} "2"
  ? {catch {C protected_object_setter 3}} 1
  ? {::nsf::dispatch C protected_object_setter 4} "4"
}

# class-object level alias ....TODO: wanted behavior of [current method]? not "plain_alias"?
Test case class-object-level-alias {
  ? {C plain_object_alias} "plain_object_method"
  ? {C public_object_alias} "public_object_method"
  ? {catch {C protected_object_alias}} 1
  ? {::nsf::dispatch C protected_object_alias} "protected_object_method"
}

###########

# scripted object level methods
Test case scripted-object-level-methods {
  ? {c1 plain_object_method} "plain_object_method"
  ? {c1 public_object_method} "public_object_method"
  ? {catch {c1 protected_object_method}} 1
  ? {::nsf::dispatch c1 protected_object_method} "protected_object_method"
}

# object level forwards
Test case object-level-forwards {
  ? {c1 plain_object_forward} "plain_object_method"
  ? {c1 public_object_forward} "public_object_method"
  ? {catch {c1 protected_object_forward}} 1
  ? {::nsf::dispatch c1 protected_object_forward} "protected_object_method"
}

# object level setter
Test case object-level-setter
? {c1 plain_object_setter 1} "1"
? {c1 public_object_setter 2} "2"
? {catch {c1 protected_object_setter 3}} 1
? {::nsf::dispatch c1 protected_object_setter 4} "4"

# object level alias ....TODO: wanted behavior of [current method]? not "plain_alias"?
Test case object-level-alias {
  ? {c1 plain_object_alias} "plain_object_method"
  ? {c1 public_object_alias} "public_object_method"
  ? {catch {c1 protected_object_alias}} 1
  ? {::nsf::dispatch c1 protected_object_alias} "protected_object_method"

  ? {lsort [c1 info methods]} \
      "plain_object_alias plain_object_forward plain_object_method plain_object_setter public_object_alias public_object_forward public_object_method public_object_setter"
  ? {lsort [C class-object info methods]} \
      "plain_object_alias plain_object_forward plain_object_method plain_object_setter public_object_alias public_object_forward public_object_method public_object_setter s3"
}

C destroy

Test case mixinguards {
  # define a Class C and mixin class M
  Class create C
  Class create M

  # register the mixin on C as a class mixin and define a mixinguard
  C mixin M
  C mixin guard M {1 == 1}
  ? {C info mixin guard M} "1 == 1"
  C mixin guard M {}
  ? {C info mixin guard M} ""

  # now the same as class-object mixin and class-object mixin guard
  C class-object mixin M
  C class-object mixin guard M {1 == 1}
  ? {C class-object info mixin guard M} "1 == 1"
  C class-object mixin guard M {}
  ? {C class-object info mixin guard M} ""
}

Test case mixin-via-objectparam {
  # add an object and class mixin via object-parameter and via slots
  Class create M1; Class create M2; Class create M3; Class create M4
  Class create C -mixin M1 -object-mixin M2 {
    :mixin add M3
    :class-object mixin add M4
  }
  
  ? {lsort [C class-object info mixin classes]} "::M2 ::M4"
  ? {lsort [C info mixin classes]} "::M1 ::M3"
  C destroy
  M1 destroy; M2 destroy; M3 destroy; M4 destroy;
}

# testing next via nonpos-args
Test case next-from-nonpos-args {
  
  Object create o {
    :method bar {-y:required -x:required} {
      #puts stderr "+++ o x=$x, y=$y [current args] ... next [current next]"
      return [list x $x y $y [current args]]
    }
  }
  Class create M {
    :method bar {-x:required -y:required} {
      #puts stderr "+++ M x=$x, y=$y [current args] ... next [current next]"
      return [list x $x y $y [current args] -- {*}[next]]
    }
  }
  
  o mixin M
  ? {o bar -x 13 -y 14} "x 13 y 14 {-x 13 -y 14} -- x 13 y 14 {-x 13 -y 14}"
  ? {o bar -y 14 -x 13} "x 13 y 14 {-y 14 -x 13} -- x 13 y 14 {-y 14 -x 13}"
}

# 
# test method attribute with protected/public
# 
Test case attribute-method {

  Class create C {
    set x [:attribute a]

    ? [list set _ $x] "::nsf::classes::C::a"

    # attribute with default
    :attribute {b b1}
    :public attribute {c c1}
    :protected attribute {d d1}

    set X [:class-object attribute A]
    ? [list set _ $X] "::C::A"
    
    # class-object attribute with default
    :class-object attribute {B B2}
    :public class-object attribute {C C2}
    :protected class-object attribute {D D2}
  }

  C create c1 -a 1
  ? {c1 a} 1
  ? {c1 b} b1
  ? {c1 c} c1
  ? {c1 d} "::c1: unable to dispatch method 'd'"

  ? {C A 2} 2
  ? {C B} B2
  ? {C C} C2
  ? {C D} "Method 'D' unknown for ::C. Consider '::C create D ' instead of '::C D '"

  Object create o {
    set x [:attribute a]
    ? [list set _ $x] "::o::a"

    # attribute with default
    :attribute {b b1}
    :public attribute {c c1}
    :protected attribute {d d1}
  }
  ? {o a 2} 2
  ? {o b} b1
  ? {o c} c1
  ? {o d} "::o: unable to dispatch method 'd'"
}

Test case subcmd {
  
  Class create Foo {

     :method "Info filter guard" {filter} {return [current object]-[current method]}
     :method "Info filter methods" {-guards pattern:optional} {return [current object]-[current method]}
     :method "Info args" {} {return [current object]-[current method]}
     :method "Info foo" {} {return [current object]-[current method]}

     :class-object method "INFO filter guard" {a b} {return [current object]-[current method]}
     :class-object method "INFO filter methods" {-guards pattern:optional} {return [current object]-[current method]}
   }
  
  ? {Foo INFO filter guard 1 2} ::Foo-guard
  ? {Foo INFO filter methods a*} ::Foo-methods
  
  Foo create f1 {
    :method "list length" {} {return [current object]-[current method]}
    :method "list reverse" {} {return [current object]-[current method]}
  }

  ? {f1 Info filter guard x} "::f1-guard"
  ? {f1 Info filter methods} "::f1-methods"
  ? {f1 Info args} "::f1-args"
  ? {f1 Info foo} "::f1-foo"

  ? {f1 list length} "::f1-length"
  ? {f1 list reverse} "::f1-reverse"
}
