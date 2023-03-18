use Test;
use Date::Event;

use-ok "Date::Event";

my $e = Date::Event.new;
is $e.is-calculated, False;
$e.is-calc;
is $e.is-calculated, True;

done-testing;
