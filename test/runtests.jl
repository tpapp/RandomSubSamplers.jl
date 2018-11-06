using RandomSubSamplers, Test, Random

Random.seed!(UInt32[0xb0a863be, 0x4c2f0833, 0xa08d7276, 0xb3fe604f])

@testset "random subsampler" begin
    v = rand(1:100, 1000)
    w = randn(1000)
    vw = tuple.(v, w)
    rvw = collect(random_subsample(first, 0.3, vw))
    k = unique(first.(rvw))
    @test 26 ≤ length(k)  ≤ 40  # generous bounds for CI
    @test filter(x -> first(x) ∈ k, vw) == rvw
end
