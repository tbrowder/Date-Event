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

has $.id;
has $.name;
has $.short-name;
has EType $.type;
has Date $.date;
has Date $.date-observed;
has $.notes;
