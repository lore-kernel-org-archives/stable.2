Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312534;
	b=qSHpaFAIJJoZ/hbK9aoPBqQ0CEHGU0hNaCnQjKjyxjdP6z3sQeIeboc2xt6cx4EUigJ3
	 iEo/+gvyVGaKDWkO2ED0txkANB89z4uR6k04PG0zgGPqXypR+wfggi+c5UZHKsTKwnrBh
	 FTwIenYXoXTmOhVpGCFuzrO+cGaG/1T/lu74pEYFebr1UI7SsN0Zv/uCXDA+B0DZybfjU
	 Y8pzFsgLBvzx4nMttI+3oRdCHQwW5zwkC2tgAclVADfDbwqeA6UF8DhaGe9KnyCSgoepK
	 6Wl2Roqe29uKrDT4C5TDchdM83s82DgyLyBXvoXCU227rIWQkc9WFMZHFbY+PR3c+dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312534;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8tppfz7M11Sk4R7lZwGvtK9dfxQCPyqvPDCMQp7NPSM=;
	b=pQD/wq0w7gBSJQ6+oVaa5OznIeMKox2IvTKKUY8yWCbrm1B7d0k+OmulEJLcOVN7YMF+
	 KKZzmf3cZM3q8mujpFoo006/+4Q3BpxN+QBtr8IzagxKrizoLpwtp8vToDxcdBs3imKnK
	 7peJz48RbpJXG5rQt3CJu3Wl9thv1hmGWBjvI1qm7yI0Y1RQL+SZNUPbAQjCGsDvaZjsu
	 tm69+WDHHkV2oBHQBE1jFnHKkSdO0wQ239MNlh/UOYlnWYA/TJiFe9SHw/s8n2xY4LibV
	 x509MmqWjsLOvsZNrO0gOgzntdD/cFZSGy4PkajC0s5HGgsP4N4hVwSzMRYi+71fTNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXCJdjgf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C560A260C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXCJdjgf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049221F008A2;
	Tue, 10 Nov 2026 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312533;
	bh=8tppfz7M11Sk4R7lZwGvtK9dfxQCPyqvPDCMQp7NPSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WXCJdjgfjVGSEPYjrrQzneT8ynOHcmoPLwjk3X99ykr4pHWS7y7uQhEQz55kvXzOo
	 k2ftlpFgnpMPa5fWmXY3cEozUyhAbrqrQAnvHO+ebTvKgA97ZE0u7fNTfZJeDv5E4t
	 PjzJLOdb6xWjhve9P03u4PHlDiTVHxpxWebsnQg8xlntG/S3hRNRlPi8kcVZ0Vi1Hn
	 gMoN2mYHWILX7XM/yBnFx6lmK97xG8yHLO9L/+zXSdkeWFWCtW9KC7Q3S1YF6so/ui
	 p0ETBDr/989L/oj/qF26C9bCJAMNaKNfbA15qx5N50B2RjCV7lUji8Goc8alONbvHQ
	 O6ErVTveR5oAQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 4B145198003A;
	Tue, 10 Nov 2026 07:08:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Nov 2026 07:08:51 -0500
X-ME-Sender: <xms:UgnzauSVqOVWEO1asITYOhtTnNyBQu-mmlcuuVhVGyuCBN15IJHpFg>
    <xme:Ugnzaqxq0YgOeb__6RtKooaMWq5YWMKLNlpXp7g7IGVMzZX7hfR_xGWXYBdJ6NPTw
    ycjwbwtu0zydfh3jUwe7dhaEdIokTD2wJfgbAy3Y6uCC45A3mhh8eoI>
X-ME-Received: <xmr:Ugnzag0Be1OWGAeawc5-bXTtbectI7g9iYqeO4DCyqRoYw3_oVARWIwWvFk>
X-ME-Proxy-Cause: dmFkZTFW0BiM+2iQGSCiw8NWFu7EDBbogT/NSgL/82/lZd7c8drkacWsS90ovnyCwq+zZ4
    nI59zLGsmfrOeYYf9Iy6pecD4JFktkYUAAJdCG1cL2bJzdfBvcsy/kIUuUgA63YzV2g6QD
    E6Wj/y63V5nQZY512BXMM6S/SRnWVEeQl35Ujy6UL7OkQJLb0RcxZQCN8l0Msjz28mJla6
    xYEHwg8P/AAbgpEuIYXoAX3CHAa+5299lWa/geKJU6aSspLAIa7da9+0StmGpfnFrL+W0h
    2cMuYM5cXG+m+hzOrmi03WFCS2ACVbw7Gn6YMbcKrVsbOtnhQN1tO79kQcWSTNqTMv8NME
    A75JQ41mgkKVeI5JSZjdIzdcYkgV1/Y65fauUkDUr098R9Phvttowch5D2Yf+Bt//Gkav4
    /F9rga/Ur+lUlaKnSiwMlVdGg1tSO7hCuxrD1i7CFr5xroN1JTjCVC92SlC0yf6BeEqHQE
    CbDL/KxaCwnB3/vPLkMSSiLRDQ99I3ChSlfeRxN318zCJy/q3Sttj7kC7hhRqA4FyrzEYC
    Iq6QG4gAoKGHLslaggAxdYW9S+Eoxb7LfwROIFkszy/jYTwGX7SQXQ/8pYqlZb2Scjzsjq
    we+dj36mkUG4jnOoiWmriD7qiNJG84fY81mNqjpA6E/WaKZKssOENjk7i6Zw
X-ME-Proxy: <xmx:Ugnzao4ubSWHPWLJizWCVafv-J4rA6JBhFRUEnk3l89rKNZX3CCG0w>
    <xmx:UgnzajWcecOIibJShROd2yMnLnNgZ-48svMObLTn5020ofWkL5bKZQ>
    <xmx:UgnzanBukcJgUjKpqc-NEYgh6rf4wNpd9Dufjm6VLDO7ycSvVZB_yA>
    <xmx:Ugnzai65T_iTFB8mIa8Ml3zyNPOMpqL0fBecN7MV-ONA5E2pSGos9Q>
    <xmx:UgnzaiwT5g_06BZ6KsHZlSy--llUGeIzXP03JM7QTYYiw0NfNBn8BZ57>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 07:08:50 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 5.10.y 2/2] arm64: sdei: Preserve the interrupted context's exception registers
Date: Tue, 10 Nov 2026 12:08:35 +0000
Message-ID: <20261110120845.373988-2-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109202926-failed-5.10-58c1eb84e977@kernel.org>
References: <20261109202926-failed-5.10-58c1eb84e977@kernel.org>
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
(cherry picked from commit 58c1eb84e97701c583605ba2fd553b69afba2245)
[ kas: 5.10 has __sdei_handler() in sdei.c around a static
  _sdei_handler(); open-code the fault type check ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/kernel/sdei.c | 76 ++++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 36e4a95ae980..118dbb7e85e8 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -158,6 +158,33 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 
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
+	unsigned long fsc_type = esr & ESR_ELx_FSC_TYPE;
+
+	switch (ESR_ELx_EC(esr)) {
+	case ESR_ELx_EC_DABT_CUR:
+		return fsc_type == ESR_ELx_FSC_FAULT ||
+		       fsc_type == ESR_ELx_FSC_PERM ||
+		       fsc_type == ESR_ELx_FSC_ACCESS;
+	case ESR_ELx_EC_BRK64:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * __sdei_handler() returns one of:
  *  SDEI_EV_HANDLED -  success, return to the interrupted context.
@@ -174,6 +201,7 @@ static __kprobes unsigned long _sdei_handler(struct pt_regs *regs,
 	int i, err = 0;
 	int clobbered_registers = 4;
 	u64 elr = read_sysreg(elr_el1);
+	u64 nested_elr, nested_esr, nested_far;
 	u32 kernel_mode = read_sysreg(CurrentEL) | 1;	/* +SPSel */
 
 	if (arm64_kernel_unmapped_at_el0())
@@ -192,18 +220,27 @@ static __kprobes unsigned long _sdei_handler(struct pt_regs *regs,
 	__uaccess_enable_hw_pan();
 
 	err = sdei_event_handler(regs, arg);
+
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
+	}
+
 	if (err)
 		return SDEI_EV_FAILED;
 
-	if (elr != read_sysreg(elr_el1)) {
-		/*
-		 * We took a synchronous exception from the SDEI handler.
-		 * This could deadlock, and if you interrupt KVM it will
-		 * hyp-panic instead.
-		 */
-		pr_warn("unsafe: exception during handler\n");
-	}
-
 	mode = regs->pstate & (PSR_MODE32_BIT | PSR_MODE_MASK);
 
 	/*
@@ -233,9 +270,20 @@ static __kprobes unsigned long _sdei_handler(struct pt_regs *regs,
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
-	unsigned long vbar;
+	unsigned long elr, spsr, esr, far, vbar;
 	unsigned long ret;
 
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
@@ -257,6 +305,14 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 
 	arm64_exit_nmi(regs);
 
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
-- 
2.54.0

