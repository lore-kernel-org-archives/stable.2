Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C7480DD7;
	Thu, 27 Aug 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842847; cv=none; b=Bh5FISyyWu6AqTOAj3XCZT7ngNAKriQ3c7q1qB7RJSZncyGpclBxC0nLJR8aAOKiIOoWdeOEE3zFNhOYMKrJEJIDKCvFPuNbkl0mlGqTaWVT3vHW2Vc46c2kDad/dVOM106fk+6pzMPJ91K/OgVk4UbLC8T2ZxqGskVqxdj/QNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842847; c=relaxed/simple;
	bh=nwwAk0A29h3a6sNfXEzr6jFkSjE0ZnFzBDXdz24nevM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh7myaA6AZyToxy46yDr3Q1mddkNp+MDXcGuC5ohcIwHcyktTYE5myEtsTlnxwqleRPn9o102RSxxLo98ZFfxU+UpnvA+aLQRdT8QMo9pidFxxlD+B/2V7g5cOvDrYw5XBhuJUfM0lCdpMSu8Z9FiHjJ2bkfuMsT4Zh4G0lRKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MpBjaT0w; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MpBjaT0w"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787842842; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Q8wUlFL8zJyE2cbq79lH4Ro3XKfTesuD81yTpjxjzp4=;
	b=MpBjaT0wmAKTJFDKTYcK3w19lK39UpdoovXxIc6Hxmbq9cpFvCx/RWINSMpwKvJ4o74G8cRwNILBt+QcGNh2O4GsHOIWee/dsiIWsqYjtkWX4CT2y3HBUhvPzJv1AAq/fU2lHxtWPWNva2B2ge1fBGG7GKGTR0fQHxe283OlGfk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X9jzafN_1787842838;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9jzafN_1787842838 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Aug 2026 23:00:40 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	xin@zytor.com,
	luto@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	akpm@linux-foundation.org,
	rdunlap@infradead.org,
	elver@google.com,
	andreyknvl@gmail.com,
	glider@google.com,
	gor@linux.ibm.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] x86/fred: Fix stack depot filtering of FRED event stacks
Date: Thu, 27 Aug 2026 23:00:22 +0800
Message-ID: <20260827150022.1618235-3-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260827150022.1618235-1-xiangzao@linux.alibaba.com>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With FRED, events are delivered to asm_fred_entrypoint_user and
asm_fred_entrypoint_kernel in .noinstr.text, not to the IDT stubs, which
are the only code covered by __irqentry_text_start..__irqentry_text_end.
in_irqentry_text() therefore never recognizes the event entry point and
filter_irq_stacks() does not truncate FRED event stacks: every trace
saved from interrupt or exception context by stack depot users such as
KASAN alloc/free tracking or SLUB object tracking combines the event path
with the arbitrarily interrupted context.  The number of unique stacks
grows with the product of both and the depot is exhausted.

Observed on a dual-socket FRED-capable system with KASAN (generic,
inline) and SLUB object tracking enabled, on both sockets roughly 80
minutes after boot, once the depot had reached its maximum of 8192 pools
(128 MiB):

  Stack depot reached limit capacity
  WARNING: CPU: 286 PID: 128614 at lib/stackdepot.c:271 depot_alloc_stack+0x158/0x170

The traces had the expected shape: an interrupt side trace ran through
asm_fred_entrypoint_kernel into the frames of the task it had
interrupted.  New traces are dropped (handle 0) from then on and the
depot never shrinks, so tracking stays dead until reboot.  (Splat from a
6.6 based kernel; filter_irq_stacks() and the FRED entry layout are
unchanged in mainline.)

The entry points cannot be brought inside that range.  x86 has no
.irqentry.text: commit f0178fc01fe4 ("x86/entry: Unbreak
__irqentry_text_start/end magic") dropped it from the linker script and
emits the markers as labels around the sequentially laid out IDT stubs
instead, exactly because the entry rework had moved that code into
.noinstr.text and broken the function graph tracer and
filter_irq_stacks(); __irq_entry has been __invalid_section since.
Those labels live inside entry_64.S and wrap the IDT stubs which
asm/idtentry.h emits into .entry.text, so the linker cannot place
another translation unit between them, and the FRED entry points cannot
join that block without leaving .noinstr.text.  Architectures which do
have the section fixed the same symptom locally, e.g.
commit f6794950f0e5 ("arm64: set __exception_irq_entry with __irq_entry
as a default") and commit 45c9f2b856a0 ("s390/entry: Mark IRQ entries
to fix stack depot warnings").

Every FRED event leaves a return address in the FRED entry text: the
return address of the call to fred_entry_from_user/kernel, or a frame of
asm_fred_entry_from_kvm(), which the core entry code uses to forward VMX
interrupts and NMIs acknowledged as part of the VM-Exit; see
commit 0701c9e17bd9 ("x86/kvm/vmx: Move IRQ/NMI dispatch from KVM
into x86 core").  So bracket it with __fred_entry_text_start/end, the
same way the IDT stubs are bracketed, and report that range from
arch_in_irqentry_text().  Verified on that system with the fix
backported: traces from FRED event context now end at
asm_fred_entrypoint_kernel (/sys/kernel/debug/slab/*/alloc_traces) and
the pool count levels off a few minutes after boot instead of climbing
to the limit.

Truncating synchronous exception stacks only restores parity with the IDT
range, which has always covered the exception stubs too.  Syscalls enter
through asm_fred_entrypoint_user as well, but there the entry frame is
already the last trace entry, so filter_irq_stacks() returns the full
trace unchanged.  The function graph tracer uses the same markers and has
the same gap; it can be converted separately.

This is not limited to FRED hardware: with CONFIG_X86_FRED=y the KVM
forwarding path above runs the FRED dispatch code even when the kernel
itself uses the IDT, so KVM host stacks take the same untruncated path
on non-FRED systems, albeit from a mostly fixed vcpu_run chain.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Cc: stable@vger.kernel.org # v6.9+
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
Build tested with CONFIG_X86_FRED=y and CONFIG_X86_KERNEL_IBT=y, with
and without CONFIG_KVM_INTEL: __fred_entry_text_start lands on the
4K-aligned asm_fred_entrypoint_user and the new range stays inside
.noinstr.text.

Note for stable: depends on patch 1/2.

 arch/x86/Kconfig                |  1 +
 arch/x86/entry/entry_64_fred.S  | 14 ++++++++++++++
 arch/x86/include/asm/sections.h |  1 +
 arch/x86/kernel/stacktrace.c    | 13 +++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15fd9ec5ecac..78b8eb4a925f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -555,6 +555,7 @@ config X86_CPU_RESCTRL_INTEL_AET
 config X86_FRED
 	bool "Flexible Return and Event Delivery"
 	depends on X86_64
+	select ARCH_HAS_IN_IRQENTRY_TEXT
 	help
 	  When enabled, use Flexible Return and Event Delivery
 	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index b98f8945dfff..620def9039a3 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -36,6 +36,17 @@
  */
 	.align 4096
 
+/*
+ * Bounds of the FRED event entry text.  Every event delivered by FRED
+ * enters here, including events which the core entry code forwards
+ * through asm_fred_entry_from_kvm().  This is the FRED counterpart of
+ * __irqentry_text_start..__irqentry_text_end and lets
+ * in_irqentry_text() find the event entry point of a stack, see
+ * arch_in_irqentry_text().
+ */
+	.globl __fred_entry_text_start
+__fred_entry_text_start:
+
 SYM_CODE_START_NOALIGN(asm_fred_entrypoint_user)
 	FRED_ENTER
 	call	fred_entry_from_user
@@ -150,3 +161,6 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 
 SYM_FUNC_END(asm_fred_entry_from_kvm)
 #endif
+
+	.globl __fred_entry_text_end
+__fred_entry_text_end:
diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 30e8ee7006f9..1b52239fcefd 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -5,6 +5,7 @@
 #include <asm-generic/sections.h>
 #include <asm/extable.h>
 
+extern char __fred_entry_text_start[], __fred_entry_text_end[];
 extern char __relocate_kernel_start[], __relocate_kernel_end[];
 extern char __brk_base[], __brk_limit[];
 extern char __end_rodata_aligned[];
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index ee117fcf46ed..4af7e52d9d97 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -9,6 +9,7 @@
 #include <linux/stacktrace.h>
 #include <linux/export.h>
 #include <linux/uaccess.h>
+#include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
@@ -128,3 +129,15 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 }
 
+#ifdef CONFIG_X86_FRED
+bool arch_in_irqentry_text(unsigned long addr)
+{
+	/*
+	 * FRED delivers events to entry points in .noinstr.text, which
+	 * __irqentry_text_start..__irqentry_text_end does not cover.  See
+	 * __fred_entry_text_start in entry_64_fred.S.
+	 */
+	return addr >= (unsigned long)__fred_entry_text_start &&
+	       addr < (unsigned long)__fred_entry_text_end;
+}
+#endif
-- 
2.43.5

