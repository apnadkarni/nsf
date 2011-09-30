package require nx
package provide nx::trait 0.2

# @package nx::trait
# 
# Minimal trait framework with checking in NX, based on
#
#    S. Ducasse, O. Nierstrasz, N. Schärli, R. Wuyts, A. Black:
#    Traits: A Mechanism for Fine-grained Reuse,
#    ACM transactions on Programming Language Systems, Vol 28, No 2, March 2006
#
# Gustaf Neumann (Aug 2011)
#
# Traits are a mechanism for the reuse of methods. In contrary to
# other forms of reuse (e.g. inheritance of methods in a class
# hierarchy or via mixin classes), the methods defined in traits are
# materialized in the target objects and classes. This gives more
# fine-grained control over the reuse of methods and overcomes the
# "total composition ordering" limitation of mixins.
#
# The current implementation does not handle overwrites (conflicting
# definition from several traits), be we handle renames (aliases) and
# we check required methods. "requiredVariables" (not part of the
# ducasse paper) are not checked yet.
#
# In essence, the package provides a class "nx::Trait" to define
# Traits and a method "useTrait" to reuse a trait in trait consumer
# (e.g. a class or another trait).
#
# Usage: 
#     package require nx::trait
#     nx::Trait create .... {
#        ...
#     }
#     nx::Class create .... {
#        ...
#        :useTrait ...
#     }
#
namespace eval ::nx::trait {}

nsf::proc nx::trait::add {obj -per-object:switch traitName {nameMap ""}} {
  array set map $nameMap
  foreach m [$traitName info methods -callprotection all] {
    if {[info exists map($m)]} {set newName $map($m)} else {set newName $m}
    # do not add entries with $newName empty
    if {$newName eq ""} continue
    set traitMethodHandle [$traitName info method origin $m]
    if {${per-object}} {
      $obj ::nsf::classes::nx::Object::alias $newName $traitMethodHandle
    } else {
      $obj public alias $newName $traitMethodHandle
    }
  }
}

nsf::proc nx::trait::checkObject {obj traitName} {
  foreach m [$traitName requiredMethods] {
    #puts "$m ok? [$obj info methods -closure $m]"
    if {[$obj info lookup method $m] eq ""} {
      error "trait $traitName requires $m, which is not defined for $obj"
    }
  }
}
nsf::proc nx::trait::checkClass {obj traitName} {
  foreach m [$traitName requiredMethods] {
    #puts "$m ok? [$obj info methods -closure $m]"
    if {[$obj info methods -closure $m] eq ""} {
      error "trait $traitName requires $m, which is not defined for $obj"
    }
  }
}

nx::Class public method "require trait" {traitName {nameMap ""}} {
  # adding a trait to a class
  nx::trait::checkClass [self] $traitName
  nx::trait::add [self] $traitName $nameMap  
}

nx::Class public method "require class trait" {traitName {nameMap ""}} {
  # adding a trait to the class object
  nx::trait::checkObject [self] $traitName
  nx::trait::add [self] -per-object $traitName $nameMap  
}

nx::Object public method "require trait" {traitName {nameMap ""}} {
  # adding a trait to an object
  nx::traitCheckObject [self] $traitName
  nx::traitAdd [self] -per-object $traitName $nameMap
}

nx::Class create nx::Trait {

  :property {requiredMethods:0..n,incremental ""}
  :property {requiredVariables:0..n,incremental ""}

  :public method "require trait" {traitName {nameMap ""}} {
    # adding a trait to a trait
    nx::trait::add [self] -per-object $traitName $nameMap
    set finalReqMethods {}
    foreach m [lsort -unique [concat ${:requiredMethods} [$traitName requiredMethods]]] {
      if {[:info lookup method $m] eq ""} {lappend finalReqMethods $m}
    }
    #puts "final reqMethods of [self]: $finalReqMethods // defined=[:info methods]"
    set :requiredMethods $finalReqMethods
  }
}