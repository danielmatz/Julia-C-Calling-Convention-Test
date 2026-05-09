using StaticArrays: SMatrix, SA

const libexample = abspath("./libexample.so")

@kwdef struct Small
    a::Cuint
end

@kwdef struct Large
    a::Cdouble
    b::Cdouble
    c::Cdouble
    d::Cdouble
    e::Cdouble
    f::Cdouble
    g::Cdouble
    h::Cdouble
    i::Cdouble
    j::Cdouble
    k::Cdouble
    l::Cdouble
    m::SMatrix{3, 3, Cdouble, 9}
end

small = Small(
    ;
    a = 1,
)
large = Large(
    ;
    a = 1,
    b = 2,
    c = 3,
    d = 4,
    e = 5,
    f = 6,
    g = 7,
    h = 8,
    i = 9,
    j = 10,
    k = 11,
    l = 12,
    m = SA[
        1 2 3
        4 5 6
        7 8 9
    ],
)

function print_bytes(x, n)
    bytes = reinterpret(UInt8, [x])[1:n]
    println(stderr, "Julia bytes:")
    println(stderr, join(bytes, " "))
end

println(stderr, "Sys.MACHINE: ", Sys.MACHINE)
println(stderr, "Sys.CPU_NAME: ", Sys.CPU_NAME)

double_ref = Ref(1.0)
println(stderr, "Julia pointer: ", pointer_from_objref(double_ref))

println("Testing small struct...")
print_bytes(small, 4)
@ccall libexample.test_small_struct(small::Small, small::Small, double_ref::Ptr{Cdouble})::Cvoid

println("Testing large struct...")
print_bytes(large, 16)
@ccall libexample.test_large_struct(small::Small, large::Large, double_ref::Ptr{Cdouble})::Cvoid
