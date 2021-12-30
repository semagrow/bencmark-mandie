## An experiment with MANy Delayed dIsjoint Endpoints

In this experiment we use 100 disjoint endpoints with varying delays (0s, 1s, 1m, 5m, 10m)
with data and queries from the [Geographica](http://geographica.di.uoa.gr/) benchmark.

The experiments are executed using the KOBE benchmarking engine. 
For instructions on how to install KOBE in your system please visit the
[GitHub page](https://github.com/semagrow/kobe/) or the
[KOBE User Guide](https://semagrow.github.io/kobe/).

In order to run the experiment run the script

```bash
./scripts/experiment-run.sh
```

In order to create the datasets we followed the instructions ./files/dataset-instructions.txt

Further reading:

* Antonis Troumpoukis et al.:
  *Evaluation framework for linked geospatial data systems.*
  Technical Report Public Deliverable D3.5, ExtremeEarth Project, December 2021.

