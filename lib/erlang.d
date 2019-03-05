
struct erlang_t {
  string pid;
};
typedef struct erlang_t erlang_t;

translator erlang_t < uint64_t pid > {
  pid = copyinstr(pid);
};

inline erlang_t erlang = xlate<erlang_t> (arg0);

