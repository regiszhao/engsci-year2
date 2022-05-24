module and(x, y, f);
    input x, y;
    output f;

    assign f = x & y;
endmodule

module or(x, y, f);
    input x, y;
    output f;

    assign f = x | y;
endmodule

module not(x, f);
    input x;
    output f;

    assign f = ~x;
endmodule

module mux2to1(x, y, s, f);
    input x, y, s;
    output f;

    wire nots;
    wire notsandx;
    wire sandy;

    not u0(
        .x(s),
        .f(nots)
    );

    and u1(
        .x(x),
        .y(nots),
        .f(notsandx)
    );

    and u2(
        .x(y),
        .y(s),
        .f(sandy)
    );

    or u3(
        .x(notsandx),
        .y(sandy),
        .f(f)
    );
endmodule

