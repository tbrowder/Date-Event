unit class Date::Event;

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

method is-calc(Bool $v?) {
    if $v.defined {
        $!is-calculated = $v
    }
    else {
        return $!is-calculated
    }
}
