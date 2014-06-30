/*
 * Written by J.T. Conklin <jtc@netbsd.org>.
 * Public domain.
 */

#include <machine/asm.h>

#if defined(LIBC_SCCS)
	RCSID("$NetBSD: strcmp.S,v 1.6 1995/10/07 09:27:10 mycroft Exp $")
#endif

/*
 * NOTE: I've unrolled the loop eight times: large enough to make a
 * significant difference, and small enough not to totally trash the
 * cache.
 */

ENTRY(strcmp)
	movl	0x04(%esp),%eax
	movl	0x08(%esp),%edx
	jmp	L2			/* Jump into the loop! */

	.align	2,0x90
L1:	incl	%eax
	incl	%edx
L2:	movb	(%eax),%cl
	testb	%cl,%cl			/* null terminator??? */
	jz	L3
	cmpb	%cl,(%edx)		/* chars match??? */
	jne	L3
	incl	%eax
	incl	%edx
	movb	(%eax),%cl
	testb	%cl,%cl
	jz	L3
	cmpb	%cl,(%edx)
	jne	L3
	incl	%eax
	incl	%edx
	movb	(%eax),%cl
	testb	%cl,%cl
	jz	L3
	cmpb	%cl,(%edx)
	jne	L3
	incl	%eax
	incl	%edx
	movb	(%eax),%cl
	testb	%cl,%cl
	jz	L3
	cmpb	%cl,(%edx)
	jne	L3
	incl	%eax
	incl	%edx
	movb	(%eax),%cl
	testb	%cl,%cl
	jz	L3
	cmpb	%cl,(%edx)
	jne	L3
	incl	%eax
	incl	%edx
	movb	(%eax),%cl
	testb	%cl,%cl
	jz	L3
	cmpb	%cl,(%edx)
	jne	L3
	incl	%eax
	incl	%edx
	movb	(%eax),%cl
	testb	%cl,%cl
	jz	L3
	cmpb	%cl,(%edx)
	jne	L3
	incl	%eax
	incl	%edx
	movb	(%eax),%cl
	testb	%cl,%cl
	jz	L3
	cmpb	%cl,(%edx)
	je	L1
	.align 2, 0x90
L3:	movzbl	(%eax),%eax		/* unsigned comparison */
	movzbl	(%edx),%edx
	subl	%edx,%eax
	ret
