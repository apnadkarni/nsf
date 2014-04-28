# Tcl package index file, version 1.1
# This file is generated by the "pkg_mkIndex -direct" command
# and sourced either when an application starts up or
# by a "package unknown" script.  It invokes the
# "package ifneeded" command to set up package-related
# information so that packages will be loaded automatically
# in response to "package require" commands.  When this
# script is sourced, the variable $dir must contain the
# full path name of this file's directory.

package ifneeded xotcl::actiweb::agent 1.0 [list source [file join $dir Agent.xotcl]]
package ifneeded xotcl::actiweb::agentManagement 1.0 [list source [file join $dir AgentManagement.xotcl]]
package ifneeded xotcl::actiweb::htmlPlace 1.0 [list source [file join $dir HtmlPlace.xotcl]]
package ifneeded xotcl::actiweb::httpPlace 1.0 [list source [file join $dir HttpPlace.xotcl]]
package ifneeded xotcl::actiweb::invoker 1.0 [list source [file join $dir Invoker.xotcl]]
package ifneeded xotcl::actiweb::pageTemplate 1.0 [list source [file join $dir pageTemplate.xotcl]]
package ifneeded xotcl::actiweb::placeAccessControl 1.0 [list source [file join $dir PlaceAccessControl.xotcl]]
package ifneeded xotcl::actiweb::secureHtmlPlace 1.0 [list source [file join $dir SecureHtmlPlace.xotcl]]
package ifneeded xotcl::actiweb::secureHttpPlace 1.0 [list source [file join $dir SecureHttpPlace.xotcl]]
package ifneeded xotcl::actiweb::sendStrategy 1.0 [list source [file join $dir SendStrategy.xotcl]]
package ifneeded xotcl::actiweb::userMgt 1.0 [list source [file join $dir UserMgt.xotcl]]
package ifneeded xotcl::actiweb::webAgent 1.0 [list source [file join $dir WebAgent.xotcl]]
package ifneeded xotcl::actiweb::webDocument 1.0 [list source [file join $dir WebDocument.xotcl]]
package ifneeded xotcl::actiweb::webObject 1.0 [list source [file join $dir WebObject.xotcl]]