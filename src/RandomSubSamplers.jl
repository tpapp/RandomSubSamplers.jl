"""
Building blocks and high level functions for filtering a collection randomly.

The typical use case would be having an iterable (eg rows from a table) for which it is
desirable to keep a subsample based on some characteristic (eg a person identifier).

`random_subsample` provides a filtered iterable, while `RandomSubSampler` and `randkeep!`
expose the building blocks.
"""
module RandomSubSamplers

export RandomSubSampler, randkeep!, random_subsample

using ArgCheck: @argcheck
using DocStringExtensions: FUNCTIONNAME, SIGNATURES
using Random: AbstractRNG, GLOBAL_RNG, rand

struct RandomSubSampler{T, R <: Real}
    table::Dict{T,Bool}
    ratio::R
    function RandomSubSampler{T}(ratio::R) where {T, R <: Real}
        @argcheck 0 ≤ ratio ≤ 1
        new{T,R}(Dict{T,Bool}(), ratio)
    end
end

"""
$(FUNCTIONNAME)([rng], rs, elt)
"""
randkeep!(rng::AbstractRNG, rs::RandomSubSampler, elt) =
    get!(() -> rand(rng) < rs.ratio, rs.table, elt)

randkeep!(rs::RandomSubSampler, elt) = randkeep!(GLOBAL_RNG, rs, elt)

"""
$(FUNCTIONNAME)([rng], key, ratio, itr)

Return a (lazy) iterator that randomly keeps `ratio` of `itr` by `key`.
"""
function random_subsample(rng::AbstractRNG, key, ratio::Real, itr)
    T = Core.Compiler.return_type(key, (eltype(itr), ))
    rs = RandomSubSampler{T}(ratio)
    Iterators.filter(elt -> randkeep!(rng, rs, key(elt)), itr)
end

random_subsample(key, ratio::Real, itr) =
    random_subsample(GLOBAL_RNG, key, ratio, itr)

end # module
