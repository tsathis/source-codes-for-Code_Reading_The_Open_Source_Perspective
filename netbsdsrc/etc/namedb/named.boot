;	$NetBSD: named.boot,v 1.3 1997/02/15 10:02:32 mikel Exp $
;	from @(#)named.boot	8.1 (Berkeley) 6/9/93

; boot file for secondary name server
; Note that there should be one primary entry for each SOA record.

sortlist 128.3.0.0

directory	/etc/namedb

; type    domain		source host/file		backup file

cache     .							root.cache
primary   0.0.127.IN-ADDR.ARPA	localhost.rev

; example secondary server config:
; secondary Berkeley.EDU	128.32.130.11 128.32.133.1	ucbhosts.bak
; secondary 32.128.IN-ADDR.ARPA	128.32.130.11 128.32.133.1	ucbhosts.rev.bak

; example primary server config:
; primary  Berkeley.EDU		ucbhosts
; primary  32.128.IN-ADDR.ARPA	ucbhosts.rev
