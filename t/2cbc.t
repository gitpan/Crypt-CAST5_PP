# See if we can interoperate with Crypt::CBC
use Test::More tests => 3;

SKIP: {
  my $cbc;
  eval {
    require Crypt::CBC;
    $cbc = Crypt::CBC->new("0123456789abcdef", "CAST5_PP");
    die "Unsupported Crypt::CBC version"
        if $Crypt::CBC::VERSION < 1.22;
  };
  skip "Couldn't load Crypt::CBC", 3 if $@;

  my $msg = $cbc->decrypt(pack("H*",
      "52616e646f6d49567878787878787878dfded8538c2ca967426a9c38006d5673"
  ));
  is(unpack("H*",$msg), unpack("H*","foo bar baz"), "decryption");

  $msg = "'Twas brillig, and the slithy toves";
  my $c = $cbc->encrypt($msg);
  is(length($c), 56, "ciphertext length check");
  my $d = $cbc->decrypt($c);
  is(unpack("H*",$d), unpack("H*",$msg), "encrypt-decrypt");
} # skip

# end 2cbc.t
