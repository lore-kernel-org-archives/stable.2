Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273598;
	b=qPlzIPzTK3sxfqZwVjJC1V5n3E2LH4b0ZigHj0R1Ij5+wGibdL+j5sipYQT6vvScbL9R
	 0z98cO7ppYf/bST2SV0hN+8UkdryUnucmU065MPk14rTE9yWNZisVuyp52xIYL/Fb1Xl2
	 G3dl7J5oFupC3sydHRJMwbkuN7rYEhO1NbZKJ04Y16q0vZrJFtJm4yKcik6Fyd1Vi3kpm
	 ccmqrvqUT9Nu5LqebeplQWV4VPMzt/DiEAMqleQJCBjTKhVcAriehX+ZSw2ZcbNEkSOfr
	 w3TpTYkoPCnxXVPln4jc5hWef7nPdXk/YR42br2RpwOqSBbO9UCplwDDkrMvE/VUzrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273598;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LkdTKX8rhmG8OvZN6CjJWuShGG/jKj1yNlHgrWmyCbM=;
	b=J/XuSoc6HKyFu9F2SfZ/Ok9bvue9v+ZV1oTQlbglzIz66lnolx3yzvm6W3lEyNHMbOtu
	 q/Z7FhicgjmRsmCOl72KagepsrmALm6siHXv+RjJ5ylfbWpdEib6b7aDiDt26+0VHuwoM
	 OdFdoq8UfNHzSW9cSQVlxt6BbZyqTPwmNeYT4BUdgQosLEziuLY4UdFwpBfAKDMJmEQfA
	 yb5P5EAktDAiVAflQSFCL/rMqzLMsYtqKp7WioApX2R1FQOt3libeMztU2lPBjGSV89K+
	 J2GcURYkJhOA1e7432r/vsXE7NgNaBWKmhlAC7AS6uMHg2eG2HNZc1yI6QUPp/WLEKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeYV+3EF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8D606A33C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeYV+3EF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690411F0089F;
	Tue, 10 Nov 2026 01:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273598;
	bh=LkdTKX8rhmG8OvZN6CjJWuShGG/jKj1yNlHgrWmyCbM=;
	h=From:To:Cc:Subject:Date;
	b=aeYV+3EFEOsxNLKO+CewJCcEQ/Zitf7OaRlEuHBJI2V0JhNFxCvsCnofhxU6eSffm
	 RSGEqoJYtO8HNWMp9bsAjxj2lePhYNU5g2CIlH69+XhfsOgmFF+BgrPwIIT9+6H+c6
	 OpQJvAKKKF0Y10RgRNHNEypME0LthbBuUzkyxdhe+k7IlAEHl9qtnEl+/DTxiwCOkk
	 qP0FV+uFZg8zhjjVG+lc9CDS2cFrHoUBtQFD7u8dbrv0YpIZ+PxcB1cES82myAomle
	 MJNQY5HU1S1e/y+X+mFSyKN8bP0cLpnJ4ijxjF7OywuMGlSfVWtg2jc+kkP7Q4F05l
	 rlQnKtCnUtXyw==
From: Sasha Levin <sashal@kernel.org>
To: kas@kernel.org,
	catalin.marinas@arm.com,
	leitao@debian.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: sdei: Run the event handler on the kernel vectors" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:19:56 -0500
Message-ID: <20261109201956-failed-6.1-9bf6ee7952c7@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9bf6ee7952c7ee151c30e0fffcfc61b58127c899
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201956-failed-6.1-9bf6ee7952c7@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




