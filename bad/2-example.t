use Test;
use Date::Event;

use-ok "Date::Event";

class Event is Date::Event {};

my $e;
my $uid = 'x';
my %events; # defined in BEGIN block at eof

my $year = 2024;

my %e = get-events :$year, :$uid;
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

sub get-events(:$year!, :$uid!, :$debug --> Hash) is export {
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
        my $ID = $uid~$id;
        my Event $e = Event.new: :$year, :id($ID), :$name, :$date;
        if %e{$date}{$ID}:exists {
            die "FATAL:  Duplicate ID '$ID'";
        }
        %e{$date}{$ID} = $e
    }
    %e
}
