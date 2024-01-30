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

has $.id = "";
has Str $.name = "";
has Str $.short-name = "";
has EType $.type;
has Date $.date;
has Date $.date-observed0;
has Str $.notes = "";
has Bool $.is-calculated = False; #= Default is a directed or
                                  #= traditionally observed date
                                  #= (e.g., St. Patrick's Day).

method is-calculated(Bool $v?) {
    if $v.defined {
        $!is-calculated = $v
    }
    else {
        return $!is-calculated
    }
}
