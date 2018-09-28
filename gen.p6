#!/usr/bin/env perl6

class Tag { has (Str $.op, Str $.sop, Int $.n) }
my %Tags of Tag;

for "riak.hrl".IO.slurp.lines.grep(*.starts-with('-define')) {
  / ｢-define(｣ <ident> "," <.ws> $<n>=[<digit>+] ｢).｣ /;
  my $n = +$<n>;
  given $<ident> {
    my (Str $op, Str $sop) = map *.lc, do {
      when / "C_" (.+) "_FSM_" (.+) / { $0, $1 }
      when / "C_DELETE_" (.+) /       { <delete>, $0 }
      when / "C_BUCKETS_" (.+) /      { <list-buckets>, $0 }
      when / "C_KEYS_" (.+) /         { <list-keys>, $0 }
      die $_;
    }

    %Tags{$_} = Tag.new(:$op, :$sop, :$n);
  }
}

#note %Tags.values;

my \indent = ‘ ’ x 4 ~ ' : ';

for %Tags.values {
  say Qc｢{indent}tag=={.n} ? "{.sop}"｣;
}

say indent, ｢"?"｣;
