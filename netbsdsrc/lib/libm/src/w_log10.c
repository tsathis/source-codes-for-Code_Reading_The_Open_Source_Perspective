/* @(#)w_log10.c 5.1 93/09/24 */
/*
 * ====================================================
 * Copyright (C) 1993 by Sun Microsystems, Inc. All rights reserved.
 *
 * Developed at SunPro, a Sun Microsystems, Inc. business.
 * Permission to use, copy, modify, and distribute this
 * software is freely granted, provided that this notice 
 * is preserved.
 * ====================================================
 */

#include <sys/cdefs.h>
#if defined(LIBM_SCCS) && !defined(lint)
__RCSID("$NetBSD: w_log10.c,v 1.7 1997/10/09 11:35:39 lukem Exp $");
#endif

/* 
 * wrapper log10(X)
 */

#include "math.h"
#include "math_private.h"


#ifdef __STDC__
	double log10(double x)		/* wrapper log10 */
#else
	double log10(x)			/* wrapper log10 */
	double x;
#endif
{
#ifdef _IEEE_LIBM
	return __ieee754_log10(x);
#else
	double z;
	z = __ieee754_log10(x);
	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
	if(x<=0.0) {
	    if(x==0.0)
	        return __kernel_standard(x,x,18); /* log10(0) */
	    else 
	        return __kernel_standard(x,x,19); /* log10(x<0) */
	} else
	    return z;
#endif
}
