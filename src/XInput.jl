__precompile__(false) #🤷

"🎮 a Julia interface to the gamepad / (xbox-)controller [win32 API](https://learn.microsoft.com/en-us/windows/win32/xinput/xinput-game-controller-apis-portal)."
module XInput

export get_battery_information, get_state, rumble

using WinTypes: DWORD, WORD, BYTE, SHORT

include("constants.jl")
include("errors.jl")
include("types.jl")

"📚 dynamic/shared library name."
const xinput = "XInput1_4"

#####
##### 🔢 Low-Level API
#####

"""
    get_battery_information(device::Integer=0)::BatteryInformation

🪫 retrieve the battery type and charge status of a wireless controller.
"""
function get_battery_information(device::Integer = 0)::BatteryInformation
    0 ≤ device ≤ 3 || throw(DomainError("`xinput` only supports `device` ids from 0 to 3."))
    battery_information = Ref{BatteryInformation}()
    err = @ccall xinput.XInputGetBatteryInformation(
        device::DWORD,
        BATTERY_DEVTYPE_GAMEPAD::BYTE,
        battery_information::Ref{BatteryInformation},
    )::DWORD
    err == ERROR_SUCCESS ||
        throw(ErrorException("`XInputGetBatteryInformation` failed for device #$(device)"))
    battery_information[]
end

"""
    get_state(device::Integer=0)::State

🎮 retrieve the current [`State`](@ref) of the specified controller.
"""
function get_state(device::Integer = 0)::State
    0 ≤ device ≤ 3 || throw(DomainError("`xinput` only supports `device` ids from 0 to 3."))
    state = Ref{State}()
    err = @ccall xinput.XInputGetState(device::DWORD, state::Ref{State})::DWORD
    err == ERROR_DEVICE_NOT_CONNECTED && throw(DeviceNotConnectedError(device))
    state[]
end

"📳 set the rumble-motor vibration strength of a controller."
function rumble end

"Set the left and right motor speed using a [`Vibration`](@ref) struct"
function rumble(device::Integer = 0, vibration::Vibration = Vibration(0, 0))
    0 ≤ device ≤ 3 || throw(DomainError("`xinput` only supports `device` ids from 0 to 3."))
    err = @ccall xinput.XInputSetState(device::DWORD, Ref(vibration)::Ref{Vibration})::DWORD
    err ≠ ERROR_SUCCESS && throw(DeviceNotConnectedError(device))
    nothing
end

"Set the left and right motor speed directly using integers in the range 0 - 65,535."
function rumble(
    device::Integer = 0,
    left_motor_speed::Integer = 0,
    right_motor_speed::Integer = 0,
)
    rumble(device, Vibration(left_motor_speed, right_motor_speed))
end

"Set the left and right motor speed directly using floats in the range 0 - 1."
function rumble(
    device::Integer = 0,
    left_motor_speed::AbstractFloat = 0.0,
    right_motor_speed::AbstractFloat = 0.0,
)
    rumble(device, Vibration(left_motor_speed, right_motor_speed))
end

end
