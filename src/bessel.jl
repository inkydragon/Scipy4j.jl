# SPDX-License-Identifier: MIT OR BSD-3-Clause
#   See also: src/specfun/LICENSE.md

"""Bessel functions
jv(v, z)
    Bessel function of the first kind of real order and complex argument.
    + cbesj_wrap_real -> cbesj_wrap,cephes_jv
    + cbesj_wrap -> amos_besj,amos_besy
        + cbesj_wrap_e

jve(v, z)
    Exponentially scaled Bessel function of the first kind of order v.
    + cbesj_wrap_e_real -> cbesj_wrap_e -> amos_besj,amos_besy

yn(n, x)
    Bessel function of the second kind of integer order and real argument.
    + cephes_yn

yv(v, z)
    Bessel function of the second kind of real order and complex argument.
    + cbesy_wrap_real -> cbesy_wrap,cephes_yv
    + cbesy_wrap -> amos_besy,amos_besj

yve(v, z)
    Exponentially scaled Bessel function of the second kind of real order.
    + cbesy_wrap_e_real -> cbesy_wrap_e -> amos_besy,amos_besj


## amos_besk,amos_besi
kn(n, x)
    Modified Bessel function of the second kind of integer order n
    + cbesk_wrap_real_int -> cbesk_wrap_real -> cbesk_wrap -> amos_besk

kv(v, z)
    Modified Bessel function of the second kind of real order v
    + cbesk_wrap_real -> cbesk_wrap -> amos_besk

kve(v, z)
    Exponentially scaled modified Bessel function of the second kind.
    + cbesk_wrap_e_real -> cbesk_wrap_e -> amos_besk

iv(v, z)
    Modified Bessel function of the first kind of real order.
    + cbesi_wrap -> amos_besi,cbesi_wrap_e,amos_besk
        + cbesi_wrap_e -> amos_besi,amos_besk
    + cephes_iv

ive(v, z)
    Exponentially scaled modified Bessel function of the first kind.
    + cbesi_wrap_e_real -> cbesi_wrap_e -> amos_besi,amos_besk


## amos_besh
hankel1(v, z)
    Hankel function of the first kind
    + cbesh_wrap1 -> amos_besh

hankel1e(v, z)
    Exponentially scaled Hankel function of the first kind
    + cbesh_wrap1_e -> amos_besh

hankel2(v, z)
    Hankel function of the second kind
    + cbesh_wrap2 -> amos_besh

hankel2e(v, z)
    Exponentially scaled Hankel function of the second kind
    + cbesh_wrap2_e -> amos_besh

    
wright_bessel(a, b, x)
    Wright's generalized Bessel function.
    + wright_bessel_scalar@_wright_bessel.pxd


lmbda(v, x)
    Jahnke-Emden Lambda function, Lambdav(x).
    + _specfun.lamv -> specfun_lamv
"""


"""Zeros of Bessel functions

## jdzo
jnjnp_zeros(nt)
    Compute zeros of integer-order Bessel functions Jn and Jn'.
    + _specfun.jdzo -> specfun_jdzo -> bjndd

## jyzo
jnyn_zeros(n, nt)
    Compute nt zeros of Bessel functions Jn(x), Jn'(x), Yn(x), and Yn'(x).
    + _specfun.jyzo -> specfun_jyzo -> jyndd -> jynbh -> msta1,msta2

    jn_zeros(n, nt) -> jnyn_zeros(n, nt)[0]
        Compute zeros of integer-order Bessel functions Jn.

    jnp_zeros(n, nt) -> jnyn_zeros(n, nt)[1]
        Compute zeros of integer-order Bessel function derivatives Jn'.

    yn_zeros(n, nt) -> jnyn_zeros(n, nt)[2]
        Compute zeros of integer-order Bessel function Yn(x).

    ynp_zeros(n, nt) -> jnyn_zeros(n, nt)[3]
        Compute zeros of integer-order Bessel function derivatives Yn'(x).

## cyzo
y0_zeros(nt)
    Compute nt zeros of Bessel function Y0(z), and derivative at each zero.
    + _specfun.cyzo(nt, 0, kc) -> specfun_cyzo -> cy01

y1_zeros(nt)
    Compute nt zeros of Bessel function Y1(z), and derivative at each zero.
    + _specfun.cyzo(nt, 1, kc) -> ...

y1p_zeros(nt)
    Compute nt zeros of Bessel derivative Y1'(z), and value at each zero.
    + _specfun.cyzo(nt, 2, kc) -> ...
"""


"""Faster Common Bessel functions

j0(x)
    Bessel function of the first kind of order 0.
    + cephes_j0

j1(x)
    Bessel function of the first kind of order 1.
    + cephes_j1

y0(x)
    Bessel function of the second kind of order 0.
    + cephes_y0

y1(x)
    Bessel function of the second kind of order 1.
    + cephes_y1

i0(x)
    Modified Bessel function of order 0.
    + cephes_i0

i0e(x)
    Exponentially scaled modified Bessel function of order 0.
    + cephes_i0e

i1(x)
    Modified Bessel function of order 1.
    + cephes_i1

i1e(x)
    Exponentially scaled modified Bessel function of order 1.
    + cephes_i1e

k0(x)
    Modified Bessel function of the second kind of order 0, K0(x)
    + cephes_k0

k0e(x)
    Exponentially scaled modified Bessel function K of order 0
    + cephes_k0e

k1(x)
    Modified Bessel function of the second kind of order 1, K1(x)
    + cephes_k1
    
k1e(x)
    Exponentially scaled modified Bessel function K of order 1
    + cephes_k1e
"""

"""Integrals of Bessel functions
itj0y0(x)
    Integrals of Bessel functions of the first kind of order 0.
    + it1j0y0_wrap -> specfun_itjya

it2j0y0(x)
    Integrals related to Bessel functions of the first kind of order 0.
    + it2j0y0_wrap -> specfun_ittjya

iti0k0(x)
    Integrals of modified Bessel functions of order 0.
    + it1i0k0_wrap -> specfun_itika

it2i0k0(x)
    Integrals related to modified Bessel functions of order 0.
    + it2i0k0_wrap -> specfun_ittika

besselpoly(a, lmb, nu)
    Weighted integral of the Bessel function of the first kind.
    + cephes_besselpoly
"""

"""Derivatives of Bessel functions

jvp(v, z)
Compute derivatives of Bessel functions of the first kind.
+ jv(v, z),_bessel_diff_formula

yvp(v, z)
Compute derivatives of Bessel functions of the second kind.
+ yv(v, z),_bessel_diff_formula

kvp(v, z)
Compute derivatives of real-order modified Bessel function Kv(z)
+ kv(v, z),_bessel_diff_formula

ivp(v, z)
Compute derivatives of modified Bessel functions of the first kind.
+ iv(v, z),_bessel_diff_formula

h1vp(v, z)
Compute derivatives of Hankel function H1v(z) with respect to z.
+ hankel1(v, z),_bessel_diff_formula

h2vp(v, z)
Compute derivatives of Hankel function H2v(z) with respect to z.
+ hankel2(v, z),_bessel_diff_formula
"""

"""Spherical Bessel functions

spherical_jn(n, z)
Spherical Bessel function of the first kind or its derivative.
+ _spherical_jn,_spherical_jn_d
    + spherical_jn_real,spherical_jn_complex -> cbesj

spherical_yn(n, z)
Spherical Bessel function of the second kind or its derivative.
+ _spherical_yn,_spherical_yn_d
    + spherical_yn_d_real -> spherical_yn_real
    + spherical_yn_d_complex -> spherical_yn_complex -> cbesy
    
spherical_in(n, z)
Modified spherical Bessel function of the first kind or its derivative.
+ _spherical_in,_spherical_in_d
    + spherical_in_real -> iv
    + spherical_in_complex -> cbesi_wrap

spherical_kn(n, z)
Modified spherical Bessel function of the second kind or its derivative.
+ _spherical_kn,_spherical_kn_d
    + spherical_yn_d_real -> spherical_yn_real
    + spherical_yn_d_complex -> spherical_yn_complex -> cbesy
"""

"""Riccati-Bessel functions
riccati_jn(n, x)
Compute Ricatti-Bessel function of the first kind and its derivative.
+ _specfun.rctj -> specfun_rctj

riccati_yn(n, x)
Compute Ricatti-Bessel function of the second kind and its derivative.
+ _specfun.rcty -> specfun_rcty
"""
