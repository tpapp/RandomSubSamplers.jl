# output is pasted to README
using RandomSubSamplers, Random
Random.seed!(3);
v = collect(zip(rand(1:100, 1000), rand('a':'z', 1000)));
w = collect(random_subsample(first, 0.4, v)); # keep approx 40% of integer keys
length(w)
k = unique(first.(w));
length(k)                         # ≈ 40% (small-sample random noise)
filter(t -> first(t) ∈ k, v) == w # equivalent to selection, but lazy
