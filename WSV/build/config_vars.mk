exp_exec_prefix = /kSCproxy/WSV
exp_bindir = /kSCproxy/WSV/bin
exp_sbindir = /kSCproxy/WSV/bin
exp_libdir = /kSCproxy/WSV/lib
exp_libexecdir = /kSCproxy/WSV/modules
exp_mandir = /kSCproxy/WSV/man
exp_sysconfdir = /kSCproxy/WSV/conf
exp_datadir = /kSCproxy/WSV
exp_installbuilddir = /kSCproxy/WSV/build
exp_errordir = /kSCproxy/WSV/error
exp_iconsdir = /kSCproxy/WSV/icons
exp_htdocsdir = /kSCproxy/WSV/htdocs
exp_manualdir = /kSCproxy/WSV/manual
exp_cgidir = /kSCproxy/WSV/cgi-bin
exp_includedir = /kSCproxy/WSV/include
exp_localstatedir = /kSCproxy/WSV
exp_runtimedir = /kSCproxy/WSV/logs
exp_logfiledir = /kSCproxy/WSV/logs
exp_proxycachedir = /kSCproxy/WSV/proxy
EGREP = /bin/grep -E
PCRE_LIBS = -lpcre
SHLTCFLAGS = -prefer-pic
LTCFLAGS = -prefer-non-pic -static
MKINSTALLDIRS = /kSCproxy/WSV/build/mkdir.sh
INSTALL = $(LIBTOOL) --mode=install /kSCproxy/WSV/build/install.sh -c
MATH_LIBS = -lm
CRYPT_LIBS = -lcrypt
DTRACE = true
INSTALL_DSO = yes
MOD_XML2ENC_LDADD = -lxml2
SSL_LIBS = -lssl -lcrypto -lrt -lcrypt -lpthread
NONPORTABLE_SUPPORT = checkgid fcgistarter
progname = httpd
OS = unix
SHLIBPATH_VAR = LD_LIBRARY_PATH
AP_BUILD_SRCLIB_DIRS = apr apr-util
AP_CLEAN_SRCLIB_DIRS = apr-util apr
bindir = ${exec_prefix}/bin
sbindir = ${exec_prefix}/bin
cgidir = ${datadir}/cgi-bin
logfiledir = ${localstatedir}/logs
exec_prefix = /kSCproxy/WSV
datadir = ${prefix}
localstatedir = ${prefix}
mandir = ${prefix}/man
libdir = ${exec_prefix}/lib
libexecdir = ${exec_prefix}/modules
htdocsdir = ${datadir}/htdocs
manualdir = ${datadir}/manual
includedir = ${prefix}/include
errordir = ${datadir}/error
iconsdir = ${datadir}/icons
sysconfdir = ${prefix}/conf
installbuilddir = ${datadir}/build
runtimedir = ${localstatedir}/logs
proxycachedir = ${localstatedir}/proxy
other_targets =
progname = httpd
prefix = /kSCproxy/WSV
AWK = gawk
CC = gcc -std=gnu99
CPP = gcc -E
CXX =
CPPFLAGS =
CFLAGS =
CXXFLAGS =
LTFLAGS = --silent
LDFLAGS =
LT_LDFLAGS =
SH_LDFLAGS =
LIBS =
DEFS =
INCLUDES =
NOTEST_CPPFLAGS =
NOTEST_CFLAGS =
NOTEST_CXXFLAGS =
NOTEST_LDFLAGS =
NOTEST_LIBS =
EXTRA_CPPFLAGS = -DLINUX=2 -D_REENTRANT -D_GNU_SOURCE
EXTRA_CFLAGS = -g -O2 -pthread -I/usr/include/libxml2
EXTRA_CXXFLAGS =
EXTRA_LDFLAGS =
EXTRA_LIBS =
EXTRA_INCLUDES = -I$(includedir) -I. -I/root/CoreSrc/httpd-2.4.3/srclib/apr/include -I/root/CoreSrc/httpd-2.4.3/srclib/apr-util/include -I/root/CoreSrc/httpd-2.4.3/srclib/apr-util/xml/expat/lib
INTERNAL_CPPFLAGS =
LIBTOOL = /kSCproxy/WSV/build/libtool --silent
SHELL = /bin/sh
RSYNC = /usr/bin/rsync
SH_LIBS =
SH_LIBTOOL = $(LIBTOOL)
MK_IMPLIB =
MKDEP = $(CC) -MM
INSTALL_PROG_FLAGS =
ENABLED_DSO_MODULES = ,authn_file,authn_core,authz_host,authz_groupfile,authz_user,authz_core,access_compat,auth_basic,reqtimeout,filter,mime,log_config,env,headers,setenvif,version,unixd,status,autoindex,dir,alias
LOAD_ALL_MODULES = no
APR_BINDIR = /kSCproxy/WSV/bin
APR_INCLUDEDIR = /kSCproxy/WSV/include
APR_VERSION = 1.4.6
APR_CONFIG = /kSCproxy/WSV/bin/apr-1-config
APU_BINDIR = /kSCproxy/WSV/bin
APU_INCLUDEDIR = /kSCproxy/WSV/include
APU_VERSION = 1.5.1
APU_CONFIG = /kSCproxy/WSV/bin/apu-1-config