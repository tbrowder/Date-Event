#!/usr/bin/env raku
use Test;

class A {
    has $.a; # = 1;
    submethod TWEAK {
        $!a = 2
    }
}

class B is A {
    has $.a = 2;
    submethod TWEAK {
        $!a = 4
    }
}

my $a = A.new;
is $a.a, 2;
my $b = B.new;
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
