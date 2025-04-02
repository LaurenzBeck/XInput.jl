using XInput
using Test
using Aqua
using JET

@testset "XInput.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(XInput; persistent_tasks=false)
    end
    @testset "Code linting (JET.jl)" begin
        JET.test_package(XInput; target_defined_modules = true)
    end

    @testset "XInput high-level functions" begin
        gamepad = XInput.Gamepad(0x3080, 0x00, 0x00, 213, 1258, -6402, 4871)
        @test XInput.get_buttons(gamepad) == Set([:a, :b, :right_thumb])
    end
end
