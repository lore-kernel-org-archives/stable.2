Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274166;
	b=xJ7Bj+Zb6b6mo497tuCIt7dh4a4mPxkrgjrG0Zqh2/3gFOeAg7WNSKTVBRr1rb8AlPKE
	 qKDmxK9TpswR05z87QEAREmStPLEz2v7MOx9q4eIWpY0X9t0gnzMa53+1aaH1DGl+gDkk
	 grgEEmeUTvCjX7MeI5vS+t3J5oHOHc/rvMRszn8SmNKsI0m9l+zP0465tGBSArUb/jF3j
	 0b5iEdX5NrGOrA+vDQbVWEWR2BfGVKi6qhhlXXCUc2yYdNdcviCXpTUGCiq29YPZNacBr
	 p3lSrhLkTCeeQ8rje2SG5+vWZ9EgcXc/fPVyUvlwlfBL64HUjuGwbzm63uSOOgYnzSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274166;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=15r+LU01z+GGdLai334XdC+71jbYunXf3zFwEFiRd3k=;
	b=bugcEjJdlGECzrckIols6mcP0p/KNi6DDK4Al+3HA1asB2gRkHxYw0nBnq/NUiyELh0v
	 To3M814JOimhQh4M3s/nF6UimPbf2P9/uiQOFeYHmYJFt941Mk04v6PHgutNK/lylZ5MI
	 H8ZHpYiVCMkPS6z88Gc0wmS6hA93Wfis81ON1yCad/5y8SHeNRq9AUanUubz9Ev8I5W5b
	 868I3xfbA/xTfIl4kZnV46PC/vI9efGLWlrKwTQSOy3GI7rpyaVOUMTYEnMgYHNnn7e3f
	 diCM+j0MxVYLrcB2rZRDMhauP+8DubNtni0q9VWUJoqvnVgiyjwC4M2tTeYFNOmwRFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5N5fYLa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E38606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5N5fYLa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0E81F0089F;
	Tue, 10 Nov 2026 01:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274166;
	bh=15r+LU01z+GGdLai334XdC+71jbYunXf3zFwEFiRd3k=;
	h=From:To:Cc:Subject:Date;
	b=i5N5fYLaJihgGvIbiiCJa2ZV/KumO+vPVkhsCBsjvlD6Kk8C531aCqbhrpjB4hT3d
	 GrhpuOeOBBn9akfO2AEdzZQH73IfjbJQzDTJ595PXUL1FMBl3F/mh12t79Tfth7hhX
	 4/GU06tkdVChShl21KqctE+R02v9Yw+TZWOFBUOKzB2MA1BzjBiFmv084FOPtDkiUt
	 6YXIbDVY9oBJMPLPAjGUeCPAdieZTy7q08jdZuWfGAaSPtf0IBolCNCS022aFcr59U
	 eTpdv4TbOpskI2jz+txAhmUYGrFwN0hVsrMH+kiHgx5E3AkLiZOe1IG5FqtwbxdOZ9
	 jUGKbUCPtHMmw==
From: Sasha Levin <sashal@kernel.org>
To: kas@kernel.org,
	catalin.marinas@arm.com,
	leitao@debian.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: sdei: Run the event handler on the kernel vectors" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:29:24 -0500
Message-ID: <20261109202924-failed-5.10-9bf6ee7952c7@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9bf6ee7952c7ee151c30e0fffcfc61b58127c899
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202924-failed-5.10-9bf6ee7952c7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9bf6ee7952c7ee151c30e0fffcfc61b58127c899 Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Thu, 5 Nov 2026 12:08:33 +0000
Subject: [PATCH] arm64: sdei: Run the event handler on the kernel vectors

With KPTI, VBAR_EL1 holds the trampoline vectors from the return to EL0
until the next exception from EL0 maps the kernel and installs the
kernel vectors. The trampoline vectors only handle exceptions from EL0;
their current-EL half is zero-filled.

An SDEI event is dispatched regardless of PSTATE.DAIF, so it lands there
whenever the CPU is in user space. The SDEI entry trampoline maps the
kernel but leaves VBAR_EL1 alone. An exception taken by the handler then
executes the zeros, takes an undefined instruction exception to the same
vector, and loops there forever. The event never completes and the CPU
is lost; RCU stall reports are the first sign of it.

RAS notifications land in user space whenever a task consumes the
error, and NMI backtraces land wherever the CPU happens to be. The GHES
handler takes no exception on its own, but any exception in the handler
path does it: a WARN, a kprobe hit, or a fault fixed up by a _nofault()
accessor.

Install the kernel vectors in __sdei_handler() when VBAR_EL1 holds the
trampoline vectors, and restore it before returning to firmware. The
switch covers irqentry_nmi_enter() and irqentry_nmi_exit() too, as Usama
Arif pointed out: their tracepoints and context tracking WARNs can take
an exception as well.

The IRQ-like resume into user space must still go through the
trampoline to map the kernel. do_sdei_event() takes the interrupted
VBAR_EL1 and keeps basing the resume address on it.

Fixes: 79e9aa59dc29 ("arm64: sdei: Add trampoline code for remapping the kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Breno Leitao <leitao@debian.org>
[catalin.marinas@arm.com: use raw_cpu_read() for this_cpu_vector]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/sdei.h    |  3 ++-
 arch/arm64/kernel/entry-common.c | 21 ++++++++++++++++++++-
 arch/arm64/kernel/sdei.c         |  6 ++++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index b2248bd3cb58f..a78a5337ff854 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -44,7 +44,8 @@ asmlinkage unsigned long __sdei_handler(struct pt_regs *regs,
 					struct sdei_registered_event *arg);
 
 unsigned long do_sdei_event(struct pt_regs *regs,
-			    struct sdei_registered_event *arg);
+			    struct sdei_registered_event *arg,
+			    unsigned long vbar);
 
 unsigned long sdei_arch_get_entry_point(int conduit);
 #define sdei_arch_get_entry_point(x)	sdei_arch_get_entry_point(x)
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 11d3f888fcd87..36b85b9e1575d 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -31,6 +31,7 @@
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
+#include <asm/vectors.h>
 
 /*
  * Where the context being returned to had an active percpu GPR critical
@@ -1040,6 +1041,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
+	unsigned long vbar;
 	irqentry_state_t state;
 	unsigned long ret;
 
@@ -1065,10 +1067,27 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 	else if (cpu_has_pan())
 		set_pstate_pan(0);
 
+	/*
+	 * With KPTI, VBAR_EL1 holds the trampoline vectors from the return to
+	 * EL0 until the next exception from EL0 maps the kernel. They only
+	 * handle exceptions from EL0: an exception taken here would run their
+	 * empty current-EL half and never come back. Switch to the kernel
+	 * vectors. The IRQ-like resume keeps using the interrupted VBAR, so it
+	 * still goes through the trampoline.
+	 */
+	vbar = read_sysreg(vbar_el1);
+	if (arm64_kernel_unmapped_at_el0() &&
+	    vbar == (unsigned long)raw_cpu_read(this_cpu_vector)) {
+		write_sysreg((unsigned long)vectors, vbar_el1);
+		isb();
+	}
+
 	state = irqentry_nmi_enter(regs);
-	ret = do_sdei_event(regs, arg);
+	ret = do_sdei_event(regs, arg, vbar);
 	irqentry_nmi_exit(regs, state);
 
+	write_sysreg(vbar, vbar_el1);
+
 	return ret;
 }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 778f2a1faac86..260c13106009c 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -200,16 +200,18 @@ unsigned long sdei_arch_get_entry_point(int conduit)
  *  SDEI_EV_HANDLED -  success, return to the interrupted context.
  *  SDEI_EV_FAILED  -  failure, return this error code to firmware.
  *  virtual-address -  success, return to this address.
+ *
+ * vbar is the interrupted context's VBAR_EL1, for the IRQ-like resume.
  */
 unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
-				      struct sdei_registered_event *arg)
+				      struct sdei_registered_event *arg,
+				      unsigned long vbar)
 {
 	u32 mode;
 	int i, err = 0;
 	int clobbered_registers = 4;
 	u64 elr = read_sysreg(elr_el1);
 	u32 kernel_mode = read_sysreg(CurrentEL) | 1;	/* +SPSel */
-	unsigned long vbar = read_sysreg(vbar_el1);
 
 	if (arm64_kernel_unmapped_at_el0())
 		clobbered_registers++;
-- 
2.53.0




