use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Crypt::CAST5_PP',
    'VERSION_FROM'	=> 'CAST5_PP.pm', # finds $VERSION
    'PREREQ_PM'		=> {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'CAST5_PP.pm', # retrieve abstract from module
       AUTHOR     => 'Bob Mathews <bobmathews@mindspring.com>') : ()),
);
