Summary: Object Oriented Extension for Tcl
Name: xotcl
Version: @FULLVERSION@
Release: 0
Copyright: open source
Group: Development/Languages
Source:  http://www.xotcl.org/xotcl-@FULLVERSION@.tar.gz
URL: http://www.xotcl.org
Packager: Gustaf.Neumann@wu-wien.ac.at
Distribution: RedHat 8.0
Requires: tcl
Prefix: /usr

%description
XOTcl is an object-oriented scripting language based on MIT's OTcl.
This packages provides a pre-packaged tcl-shell (xotclsh) and tk-shell
(xowish) together with the Tcl-extension (libxotcl.so) which can be
loaded to any Tcl-application. Furthermore it includes several
xotcl-based packages for e.g. HTTP client and server, XML, RDF,
persistent object store, mobile code system, etc. For more details
consult http://www.xotcl.org

%prep
%setup -q -n xotcl-@FULLVERSION@


%build
cd unix
./configure --with-tcl=/usr/lib --with-all --prefix=/usr --exec-prefix=/usr
make

%install
cd unix
make install

%files
%define _unpackaged_files_terminate_build      0
%undefine       __check_files

%doc doc 
/usr/lib/xotcl@VERSION@
/usr/bin/xotclsh
/usr/bin/xowish
/usr/lib/libxotcl@VERSION@.so
/usr/lib/libxotclstub@VERSION@.a
/usr/include/xotclDecls.h
/usr/include/xotcl.h
/usr/include/xotclIntDecls.h
/usr/include/xotclInt.h
