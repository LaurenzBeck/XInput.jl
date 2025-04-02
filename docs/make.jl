using XInput
using Documenter

DocMeta.setdocmeta!(XInput, :DocTestSetup, :(using XInput); recursive = true)

makedocs(;
    modules = [XInput],
    authors = "Laurenz Farthofer <laurenz@hey.com>",
    sitename = "XInput.jl",
    format = Documenter.HTML(;
        canonical = "https://laurenzbeck.github.io/XInput.jl",
        edit_link = "master",
        assets = String[],
    ),
    pages = ["Home" => "index.md"],
)

deploydocs(; repo = "github.com/laurenzbeck/XInput.jl", devbranch = "master")
