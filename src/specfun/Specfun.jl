# SPDX-License-Identifier: MIT OR BSD-3-Clause
#   See also: src/specfun/LICENSE.md

"""Special functions in pure julia.
"""

module Specfun

# SUBROUTINE
include("gamma.jl")
include("exp.jl")
include("error.jl")
include("airy.jl")

include("bessel_zeros.jl")
include("kelvin.jl")
include("struve.jl")
include("parabolic.jl")
include("hyper.jl")
include("legendre.jl")

include("mathieu.jl")
include("spheroidal.jl")

end # PureSpecial