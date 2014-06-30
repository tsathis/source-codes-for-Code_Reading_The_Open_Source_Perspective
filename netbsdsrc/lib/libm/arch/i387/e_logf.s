/*
 * Written by J.T. Conklin <jtc@netbsd.org>.
 * Public domain.
 */

#include <machine/asm.h>

RCSID("$NetBSD: e_logf.S,v 1.2 1996/07/06 00:15:45 jtc Exp $")

ENTRY(__ieee754_logf)
	fldln2
	flds	4(%esp)
	fyl2x
	ret
