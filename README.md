[![Actions Status](https://github.com/tbrowder/Date-Event/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/Date-Event/actions) [![Actions Status](https://github.com/tbrowder/Date-Event/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/Date-Event/actions) [![Actions Status](https://github.com/tbrowder/Date-Event/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/Date-Event/actions)

NAME
====

**Date::Event** - Provides a class suitable for use with calendars or any Raku program associated with the Raku Date type

SYNOPSIS
========

```raku
use Date::Event;
```

DESCRIPTION
===========

**Date::Event** is a class that provides basic attributes to describe an event occurring on a particular `Date`. It is suitable for multiple instances on a `Date` and is defined as follows:

    enum EType (
        Birth       => 1, 
        Christening => 2,
        Baptism     => 3,
        BarMitzvah  => 4,
        BatMitzvah  => 5,
        Graduation  => 6,
        Wedding     => 7,
        Anniversary => 8,
        Retirement  => 9,
        Death       => 10,

        Holiday     => 100,
        Other       => 200,
    );

    class Date::Event {
        has $.id;
        has $.name;
        has $.short-name;
        has EType $.type;
        has Date $.date;
        has Date $.date-observed;
        has $.notes;
    }

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2023 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

