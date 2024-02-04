#!/usr/bin/env raku
use Test;

use lib 'lib';
use D::E;
use D::B;
use D::V;

my $e = D::E.new;
my $b = D::B.new;
is $e.a, 2;
is $b.a, 4;

=finish


use UUID::V4;
my $uuid = uuid-v4();
isa-ok $uuid, Str;

# 2024-02-01 #raku, 0626
role Foo {
    proto method Bar($a, $b) {*};
}

class A does Foo {
    multi method bar($a, $b?) {
        say "in class A, a = ", $a // '?';
    }
}

say "Contructing an instance of class A...";
my $o = A.new;
$o.bar: "b";
