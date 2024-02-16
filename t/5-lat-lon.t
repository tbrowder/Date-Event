use Test;
use Date::Event;
use Date::DB;
use Date::Utilities;

use UUID::V4;

use lib "data";

my $o;
my $year = 2024;
my $set-id = uuid-v4;

$o = Date::Event.new: :$year, :$set-id, :Etype(150);
isa-ok $o, Date::Event;

use-ok "Date::Event";
use-ok "Date::DB";
use-ok "Date::Utilities";

is $o.etype, "Astro", "Event type 150 was set on instantiation";
$o.lat: 50;
$o.lon: 60;
is $o.lat, 50;
is $o.lon, 60;

$o.lat: -55.5;
$o.lon: -60.123456789;
is $o.lat, -55.5;
is $o.lon, -60.123456789;

dies-ok { $o.lon: -180.1; }
dies-ok { $o.lon:  180.1; }

dies-ok { $o.lat: -90.1; }
dies-ok { $o.lat:  90.1; }

done-testing;
