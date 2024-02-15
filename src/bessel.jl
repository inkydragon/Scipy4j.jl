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
y0_zeros(nt[, complex])
    Compute nt zeros of Bessel function Y0(z), and derivative at each zero.
    + _specfun.cyzo(nt, 0, kc) -> specfun_cyzo -> cy01

y1_zeros(nt[, complex])
    Compute nt zeros of Bessel function Y1(z), and derivative at each zero.
    + _specfun.cyzo(nt, 1, kc) -> ...

y1p_zeros(nt[, complex])
    Compute nt zeros of Bessel derivative Y1'(z), and value at each zero.
    + _specfun.cyzo(nt, 2, kc) -> ...
"""