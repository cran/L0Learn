## -*- mode: autoconf; autoconf-indentation: 4; -*-
##
##  L0Learn configure.ac

## require at least autoconf 2.61
AC_PREREQ(2.61)

## Process this file with autoconf to produce a configure script.
AC_INIT([L0Learn], 2.0.9)

## Set R_HOME, respecting an environment variable if one is set
: ${R_HOME=$(R RHOME)}
if test -z "${R_HOME}"; then
    AC_MSG_ERROR([Could not determine R_HOME.])
fi

CXX=$(${R_HOME}/bin/R CMD config CXX)
CXXFLAGS=$("${R_HOME}/bin/R" CMD config CXXFLAGS)


AC_LANG(C++)
AC_REQUIRE_CPP
AC_PROG_CXX
AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT
