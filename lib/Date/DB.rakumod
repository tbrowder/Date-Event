unit class Date::DB;

use Date::Event;
use Date::Utilities;

has $.path-to-module is required;
has $.data-hash-name is required;
has %.data;

has Date %.dates;

=begin comment
submethod TWEAK {
    # read the hash of data
    use lib $.path-to-module.dirname;
    %!data = $!data-hash-name;
    # convert to a date/event entry
}
=end comment

proto method get-events(:$year, :$set-id --> Hash of Date) {*};
proto method events(:$year, :$set-id --> Hash of Date) {*};
#proto method load-data(:$year, :$set-id) {*};
#proto method load-data() {*};
