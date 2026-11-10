Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273295;
	b=qahkwR6+Sdrr4hOUTsMAEw4hWIj1DdkyY3hEf/YOy4RJcscBvkOhCcrel2tCmXsWLk2h
	 qddFC2tgKJIyn6/ZxXxqBt9Ptk9f+h2ksJ29DzyyaSq/zziSWKqT7oTfqYGYa2xd17hSC
	 9Y4htRGJ7h8+iZT+LFh5CDQRQZq5rQhdvMtZuTqnXjm/de8YB2pR3nGUXGSWXwtBcSUe2
	 Q/PwznX8iE0CRiN43BGTOQaSN56odXw8uolZPpynngBJf02YihOzAc6YeMUos6pHAK+FZ
	 YfurmlCClc1VSxCHoUdS2iHnqv+xpdIy54FFywgiQkiQK1T3+cQukJ1/6sxMpZWMwLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273295;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oyeC5+lsaitpMZBGkXhqKhixvm//0fJrJvMiOtz5plA=;
	b=sQW0W+MjrK06V2K6PoFLSFuA89KswPwekSjSDwkqn9vS1ckRsLbDcA5edJEH1GiH4QYx
	 fR1mXhdn+EkNuAl3hk92Sh/Z9km03Zw5RHWek5knu2bHyII3lUr9iQmH8GL4CS8l4o8eM
	 1Hbc1GuoHqlsB4nl2fgzHsRLQZ9fK9hFTdpb28qX9RPHBu1D4K7oWlFLfPCmVTt2sgSlq
	 4TymP9TYAHRbbuX/jYy2glHb+FGe+CburF288roBHkWtTl1VJHI+1+q+W9w/RQEYgv4xb
	 ycGazZp9JMG93guqaKKDo58YtgRMTc0HQu3ubZrPzjyehTC9jwZ11Ullt8aOH/6rK/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfNWnChI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160DE606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfNWnChI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6453D1F0089F;
	Tue, 10 Nov 2026 01:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273294;
	bh=oyeC5+lsaitpMZBGkXhqKhixvm//0fJrJvMiOtz5plA=;
	h=From:To:Cc:Subject:Date;
	b=PfNWnChI1TKz18xY2+sCRCbDm7L/1ej/ZEHxMMPN1fX1sSEtVTZjqTaOdcNd5ExWi
	 9eI2mlZJINfog68O+ah2uCSA6d+XPIZ28zq3XRwkK0QOs6x9RAowoZIYcctmQe7ORi
	 MJRzsJ0aMSkaEeGjhMufcHg8W5img/Ii3HLyrBm5pQenzC2y3ZHYYQt0O2WUolSNP5
	 ma9GEaStJacePcx0ZaRNdhCOgfOYig9fwWo23s3FHDBCTPYiYMC0Agz4D99zh7rNcy
	 6cX4cUY29bHDCGwqQ5IlQN2yQ1UVy/rWQicOqv1NwAx9MQ2Lof8L3Off92F/xbQ230
	 eMeVuFKI3J5ww==
From: Sasha Levin <sashal@kernel.org>
To: kas@kernel.org,
	leitao@debian.org,
	catalin.marinas@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: sdei: Preserve the interrupted context's exception registers" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:14:53 -0500
Message-ID: <20261109201453-failed-6.6-58c1eb84e977@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 58c1eb84e97701c583605ba2fd553b69afba2245
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201453-failed-6.6-58c1eb84e977@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 58c1eb84e97701c583605ba2fd553b69afba2245 Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Thu, 5 Nov 2026 12:08:34 +0000
Subject: [PATCH] arm64: sdei: Preserve the interrupted context's exception
 registers

An SDEI event is dispatched by firmware regardless of PSTATE.DAIF, so it
can interrupt the kernel where the exception registers are live:

 - exception entry, before kernel_entry has saved ELR_EL1/SPSR_EL1 and
   before the C handler has read ESR_EL1/FAR_EL1;
 - exception return, after kernel_exit has loaded ELR_EL1/SPSR_EL1 and
   before the ERET.

An IRQ or pseudo-NMI cannot arrive there with PSTATE.I set. Firmware
saves only x0-x17, PC and PSTATE around an SDEI event, so a synchronous
exception taken by the handler overwrites the interrupted context's
ELR, SPSR, ESR and FAR. do_sdei_event() only notices that ELR changed,
and warns.

The interrupted context then carries on with the handler's state. A
task interrupted on its way into the kernel can be sent SIGILL for the
handler's kernel data abort. A task interrupted on its way back to user
space ERETs to EL1, at the handler's fixup address, with user registers
loaded.

With SDEI delivering NMI backtraces, this happens in normal operation.
The handler runs show_regs(), which reads through possibly-NULL pointers
with the _nofault() accessors. print_worker_info() faults this way for a
kworker that is not running a work item, and a single sysrq-l warned
once per such kworker.

Save ELR, SPSR, ESR and FAR in __sdei_handler() before
irqentry_nmi_enter(), which can take an exception too, and restore them
after irqentry_nmi_exit().

Once they are restored, a nested exception is harmless if its handler is
safe in NMI context. That holds for EL1 data aborts on translation,
permission and access-flag faults, which never take the mmap lock in NMI
context, and for BRK. Warn once, with the syndrome, about any other
exception class.

Fixes: f5df26961853 ("arm64: kernel: Add arch-specific SDEI entry code and CPU masking")
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Tested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/entry-common.c | 21 ++++++++++++-
 arch/arm64/kernel/sdei.c         | 53 ++++++++++++++++++++++++++------
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 36b85b9e1575d..beb56891fc4fa 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -1041,7 +1041,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
-	unsigned long vbar;
+	unsigned long elr, spsr, esr, far, vbar;
 	irqentry_state_t state;
 	unsigned long ret;
 
@@ -1067,6 +1067,17 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 	else if (cpu_has_pan())
 		set_pstate_pan(0);
 
+	/*
+	 * Nothing saved the interrupted context's exception registers on the
+	 * way in, and it may be in the middle of exception entry or return
+	 * (SDEI ignores DAIF). Save them before anything can take an exception
+	 * and overwrite them.
+	 */
+	elr = read_sysreg(elr_el1);
+	spsr = read_sysreg(spsr_el1);
+	esr = read_sysreg(esr_el1);
+	far = read_sysreg(far_el1);
+
 	/*
 	 * With KPTI, VBAR_EL1 holds the trampoline vectors from the return to
 	 * EL0 until the next exception from EL0 maps the kernel. They only
@@ -1086,6 +1097,14 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 	ret = do_sdei_event(regs, arg, vbar);
 	irqentry_nmi_exit(regs, state);
 
+	/*
+	 * Put them back unconditionally. An unchanged ELR does not rule out a
+	 * nested exception: one may have returned to the same address.
+	 */
+	write_sysreg(elr, elr_el1);
+	write_sysreg(spsr, spsr_el1);
+	write_sysreg(esr, esr_el1);
+	write_sysreg(far, far_el1);
 	write_sysreg(vbar, vbar_el1);
 
 	return ret;
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 260c13106009c..1b902da8ba43c 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -195,6 +195,31 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 	return 0;
 }
 
+/*
+ * Exceptions an SDEI handler may take without harm once __sdei_handler() has
+ * restored the interrupted context's exception registers. Their handlers are
+ * safe in NMI context:
+ *  - EL1 data aborts on translation, permission and access-flag faults:
+ *    faulthandler_disabled() is true in NMI context, so do_page_fault() never
+ *    takes the mmap lock. This covers the _nofault() accessors used by the
+ *    generic dump_stack()/show_regs() code (e.g. print_worker_info()).
+ *  - BRK: kprobes, WARN/BUG, kCFI and UBSAN traps, all NMI-capable.
+ * Anything else taken at EL1 is fatal on its own, or unexpected here.
+ */
+static bool sdei_nested_exception_ok(unsigned long esr)
+{
+	switch (ESR_ELx_EC(esr)) {
+	case ESR_ELx_EC_DABT_CUR:
+		return esr_fsc_is_translation_fault(esr) ||
+		       esr_fsc_is_permission_fault(esr) ||
+		       esr_fsc_is_access_flag_fault(esr);
+	case ESR_ELx_EC_BRK64:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * do_sdei_event() returns one of:
  *  SDEI_EV_HANDLED -  success, return to the interrupted context.
@@ -211,6 +236,7 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 	int i, err = 0;
 	int clobbered_registers = 4;
 	u64 elr = read_sysreg(elr_el1);
+	u64 nested_elr, nested_esr, nested_far;
 	u32 kernel_mode = read_sysreg(CurrentEL) | 1;	/* +SPSel */
 
 	if (arm64_kernel_unmapped_at_el0())
@@ -223,18 +249,27 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 	}
 
 	err = sdei_event_handler(regs, arg);
-	if (err)
-		return SDEI_EV_FAILED;
 
-	if (elr != read_sysreg(elr_el1)) {
-		/*
-		 * We took a synchronous exception from the SDEI handler.
-		 * This could deadlock, and if you interrupt KVM it will
-		 * hyp-panic instead.
-		 */
-		pr_warn("unsafe: exception during handler\n");
+	/*
+	 * A synchronous exception taken by the handler has overwritten the
+	 * exception registers; __sdei_handler() puts them back. Only the last
+	 * one's syndrome survives; report it if it is not one known to be
+	 * harmless.
+	 *
+	 * If the event interrupted a KVM world switch, VBAR points at the KVM
+	 * hyp vectors and any such exception is a hyp panic instead.
+	 */
+	nested_elr = read_sysreg(elr_el1);
+	nested_esr = read_sysreg(esr_el1);
+	nested_far = read_sysreg(far_el1);
+	if (nested_elr != elr && !sdei_nested_exception_ok(nested_esr)) {
+		pr_warn_once("unexpected exception during handler: ESR %#llx FAR %#llx near %pS\n",
+			     nested_esr, nested_far, (void *)nested_elr);
 	}
 
+	if (err)
+		return SDEI_EV_FAILED;
+
 	mode = regs->pstate & (PSR_MODE32_BIT | PSR_MODE_MASK);
 
 	/*
-- 
2.53.0




