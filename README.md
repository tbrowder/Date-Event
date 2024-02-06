[![Actions Status](https://github.com/tbrowder/Date-Event/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/Date-Event/actions) [![Actions Status](https://github.com/tbrowder/Date-Event/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/Date-Event/actions) [![Actions Status](https://github.com/tbrowder/Date-Event/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/Date-Event/actions)

NAME
====

**Date::Event** - Provides a class suitable for use with calendars or any program using the Raku Date type

**WARNING**: This version introduces API 2 and backward compatibility with previous versions is not tested.

SYNOPSIS
========

```raku
use Date::Event;

my $date = Date.new: :year(2024), :month(12), :day(31);

# Enter an Etype with a known enum EType name:
my $e  = Date::Event.new: :$date, :Etype<Birthday>;

# Enter an Etype with a known enum EType number
my $e2 = Date::Event.new: :$date, :Etype(11);
```

DESCRIPTION
===========

**Date::Event** is a class that provides basic attributes to describe an event occurring on a particular `Date`. It is suitable for multiple instances on a `Date` and is currently defined as follows:

    unit class Date::Event:api<2>;

    enum EType is export (
        Unknown     => 0,
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
        Birthday    => 11,

        Holiday     => 100,
        Other       => 200,
    );

    has Str   $.set-id                  = "";
    has Str   $.id                      = "";
    has Str   $.name;                   = "";
    has Str   $.short-name              = "";
    has       $.Etype                   = 0;
    has Date  $.date;
    has Date  $.date-observed;
    has Str   $.notes                   = "";
    has Bool  $.is-calculated           = False;

    # For use with Date::Utils:
    has UInt  $.nth-value;
    has UInt  $.nth-dow;
    has UInt  $.nth-month-number;

    submethod TWEAK {
        $!Etype = self.etype($!Etype)
    }

    multi method etype(Str $v? --> UInt) {
        my %m = EType.enums;
        if $v.defined {
            return %m{$v}
        }
        else {
            return %m{self.Etype}
        }
    }

    multi method etype(UInt $v? --> EType) {
        if $v.defined {
            return EType($v)
        }
        else {
            return EType(self.Etype)
        }
    }

    # A default event is normally set on a certain date.  Many holidays
    # are an exception in that they are calculated based on one or more
    # date criteria or conversion from another calendar (e.g., from Jewish
    # to Gregorian).  }

    #= Enable the user to change the attribute
    #= during development
    method is-calculated(Bool $v?) {
        if $v.defined {
            $!is-calculated = $v
        }
        else {
            return $!is-calculated
        }
    }

A an example of how to use the module is shown in './t/2-example.t'. Published modules showing similar use are 'Holidays::US:Federal' and 'Holidays::Miscellaneous'. They include special databases that use the 'Date::Event' class to provide a common interface (API) for working with dates. Those modules are being integrated into the next version of published module 'Calendar'.

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2023-2024 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

