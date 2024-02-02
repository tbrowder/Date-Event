#!/usr/bin/env raku
use Test;

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
