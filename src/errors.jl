"🛜🙅 Error indicating connection problems to a controller."
struct DeviceNotConnectedError <: Exception
    device::Unsigned
end
Base.showerror(io::IO, e::DeviceNotConnectedError) =
    print(io, "🛜🙅 device #$(e.device) not connected.")
