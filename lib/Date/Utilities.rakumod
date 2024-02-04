unit module Date::Utilities;

use JSON::Fast;

=begin comment
my $ofil = "../t/data/hol-dates.json";
my $ifil = "./hol-dates.txt";
my %h = EVALFILE $ifil;
dd %h;
my $htxt = slurp $ifil;
%h = EVAL $htxt;
dd %h;
# remove newlines
$htxt = $htxt.words.join(" ");
my $c = $htxt.index: "=";
say $htxt.chars;
say $c;
my $h = $htxt.substr: $c+1;
my %h = EVAL $h.Hash;
my $jstr = to-json %h;
# say $htxt;
my $h = ($htxt.substr: $c+1).Hash;
say $h.raku;
say $jstr;
spurt $ofil, $jstr;
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
=end comment
# rakumod
sub load-rakumod() is export {
    use MONKEY;

    # input should have one hash defined
}
sub output-rakumod() is export {
}

# JSON
sub load-json() is export {
}
sub output-json() is export {
}

# CSV
sub load-csv() is export {
}
sub output-csv() is export {
}
