# RandomSubSamplers

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)<!--
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![Build Status](https://travis-ci.com/tpapp/RandomSubSamplers.jl.svg?branch=master)](https://travis-ci.com/tpapp/RandomSubSamplers.jl)
[![Build Status](https://travis-ci.com/tpapp/RandomSubSamplers.svg?branch=master)](https://travis-ci.com/tpapp/RandomSubSamplers)
[![codecov.io](http://codecov.io/github/tpapp/RandomSubSamplers.jl/coverage.svg?branch=master)](http://codecov.io/github/tpapp/RandomSubSamplers.jl?branch=master)


Select a random subsample of an iterable (eg rows from a table) online.

```julia
julia> using RandomSubSamplers, Random

julia> Random.seed!(3);

julia> v = collect(zip(rand(1:100, 1000), rand('a':'z', 1000)));

julia> w = collect(random_subsample(first, 0.4, v)); # keep approx 40% of integer keys

julia> length(w)
449

julia> k = unique(first.(w));

julia> length(k)                         # ≈ 40% (small-sample random noise)
45

julia> filter(t -> first(t) ∈ k, v) == w # equivalent to selection, but lazy
true
```
