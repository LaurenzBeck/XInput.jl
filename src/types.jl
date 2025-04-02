# XInput [structures](https://learn.microsoft.com/en-us/windows/win32/api/_xinput/#structures)
"🎮 gamepad input."
struct Gamepad
    "Bitmask of the digital buttons (see [`BUTTONS_BITMASKS`](@ref)). A set bit indicates that the corresponding button is pressed"
    bottons::WORD
    "The current value of the left trigger analog control. The value is between 0 and 255."
    ltrigger::BYTE
    "The current value of the right trigger analog control. The value is between 0 and 255."
    rtrigger::BYTE
    """
    Left thumbstick x-axis value. Each of the thumbstick axis members is an integer value between -32768 and 32767
    describing the position of the thumbstick. A value of 0 is centered. Negative values signify down or to the left.
    Positive values signify up or to the right.
    """
    lthumbx::SHORT
    "Left thumbstick y-axis value."
    lthumby::SHORT
    "Right thumbstick x-axis value."
    rthumbx::SHORT
    "Right thumbstick y-axis value."
    rthumby::SHORT
end

"🔢🎭 a mapping from buttons (see [`Gamepad.buttons`](@ref)) to their corresponding bitmasks."
const BUTTONS_BITMASKS = Dict(
    :up => 0x0001,
    :down => 0x0002,
    :left => 0x0004,
    :right => 0x0008,
    :start => 0x0010,
    :back => 0x0020,
    :left_thumb => 0x0040,
    :right_thumb => 0x0080,
    :left_shoulder => 0x0100,
    :right_shoulder => 0x0200,
    :a => 0x1000,
    :b => 0x2000,
    :x => 0x4000,
    :y => 0x8000,
)

"#️⃣ extract the list of pressed buttons from `input.buttons`."
get_buttons(input::Gamepad)::Set{Symbol} =
    [button for (button, mask) in BUTTONS_BITMASKS if input.bottons & mask > 0] |> Set

"📦 a [`Gamepad`](@ref) input state wrapper."
struct State
    "Used for optimized checks for state changes."
    packetnumber::DWORD
    gamepad::Gamepad
end

"❓ check if two input [`State`](@ref)s have not changed."
Base.:(==)(state₁::State, state₂::State)::Bool = state₁.packetnumber == state₂.packetnumber

"🔋 information on battery type and charge state."
struct BatteryInformation
    """
    The `type` will be one of the following values:
    | `xinput.h` constant       | value | description |
    | ------------------------- | ----- | ----------- |
    | BATTERY_TYPE_DISCONNECTED | 0x00  | the device is not connected. |
    | BATTERY_TYPE_WIRED        | 0x01  | the device is a wired device and does not have a battery. 
    | BATTERY_TYPE_ALKALINE     | 0x02  | the device has an alkaline battery. | 
    | BATTERY_TYPE_NIMH         | 0x03  | the device has a nickel metal hydride battery. |
    | BATTERY_TYPE_UNKNOWN      | 0xFF  | the device has an unknown battery type. |
    """
    type::BYTE
    """
    The charge state of the battery. This value is only valid for wireless devices
    with a known battery type. `level` will be one of the following values:
    | `xinput.h` constant  | value |
    | -------------------- | ----- |
    | BATTERY_LEVEL_EMPTY  | 0x00  |
    | BATTERY_LEVEL_LOW    | 0x01  |
    | BATTERY_LEVEL_MEDIUM | 0x02  | 
    | BATTERY_LEVEL_FULL   | 0x03  |
    """
    level::BYTE
end

"📳 motor speed levels for the vibration function of a controller."
struct Vibration
    """
    Speed of the low-frequency, left motor. Valid values are in the range 0 to 65,535.
    Zero signifies no motor use; 65,535 signifies 100 percent motor use.
    """
    left_motor_speed::WORD
    """
    Speed of the high-frequency, right motor. Valid values are in the range 0 to 65,535.
    Zero signifies no motor use; 65,535 signifies 100 percent motor use.
    """
    right_motor_speed::WORD

    function Vibration(l::Integer, r::Integer)
        (0 ≤ l ≤ 65535 && 0 ≤ r ≤ 65535) ||
            throw(DomainError("values not in the range 0 to 65,535"))
        new(l, r)
    end
end
function Vibration(l::AbstractFloat, r::AbstractFloat)
    (0.0 ≤ l ≤ 1.0 && 0.0 ≤ r ≤ 1.0) ||
        throw(DomainError("float values not in the range 0 to 1"))
    l = round(Int, l * 65535)
    r = round(Int, r * 65535)
    Vibration(l, r)
end
