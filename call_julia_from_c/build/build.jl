using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()

using PackageCompiler

target_dir = abspath(@__DIR__, "output")

PackageCompiler.create_library(
    ".",
    target_dir;
    lib_name = "c_calling_convention_test",
    header_files = [abspath(@__DIR__, "c_calling_convention_test.h")],
    force = true,
)
