[comment {-*- tcl -*- manpage fragment for property method, shared by nx::Object and nx::Class}]

[keywords "property"]
[keywords "slot object"]
[keywords "call protection"]
[keywords "public"]
[keywords "protected"]
[keywords "private"]
[keywords "switch"]
[keywords "value checker"]
[keywords "multiplicity"]

[comment {
  At the time of writing, the only material difference between
  property and variable is a different -configurable default.
}]

Defines a [term property] for the scope of the [vset SCOPE]. The [arg spec] provides
the [term property] specification as a [cmd list] holding at least one
element or, maximum, two elements: 
[emph propertyName][opt ":[emph typeSpec]"] [opt [emph defaultValue]]. The [arg propertyName] sets
the name of the property and the corresponding object variable(s). It
is, optionally, equipped with a [emph typeSpec] following a colon
delimiter which specifies a [term "value checker"] for the values
which become assigned to the property. The second, optional element
sets a [emph defaultValue] for this property.

[para] 

If [option "-accessor"] is set, a property will provide for
a pair of getter and setter methods:
[list_begin definitions]
[def "[arg obj] [arg propertyName] [method set] [arg value]"]
Sets the [term property] [arg propertyName] to [arg value].
[def "[arg obj] [arg propertyName] [method get]"]
Returns the current value of [term property] [arg propertyName].
[list_end]
The option value passed along [option "-accessor"] sets the level of
[term "call protection"] for the generated getter and setter methods: [term public],
[term protected], or [term private]. By default, no getter and setter
methods are created.

[para]

Turning on the [term switch] [option -incremental] provides a refined
setter interface to the value managed by the [term property]. First,
setting [option -incremental] implies requesting [option -accessor]
(set to [emph public] by default, if not specified
explicitly). Second, the managed value will be considered a valid Tcl
list. A [term multiplicity] of [const 1..*] is set by default, if not
specified explicitly as part of [arg spec] (see above). Third, to
manage this list value element-wise ([emph incrementally]), two
additional setter methods become available:

[list_begin definitions]
[def "[arg obj] [arg propertyName] [method add] [arg element] [opt [arg index]]"]
Adding [arg element] to the managed list value, at the list position given by [arg index] (by default: 0).
[def "[arg obj] [arg propertyName] [method delete] [arg element] [opt [arg index]]"]
Removing the first occurrence of [arg value] from the managed list value, starting from list position [arg index] (by default: [const end]).
[list_end]


[para]

By setting [option -configurable] to [const true] (the default), the
property can be accessed and modified through [method cget] and
[method configure], respectively. If [const false], no configuration option
will become available via [method cget] and [method configure].
[para]
If neither [option -accessor] nor [option -configurable] are
requested, the value managed by the [term property] will have to be accessed
and modified directly. If the property manages an object variable, its
value will be readable and writable using [cmd set] and [method eval].

[para]

A [term property] becomes implemented by a [term "slot object"] under any of the following conditions:
[list_begin itemized]
[item] [option -configurable] equals [const true] (by default).
[item] [option -accessor] is one of [const public], [const protected], or [const private].
[item] [option -incremental] is turned on.
[item] [arg initBlock] is not an empty string.
[list_end]
Assuming default settings, every [term property] is realized by a
[term "slot object"].
[para]
Provided a [term "slot object"] managing the [term property] is to be
created, a custom class [arg className] from which this [term "slot object"] is
to be instantiated can be set using [option -class]. The
default value is [cmd ::nx::VariableSlot].

[para]

The last argument [arg initBlock] accepts an optional Tcl script which is passed into
the initialization procedure (see [method configure]) of the [term property]'s [term "slot object"]. See
also [sectref description "[arg initBlock] for [method create] and [method new]"].