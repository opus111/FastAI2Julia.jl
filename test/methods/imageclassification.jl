include("../imports.jl")


@testset ExtendedTestSet "`ImageClassification`" begin
    @testset ExtendedTestSet "Core interface" begin
        method = ImageClassification(1:10, (32, 32))
        @test method isa ImageClassificationSingle
        DLPipelines.checkmethod_core(method)
        FastAI.checkmethod_plot(method)

        @testset ExtendedTestSet "`encodeinput`" begin
            method = ImageClassification(1:10, (32, 32))
            image = rand(RGB, 64, 96)

            xtrain = encodeinput(method, Training(), image)
            @test size(xtrain) == (32, 32, 3)
            @test eltype(xtrain) == Float32

            xinference = encodeinput(method, Inference(), image)
            @test size(xinference) == (32, 48, 3)
            @test eltype(xinference) == Float32
        end

        @testset ExtendedTestSet "`encodetarget`" begin
            method = ImageClassification(1:2, (32, 32))
            category = 1
            y = encodetarget(method, Training(), category)
            @test y ≈ [1, 0]
            encodetarget!(y, method, Training(), 2)
            @test y ≈ [0, 1]
        end

        @testset ExtendedTestSet "`encode`" begin
            method = ImageClassification(1:10, (32, 32))
            image = rand(RGB, 64, 96)
            category = 1
            @test_nowarn encode(method, Training(), (image, category))
        end
    end
end


@testset ExtendedTestSet "`ImageClassificationMulti`" begin
    method = ImageClassification(1:10, (32, 32), multi_class = true)
    @test method isa ImageClassificationMulti
    DLPipelines.checkmethod_core(method)
    FastAI.checkmethod_plot(ImageClassificationMulti(1:10, (32, 32)))

end
