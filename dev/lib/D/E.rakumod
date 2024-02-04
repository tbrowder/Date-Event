unit class D::E;

use D::V;

# event object
# uses D::V
# used by D::B;

class D::E {
    has $.a; # = 1;
    submethod TWEAK {
        $!a = 2
    }
}

