use strict;
use Test::More 0.98;
use Test::Exception;
use Getopt::Kingpin;


subtest 'arg' => sub {
    local @ARGV;
    push @ARGV, qw(--name=kingpin arg1 arg2);

    my $kingpin = Getopt::Kingpin->new;
    my $name = $kingpin->flag('name', 'set name')->string();
    my $arg1 = $kingpin->arg('arg1', 'set arg1')->string();
    my $arg2 = $kingpin->arg('arg2', 'set arg2')->string();

    $kingpin->parse;

    is $name, 'kingpin';
    is $arg1, 'arg1';
    is $arg2, 'arg2';
};

subtest 'arg required' => sub {
    local @ARGV;
    push @ARGV, qw(--name=kingpin arg1);

    my $kingpin = Getopt::Kingpin->new;
    my $name = $kingpin->flag('name', 'set name')->string();
    my $arg1 = $kingpin->arg('arg1', 'set arg1')->string();
    my $arg2 = $kingpin->arg('arg2', 'set arg2')->required->string();

    throws_ok {
        $kingpin->parse;
    } qr/required arg 'arg2' not provided/, 'required error';
};

subtest 'arg required 2' => sub {
    local @ARGV;
    push @ARGV, qw(--name=kingpin);

    my $kingpin = Getopt::Kingpin->new;
    my $name = $kingpin->flag('name', 'set name')->string();
    my $arg1 = $kingpin->arg('arg1', 'set arg1')->string();
    my $arg2 = $kingpin->arg('arg2', 'set arg2')->required->string();

    # requiredがついている手前は、全てrequiredの扱い
    throws_ok {
        $kingpin->parse;
    } qr/required arg 'arg1' not provided/, 'required error';
};

subtest 'arg required 3' => sub {
    local @ARGV;
    push @ARGV, qw(--name=kingpin arg1 arg2);

    my $kingpin = Getopt::Kingpin->new;
    my $name = $kingpin->flag('name', 'set name')->string();
    my $arg1 = $kingpin->arg('arg1', 'set arg1')->string();
    my $arg2 = $kingpin->arg('arg2', 'set arg2')->required->string();

    # requiredがついている手前は、全てrequiredの扱い
    lives_ok {
        $kingpin->parse;
    };

    is $arg1, 'arg1';
    is $arg2, 'arg2';
};

done_testing;

