
struct riak_op_t {
  int tag;
  string op;
  string stage;
};
typedef struct riak_op_t riak_op_t;


translator riak_op_t < uint64_t tag > {
  tag = tag;
  op = tag>=500 && tag<=512 ? "get"
     : tag>=520 && tag<=532 ? "put"
     : tag>=535 && tag<=537 ? "delete"
     : "?";
  stage = tag==500 || tag==520 ? "init"
        : tag==507 ? "reply"
        : tag==530 ? "finish"
        : "?";
};

inline riak_op_t riak_op = xlate<struct riak_op_t>(arg2);

