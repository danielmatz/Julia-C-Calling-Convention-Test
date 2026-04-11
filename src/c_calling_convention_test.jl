module c_calling_convention_test

struct SmallStruct
    data::NTuple{4, UInt8}
end

struct LargeStruct
    data::NTuple{168, UInt8}
end

function print_bytes(data, n)
    println(stderr, "Julia bytes:")
    for i in 1:n
        print(stderr, data[i], " ")
    end
    println(stderr)
end

Base.@ccallable function test_small_struct(first::SmallStruct, second::SmallStruct)::Cvoid
    print_bytes(second.data, 4)
end

Base.@ccallable function test_large_struct(first::SmallStruct, second::LargeStruct)::Cvoid
    print_bytes(second.data, 16)
end

end
