Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312539;
	b=sA+DSZcKUWmXBP3fpGVHjMWOLp2NyBR5+zZUzKxNd3pOzVNwFratMF2+v2pK8dvzGUQY
	 pLoWiE/wAvT1qPP7dt9fZ+YfwCOEX4Msm5jN5CEP24tsXSnzetQYaeQaaNxLaRKy+cKi+
	 aB69UpBPwMUW0oc6qoxk4AGrb+XdrvRD6uuvJuHXnCGzdUkue6IfEy10HZBcW4TExqrx6
	 rotDv9tbRG2txlQEvxPbs4481eV7xljjzIG034gKSdZpcBWquNCT0YTaIBkkJidJxqvQ3
	 crpmNykggqdCfdPb4a5Se2JgFWKx0PYRevTJlwPNJu/uMNBaS23/3kOwUUYBk29078w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312539;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SQYrFYsgSFZUcx1rBi76XbNQ8benC0lbhizVMJ9+leI=;
	b=0lQ64nr9OAr+IMuKT5NnJUicfPrMNZhD0P1r4LiOq7iUAHatOW5C96T31iuOAUdVDIPR
	 Lon7+zJHjt/6NbOgXpiDBP5O0kXaEBYIq1kqCSrQApNgnT1NYsBOz1Twaag91FbtEoRh0
	 rU5QWSs74Dgm4aTuDFjVTV0P5A+ayeqPPGwLJIL45YmvbFmnlwFTeAx+kD1VWYwreB76z
	 7VGSRhNqtAMEpGwy3LRquCz35SUM07YQS95Sj/0GqluursRnEmquDdeKBGGB5oCG3WH7h
	 EsUjt/wWFZ9+Dmye71opf1u6UhTZKgTeC+Z8VqbwBniPHKk9ie/OulXTR1yM4Pj/9SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWMKsUNf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9E60A2620
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWMKsUNf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FDA1F0089F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312538;
	bh=SQYrFYsgSFZUcx1rBi76XbNQ8benC0lbhizVMJ9+leI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NWMKsUNfcboayRdPlvHm/kdzMSecQ3DSiITfzk5KjWK04MIMlTYs7A+nKYDVFL1XO
	 lfhyfA3GOKURBkIrHty46D8pe8jtqP3E1kUx0UhG2jp9BvinKyIH4wYr9zJWwUu3o8
	 qDoTzt/BcfeTs6AsWTODm240gEXb5NslDju3wqfUfvtcKIQY8RcAAXuYcPlf4t5OqA
	 twjWgCDuyYaBYEN0Xyi7038Z4Y/7aOA7klCmfdiv+038ExbjaqY6XMh1bHGQGE+H2u
	 YRhR9A3nVH29hNVHIkZxEYuJbuuCqySG2FxIdmZB2iwiSwGEUg8cbkZZoSboQVcrEG
	 T3oTipnEpdTfw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 982671980047;
	Tue, 10 Nov 2026 07:08:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Nov 2026 07:08:56 -0500
X-ME-Sender: <xms:WAnzal0RfS8GQQ7mz7XKx96JfLi-uuynEfh3L1tTewpnoJiS_CnyfQ>
    <xme:WAnzajGzxKAwARL9zFKQtkKSrZFaBK5L2-H-vfTBXZThiAdSXXoj3O82U_iICVnM4
    3nRr1jwH1pxO9T8-YCHXzJ2bm4RLcx6NFwym0-1NNDlqyD3QCmpUrcC>
X-ME-Received: <xmr:WAnzaq5f1EnZQ5HhZZEkFmmehj7_xaFBhtbKcalpa4OOhElaM6WWuS1LDd0>
X-ME-Proxy-Cause: dmFkZTGBHyJLLKJKFF1yqV9yoM2aBlEIjb51YAwUUNwmA+6zS/+FQ51cysO4Ho3Uyd0AL9
    fbqWgmpo2xceUTkmijFv71rEOAcuon2h04LHiVCGs0x4fQ2jLxKMcIwfiW2TASq/K0jCf5
    i8+LGS5Yiy1Y97xb0ys9jmR5GGI7twgQmuX2wL5w6ALl0h/S3DYuf7/BXo7xfMo2Le/y8q
    yir31cLtlZad6SP1iqY+3Vwpxt2Kmzt27xY3i7EUdMDvoi2MEeeHV9Hb87v4BB2S3ODvNW
    ViB5LVGlnJU1FxqQhUfWgQdxj+fb8r0avbWXCwkcgpjf/LH8LVP89X8uyV/IXyOrULfCZ9
    J04vWFjLM8rRn6GoA/6DKOUfi4GPui6kftwZdmiOUBlVY3MpruIOoJXBpT7Yd8pduBGDw5
    Mhai/u/29QqJ4JNJD0MS/96QP8IH/BsKJnrqTK7jYSab/nqvyvSugbk8HkrEH0/UEn3sTy
    xm5OtzzD84S4Ia8KV4ZCfSFF+ifIKDyuMtUG/Zz6XADJEr+X1DOfYCiZcBmK9Na7M9m/zm
    GnbkOFREtYhwvmgjOIab1gm7hx9aUY+Fk1RXJFEE5cg6Q8ArtPplX8Gz8fKhkUPLl4woMg
    3/xxnN/5lwjwW9zTBgHm55Xwh04qbazU7MU4L8Zt06wrIXuB9F7SXK9FTiXg
X-ME-Proxy: <xmx:WAnzahsf6y4_o_jozKdldlGZXqkqpu4uuiGHmjwZPuOe8vLOyuv2YQ>
    <xmx:WAnzaj62M_zsD8POYsA_XoRFp6oIn6EazPl4d6giJqioTxQrLm-cZg>
    <xmx:WAnzakWafuuHkyyFrEYtc8lx29CXA5TL8L22Anilt1WBCMbD2HhMOw>
    <xmx:WAnzat_ACJnO51pnDoCSpCBURoi4UEXMZWkASR3QjXhQwfqaYUUNyg>
    <xmx:WAnzaolfw1DHDb55EtM1F_i-Rz3wj0dkMSyef0Gs-7FRlFeYiki0w50l>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 07:08:55 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 5.15.y 2/2] arm64: sdei: Preserve the interrupted context's exception registers
Date: Tue, 10 Nov 2026 12:08:37 +0000
Message-ID: <20261110120845.373988-4-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109202501-failed-5.15-58c1eb84e977@kernel.org>
References: <20261109202501-failed-5.15-58c1eb84e977@kernel.org>
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
[ kas: keep arm64_enter_nmi()/arm64_exit_nmi() in __sdei_handler();
  open-code the fault type check, no esr_fsc_is_*() helpers here ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/kernel/entry-common.c | 21 +++++++++++-
 arch/arm64/kernel/sdei.c         | 55 ++++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 0efe4ee319f4..0f52fbb5cfe6 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -821,7 +821,7 @@ asmlinkage void noinstr handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
-	unsigned long vbar;
+	unsigned long elr, spsr, esr, far, vbar;
 	unsigned long ret;
 
 	/*
@@ -846,6 +846,17 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
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
@@ -865,6 +876,14 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 	ret = do_sdei_event(regs, arg, vbar);
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
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index c95a71156e99..43bfe19e08a9 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -235,6 +235,33 @@ unsigned long sdei_arch_get_entry_point(int conduit)
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
  * do_sdei_event() returns one of:
  *  SDEI_EV_HANDLED -  success, return to the interrupted context.
@@ -251,6 +278,7 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 	int i, err = 0;
 	int clobbered_registers = 4;
 	u64 elr = read_sysreg(elr_el1);
+	u64 nested_elr, nested_esr, nested_far;
 	u32 kernel_mode = read_sysreg(CurrentEL) | 1;	/* +SPSel */
 
 	if (arm64_kernel_unmapped_at_el0())
@@ -263,18 +291,27 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 	}
 
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
-- 
2.54.0

