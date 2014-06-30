/*	$NetBSD: bcopy.S,v 1.13 1997/05/15 16:07:31 jtc Exp $	*/

/*-
 * Copyright (c) 1997 The NetBSD Foundation, Inc.
 * All rights reserved.
 *
 * This code is derived from software contributed to The NetBSD Foundation
 * by J.T. Conklin.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *        This product includes software developed by the NetBSD
 *        Foundation, Inc. and its contributors.
 * 4. Neither the name of The NetBSD Foundation nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

/*-
 * Copyright (c) 1990 The Regents of the University of California.
 * All rights reserved.
 *
 * This code is derived from software contributed to Berkeley by
 * the Systems Programming Group of the University of Utah Computer
 * Science Department.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *	This product includes software developed by the University of
 *	California, Berkeley and its contributors.
 * 4. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#include <machine/asm.h>

#if defined(LIBC_SCCS) && !defined(lint)
#if 0
	RCSID("from: @(#)bcopy.s	5.1 (Berkeley) 5/12/90")
#else
	RCSID("$NetBSD: bcopy.S,v 1.13 1997/05/15 16:07:31 jtc Exp $")
#endif
#endif /* LIBC_SCCS and not lint */


#ifdef MEMCOPY
ENTRY(memcpy)
#else
#ifdef MEMMOVE
ENTRY(memmove)
#else
ENTRY(bcopy)
#endif
#endif
#if defined(MEMCOPY) || defined(MEMMOVE)
	movl	sp@(4),a1		| dest address
	movl	sp@(8),a0		| src address
#else
	movl	sp@(4),a0		| src address
	movl	sp@(8),a1		| dest address
#endif
	movl	sp@(12),d1		| count

	cmpl	a1,a0			| src after dest?
	jlt	Lbcback			| yes, must copy backwards

	/* 
	 * It isn't worth the overhead of aligning to {long}word boundries
	 * if the string is too short.
	 */
	cmpl	#8,d1
	jlt	Lbcfbyte

	/* word align */
	movl	a1,d0
	btst	#0,d0		| if (dst & 1)
	jeq	Lbcfalgndw	| 
	movb	a0@+,a1@+	|	*(char *)dst++ = *(char *) src++
	subql	#1,d1		|	len--
Lbcfalgndw:
	/* long word align */
	btst	#1,d0		| if (dst & 2)
	jeq	Lbcfalgndl
	movw	a0@+,a1@+	|	*(short *)dst++ = *(short *) dst++
	subql	#2,d1		|	len -= 2
Lbcfalgndl:
	/* copy by 8 longwords */
	movel	d1,d0
	lsrl	#5,d0		| cnt = len / 32
	jeq	Lbcflong	| if (cnt)
	andl	#31,d1		|	len %= 32
	subql	#1,d0		|	set up for dbf
Lbcf32loop:
	movl	a0@+,a1@+	|	copy 8 long words
	movl	a0@+,a1@+
	movl	a0@+,a1@+
	movl	a0@+,a1@+
	movl	a0@+,a1@+
	movl	a0@+,a1@+
	movl	a0@+,a1@+
	movl	a0@+,a1@+
	dbf	d0,Lbcf32loop	|	till done
	clrw	d0
	subql	#1,d0
	jcc	Lbcf32loop

Lbcflong:
	/* copy by longwords */
	movel	d1,d0
	lsrl	#2,d0		| cnt = len / 4
	jeq	Lbcfbyte	| if (cnt)
	subql	#1,d0		|	set up for dbf
Lbcflloop:
	movl	a0@+,a1@+	|	copy longwords
	dbf	d0,Lbcflloop	|	til done
	andl	#3,d1		|	len %= 4
	jeq	Lbcdone

	subql	#1,d1		| set up for dbf
Lbcfbloop:
	movb	a0@+,a1@+	| copy bytes
Lbcfbyte:
	dbf	d1,Lbcfbloop	| till done
Lbcdone:
#if defined(MEMCOPY) || defined(MEMMOVE)
	movl	sp@(4),d0	| dest address
#endif
	rts


Lbcback:
	addl	d1,a0		| src pointer to end
	addl	d1,a1		| dest pointer to end

	/* 
	 * It isn't worth the overhead of aligning to {long}word boundries
	 * if the string is too short.
	 */
	cmpl	#8,d1
	jlt	Lbcbbyte

	/* word align */
	movl	a1,d0
	btst	#0,d0		| if (dst & 1)
	jeq	Lbcbalgndw	| 
	movb	a0@-,a1@-	|	*(char *)dst-- = *(char *) src--
	subql	#1,d1		|	len--
Lbcbalgndw:
	/* long word align */
	btst	#1,d0		| if (dst & 2)
	jeq	Lbcbalgndl
	movw	a0@-,a1@-	|	*(short *)dst-- = *(short *) dst--
	subql	#2,d1		|	len -= 2
Lbcbalgndl:
	/* copy by 8 longwords */
	movel	d1,d0
	lsrl	#5,d0		| cnt = len / 32
	jeq	Lbcblong	| if (cnt)
	andl	#31,d1		|	len %= 32
	subql	#1,d0		|	set up for dbf
Lbcb32loop:
	movl	a0@-,a1@-	|	copy 8 long words
	movl	a0@-,a1@-
	movl	a0@-,a1@-
	movl	a0@-,a1@-
	movl	a0@-,a1@-
	movl	a0@-,a1@-
	movl	a0@-,a1@-
	movl	a0@-,a1@-
	dbf	d0,Lbcb32loop	|	till done
	clrw	d0
	subql	#1,d0
	jcc	Lbcb32loop
	
Lbcblong:
	/* copy by longwords */
	movel	d1,d0
	lsrl	#2,d0		| cnt = len / 4
	jeq	Lbcbbyte	| if (cnt)
	subql	#1,d0		|	set up for dbf
Lbcblloop:
	movl	a0@-,a1@-	|	copy longwords
	dbf	d0,Lbcblloop	|	til done
	andl	#3,d1		|	len %= 4
	jeq	Lbcdone

	subql	#1,d1		| set up for dbf
Lbcbbloop:
	movb	a0@-,a1@-	| copy bytes
Lbcbbyte:
	dbf	d1,Lbcbbloop	| till done

#if defined(MEMCOPY) || defined(MEMMOVE)
	movl	sp@(4),d0	| dest address
#endif
	rts
