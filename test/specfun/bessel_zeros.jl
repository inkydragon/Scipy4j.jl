# SPDX-License-Identifier: MIT

@testset "bjndd" begin
    test_x = Float64[
        0.0, -0.0,
        1:10...,
        rand(10:100, 5)...,
    ]

    for x in test_x,
        n in 0:100
        @testset "_bjndd(x=$x, n=$n)" begin
            r_bj, r_dj, r_fj = _bjndd(x, n)
            bj, dj, fj = Specfun.bjndd(x, n)

            broken_list = [
                0.0,
            ]
            if x in broken_list
                @test_broken false
                continue
            end
            
            @test isapprox(r_bj, bj)
            @test isapprox(r_dj, dj)
            @test isapprox(r_fj, fj)
        end
    end
end

@testset "jdzo" begin
    test_nt = Int64[
        1:31...,
        700,
    ]

    for nt in test_nt
        @testset "_jdzo(nt=$nt)" begin
            r_zo, r_n, r_m, r_p = _jdzo(nt)
            zo, n, m, p = Specfun.jdzo(nt)
            
            if nt >= 30
                @test_broken false
                continue
            end
            
            @test isapprox(r_zo, zo)
            @test isequal(r_n, n)
            if r_n != n
                @show nt r_n n
            end
            @test isequal(r_m, m)
            @test isequal(r_p, p)
            if r_p != p
                @show nt r_p p
            end
        end
    end
end

@testset "msta1" begin
    test_x = Float64[
        rand(10)...,
        -10:-1...,
        1:10...,
        rand(1:1000, 5)...,
    ]
    test_mp = Int64[
        1:16...,
    ]

    for x in test_x,
        mp in test_mp
        @testset "_msta1(x=$x, mp=$mp)" begin
            r_nn = _msta1(x, mp)
            nn = Specfun.msta1(x, mp)

            @test isapprox(r_nn, nn)
            @test isequal(r_nn, nn)
        end
    end
end
