using FastAI
using FastAI.recorder
using Test

@testset "FastAI.jl" begin
    include("utils.jl")
    include("test_learner.jl")
    include("test_recorder.jl")
end
