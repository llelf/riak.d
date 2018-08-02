#!/usr/bin/env perl6

for "riak.hrl".IO.slurp.lines.grep(*.starts-with('-define')) {
  / ｢-define(｣ <ident> "," <.ws> $<n>=<digit>+ ｢).｣ /;
  given $<ident> {
    when / "C_" (.+) "_FSM_" (.+) / { "$0/$1" }
    when / "C_DELETE_" (.+) /       { "delete/$0" }
    when / "C_BUCKETS_" (.+) /      { "list-buckets/$0" }
    when / "C_KEYS_" (.+) /         { "list-keys/$0" }
  }
}

