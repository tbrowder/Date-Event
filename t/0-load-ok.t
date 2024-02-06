use Test;
use Date::Event;
use Date::DB;
use Date::Utilities;

use UUID::V4;

use lib "data";

use-ok "Date::Event";
use-ok "Date::DB";
use-ok "Date::Utilities";

my $site-id = uuid-v4;
is is-uuid-v4($site-id), True, "is uuid-v4";

done-testing;

=finish

BEGIN {
#    use lib 't/data';
    use lib 'lib';
}

class BdayEvent does Date::Event {
};

class BdayDB does Date::Event::DB {
    submethod TWEAK() {
        # read the hash of data
        my $p = $!path-to-module;
        my $dir = $p.IO.dirname;

        # we need to load that module
        require ::('BdayData');

        my $cur-dir = $*CWD;
        say "cur dir is '$cur-dir'";
        %!data = %BdayData::events.Hash; #$!data-hash-name;
    }

    multi method get-events(:$year, :$set-id --> Hash of Date) {
    }

    multi method load-data() {
        # read the hash of data
        # use lib $!path-to-module.dirname;
        # use Data;
        # %!data = %events; #$!data-hash-name;
    }
}

my $year = 2024;
my $set-uid  = uuid-v4();

my $path-to-module = "./t/data/BdayData.rakumod";
my $data-hash-name = "%events";

my $db = BdayDB.new: :$path-to-module, :$data-hash-name;
is $db.path-to-module, $path-to-module;
#$db.load-data;


#is $db.data-hash-name, :$data-hash-name;

=finish
my %e = get-events :$year; :$set-uid;

done-testing;
