Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047241;
	b=aSanKQC8gnDgyg4y1OP8i+swWbgRXNLmuVRADSFeoK0cxBDNU1LgRf+r/KWmwuQwr+om
	 pFFS5Ux+ZWkY4GjrB7/mcDoqr+Gk1EDsfoqSpRqcbrskv8qtF1V1gwBY409hqoyCgas1V
	 Hvru5B+Ac3VrUbxgJ9q8si55t7S2MyLutszXiaQxoK599+y78xL25Vj0FwNJ0HsumGKpa
	 muX/IU+ckS8NOhWAEBiQQfr4hMTTF8IA+NA+Lave+F1AoCZMIyQr1/5myw3MIRYoSUi90
	 wlaDNgZDX5rCkhO8bdrauDHTXuF1d4UK+hNpO3ajwu97LOHLlX2WgwPWswZ2k8wa4kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047241;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=E8St1K6Cz05MwAR2E+5vT1sf/1427GgEhffkACIxXEc=;
	b=f7OJiOVk9FGYuB1OGlJ3pxjI7VQR/ywzVd8+h9J0usS2hXpvcUX4mf1Qs7/aZz/1KUNq
	 70+A03wBMw3fZDG49LdRHjcGlS2qvWUtgVanu9lFoTo5YxDC1teAoF5txTFzx5U1kaK9S
	 Ll8jgcqPlDdFcZOno0FgSc2pqNT8NunwMH3qijNkqpnHaW33AhiB3VEgBk3PsynHdKTv4
	 frwiGp6LTkksGh9uWlTQSE6YYXpqrycLqAN2WaEnqr0OnofSF99or/9fChPDP47xReNMJ
	 25ueyTCHB7LQsTAIz+66ZZ1ufyFBvHKeJr9NclIES+ACG0hFXOcqnHLtAgiQgXpAkaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLIAxxFX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD54606A33A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLIAxxFX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B951F0089F;
	Sat,  7 Nov 2026 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047240;
	bh=E8St1K6Cz05MwAR2E+5vT1sf/1427GgEhffkACIxXEc=;
	h=From:To:Cc:Subject:Date;
	b=HLIAxxFXT4e2XzcoPkOmOmxX+cC0HziTFU86Ax2hwmPJ7B1NOwStJVc1npvvIK1Iv
	 VyrCS7CqGTZdJlIg0JauS+X3MSrXrs+7JnjXASPafKv4choq12r/B35coAAfalosQc
	 1NjYlBKaGomuXcn+HYOCPh7USEAWwymJnqhnCdmxpuMBBt7hv9xfav27DyEskoZmw6
	 3UzvsmyXHGpwA2XDnnOcZyS8sLln0h6p/dXpSid5SqAjNbrvCtfiJxSMii5x33JZnN
	 gt/f0A8yx8m3vxSIMGnJi3fBI8dsS2AFSMJKE1dx5gwCH6p4Lds9VbZTRpGvUL2J0k
	 pG0VxUDyUzBbA==
From: Sasha Levin <sashal@kernel.org>
To: yangtiezhu@loongson.cn,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Fix one-shot limitation for perf hardware breakpoints" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:19 -0500
Message-ID: <20261107052719-failed-6.12-5e0b00fd000a@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5e0b00fd000a53a5428fed6c96be74019bd0ad17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052719-failed-6.12-5e0b00fd000a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5e0b00fd000a53a5428fed6c96be74019bd0ad17 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue, 27 Oct 2026 22:51:35 +0800
Subject: [PATCH] LoongArch: Fix one-shot limitation for perf hardware
 breakpoints

In breakpoint_handler() and watchpoint_handler(), the code disables the
hardware slot by executing update_bp_registers(regs, 0, ...). This design
forces the active hardware breakpoint configuration to be wiped out upon
its first hit, turning standard perf hardware breakpoints into "one-shot"
events.

Furthermore, while the ptrace single-step path in do_watch() executes a
hardware single-step skip mechanism to advance the PC, the standard perf
path lacks any mechanism to bypass the original triggering instruction.

To maintain the long-term persistence of hardware breakpoints for perf
usage, eliminate the disruptive calls to update_bp_registers() within
the handler loops to keep the breakpoint configuration enabled.

Concurrently, execute a single, unified register write outside the loop
to atomize the state transition and explicitly enforce the hardware skip
mechanism once per exception return, ensuring the processor safely steps
forward without lockups.

Meanwhile, in order to prevent status contamination during single-core
context switches or cross-core thread migrations, the hardware register
skip state of the previous thread is saved first. Then, the skip state
is restored and its software skip flag is also cleared only if the next
thread has the skip flag; otherwise, 0 is written to clear the FWPS and
MWPS registers, which explicitly clears the skip bit according to the
architectural specification.

Additionally, explicitly clear hbp_break_skip and hbp_watch_skip inside
ptrace_hw_copy_thread() which is called by copy_thread() during the task
creation. This guarantees that a newly cloned child task starts with a
clean slate.

Here is a user-space reproducer to demonstrate the issue.

(1) Test program (test_perf_continuous.c):

  #include <stdio.h>
  #include <unistd.h>
  #include <sys/syscall.h>
  #include <sys/ioctl.h>
  #include <linux/perf_event.h>
  #include <linux/hw_breakpoint.h>

  static int var = 0;

  int main(void)
  {
  	size_t count = 0;
  	struct perf_event_attr attr = {
  		.type = PERF_TYPE_BREAKPOINT,
  		.size = sizeof(attr),
  		.bp_type = HW_BREAKPOINT_W,
  		.bp_addr = (unsigned long)&var,
  		.bp_len = HW_BREAKPOINT_LEN_1,
  		.exclude_kernel = 1,
  	};

  	int fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
  	ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);

  	asm volatile("st.b %1, %0" : "=m"(var) : "r"(11) : "memory");
  	asm volatile("st.b %1, %0" : "=m"(var) : "r"(22) : "memory");
  	asm volatile("st.b %1, %0" : "=m"(var) : "r"(33) : "memory");

  	ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
  	read(fd, &count, sizeof(size_t));

  	printf("Watchpoint counts: expected = 3, actual = %zu\n", count);

  	close(fd);
  	return 0;
  }

(2) Test steps:

  $ gcc test_perf_continuous.c -o test_perf_continuous
  $ ./test_perf_continuous

(3) Test results:

Without this patch:

  Watchpoint counts: expected = 3, actual = 1

With this patch:

  Watchpoint counts: expected = 3, actual = 3

Cc: stable@vger.kernel.org
Fixes: 3eb2a8b23598 ("LoongArch: Fix multiple hardware watchpoint issues")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/hw_breakpoint.h |  4 +--
 arch/loongarch/include/asm/loongarch.h     |  3 ++
 arch/loongarch/include/asm/processor.h     |  1 +
 arch/loongarch/include/asm/switch_to.h     |  2 +-
 arch/loongarch/kernel/hw_breakpoint.c      | 39 +++++++++++++++++++---
 5 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/include/asm/hw_breakpoint.h b/arch/loongarch/include/asm/hw_breakpoint.h
index d202052df8a16..f4478936787d6 100644
--- a/arch/loongarch/include/asm/hw_breakpoint.h
+++ b/arch/loongarch/include/asm/hw_breakpoint.h
@@ -121,12 +121,12 @@ bool watchpoint_handler(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 extern void ptrace_hw_copy_thread(struct task_struct *task);
-extern void hw_breakpoint_thread_switch(struct task_struct *next);
+extern void hw_breakpoint_thread_switch(struct task_struct *prev, struct task_struct *next);
 #else
 static inline void ptrace_hw_copy_thread(struct task_struct *task)
 {
 }
-static inline void hw_breakpoint_thread_switch(struct task_struct *next)
+static inline void hw_breakpoint_thread_switch(struct task_struct *prev, struct task_struct *next)
 {
 }
 #endif
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 32bbff337c5c4..28eff8b49d1ba 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1133,6 +1133,9 @@
 #define CSR_FWPS_SKIP_SHIFT		16
 #define CSR_FWPS_SKIP			(_ULCAST_(1) << CSR_FWPS_SKIP_SHIFT)
 
+#define CSR_MWPS_SKIP_SHIFT		16
+#define CSR_MWPS_SKIP			(_ULCAST_(1) << CSR_MWPS_SKIP_SHIFT)
+
 /*
  * CSR_ECFG IM
  */
diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
index ce8b953f8c793..a884f964ec983 100644
--- a/arch/loongarch/include/asm/processor.h
+++ b/arch/loongarch/include/asm/processor.h
@@ -138,6 +138,7 @@ struct thread_struct {
 	struct loongarch_lbt lbt; /* Also conditionally copied */
 
 	/* Hardware breakpoints pinned to this task. */
+	bool hbp_break_skip, hbp_watch_skip;
 	struct perf_event *hbp_break[LOONGARCH_MAX_BRP];
 	struct perf_event *hbp_watch[LOONGARCH_MAX_WRP];
 };
diff --git a/arch/loongarch/include/asm/switch_to.h b/arch/loongarch/include/asm/switch_to.h
index 27acbf9137744..ab9e0292c7f37 100644
--- a/arch/loongarch/include/asm/switch_to.h
+++ b/arch/loongarch/include/asm/switch_to.h
@@ -34,7 +34,7 @@ extern asmlinkage struct task_struct *__switch_to(struct task_struct *prev,
 do {										\
 	lose_fpu_inatomic(1, prev);						\
 	lose_lbt_inatomic(1, prev);						\
-	hw_breakpoint_thread_switch(next);					\
+	hw_breakpoint_thread_switch(prev, next);				\
 	set_current(next);							\
 	(last) = __switch_to(prev, next,					\
 		 __builtin_return_address(0), __builtin_frame_address(0));	\
diff --git a/arch/loongarch/kernel/hw_breakpoint.c b/arch/loongarch/kernel/hw_breakpoint.c
index 1a05350159f7b..df149ff06dd50 100644
--- a/arch/loongarch/kernel/hw_breakpoint.c
+++ b/arch/loongarch/kernel/hw_breakpoint.c
@@ -156,6 +156,9 @@ static int hw_breakpoint_slot_setup(struct perf_event **slots, int max_slots,
 
 void ptrace_hw_copy_thread(struct task_struct *tsk)
 {
+	tsk->thread.hbp_break_skip = 0;
+	tsk->thread.hbp_watch_skip = 0;
+
 	memset(tsk->thread.hbp_break, 0, sizeof(tsk->thread.hbp_break));
 	memset(tsk->thread.hbp_watch, 0, sizeof(tsk->thread.hbp_watch));
 }
@@ -485,6 +488,7 @@ NOKPROBE_SYMBOL(update_bp_registers);
 bool breakpoint_handler(struct pt_regs *regs)
 {
 	int i;
+	unsigned int clear_mask = 0;
 	bool need_sigtrap = false;
 	struct perf_event *bp, **slots;
 
@@ -500,11 +504,13 @@ bool breakpoint_handler(struct pt_regs *regs)
 			if (bp->attr.sigtrap)
 				need_sigtrap = true;
 
-			csr_write32(0x1 << i, LOONGARCH_CSR_FWPS);
-			update_bp_registers(regs, 0, 0);
+			clear_mask |= (0x1 << i);
 		}
 	}
 
+	if (clear_mask)
+		csr_write32(clear_mask | CSR_FWPS_SKIP, LOONGARCH_CSR_FWPS);
+
 	return need_sigtrap;
 }
 NOKPROBE_SYMBOL(breakpoint_handler);
@@ -512,6 +518,7 @@ NOKPROBE_SYMBOL(breakpoint_handler);
 bool watchpoint_handler(struct pt_regs *regs)
 {
 	int i;
+	unsigned int clear_mask = 0;
 	bool need_sigtrap = false;
 	struct perf_event *wp, **slots;
 
@@ -527,11 +534,13 @@ bool watchpoint_handler(struct pt_regs *regs)
 			if (wp->attr.sigtrap)
 				need_sigtrap = true;
 
-			csr_write32(0x1 << i, LOONGARCH_CSR_MWPS);
-			update_bp_registers(regs, 0, 1);
+			clear_mask |= (0x1 << i);
 		}
 	}
 
+	if (clear_mask)
+		csr_write32(clear_mask | CSR_MWPS_SKIP, LOONGARCH_CSR_MWPS);
+
 	return need_sigtrap;
 }
 NOKPROBE_SYMBOL(watchpoint_handler);
@@ -555,7 +564,7 @@ static int __init arch_hw_breakpoint_init(void)
 }
 arch_initcall(arch_hw_breakpoint_init);
 
-void hw_breakpoint_thread_switch(struct task_struct *next)
+void hw_breakpoint_thread_switch(struct task_struct *prev, struct task_struct *next)
 {
 	u64 addr, mask;
 	struct pt_regs *regs = task_pt_regs(next);
@@ -567,6 +576,26 @@ void hw_breakpoint_thread_switch(struct task_struct *next)
 			csr_write32(CSR_FWPS_SKIP, LOONGARCH_CSR_FWPS);
 		regs->csr_prmd |= CSR_PRMD_PWE;
 	} else {
+		unsigned int fwps = csr_read32(LOONGARCH_CSR_FWPS);
+		unsigned int mwps = csr_read32(LOONGARCH_CSR_MWPS);
+
+		prev->thread.hbp_break_skip = !!(fwps & CSR_FWPS_SKIP);
+		prev->thread.hbp_watch_skip = !!(mwps & CSR_MWPS_SKIP);
+
+		if (!next->thread.hbp_break_skip)
+			csr_write32(0, LOONGARCH_CSR_FWPS);
+		else {
+			csr_write32(CSR_FWPS_SKIP, LOONGARCH_CSR_FWPS);
+			next->thread.hbp_break_skip = 0;
+		}
+
+		if (!next->thread.hbp_watch_skip)
+			csr_write32(0, LOONGARCH_CSR_MWPS);
+		else {
+			csr_write32(CSR_MWPS_SKIP, LOONGARCH_CSR_MWPS);
+			next->thread.hbp_watch_skip = 0;
+		}
+
 		/* Update breakpoints */
 		update_bp_registers(regs, 1, 0);
 		/* Update watchpoints */
-- 
2.53.0




