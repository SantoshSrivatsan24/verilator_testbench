`define UNUSED_VAR(x) \
    generate \
        /* verilator lint_off UNUSED */ \
        bit [$bits(x)-1:0] __``x = x; \
        /* verilator lint_on UNUSED */ \
    endgenerate
