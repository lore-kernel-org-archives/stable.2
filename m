Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63410288B8
	for <stable@vger.kernel.org>; Sat, 30 May 2026 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102944; cv=none; b=r90p3wno61QxeVPvd3rgLrnrRhIStMhrF+wCVD/u/6UHkGoKTYL8VU4/Zt3oDPirJUYakzfGRXakC6gnAq3b4KsvRiB5yQOIAgMDYpVARSV+ePE54lKg0M1YKFhY49Aucvgv8N8BQEbBVOs/n2QcyO5TmMqGAyOsXhJVDQ8InF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102944; c=relaxed/simple;
	bh=BGwk0Xz0Oq0aYfF5q2dUHXvEbYT9Ah0t+UA76SEy7pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6FyNFo+8EN6C3RZsrFF/TaTwdi8VAOMysYOr+rXCPbOZrhmeQZIMbeWd/blqD2F5N/WAmo+eStD364o+law6T0s9snCZFz+gCp8KHZ3AJURG7mPyCjoNjmFShZYNpzk0iHfblcqFHvCyJ7BnjfKtsBI3q+QafVxJiBySo8M6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/Tyw8Ij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/Tyw8Ij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383CE1F00893;
	Sat, 30 May 2026 01:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102943;
	bh=dobI/ylMiYp0FfPHWJOkPKe/SCovzWOczJOvGw5cuys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/Tyw8Ijd3CGjGBTA2Njhub56eLvrXrprfuCezUOzgF9z7QlVXNmNrKCOFiB2c6s9
	 gTUm3VEZqPJSvWepSrXcRx95jXZQoUZ+3aJg/NYpwklgYPCO2V3bccaOoiyXgHqunr
	 JG1tFGPW0bGRPPl+WV98vlgpFK0MF5D6hADJbWOZvQheTot11WV0PpZxgG/BEuKTUE
	 mDB9cOy9zdG4Hu6xEwT9ImAab0J35GTIo4bvSJiR/eEZjXcwO5QkA6lrS4O5ec064B
	 /HQlnzQRJYT7beWIjh5D5pk8d0+8HLkvl+LxRSAuNzm2iw7rPFXZ3t8hiszUZYWoVJ
	 zaVdNpdEj8tbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ian Rogers <irogers@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ring-buffer: Flush and stop persistent ring buffer on panic
Date: Fri, 29 May 2026 21:02:19 -0400
Message-ID: <20260530010219.2456798-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052840-curve-charger-8597@gregkh>
References: <2026052840-curve-charger-8597@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit a494d3c8d5392bcdff83c2a593df0c160ff9f322 ]

On real hardware, panic and machine reboot may not flush hardware cache
to memory. This means the persistent ring buffer, which relies on a
coherent state of memory, may not have its events written to the buffer
and they may be lost. Moreover, there may be inconsistency with the
counters which are used for validation of the integrity of the
persistent ring buffer which may cause all data to be discarded.

To avoid this issue, stop recording of the ring buffer on panic and
flush the cache of the ring buffer's memory.

Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
Cc: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ian Rogers <irogers@google.com>
Link: https://patch.msgid.link/177751969602.2136606.12031934362587643488.stgit@mhiramat.tok.corp.google.com
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/include/asm/Kbuild        |  1 +
 arch/arc/include/asm/Kbuild          |  1 +
 arch/arm/include/asm/Kbuild          |  1 +
 arch/arm64/include/asm/ring_buffer.h | 10 ++++++++++
 arch/csky/include/asm/Kbuild         |  1 +
 arch/hexagon/include/asm/Kbuild      |  1 +
 arch/loongarch/include/asm/Kbuild    |  1 +
 arch/m68k/include/asm/Kbuild         |  1 +
 arch/microblaze/include/asm/Kbuild   |  1 +
 arch/mips/include/asm/Kbuild         |  1 +
 arch/nios2/include/asm/Kbuild        |  1 +
 arch/openrisc/include/asm/Kbuild     |  1 +
 arch/parisc/include/asm/Kbuild       |  1 +
 arch/powerpc/include/asm/Kbuild      |  1 +
 arch/riscv/include/asm/Kbuild        |  1 +
 arch/s390/include/asm/Kbuild         |  1 +
 arch/sh/include/asm/Kbuild           |  1 +
 arch/sparc/include/asm/Kbuild        |  1 +
 arch/um/include/asm/Kbuild           |  1 +
 arch/x86/include/asm/Kbuild          |  1 +
 arch/xtensa/include/asm/Kbuild       |  1 +
 include/asm-generic/ring_buffer.h    | 13 +++++++++++++
 kernel/trace/ring_buffer.c           | 22 ++++++++++++++++++++++
 23 files changed, 65 insertions(+)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 396caece6d6d9..80a12a6035530 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += agp.h
 generic-y += asm-offsets.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 49285a3ce2398..ccc466802b5c4 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -5,4 +5,5 @@ generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 generic-y += user.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 03657ff8fbe3d..decad5f2c826f 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += early_ioremap.h
 generic-y += extable.h
 generic-y += flat.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 
 generated-y += mach-types.h
 generated-y += unistd-nr.h
diff --git a/arch/arm64/include/asm/ring_buffer.h b/arch/arm64/include/asm/ring_buffer.h
new file mode 100644
index 0000000000000..62316c4068881
--- /dev/null
+++ b/arch/arm64/include/asm/ring_buffer.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_ARM64_RING_BUFFER_H
+#define _ASM_ARM64_RING_BUFFER_H
+
+#include <asm/cacheflush.h>
+
+/* Flush D-cache on persistent ring buffer */
+#define arch_ring_buffer_flush_range(start, end)	dcache_clean_pop(start, end)
+
+#endif /* _ASM_ARM64_RING_BUFFER_H */
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 9a9bc65b57a9d..c98d8be2330a3 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -9,5 +9,6 @@ generic-y += qrwlock.h
 generic-y += qrwlock_types.h
 generic-y += qspinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 8c1a78c8f5271..10a1426d95e81 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += extable.h
 generic-y += iomap.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 5b5a6c90e6e20..7850eedda3b38 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -9,5 +9,6 @@ generic-y += qrwlock.h
 generic-y += user.h
 generic-y += ioctl.h
 generic-y += mmzone.h
+generic-y += ring_buffer.h
 generic-y += statfs.h
 generic-y += param.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 0dbf9c5c6faeb..8ea462cd10e7f 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -3,4 +3,5 @@ generated-y += syscall_table.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += spinlock.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index a055f5dbe00a3..0ed312ae61ef1 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 generic-y += syscalls.h
 generic-y += tlb.h
 generic-y += user.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 7ba67a0d6c97b..a6bb06820e7c2 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -12,4 +12,5 @@ generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 0d09829ed1445..378ddebc1db36 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -5,5 +5,6 @@ generic-y += cmpxchg.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += spinlock.h
 generic-y += user.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index cef49d60d74c0..8aa34621702de 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -8,4 +8,5 @@ generic-y += spinlock_types.h
 generic-y += spinlock.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 4fb596d94c893..d48d158f72412 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -4,4 +4,5 @@ generated-y += syscall_table_64.h
 generic-y += agp.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index e5fdc336c9b22..12537f780e2c5 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -6,4 +6,5 @@ generic-y += agp.h
 generic-y += kvm_types.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
+generic-y += ring_buffer.h
 generic-y += early_ioremap.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 1461af12da6e2..ad6978567e5f5 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -11,5 +11,6 @@ generic-y += spinlock.h
 generic-y += spinlock_types.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 297bf71579689..2b367fa4de8e4 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -8,3 +8,4 @@ generic-y += asm-offsets.h
 generic-y += kvm_types.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
+generic-y += ring_buffer.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index fc44d9c88b419..edbf46a7ea4c3 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -3,3 +3,4 @@ generated-y += syscall_table.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 43b0ae4c2c211..9aa7a7e1242d5 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -4,3 +4,4 @@ generated-y += syscall_table_64.h
 generic-y += agp.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 18f902da8e997..abe7a9fe13c8f 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -19,6 +19,7 @@ generic-y += param.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
+generic-y += ring_buffer.h
 generic-y += runtime-const.h
 generic-y += softirq_stack.h
 generic-y += switch_to.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 6c23d1661b173..269b1ed3f12ec 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -12,3 +12,4 @@ generated-y += xen-hypercalls.h
 generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
+generic-y += ring_buffer.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index fa07c686cbcc2..a5875956392ab 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -7,4 +7,5 @@ generic-y += param.h
 generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
diff --git a/include/asm-generic/ring_buffer.h b/include/asm-generic/ring_buffer.h
new file mode 100644
index 0000000000000..201d2aee10054
--- /dev/null
+++ b/include/asm-generic/ring_buffer.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Generic arch dependent ring_buffer macros.
+ */
+#ifndef __ASM_GENERIC_RING_BUFFER_H__
+#define __ASM_GENERIC_RING_BUFFER_H__
+
+#include <linux/cacheflush.h>
+
+/* Flush cache on ring buffer range if needed. Do nothing by default. */
+#define arch_ring_buffer_flush_range(start, end)	do { } while (0)
+
+#endif /* __ASM_GENERIC_RING_BUFFER_H__ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ccfaae8795f00..81990ebd63007 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2008 Steven Rostedt <srostedt@redhat.com>
  */
 #include <linux/trace_recursion.h>
+#include <linux/panic_notifier.h>
 #include <linux/trace_events.h>
 #include <linux/ring_buffer.h>
 #include <linux/trace_clock.h>
@@ -29,6 +30,7 @@
 #include <linux/oom.h>
 #include <linux/mm.h>
 
+#include <asm/ring_buffer.h>
 #include <asm/local64.h>
 #include <asm/local.h>
 
@@ -549,6 +551,7 @@ struct trace_buffer {
 
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
+	struct notifier_block		flush_nb;
 
 	long				last_text_delta;
 	long				last_data_delta;
@@ -2316,6 +2319,16 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	kfree(cpu_buffer);
 }
 
+/* Stop recording on a persistent buffer and flush cache if needed. */
+static int rb_flush_buffer_cb(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct trace_buffer *buffer = container_of(nb, struct trace_buffer, flush_nb);
+
+	ring_buffer_record_off(buffer);
+	arch_ring_buffer_flush_range(buffer->range_addr_start, buffer->range_addr_end);
+	return NOTIFY_DONE;
+}
+
 static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 int order, unsigned long start,
 					 unsigned long end,
@@ -2421,6 +2434,12 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 	mutex_init(&buffer->mutex);
 
+	/* Persistent ring buffer needs to flush cache before reboot. */
+	if (start && end) {
+		buffer->flush_nb.notifier_call = rb_flush_buffer_cb;
+		atomic_notifier_chain_register(&panic_notifier_list, &buffer->flush_nb);
+	}
+
 	return buffer;
 
  fail_free_buffers:
@@ -2512,6 +2531,9 @@ ring_buffer_free(struct trace_buffer *buffer)
 {
 	int cpu;
 
+	if (buffer->range_addr_start && buffer->range_addr_end)
+		atomic_notifier_chain_unregister(&panic_notifier_list, &buffer->flush_nb);
+
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
 	irq_work_sync(&buffer->irq_work.work);
-- 
2.53.0

