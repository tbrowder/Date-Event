role Date::DB;

has $.path-to-module is required;
has $.data-hash-name is required;

has Date %.dates;

subset TWEAK {
    # read the hash of data
    # convert to a date/event entry
}

proto method get-events(:$year, :$set-id --> Hash of Date) {*};
proto method events(:$year, :$set-id --> Hash of Date) {*};
proto method load-data-db(:$path-to-module, :$data-hash-name) {*}

