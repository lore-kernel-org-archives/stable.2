Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312545;
	b=bUMzosB5IJ5fRvduxsJjuGfEciEUGeUj6UtP/I5qFBhfzkorMjBAk6yYCkJsoT2G4shX
	 0jd1twxrPiZqZjVdDVtoJKYBqQdRabVTzjC5vWJ45G9iTjhRXna5NXwDt1YO6fPOdFtKN
	 lGgbqU265PrXFfwl2pSBdYRjfJ6au+5+uCYr1kwNLiNWK8HuJHsufxt3KcuX9togtO8Lt
	 zUxfFhrRGBgNj2Lc69ZP00Ri7OP8IMRYZMwQp+22LFEpaPwOiGqp9qyyyjhF7f/ojgA7W
	 j9athNqT+GD0H2sNEL6lfPGjtR7TmSVKU19MmPrlPbSZo5o4sxnfLIuopPp7j7eyhog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312545;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2OSwwjOsbXNGLAOeLlKTFzsBfpIImPAcFGGNM31yAKM=;
	b=zqNVMDs1PtOxckbfYAHnM+auAKe9RHODERsMbMNSt2jkx6BoJaix/Zx7nkR8S1+iAdmo
	 X2KLr+ioR8dLBbPC55qBYkarEOeMtx+R+9UKWfAPh/bRrjLL49T2GE4Q7ll0SSH44brF1
	 J0bOFTMJpPVC8Iiybsvc119N7RWGbjwAtvb7GsW4Zjm8lKpK0Iz2t1cpI8fm7anwUD6/q
	 VujzyO7SwDjap1yh28FbW3fgn3S1mC5Pxx+uNsSKV0HOdrS9vBjMo7u9MIPyIL2kbvhvI
	 4NDMZCMpH1pFPtnMPX0lXwEUUxSfdwSR19kvJ3krne9HWBZP4E+wvB2XMNT8y9IEouw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUpx2oLy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1CE606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUpx2oLy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A401F00906;
	Tue, 10 Nov 2026 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312545;
	bh=2OSwwjOsbXNGLAOeLlKTFzsBfpIImPAcFGGNM31yAKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WUpx2oLySZLk+B7KPBJWtAiDOpj12/hLeSzhTSnA5zj/z3EbORszmrJ/3RPcqcOLF
	 Njo7OjZ4uYbzNz0Qgdf3gcHkME+m1oWPIga8jBbIjnvODCbmEf4gxqHfmyiHlXlDDF
	 JYzdqsUc8b2S1WeYGKkbYMijvZePhspBUkSLyUsNUqxROimV0nJOBD0FyagxgUYheu
	 nE18TUnF2IbYEvtEdnbjxMkMhaBS9/wW/mkRKJ92KYoXXqIcV5ynZZluRUw/tLS2so
	 ehmT3WIyHpvnfjNd67J3b68tnL2rS8Fd6kzWvOlvo+snzu6cvu5d48mjuIPjEnaM5e
	 zec/ipb9m1z+g==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id B4647198003A;
	Tue, 10 Nov 2026 07:09:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 07:09:03 -0500
X-ME-Sender: <xms:XgnzaqjVfAk7lpPlOuOvYmPS7mKEyu157IbnJlVm_9CCsa2LzqHeEw>
    <xme:XgnzaiCpKjz3m4kLgOEbSyN00NJTqtI8tfaw9LE7tscxbvN8zQBwBaICr5y4MinKn
    qUe_a07Exg-pMxim-ZyobNZdXHUPiCW60-twK9-f7JS-xEtBBGHXaic>
X-ME-Received: <xmr:XgnzanHQhgkQJr_HrzX-B5PlkLTKNXy0NJ6hdUzN15nnW4Oo5teezblPl48>
X-ME-Proxy-Cause: dmFkZTGBHyJLLKJKFF1yqV9yoM2aBlEIjb51YAwUUNwmA+6zS/+FQ51cysO4Ho3Uyd0AL9
    fbqWgmpo2xceUTkmijFv71rEOAcuon2h04LHiVCGs0x4fQ2jLxKMcIwfiW2TASq/K0jCf5
    i8+LGS5Yiy1Y97xb0ys9jmR5GGI7twgQmuX2wL5w6ALl0h/S3DYuf7/BXo7xfMo2Le/y8q
    yir31cLtlZad6SP1iqY+3Vwpxt2Kmzt27xY3i7EUdMDvoi2MEeeHV9Hb87v4BB2S3ODvNW
    ViB5LVGlnJU1FxqQhUfWgQdxj+fb8r0avbWXCwkcgpjf/LH8LVP89X8uyV/IXyOrULfCRb
    r8gnBJSKmDPwlJ/5wfwpAJAD2BZ78565iRoxXIgai9XETkZW/xqHakHobMsq/I2yxb2Q25
    yq122Bw0VGIlZXrqxqA0aJOpl8O1ntkiQktR7u6orRNF71H3Id8mO/M08IXWnXvwh60RB3
    dF6GsPMUaH1gUDa2TS39ivG0NDCwso+dNie3KD3ANnReUVpbuZMzzmQzfdusH7OjwomG6q
    wzitbCykJW/IIr/CloO9XRaE+KlFL3kRPtJWhUMEo9NZ8ETSGsKeVYMnlsfjo+d7iiZ8vl
    v/YwHt5ijW1I1hvIUmjlr7lB1O4JCurtuVkW26GIwUxMNnpiGWP/5QSTxUOQ
X-ME-Proxy: <xmx:XgnzaiJU-CxQP7AAzsNLxcpXe1S--1wGHBoriHg8yKpJM7LY82MfGQ>
    <xmx:XgnzajmU6_mPce50Q0Zt_kXEUq0NTV0EtEKLlHq8CDSF-9-fUj07ng>
    <xmx:XgnzaiSgm3F8g0rb5Kd0gRPsU34gEjhG4xRM6c3SRtvY9Ewr2YPD_Q>
    <xmx:XgnzatKaPpJhdzsgu8KMCFYxOvt_mDnTbBWIWIo5txkv-q0Y2lGvbw>
    <xmx:XgnzagB-hXSktSRjpNSRCwQdDqeUqf24TXdU_HSfX3m1_9Hab6-WKF5f>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 07:09:01 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 6.1.y 2/2] arm64: sdei: Preserve the interrupted context's exception registers
Date: Tue, 10 Nov 2026 12:08:39 +0000
Message-ID: <20261110120845.373988-6-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109201958-failed-6.1-58c1eb84e977@kernel.org>
References: <20261109201958-failed-6.1-58c1eb84e977@kernel.org>
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
index 833ad10421c2..cc35632f9a4b 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -855,7 +855,7 @@ asmlinkage void noinstr handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
-	unsigned long vbar;
+	unsigned long elr, spsr, esr, far, vbar;
 	unsigned long ret;
 
 	/*
@@ -880,6 +880,17 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
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
@@ -899,6 +910,14 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
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
index 544c3078f0a6..3a74e64e4694 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -203,6 +203,33 @@ unsigned long sdei_arch_get_entry_point(int conduit)
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
@@ -219,6 +246,7 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 	int i, err = 0;
 	int clobbered_registers = 4;
 	u64 elr = read_sysreg(elr_el1);
+	u64 nested_elr, nested_esr, nested_far;
 	u32 kernel_mode = read_sysreg(CurrentEL) | 1;	/* +SPSel */
 
 	if (arm64_kernel_unmapped_at_el0())
@@ -231,18 +259,27 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
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

