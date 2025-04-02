<p align="center">
    <img src="https://github.com/LaurenzBeck/XInput.jl/blob/master/docs/src/assets/xbox_controller_banner.jpg?raw=true"/></a>
</p>

<h1 align="center">
    🎮 XInput.jl
</h1>

a Julia interface to the gamepad / (xbox-)controller [win32 API](https://learn.microsoft.com/en-us/windows/win32/xinput/xinput-game-controller-apis-portal).

> 🤚⚠️ this is my first Julia package, which I mainly wrote to get some experience using the language, so expect some beginners mistakes 😺

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://laurenzbeck.github.io/XInput.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://laurenzbeck.github.io/XInput.jl/dev/)
[![Build Status](https://github.com/LaurenzBeck/XInput.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/LaurenzBeck/XInput.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Coverage](https://codecov.io/gh/LaurenzBeck/XInput.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/LaurenzBeck/XInput.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

---

## 📦 Installation

In a Julia script:

```julia
using Pkg

Pkg.add("XInput")
```

or in the Julia REPL:

```julia
julia> ]  # enters the pkg interface
pkg> add XInput
```

## 🧑‍💻 Usage

1. 🛜 make sure your controller is connected to your PC.
2. 📦 import package: `julia> using XInput`.
3. 🎮 get input from one of four connected devices: `julia> state = get_state(0)`.
4. 🔋 get information about the charging state of your controller: `julia> battery = get_battery_information(0)`.
5. 📳 set the vibration power of the two rumble motors of a controller: `julia> rumble(0, 0.5, 0.2)`

---

## 🖼️ ©️ Banner Artwork Attribution

<a rel="license" href="https://creativecommons.org/licenses/by-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br />The art in the banner of this README is licensed under a [Creative Commons Attribution-ShareAlike 3.0 License](https://creativecommons.org/licenses/by-sa/3.0/). It was made by [ljdesigner](https://www.deviantart.com/ljdesigner). Check out his beautiful artwork ❤️
