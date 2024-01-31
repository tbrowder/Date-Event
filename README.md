[![Actions Status](https://github.com/tbrowder/Date-Event/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/Date-Event/actions) [![Actions Status](https://github.com/tbrowder/Date-Event/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/Date-Event/actions) [![Actions Status](https://github.com/tbrowder/Date-Event/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/Date-Event/actions)

NAME
====

**Date::Event** - Provides a class suitable for use with calendars or any Raku program associated with the Raku Date type

SYNOPSIS
========

```raku
use Date::Event;
my $year = 2024;
my $uid = 'x'; # use the $uid to uniquely identify this set of events
my %e = get-events(:$year, :$uid); # OUTPUT: «...hash of hashes of events per Date␤»
say "Showing database of events for year $year";
for %e.keys -> $date {
    say "  date: $date"; # OUTPUT: «  date: 2024-07-04␤»
    for %h{$date}.keys -> $id {
        my $e = %e{$date}{$id};
        say "    Event '$e.name'"; OUTPUT: «    Birthday␤»
        last;
    }
    last;
}
```

DESCRIPTION
===========

**Date::Event** is a class that provides basic attributes to describe an event occurring on a particular `Date`. It is suitable for multiple instances on a `Date` and is currently defined as follows:

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
        has Str   $.id;
        has Str   $.name;
        has Str   $.short-name;
        has EType $.type;
        has Date  $.date;
        has Date  $.date-observed;
        has Str   $.notes;
        has Bool  $.is-calculated;

        # For use with Date::Utils:
        has UInt  $.nth-value;
        has UInt  $.nth-dow;
        has UInt  $.nth-month-number;

        # A default event is normally set on a certain date.  Many
        # holidays are an exception in that they are calculated based on
        # one or more date criteria or conversion from another calendar
        # (e.g., from Jewish to Gregorian).  }

    #= Enable the user to change the attribute
    method is-calculated(Bool $v?) {
        if $v.defined {
            $!is-calculated = $v
        }
        else {
            return $!is-calculated
        }
    }

A full example of how to use the module is shown in './t/2-example.t'. Published modules showing similar use are 'Holidays::US:Federal' and 'Holidays::Miscellaneous'. They are special databases that use the 'Date::Event' class to provide a common interface (API) for working with dates. Those modules are being integrated into the next version of published module 'Calendar'.

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2023-2024 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

