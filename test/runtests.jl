using XInput
using Test
using Aqua
using JET

@testset "XInput.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(XInput)
    end
    @testset "Code linting (JET.jl)" begin
        JET.test_package(XInput; target_defined_modules = true)
    end
    # Write your tests here.
end
