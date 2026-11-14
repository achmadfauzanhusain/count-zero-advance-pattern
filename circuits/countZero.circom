pragma circom 2.0.0;

template IsZero() {
    signal input in;
    signal output out;
    signal inv;

    inv <-- in != 0 ? 1 / in : 0;
    out <== -in * inv + 1;
    in * out === 0;
}

template CountZeros(n) {
    signal input in[n];
    signal output count;

    component isz[n];

    signal acc[n + 1];
    acc[0] <== 0;

    for (var i = 0; i < n; i++) {
        isz[i] = IsZero();
        isz[i].in <== in[i];
        acc[i + 1] <== acc[i] + isz[i].out;
    }

    count <== acc[n];
}

component main { public [in] } = CountZeros(5);