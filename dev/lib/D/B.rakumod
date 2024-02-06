unit class D::B;

use D::E;
use D::V;
# database, uses D::E and D::V

class D::B {
    has $.a = 2;
    submethod TWEAK {
        $!a = 4
    }
}
