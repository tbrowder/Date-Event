use Test;
use Date::Event;

use-ok "Date::Event";

my $e;

$e = Date::Event.new;
is $e.is-calculated, False, "current (default) value of 'is-calculated'";;

$e = Date::Event.new: :is-calculated(True);
is $e.is-calculated, True, "Setting True as current value of 'is-calculated'";;
	
lives-ok {
    $e.is-calculated: True; 
}, "set 'is-calculated' to True'";
is $e.is-calculated, True, "setting is now True";

dies-ok {
    $e.is-calculated: 1;
}, "Setting failure, 'is-calculated' entry must be a Bool";

dies-ok {
    $e.is-calculated: "true";
}, "Setting failure, 'is-calculated' entry must be a Bool";

done-testing;
