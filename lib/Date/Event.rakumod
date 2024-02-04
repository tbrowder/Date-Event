unit class Date::Event;

use JSON::Fast;
use Date::Utilities;

enum EType is export (
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

# This id is for use in multiple sets of events:
has Str   $.set-uid        = "";
# This id is for use in a single set of events:
has Str   $.id             = "";
has Str   $.name           = "";
has Str   $.short-name     = "";
has EType $.type;
has Date  $.date;
has Date  $.date-observed;
has Str   $.notes          = "";
has Bool  $.is-calculated  = False; #= Default is a directed or
#= traditionally observed date
#= (e.g., St. Patrick's Day).

# Additional attributes for use with module 'Date::Utils'"
has UInt $.nth-value;
has UInt $.nth-dow;
has UInt $.nth-month-number;

method is-calculated(Bool $v?) {
    if $v.defined {
        $!is-calculated = $v
    }
    else {
        return $!is-calculated
    }
}

method attr-info(--> Hash) is export {
    my @attrs = self.^attributes;
    my @names;
    my @values;
    my %h;
    for @attrs.kv -> $i, $a {
        my $name = $a.name;
        $name ~~ s/\S\S//;
        @names.push: $name;
        %h{$i}<name> = $name;

        my $value = $a.get_value: self;
        @values.push: $value;
        %h{$i}<value> = $value;
    }
    %h
}


# in DB role: proto method get-events(:$year, :$set-id --> Hash of Date) {*};
# in DB role: proto method load-data() {*};

#| This method combines the $set-id with the event's $id to yield its
#| $gid (global ID)
method make-gid(:$set-id!, :$id!) {
    $id ~ '|' ~ $set-id
}
method split-gid(:$gid! --> List) {
    $gid.split: '|';
}

=finish

method is-calculated(Bool $v?) {
    if $v.defined {
        $!is-calculated = $v
    }
    else {
        return $!is-calculated
    }
}

method is-calc(Bool $v?) {
    if $v.defined {
        $!is-calculated = $v
    }
    else {
        return $!is-calculated
    }
}
