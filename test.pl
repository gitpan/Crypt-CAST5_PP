# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

use Test;
BEGIN { plan tests => 8 };
use Crypt::CAST5_PP;
ok(1); # If we made it this far, we're ok.

#########################

my $cast5 = Crypt::CAST5_PP->new();
ok($cast5);

my ($key, $text, $want);
my ($enc, $dec);

# The following tests are from RFC 2144

# 128-bit key test
$key  = pack "H*", "0123456712345678234567893456789A";
$text = pack "H*", "0123456789ABCDEF";
$want = pack "H*", "238B4FE5847E44B2";
$cast5->init($key);
$enc = $cast5->encrypt($text, $rounds, $k);
ok($enc eq $want);
$dec = $cast5->decrypt($enc, $rounds, $k);
ok($dec eq $text);

# 80-bit key test
$key  = pack "H*", "01234567123456782345";
$text = pack "H*", "0123456789ABCDEF";
$want = pack "H*", "EB6A711A2C02271B";
$cast5->init($key);
$enc = $cast5->encrypt($text, $rounds, $k);
ok($enc eq $want);
$dec = $cast5->decrypt($enc, $rounds, $k);
ok($dec eq $text);

# 40-bit key test
$key  = pack "H*", "0123456712";
$text = pack "H*", "0123456789ABCDEF";
$want = pack "H*", "7AC816D16E9B302E";
$cast5->init($key);
$enc = $cast5->encrypt($text, $rounds, $k);
ok($enc eq $want);
$dec = $cast5->decrypt($enc, $rounds, $k);
ok($dec eq $text);

__END__

# This test takes a long time to complete

my $al = pack "H*", "0123456712345678";
my $ar = pack "H*", "234567893456789A";
my $bl = $al;
my $br = $ar;

for (my $i = 1; $i <= 1_000_000; $i++) {
  $cast5->init($bl.$br);
  $al = $cast5->encrypt($al);
  $ar = $cast5->encrypt($ar);
  $cast5->init($al.$ar);
  $bl = $cast5->encrypt($bl);
  $br = $cast5->encrypt($br);
}

my $wanta = pack "H*", "EEA9D0A249FD3BA6B3436FB89D6DCA92";
my $wantb = pack "H*", "B2C95EB00C31AD7180AC05B8E83D696E";
ok($wanta eq $al.$ar);
ok($wantb eq $bl.$br);

