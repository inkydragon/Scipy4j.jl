# SPDX-License-Identifier: MIT

"""Spheroidal Wave Functions
- specfun_segv
- specfun_rswfp
- specfun_aswfa
- specfun_rswfo
"""

@testset "segv" begin
    # TODO: test branch: `if k != 1 && h[k] < h[k-1]`
    test_mn = Tuple{Int64,Int64}[
        (1, 2),
        (10, 20),
        (50, 100),
        (100, 200),
    ]
    test_c = Float64[
        # test br: c < 1e-10
        1e-9, eps(), 1e-10,
        1:10...,
        rand(10)...,
    ]

    for (m, n) in test_mn,
        c in test_c,
        kd in [1, -1]
        #
        max_cv_len = n - m + 1
        @assert 0 <= max_cv_len <= 200
        icm = (n - m + 2) ÷ 2
        max_eg_nz_len = icm * 2
        eg_ref = zeros(Float64, 200)
        eg_res = zeros(Float64, 200)
        #
        cv_ref, _ = _segv!(m, n, c, kd, eg_ref)
        cv_res, _ = Specfun.segv(m, n, c, kd, eg_res)
        @testset "_segv(m=$m, n=$n, c=$c, kd=$kd)" begin
            # Result
            @test isapprox(cv_ref, cv_res)
            @test isapprox(eg_ref[1:max_cv_len], eg_res[1:max_cv_len])
            # temp value
            @test isapprox(eg_ref[max_cv_len+1:max_eg_nz_len], eg_res[max_cv_len+1:max_eg_nz_len])
            # zeros
            @test iszero(eg_ref[max_eg_nz_len+1:end])
            @test iszero(eg_res[max_eg_nz_len+1:end])
        end
    end
end

@testset "sdmn" begin
    test_mn = Tuple{Int64,Int64}[
        (1, 2),
        (10, 20),
        (50, 100),
        (100, 200),
        (710, 1000),
    ]
    test_c = Float64[
        # test br: c < 1e-10
        1e-9, eps(), 1e-10,
        1:10...,
        rand(10)...,
    ]
    test_cv = Float64[
        rand(10)...,
        1:10...,
        # test branch: `kb > 2 && if abs(f) > T(1e100)`
        930:950...,
    ]

    for (m, n) in test_mn,
        kd in [1, -1],
        c in test_c,
        cv in test_cv
        #
        max_df_len = 1 + 25 + trunc(Int, 0.5*(n-m) + c)
        @assert 0 <= max_df_len <= 200
        df_ref = zeros(Float64, 200)
        df_res = zeros(Float64, 200)
        #
        _sdmn!(m, n, c, cv, kd, df_ref)
        Specfun.sdmn!(m, n, c, cv, kd, df_res)
        @testset "_sdmn(m=$m,n=$n, c=$c,cv=$cv, kd=$kd)" begin
            # Result
            @test isapprox(df_ref[1:max_df_len], df_res[1:max_df_len]; nans=true)
            # zeros
            # @test iszero(df_ref[max_df_len+1:end])
            # @test iszero(df_res[max_df_len+1:end])
        end
    end
end