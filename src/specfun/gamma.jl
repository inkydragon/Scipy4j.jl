# SPDX-License-Identifier: MIT OR BSD-3-Clause
#   See also: src/specfun/LICENSE.md
#= gamma.jl 
    + gam0:     abs(x) <= 1
    + gamma2:   x
    + gaih:     x = n/2, n=1,2,3,…
    + cgama:    Г(z) or ln[Г(z)]

TODO: use gamma in AMOS?
=#

"""
Ref
- DLMF 5.7.1,5.7.2
- Wrench, J. W. (1968).
    Concerning two series for the gamma function.
    Mathematics of Computation, 22(103), 617-626.
    https://www.jstor.org/stable/2004538

TODO: TThe coefficients are not consistent with those in the paper
"""
const _GAM0_G = Float64[
#= 01 =#
    1.0e0, 0.57721_56649_01532_9e0,
    #                    9
    -0.65587_80715_20253_8e0, -0.4200_26350_34095_2e-1,
     0.16653_86113_82291_5e0, -0.4219_77345_55544_3e-1,
    #                6_973                     1
    -0.962_19715_27877_0e-2, 0.721_89432_46663_0e-2,
    #                                          95098
    -0.116_51675_91859_1e-2, -0.21_52416_74114_9e-3,
#= 11 =#
    #                 1162                   78824
     0.12_80502_82388_2e-3, -0.2_01348_54780_7e-4,
    -0.12504934821e-5, 0.11330272320e-5, 
    -0.2056338417e-6, 0.61160950e-8, 
     0.50020075e-8, -0.11812746e-8,
     0.1043427e-9, 0.77823e-11,
#= 21 =#
    -0.36968e-11, 0.51e-12, 
    -0.206e-13, -0.54e-14,
    0.14e-14
]

"""
    gam0(x)

Compute gamma function Г(x) for small `x`

Input
x  --- Argument of Г(x)  ( |x| ≤ 1 )

Output
ga --- Г(x)
"""
function gam0(x::Float64)
    @assert abs(x) <= 1

    gr = _GAM0_G[end]

    for k = 24:-1:1
        gr = gr * x + _GAM0_G[k]
    end

    return 1.0 / (gr * x)
end

const _GAMMA2_G = Float64[
    _GAM0_G...,
    0.1e-15,
]

"""
    gamma2(x::Float64)

Compute gamma function Г(x)

Input
x  --- Argument of Г(x)
        ( x is not equal to 0,-1,-2,…)

Output
ga --- Г(x)
"""
function gamma2(x::Float64)
    ga = NaN
    if isinteger(x)
        if x > 0.0
            # Whne x is positive integer
            #   DLMF 5.4.1:  Г(n+1) = n!
            ga = 1.0
            m1 = trunc(Int64, x) - 1
            for k = 2:m1
                ga *= k
            end
        else
            # Inf
            ga = 1e300
        end
    else
        r = 1.0
        if abs(x) > 1.0
            # When |x| > 1, DLMF 5.5.1:
            #   Г(z+1) = z*Г(z)
            z = abs(x)
            m = trunc(Int64, z)
            for k = 1:m
                r *= (z - k)
            end
            z -= m
        else
            # When |x| <= 1
            z = x
        end

        # Calculate 1/Г(x), DLMF 5.7.1:
        gr = _GAMMA2_G[26]
        for k = 25:-1:1
            gr = gr*z + _GAMMA2_G[k]
        end
        ga = 1.0 / (gr * z)

        if abs(x) > 1.0
            # When |x| > 1, DLMF 5.5.1:
            ga *= r
            if x < 0.0
                # When x < 0, DLMF 5.5.2:
                ga = -pi / (x * ga * sin(pi * x))
            end
        end
    end

    return ga
end

"""
    gaih(x::Float64)

Compute gamma function Г(x)

Input
x  --- Argument of Г(x), x = n/2, n=1,2,3,…

Output
ga --- Г(x)
"""
function gaih(x::Float64)
    @assert x > 0

    ga = NaN
    if x > 0.0
        if isinteger(x)
            m1 = trunc(Int64, x - 1.0)
            ga = 1.0
            for k = 2:m1
                ga *= k
            end
        elseif isinteger(x + 0.5)
            m = trunc(Int64, x)
            ga = sqrt(pi)
            for k = 1:m
                ga *= 0.5 * (2.0 * k - 1.0)
            end
        end
    end

    return ga
end


"Coefficients for the series expansion"
const _CGAMMA_A = Float64[
    8.333333333333333e-02, -2.777777777777778e-03,
    7.936507936507937e-04, -5.952380952380952e-04,
    8.417508417508418e-04, -1.917526917526918e-03,
    6.410256410256410e-03, -2.955065359477124e-02,
    1.796443723688307e-01, -1.392432216905900e+00
]

"""
    cgama(z::Complex{Float64}, kf::Int)

Compute the gamma function Г(z) or ln[Г(z)]
for a complex argument.

Input
z  --- Complex argument
kf --- Function code
       kf=0 for ln[Г(z)]
       kf=1 for Г(z)

Output
g  --- ln[Г(z)] or Г(z)
"""
function cgama(z::Complex{Float64}, kf::Int)
    @assert kf in [0, 1] "Only accept `kf=0` or `kf=1`"

    x = real(z)
    y = imag(z)

    # Check if z is a negative real integer
    if y == 0.0 && x <= 0.0 && isinteger(x)
        # Inf
        return complex(1e300)
    end

    x1 = x
    y1 = y
    if x < 0.0
        x = -x
        y = -y
        z = -z
        @assert z === complex(x, y)
    else
        x1 = x
        y1 = 0.0
    end

    x0 = x
    na = 0
    if x <= 7.0
        na = trunc(Int64, 7 - x)
        x0 += na
    end

    az0 = abs(complex(x0, y))
    th = atan(y / x0)
    gr = (x0 - 0.5)*log(az0) - th*y - x0 + 0.5*log(2.0 * pi)
    gi = th * (x0 - 0.5) + y*log(az0) - y

    for k in 1:10
        t = az0 ^ (1 - 2*k)
        gr += _CGAMMA_A[k] * t * cos((2.0*k - 1.0) * th)
        gi -= _CGAMMA_A[k] * t * sin((2.0*k - 1.0) * th)
    end

    if x <= 7.0
        gr1 = 0.0
        gi1 = 0.0
        for j in 0:(na-1)
            gr1 += 0.5 * log((x + j)^2 + y^2)
            gi1 += atan(y / (x + j))
        end
        gr -= gr1
        gi -= gi1
    end

    if x1 < 0.0
        az0 = abs(z)
        th1 = atan(y / x)
        sr = -sin(pi*x) * cosh(pi*y)
        si = -cos(pi*x) * sinh(pi*y)
        az1 = abs(complex(sr, si))
        th2 = atan(si / sr)
        if sr < 0.0
            th2 += pi
        end
        gr = log(pi / (az0 * az1)) - gr
        gi = -th1 - th2 - gi
        z = complex(x1, y1)
    end

    if kf == 1
        # Г(z)
        #= exp(gr) * complex(cos(gi), sin(gi)) =#
        return exp(gr) * cis(gi)
    else
        # ln[ Г(z) ]
        return complex(gr, gi)
    end
end
cgama(f::Float64, kf) = cgama(complex(f), kf)
