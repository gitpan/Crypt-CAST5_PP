# See if we can interoperate with Crypt::CBC
use Test::More;
eval "use Crypt::CBC 1.22";
plan skip_all => "Crypt::CBC 1.22 required for this test" if $@;
plan tests => 3;

$cbc = Crypt::CBC->new("0123456789abcdef", "CAST5_PP");

my $msg = $cbc->decrypt(pack("H*",
    "52616e646f6d49567878787878787878dfded8538c2ca967426a9c38006d5673"
));
is(unpack("H*",$msg), unpack("H*","foo bar baz"), "decryption");

$msg = "'Twas brillig, and the slithy toves";
my $c = $cbc->encrypt($msg);
is(length($c), 56, "ciphertext length check");
my $d = $cbc->decrypt($c);
is(unpack("H*",$d), unpack("H*",$msg), "encrypt-decrypt");

# end 2cbc.t
