unit class Date::Event;

use JSON::Fast;
use Date::Utilities;

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
    Liturgy     => 12,  # event related to worship, e.g, Easter

    Holiday     => 100,
    Astro       => 150, # this event depends on geographic location
                        # and local UTC offset
    Other       => 200,
);

# This id is for use in multiple sets of events:
has Str   $.set-id         = "";
# This id is for use in a single set of events:
has Str   $.id             = "";
has Str   $.name           = "";
has Str   $.short-name     = "";
has       $.Etype          = 0;
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

# Additional attributes for Astro events
has Numeric  $.lat where {  -90 <= $_ <=  90 };
has Numeric  $.lon where { -180 <= $_ <= 180 };
has DateTime $.time;

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

method lat(Numeric $v?) {
    if $v.defined {
        $!lat = $v
    }
    else {
        return $!lat
    }
}

method lon(Numeric $v?) {
    if $v.defined {
        $!lon = $v
    }
    else {
        return $!lon
    }
}

method is-calculated(Bool $v?) {
    # for holidays that are calculated
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
