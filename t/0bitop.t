# make sure some bitwise ops work the way we want
use Test::More tests => 3;
use integer;
my $x;

$x = 1;
is(hexword($x-2), "ffffffff", "negative");

$x = 0x7fffffff;
is(hexword($x+$x+$x), "7ffffffd", "overflow");

$x = -1;
{no integer; $x = ($x&0xffffffff)>>1}
is(hexword($x), "7fffffff", "right shift with zero-extend");

sub hexword { unpack "H*", pack "N", $_[0] }

