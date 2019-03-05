
struct riak_op_t {
  int tag;
  string op;
  string stage;
  string bk;
};
typedef struct riak_op_t riak_op_t;


translator riak_op_t < uint64_t tag > {
  tag = tag;
  op = tag>=500 && tag<=512 ? "get"
     : tag>=520 && tag<=532 ? "put"
     : tag>=535 && tag<=537 ? "delete"
     : "?";
  stage =
       tag==532 ? "decode_postcommit"
     : tag==525 ? "waiting_local_vnode"
     : tag==546 ? "process_results"
     : tag==503 ? "execute"
     : tag==509 ? "maybe_delete"
     : tag==523 ? "precommit"
     : tag==545 ? "init"
     : tag==504 ? "preflist"
     : tag==529 ? "postcommit"
     : tag==511 ? "waiting_rr"
     : tag==505 ? "waiting_r"
     : tag==501 ? "prepare"
     : tag==502 ? "validate"
     : tag==528 ? "process_reply"
     : tag==537 ? "reaper_get_done"
     : tag==535 ? "init1"
     : tag==522 ? "validate"
     : tag==526 ? "execute_remote"
     : tag==524 ? "execute_local"
     : tag==508 ? "finalize"
     : tag==507 ? "client_reply"
     : tag==500 ? "init"
     : tag==521 ? "prepare"
     : tag==547 ? "finish"
     : tag==540 ? "init"
     : tag==536 ? "init2"
     : tag==542 ? "finish"
     : tag==531 ? "decode_precommit"
     : tag==506 ? "waiting_r_timeout"
     : tag==530 ? "finish"
     : tag==541 ? "process_results"
     : tag==527 ? "waiting_remote_vnode"
     : tag==520 ? "init"
     : tag==510 ? "rr"
     : tag==512 ? "waiting_rr_timeout"
     : "?";

  bk = arg1 ? copyinstr(arg1) : "";
};

inline riak_op_t riak_op = xlate<struct riak_op_t>(arg2);

