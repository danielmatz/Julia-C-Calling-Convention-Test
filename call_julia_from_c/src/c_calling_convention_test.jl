module c_calling_convention_test

using StaticArrays: SMatrix

struct Small
    a::Cuint
end

struct Large
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

function print_bytes(x, n)
    bytes = reinterpret(UInt8, [x])[1:n]
    println(stderr, "Julia bytes:")
    println(stderr, join(bytes, " "))
end

Base.@ccallable function print_metadata()::Cvoid
    println(stderr, "Julia Sys.MACHINE: ", Sys.MACHINE)
    println(stderr, "Julia Sys.CPU_NAME: ", Sys.CPU_NAME)
    println(stderr, "Julia sizeof(Small): ", sizeof(Small))
    println(stderr, "Julia alignof(Small): ", Base.datatype_alignment(Small))
    println(stderr, "Julia sizeof(Large): ", sizeof(Large))
    println(stderr, "Julia alignof(Large): ", Base.datatype_alignment(Large))
end

Base.@ccallable function test_small_struct(first::Small, second::Small, double_ptr::Ptr{Cdouble})::Cvoid
    print_bytes(second, 4)
    println(stderr, "Julia pointer: ", double_ptr)
end

Base.@ccallable function test_large_struct(first::Small, second::Large, double_ptr::Ptr{Cdouble})::Cvoid
    print_bytes(second, 16)
    println(stderr, "Julia pointer: ", double_ptr)
end

end
