requires 'perl', '5.008001';
requires 'Object::Simple';
requires 'Path::Tiny';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::Exception';
    requires 'Capture::Tiny';
    requires 'Digest::MD5';
};

