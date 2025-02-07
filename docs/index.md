<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
    <title>Infinite State Model Checking by Learning Transitive Relations</title>
    <style>
      table, th, td {border: 1px solid black;}
      td {text-align: center;}
      p {text-align: justify;}
    </style>
  </head>
  <body>

    <p>
      This is the empirical evaluation of the implementation of our techniques from the paper <a href="???"><i>Infinite State Model Checking by Learning Transitive Relations</i></a> in our tool LoAT.
    </p>

    <h1>Getting LoAT</h1>

    <p>
      We provide a <a href="https://github.com/LoAT-developers/LoAT/releases/tag/v0.9.0">pre-compiled binary of LoAT (Linux, 64 bit)</a>.
      Moreover, you can find the source code of LoAT at <a href="https://github.com/loat-developers/LoAT/tree/v0.9.0">GitHub</a>.
    </p>
    <p>We refer to the <a href="https://loat-developers.github.io/LoAT/">general LoAT website</a> for further information.</p>

    <h1>Evaluation</h1>

    <h2>Examples</h2>

    <p>
      We used the examples from the category LIA-Lin (linear CHCs with linear integer arithmetic) from the <a href="https://chc-comp.github.io/2023/">CHC competitions</a> 2023 and 2024, excluding duplicates.
      They can be found <a href="benchmarks_23.zip">here (2023)</a> and <a href="benchmarks_24.zip">here (2024)</a>.
    </p>

    <h2>Tools</h2>

    In our evaluation, we considered the following tools and configurations:
    <ul>
      <li>LoAT 0.9.0</li>
      <ul>
        <li>Transitive Relation Learning (LoAT TRL)</li>
        <ul>
          <li><tt>loat-static --mode safety --format horn --engine trl $INPUT</tt></li>
        </ul>
        <li>Accelerated Bounded Model Checking (LoAT ABMC)</li>
        <ul>
          <li><tt>loat-static --mode safety --format horn --engine abmc $INPUT</tt></li>
        </ul>
        <li>k-Induction (LoAT KIND)</li>
        <ul>
          <li><tt>loat-static --mode safety --format horn --engine kind $INPUT</tt></li>
        </ul>
      </ul>
      <li><a href="https://github.com/Z3Prover/z3">Z3</a> 4.13.3</li>
      <ul>
        <li>Spacer with Global Guidance (Z3 GSpacer)</li>
        <ul>
          <li><tt>z3 fp.engine=spacer fp.spacer.global=true $INPUT</tt></li>
        </ul>
        <li>Spacer (Z3 Spacer)</li>
        <ul>
          <li><tt>z3 fp.engine=spacer $INPUT</tt></li>
        </ul>
        <li>Bounded Model Checking (Z3 BMC)</li>
        <ul>
          <li><tt>z3 fp.engine=bmc $INPUT</tt></li>
        </ul>
      </ul>
      <li><a href="https://github.com/usi-verification-and-security/golem">Golem</a> 0.6.2</li>
      <ul>
        <li>Spacer (Golem Spacer)</li>
        <ul>
          <li><tt>golem -l QF_LIA -e spacer $INPUT</tt></li>
        </ul>
        <li>Property Directed k-Induction (Golem PDKIND)</li>
        <ul>
          <li><tt>golem -l QF_LIA -e pdkind $INPUT</tt></li>
        </ul>
        <li>Interpolation Based Model Checking (Golem IMC)</li>
        <ul>
          <li><tt>golem -l QF_LIA -e imc $INPUT</tt></li>
        </ul>
        <li>Transition Power Abstraction (Golem TPA)</li>
        <ul>
          <li><tt>golem -l QF_LIA -e split-tpa $INPUT</tt></li>
        </ul>
        <li>Lazy Abstraction with Interpolants (Golem LAWI)</li>
        <ul>
          <li><tt>golem -l QF_LIA -e lawi $INPUT</tt></li>
        </ul>
        <li>Predicate Abstraction (Golem PA)</li>
        <ul>
          <li><tt>golem -l QF_LIA -e pa $INPUT</tt></li>
        </ul>
        <li>Bounded Model Checking (Golem BMC)</li>
        <ul>
          <li><tt>golem -l QF_LIA -e bmc $INPUT</tt></li>
        </ul>
      </ul>
      <li><a href="https://github.com/uuverifiers/eldarica">Eldarica</a> 2.1.0</li>
      <ul>
        <li><tt>eld $INPUT</tt></li>
      </ul>
    </ul>

    <h2>Results</h2>

    <a href="./table.html">Here</a> you can find a table with the detailed results of our benchmarks.

    <h1>Examples from the Paper</h1>

    <p>
      <a href="./leading.smt2">Here</a> you can find our leading exmaple, and <a href="./unsafe.smt2">here</a> you can find our example for proving unsafety from Section 5 of our paper.
      Note that for the latter, the default configuration of LoAT fails:
    </p>
    <p>
      <tt>
        $ loat-static --format horn --engine trl --mode safety unsafe.smt2<br/>
        > unknown
      </tt>
    </p>
    However, LoAT can prove unsafety with the SMT solvers <a href="https://ffrohn.github.io/swine/">SwInE</a>, <a href="https://github.com/Z3Prover/z3">Z3</a>, and <a href="https://cvc5.github.io/">CVC5</a>:
    <p>
      <tt>
        $ loat-static --format horn --engine trl --mode safety --smt swine unsafe.smt2<br/>
        > unsat<br/>
        $ loat-static --format horn --engine trl --mode safety --smt z3 unsafe.smt2<br/>
        > unsat<br/>
        $ loat-static --format horn --engine trl --mode safety --smt cvc5 unsafe.smt2<br/>
        > unsat
      </tt>
    </p>
    By default, LoAT's implementation of TRL uses the SMT solver <a href="https://yices.csl.sri.com/">Yices</a>.
    For this example, LoAT obtains different traces with Yices than with the other solvers.
    As TRL just considers a single trace for proving unsafety (see the discussion of related work in our paper), this prevents it from proving unsafety.
    In contrast, our technique <a href="https://loat-developers.github.io/abmc-eval/">Accelerated Bounded Model Checking</a> (ABMC -- again, see the discussion of related work in our paper) considers many different traces for proving unsafety.
    Thus, ABMC can prove unsafety with all supported SMT solvers:
    <p>
      <tt>
        $ loat-static --format horn --engine abmc --mode safety --smt yices unsafe.smt2<br/>
        > unsat<br/>
        $ loat-static --format horn --engine abmc --mode safety --smt swine unsafe.smt2<br/>
        > unsat<br/>
        $ loat-static --format horn --engine abmc --mode safety --smt z3 unsafe.smt2<br/>
        > unsat<br/>
        $ loat-static --format horn --engine abmc --mode safety --smt cvc5 unsafe.smt2<br/>
        > unsat
      </tt>
    </p>
    <p>
      This shows that ABMC is more robust for proving unsafety.
      However, TRL is far superior for proving safety (see the experiments above and in our paper).
    </p>
  </body>
</html>

