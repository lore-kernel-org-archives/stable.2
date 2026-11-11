Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420833;
	b=bI6W+l7YnCHooGXEkI29pfwQwgDf5eTSOSEiaCfIYa69MudzRXPDuUEgsegW/EYQOifT
	 qznFIJ3OmnhkqEJbTpo8nmZK/gJyDK+N+0KmMQHgZZE19beTv+/WDA/yzAxozQKSDCuTN
	 5xWsquGHi3oc+HHMmxq3cESdH3y2aXR/yqnUOzH3HD4IKVCRgCj23KKdRFrPHCpIATnjo
	 rEp7mKJKC11ros6SbIJlmlkQJ4NeH3w2KvvI6+9JW2wnTEszTJsTvmNpOKc8t7qYV3pIz
	 2CWR5hXTzLrQ53hxrjWRBld3UMhG7LdLWh3kZlQljpZD+2V6ZftRfCc35zS9WAyRlqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420833;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YYEjhO22grQhNceaCwu/+O1uw5mne99I34/I4Zug3/c=;
	b=NMwI31B+y63G1w3tk26ybQlS1wVQeHb+ThXysRAXGPPlKwVm7qbPXxIcAoZOdgTjAZvD
	 MpCRW1Ngujar+KKF+ndGgsmjL0ucXotYnKkxKTtIVzf4sPGR1haob5vMBrxKNKPTG81oq
	 jNNnZqJXAuagv8vFe2OzKzO3vnYWGRDrF0BBAonyHjnI/f+M86F7WZaKu10MtDaQexVx8
	 ELzfqhZB/VsRiMtjnGJosihk/kp6ZFsKrQAwJmwBLBppy1MxQyy69bkA5HxACxAAyo1RH
	 y2U5ginxPFpMNUzrVFofyuNXRzT37h+3o7X5ymvp8n0+v2boFkEqM1piJjmQJ2FafQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cynB0wuy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43937606A895
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cynB0wuy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652AB1F00A07;
	Wed, 11 Nov 2026 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420833;
	bh=YYEjhO22grQhNceaCwu/+O1uw5mne99I34/I4Zug3/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cynB0wuyd5BYUqfBoMOF7W/fSIVotXYZAoeEM56K5lzf5hDQX3Tl3defMiBfEWPBb
	 75vH4Rfa3E+ZteVx4fxLhK+tqkHpr/SRLfqggL5fM1i5YZaX3k8JAFojRUR1dsw6Nr
	 zvucgZxeiR1rzZb2BT7aT6XdLSjx1ETl3L7XvSioSpmAsZJkdy8N3LSIe6hMfqGAZ3
	 nsmNev+w5naOt3A4HLBUdi2D5uSdzXg3R+coxxRjTt4QxPlG8vkS1RXCkW8/u0T9By
	 7Q6lvGjireyggjDMD4bI429OpogdEln+cr4gDcgOrXYHMgbhOWl5CpzcZX7n9GXmG/
	 sqBcrZFcNwgqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@rothwell.id.au>,
	"David S. Miller" <davem@davemloft.net>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] arch: turn off -Werror for architectures with known warnings
Date: Wed, 11 Nov 2026 13:13:48 -0500
Message-ID: <20261111181340.3748826-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111181340.3748826-1-sashal@kernel.org>
References: <20261107062501-failed-5.10-fe221b7b2d3e@kernel.org>
 <20261111181340.3748826-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 0f0d2871e78db648a2578abbeb9103f484f9b754 ]

A couple of architectures enable -Werror for their own files regardless of
CONFIG_WERROR but also have known warnings that fail the build with
-Wmissing-prototypes enabled by default:

arch/alpha/lib/memcpy.c:153:8: error: no previous prototype for 'memcpy' [-Werror=missing-prototypes]
arch/alpha/kernel/irq.c:96:1: error: no previous prototype for 'handle_irq' [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:673:17: error: no previous prototype for ‘sys_rt_sigreturn’ [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:636:17: error: no previous prototype for ‘sys_sigreturn’ [-Werror=missing-prototypes]
arch/mips/kernel/syscall.c:51:16: error: no previous prototype for ‘sysm_pipe’ [-Werror=missing-prototypes]
arch/mips/mm/fault.c:323:17: error: no previous prototype for ‘do_page_fault’ [-Werror=missing-prototypes]
arch/sparc/vdso/vma.c:246:12: warning: no previous prototype for ‘init_vdso_image’ [-Wmissing-prototypes]v
arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no previous prototype for ‘__vdso_gettimeofday_stick’ [-Wmissing-prototypes]
arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous prototype for ‘__vdso_gettimeofday_stick’ [-Wmissing-prototypes]
arch/sparc/prom/p1275.c:52:6: warning: no previous prototype for ‘prom_cif_init’ [-Wmissing-prototypes]
arch/sparc/prom/misc_64.c:165:5: warning: no previous prototype for ‘prom_get_mmu_ihandle’ [-Wmissing-prototypes]

This appears to be an artifact from the times when this architecture code
was better maintained that most device drivers and before CONFIG_WERROR
was added.  Now it just gets in the way, so remove all of these.

Powerpc and x86 both still have their own Kconfig options to enable
-Werror for some of their files.  These architectures are better
maintained than most and the options are easy to disable, so leave those
untouched.

Link: https://lkml.kernel.org/r/4be73872-c1f5-4c31-8201-712c19290a22@app.fastmail.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Stephen Rothwell <sfr@rothwell.id.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: fe221b7b2d3e ("alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/lib/Makefile    | 1 -
 arch/alpha/mm/Makefile     | 2 --
 arch/mips/Kbuild           | 6 ------
 arch/sparc/kernel/Makefile | 1 -
 arch/sparc/lib/Makefile    | 1 -
 arch/sparc/mm/Makefile     | 1 -
 arch/sparc/prom/Makefile   | 1 -
 7 files changed, 13 deletions(-)

diff --git a/arch/alpha/lib/Makefile b/arch/alpha/lib/Makefile
index 854d5e79979e4..6a1dae277592f 100644
--- a/arch/alpha/lib/Makefile
+++ b/arch/alpha/lib/Makefile
@@ -4,7 +4,6 @@
 #
 
 asflags-y := $(KBUILD_CFLAGS)
-ccflags-y := -Werror
 
 # Many of these routines have implementations tuned for ev6.
 # Choose them iff we're targeting ev6 specifically.
diff --git a/arch/alpha/mm/Makefile b/arch/alpha/mm/Makefile
index 08ac6612edadf..09fea7216efdf 100644
--- a/arch/alpha/mm/Makefile
+++ b/arch/alpha/mm/Makefile
@@ -3,8 +3,6 @@
 # Makefile for the linux alpha-specific parts of the memory manager.
 #
 
-ccflags-y := -Werror
-
 obj-y	:= init.o fault.o
 
 obj-$(CONFIG_DISCONTIGMEM) += numa.o
diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index d5d6ef9bb9867..ec088204f51cb 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -1,10 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# Fail on warnings - also for files referenced in subdirs
-# -Werror can be disabled for specific files using:
-# CFLAGS_<file.o> := -Wno-error
-ifeq ($(W),)
-subdir-ccflags-y := -Werror
-endif
 
 # platform specific definitions
 include arch/mips/Kbuild.platforms
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index d3a0e072ebe8c..6858304be1dbe 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -5,7 +5,6 @@
 #
 
 asflags-y := -ansi
-ccflags-y := -Werror
 
 extra-y     := head_$(BITS).o
 
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 063556fe2cb1d..59669ebddd4e1 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -3,7 +3,6 @@
 #
 
 asflags-y := -ansi -DST_DIV0=0x02
-ccflags-y := -Werror
 
 lib-$(CONFIG_SPARC32) += ashrdi3.o
 lib-$(CONFIG_SPARC32) += memcpy.o memset.o
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index b078205b70e0b..c56f3b1236ebd 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -3,7 +3,6 @@
 #
 
 asflags-y := -ansi
-ccflags-y := -Werror
 
 obj-$(CONFIG_SPARC64)   += ultra.o tlb.o tsb.o
 obj-y                   += fault_$(BITS).o
diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
index 397b79af77f7b..a1adc75d80551 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -3,7 +3,6 @@
 # Linux.
 #
 asflags := -ansi
-ccflags := -Werror
 
 lib-y                 := bootstr_$(BITS).o
 lib-y                 += init_$(BITS).o
-- 
2.53.0

