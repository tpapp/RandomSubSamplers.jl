using RandomSubSamplers, Test

@testset "random subsampler" begin
    v = rand(1:100, 1000)
    w = randn(1000)
    vw = tuple.(v, w)
    rvw = collect(random_subsample(first, 0.3, vw))
    k = unique(first.(rvw))
    @test 30 ≤ length(k)  ≤ 36
    @test filter(x -> first(x) ∈ k, vw) == rvw
end
