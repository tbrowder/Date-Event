use Test;
use Date::Event;

use-ok "Date::Event";

class Event is Date::Event {};

my $e;
my %events; # defined in BEGIN block at eof

my $year = 2024;

my %e = get-events :$year;
is %e.elems, 1;
lives-ok {
    for %e.keys -> $date {
        is $date, '2024-07-04';
        is %e{$date}.elems, 2;
        for %e{$date}.keys -> $id {
            my $e = %e{$date}{$id};
            isa-ok $e, Event;
        }
    }
}

# Example in README SYNOPSIS
my $d = Date.new("2024-07-04");
$e = %e{$d}<june>;
is $e.name, "Birthday";
$e = %e{$d}<2>;
is $e.name, "Anniversary";

done-testing;

BEGIN {
    %events = %(
        june => {
            name => "Birthday",
            date => "0000-07-04",
            short-name => "",
        },
        2 => {
            name => "Anniversary",
            date => "0000-07-04",
            short-name => "",
        },
    );
}

sub get-events(:$year!, :$debug --> Hash) is export {
    my %e;
    # go through the hash data and convert to the current year
    for %events.keys -> $id {
        my Date $date;
        my $date-str = %events{$id}<date>;
        my $name = %events{$id}<name>;
        if $date-str ~~ /^ \h* '0000' '-' (\d\d) '-' (\d\d)/ {
            my $month = ~$0;
            my $day   = ~$1;
            $date = Date.new: :$year, :$month, :$day;
        }
        else {
            die "FATAL:  Invalid date string '$date-str' (expected format: '0000-mm-dd')";
        }
        my Event $e = Event.new: :$year, :$id, :$name, :$date;
        if %e{$date}{$id}:exists {
            die "FATAL:  Duplicate ID '$id'";
        }
        %e{$date}{$id} = $e
    }
    %e
}
