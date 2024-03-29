use Test;
use Date::Event;
use Date::DB;
use Date::Utilities;
use UUID::V4;

my $o;
my $year = 2024;
my $set-id = uuid-v4;

$o = Date::Event.new: :$year, :$set-id;
isa-ok $o, Date::Event;

is $o.etype, "Unknown", "default Etype: Unknown";
is $o.etype(200), "Other", "name of a given EType number 200";
is $o.etype(150), "Astro", "name of a given EType number 200";
is $o.etype(12), "Liturgy", "name of a given EType number 12";

$o = Date::Event.new: :$year, :name<Easter>, :Etype(12);
cmp-ok $o.etype, '~~', Liturgy, "enums smart match";
is $o.etype, "Liturgy", "can use literal name of .etype";

my $m = EType.enums;
isa-ok $m, Map;
is $m<Unknown>, 0, "created an enums map";
is $m.elems, 16, "there are 16 enums as expected";
is $m<Holiday>, 100, "value 100 is a Holiday event";


for $m.kv -> $k, $v {
    isa-ok $k, Str;
    isa-ok $v, UInt;
}

done-testing;
