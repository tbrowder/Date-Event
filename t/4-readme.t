use Test;

# in the README =====================================
use Date::Event;

my $date = Date.new: :year(2024), :month(12), :day(31);

my $e = Date::Event.new: :$date, :Etype<Birthday>;
# end of the README =====================================

my $e2;

isa-ok $e, Date::Event;
is $e.Etype, 11, "Etype value 11 is Birthday";

my %m = EType.enums;
for %m.kv -> $name, $value {
    $e = Date::Event.new: :$date, :Etype($name);
    is $e.Etype, $value, "Etype value for '$name' is '$value'";

    $e2 = Date::Event.new: :$date, :Etype($value);
    is $e2.Etype, $name, "Etype name  for value '$value' is '$name'";
}

dies-ok {
    $e = Date::Event.new: :$date, :Etype(300);
}, "invalid Etype value of 300";

dies-ok {
    $e = Date::Event.new: :$date, :Etype<Moon>;
}, "invalid Etype value of 'Moon'";

done-testing;
