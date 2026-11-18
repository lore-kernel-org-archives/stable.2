Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991510;
	b=0HW8wQuNIbgSkfPSGu+IpFks3V4Ty7VaTJP7fQrk2IiOwFSkdxeh/h0NRJCViAa2R/Gg
	 5ZD9MqKbXRYKFvajEd1fvOubbLnLu9Sgf0KuZF7F7mAca4gLop1mypD1LPdrtVJh3TWlE
	 mojA9qS5ETVfJb7h1IemRnlZIsLhHGLVHjHeFOgA966/Xor4hY7m6XIexskzk5DD7rGRg
	 EYdeUm6F839JasW4PdMGVSjxNW6jmGzOH6elrNlXwut4W850EuhQ/UWJe7A+YWiOh8XIf
	 p9RkRkaJ+vC3fmyax1eR9WTaYiwUIPUGFEtL0HLEiMgAKIhuL/fvEKbJBMNkccxZubQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991510;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uj/+EXTmzLT4/4V/gPbOch99z9AncJy44fRIKCdAIAY=;
	b=saflzWBR59Z56GLfJG+3xGWIizjXdRPbDB7ARVLtDVBqvKvyxminpu2GqiFy+mC3aGHp
	 G3z95AykwfMQZfTBvQF3EIIWIgy7vNBxlR4Q2Q4F1KBa9+5uf1gTUSlI0yRa7CQ1If3kH
	 qc+6bwkjfQnBKY+vj5DwhZLJ8laNZSv8HwpiNfy64voBhY7UwFTuQDMgywcZOkr8AKXFw
	 8G3WEzp5A1vVAIkHV3Cxvf7kQa553f4xsKQasljWCYHBt5v63jR6e3FVyj+NbpLnf79xK
	 uBLLh0wfxlO6Jb5/xbc7R+tOyDSPAVuV6oAqu59vUmT5U2NSyJ+wRZCVtKT7SYE+MtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfyNvyMU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D389606A31C;
	Wed, 18 Nov 2026 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfyNvyMU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3681F000C4;
	Wed, 18 Nov 2026 08:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991510;
	bh=uj/+EXTmzLT4/4V/gPbOch99z9AncJy44fRIKCdAIAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LfyNvyMU8jP0PIo0KqkaGxou0iqRctVwssjHLSBG+MnPHGpmCKXXYhgxFM9wObuWm
	 5r1r397m1WkuJnwPJX8k5HBaHkiuoaOZJUyCca6nAqBwih+gUuZRY78FvBL6GxovEI
	 yuyFFIBlmLHWOpLgcef9nbbOF5FYCs4QZq4/H+RwaDeqnXmFqKR/mQcpQdhdl29kAq
	 SL/Rk+ibwiBc4jwp6vVuereeTkKUik0PxD/9aN0CTJjcr9ovYYsWqiUgby/7l4bfHD
	 aFJDwj8MgsaEDjvqG4qejKV0sUSVQZYAp9aLMRjMm394KfaMUcGY0ucpUyWxX37zkn
	 /+p/9iOV8e/AA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org,
	rtm@csail.mit.edu,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf 1/2] bpf: Restrict uprobe ctx writes to the registers ptrace can set
Date: Wed, 18 Nov 2026 09:44:49 +0100
Message-ID: <20261118084451.12590-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118084451.12590-1-jolsa@kernel.org>
References: <20261118084451.12590-1-jolsa@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 7384893d970e ("bpf: Allow uprobe program to change context
registers") a uprobe program can write any field of struct pt_regs.
Some of those fields are not plain user registers. The exit to user
space loads them into the CPU:

  arch    field   exit path                        ptrace
  ------  ------  -------------------------------  ------------------
  riscv   status  csrw CSR_STATUS, a0              not in the regset
  arm64   pstate  msr spsr_el1, x22                valid_user_regs()
  x86-64  cs, ss  (cs & 3) == 0: iretq to ring 0   set_segment_reg()
  x86-64  flags   iretq loads IF and IOPL          set_flags()

On riscv a program that sets sstatus.SPP in pt_regs.status makes
ret_from_exception return to user code in supervisor mode. On x86-64 a
program that writes a kernel selector to cs makes iretq return to
ring 0.
ptrace guards these fields, but the bpf verifier does not.

Add arch_uprobe_regs_writable(). Each arch lists the registers that
ptrace can set to any value, and kprobe_prog_is_valid_access() rejects
writes to any other offset when the program is loaded:

  arm64:   x0 to x30, sp, pc
  riscv:   epc, ra to t6
  x86-64:  r15 to di, ip, sp

The default is no writes, so arches without a list (and 32-bit x86)
lose ctx writes for uprobe programs. Reads are not affected.

flags on x86-64 and pstate on arm64 become read-only, including the
condition bits that ptrace would let a debugger change. orig_ax is
read-only too.

Kprobe programs that write ctx were already rejected when they were
attached. Those that write one of these fields now fail to load.

Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
Cc: stable@vger.kernel.org
Reported-by: rtm@csail.mit.edu
Closes: https://lore.kernel.org/bpf/30318.1794850523@30-11-166.wireless.csail.mit.edu/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/arm64/kernel/probes/uprobes.c |  6 ++++++
 arch/riscv/kernel/probes/uprobes.c |  6 ++++++
 arch/x86/kernel/uprobes.c          | 15 +++++++++++++++
 include/linux/uprobes.h            |  5 +++++
 kernel/events/uprobes.c            |  9 +++++++++
 kernel/trace/bpf_trace.c           | 10 +++++++++-
 6 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 2a9b0bc083a3..1e6ac4785a53 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -152,6 +152,12 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 		return regs->sp < ret->stack;
 }
 
+bool arch_uprobe_regs_writable(int off, int size)
+{
+	/* From x0 to x30, sp, pc. */
+	return off + size <= offsetof(struct pt_regs, pstate);
+}
+
 unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 				  struct pt_regs *regs)
diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index eb177d0ce8ab..dbb153463197 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -126,6 +126,12 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 		return regs->sp < ret->stack;
 }
 
+bool arch_uprobe_regs_writable(int off, int size)
+{
+	/* epc, from ra to t6. */
+	return off + size <= offsetof(struct pt_regs, status);
+}
+
 unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 				  struct pt_regs *regs)
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0f60c0d076b6..fc07bcd0f462 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1888,6 +1888,21 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 		return regs->sp <= ret->stack;
 }
 
+bool arch_uprobe_regs_writable(int off, int size)
+{
+	int end = off + size;
+
+	/* The 32-bit pt_regs has segments in front of orig_ax. */
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return false;
+	/* From r15 to di. Not orig_ax, cs, flags, ss. */
+	if (end <= offsetof(struct pt_regs, orig_ax))
+		return true;
+	if (off >= offsetof(struct pt_regs, ip) && end <= offsetofend(struct pt_regs, ip))
+		return true;
+	return off >= offsetof(struct pt_regs, sp) && end <= offsetofend(struct pt_regs, sp);
+}
+
 /*
  * Heuristic-based check if uprobe is installed at the function entry.
  *
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index d34dbc0fbbfe..43b250bff162 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -239,6 +239,7 @@ extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
 extern unsigned long arch_uprobe_get_xol_area(void);
+extern bool arch_uprobe_regs_writable(int off, int size);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
@@ -300,5 +301,9 @@ static inline void uprobe_copy_process(struct task_struct *t, u64 flags)
 static inline void uprobe_clear_state(struct mm_struct *mm)
 {
 }
+static inline bool arch_uprobe_regs_writable(int off, int size)
+{
+	return false;
+}
 #endif /* !CONFIG_UPROBES */
 #endif	/* _LINUX_UPROBES_H */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf444762a27..c47b1ee266d5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2703,6 +2703,15 @@ void __weak arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vadd
 {
 }
 
+/*
+ * Can a bpf prog write these bytes of pt_regs? An arch opts in and lists the
+ * registers that ptrace can set to any value.
+ */
+bool __weak arch_uprobe_regs_writable(int off, int size)
+{
+	return false;
+}
+
 /*
  * Run handler and ask thread to singlestep.
  * Ensure all non-fatal signals cannot interrupt thread while it singlesteps.
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2aec56d7f3d3..636c9849e07f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1397,8 +1397,16 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
 	if (off + size > sizeof(struct pt_regs))
 		return false;
 
-	if (type == BPF_WRITE)
+	if (type == BPF_WRITE) {
+		/*
+		 * pt_regs also holds what the kernel restores on the way to
+		 * user space: cs and flags on x86, pstate on arm64, status on
+		 * riscv. A prog can write the registers of the task only.
+		 */
+		if (!arch_uprobe_regs_writable(off, size))
+			return false;
 		prog->aux->kprobe_write_ctx = true;
+	}
 
 	return true;
 }
-- 
2.43.0

