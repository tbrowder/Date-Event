#!/usr/bin/env raku
use MONKEY-SEE-NO-EVAL;

use JSON::Fast;

my $ofil = "../t/data/hol-dates.json";
my $ifil = "./hol-dates.txt";

my %h = EVALFILE $ifil;
dd %h;


my $htxt = slurp $ifil;
%h = EVAL $htxt;
dd %h;
=finish
# remove newlines
$htxt = $htxt.words.join(" ");
my $c = $htxt.index: "=";
say $htxt.chars;
say $c;
my $h = $htxt.substr: $c+1;
my %h = EVAL $h.Hash;

=finish
my $jstr = to-json %h;




# say $htxt;
my $h = ($htxt.substr: $c+1).Hash;
say $h.raku;
=finish

say $jstr;

spurt $ofil, $jstr;

=finish

# contents of hol-dates.txt initially:
my %events = %(
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
