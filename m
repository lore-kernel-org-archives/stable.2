Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312556;
	b=wdhyfXtzAQvV2TNluaI6uzyD2v32e6xN6oYMCXI6dSq6QUOTbBe4+4LjI+sV9mVBIVfv
	 kUh53mkMuoOczc027gXLLO4fnnQkM4gtuOw+cQcQfOX9fh9iDP5fTiZ67yY8+3eleb9z0
	 mCkA4os271x9lIWa/J9tem/9lr1WuYCHLm0sub3Sbl282frLczUTL1u3PiJGtRDzT94yz
	 PzK4MtYlSRqI83hJV9UuJkg7plG0YXe2/I5pHAsxoDdCQOUe7YUSq4HmhVb7su+uyJwxK
	 DspuYqAMSm8f50HGbT0D2x+Xq55SRXEvwJ414EI/5IQOyi6LI1UwpChHXvpdsUX5r7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312556;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mZtU6UTR0lW8r0P99/OCZsSJ3g9rPl4eKGO9RFHwrbk=;
	b=ImJthu38271yDOcx51hp9oNEaNkDABqsUsYGIhsNV3GCeOP/6fUj1SVHTcTAqfHFLcBZ
	 uxWeMn28Gw1koeKx6hqmMx1l5lLY2UBN/nDxcv25RidTP5kuXsNau+DuiBvXGjnR6aOMV
	 Ly7fvA+MHldBo+ChatY9zSmGZo+kp/f6SZpjYcblZ2v4zYO+pKvEJCXk4WRYPKi7+9pBW
	 D31Cyo+UeenoTDpfYq6va5d0Ou3m6ma7bRVFxS5TfDPeNakhUiulsFdIfyG3mepqdyi4f
	 yfYP9yrbijo1L/N66kk88CrRQ9UFqhY4AMEil1ajPmJ6EDg2musvKvuZkHkYEiSRKnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1q4i+Bj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985160A3831
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1q4i+Bj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724B01F008A2;
	Tue, 10 Nov 2026 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312555;
	bh=mZtU6UTR0lW8r0P99/OCZsSJ3g9rPl4eKGO9RFHwrbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M1q4i+BjofudyIlFOd2gWk8Mh4YK5Cz4UjnZyhKkx30kVbAms3UakdXytU9xJB4Vk
	 ujCwOGBonQsl1G8ypdbUPfF199Gu/AlFNp01E8c6lo5hg0Kxw6RoGVvGFezrEQ9UPd
	 LQ2RbJ+GpaGKHo5ys4HMKTTnBZVmR9DMg3vNbj8OSHv7DCT9KNjSnWtc2UfkykNIPA
	 sdR7YbT/x/mLuqdjkKABClgALo3ibGNRjiQ/5+zAdx7t7Zi+XGuM6LsOGghDKBIWOb
	 w+RRRUyB4ygT1eJnZAMNud6ym6B93ARXNP4Ry6FQrM8R2FOoN1Dxr/2mjnbqlboOVp
	 8EOSd64eN6xng==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.ams.internal (Postfix) with ESMTP id ACF6A198003A;
	Tue, 10 Nov 2026 07:09:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 10 Nov 2026 07:09:14 -0500
X-ME-Sender: <xms:aQnzal11WPJvMFtzuiOPdYj-3EMZcwr1zDigDxzahluYExjTpck1ow>
    <xme:aQnzajFHBuRlMqw8MRj46Q_fVRtc07GW1tN5oxdnBOq5GhCC0HVIeMJYYZrpkM0QZ
    v8mu89HptaOx3Vgkszjkf4OTYZbKrPPJ7nO1UEQrVSgFrnTeCb7t587>
X-ME-Received: <xmr:aQnzaq5juEdFayiw7EKnRvvQk3fVP1c4H3RE0YWnayPkmEAxqATVAQX5n5M>
X-ME-Proxy-Cause: dmFkZTEG2QReU+pWTNduaklhlkyQmgA2xQd/4IsynuMn34X0smgSntMrkGGYnOu/UWJaW0
    vpHAX2MtLLcpL+wM2+LoY27eKP5ZCUw7CEKEIhnlGCbfvM2buNLPmMf43G7Q6LpzGxpqYK
    QxCOLZwlEZLonrmTUYjGqaxU0JUdCT/pJWYZNyVejQXMqZzX1METg/cTiLAVNkrSjKRFd8
    mqwBX7XhqB9VGWuPNe9KXx8sVESZseQo2UOGi5HWojPvhxtOtUA1yEy6NthWmmG6c9TyS2
    fR5gfVARf+E+DTwJ69pax7e2r5RLEjoyczu9XdmowWP/MDBAVHzmIbWEwFb75eZj63Wipe
    cnByvFlvjLMAN8xquSigpGtufrmXkVtPC4/jXEFX3vaoV32cbjbXszaXQ6GGDvBy4cLCzo
    MqjvEmIueEemNmB4LO+nM/iLO8vu6DDckyT2D+V5E/9/8R4m/wCliOGR19WI4fj1GQGD8G
    l3c4cgMwn1oZrUBpsGLk49ShWNBgg8KU8Z2EtU0wivTZy1al9o5M0jIYiB5swwvW8XD5ho
    qG8KrlWiLiQvbEBeE9G6xe8sprB9MWUZKoJcfeCzDsbcyda3nG6jEcDR7QiA3uQ4fUTqE6
    5AoeR4PEYC5lGlQd8Oij6ua+Jl4SWiFxkhNIZkFN9lDwh+eWakK63W6ZVYpA
X-ME-Proxy: <xmx:aQnzahvTmNT1mllW_5T-g80so0GDsrB5kAmqPU34xOMO9L_eJZTG3w>
    <xmx:aQnzaj5a4YYZUxaSKayD772bn1PQLWvK21_2DmA-Lo7QxC89qetBXQ>
    <xmx:aQnzakVuxShJrUQpcQX1BqRJZ_93rWHtKSOBedegReP445Cf1MIPAQ>
    <xmx:aQnzat8EqcJpfF8gB5OhsrL9fi4XVnga8_IHfj6R3_tYfr86A8H2ag>
    <xmx:aQnzaolTGLfTsg2HHrlGkLcOeEG_knRa4RrpGFFg-Tnszc2Y7Pv2Qy63>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 07:09:12 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 6.12.y 2/2] arm64: sdei: Preserve the interrupted context's exception registers
Date: Tue, 10 Nov 2026 12:08:43 +0000
Message-ID: <20261110120845.373988-10-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109201015-failed-6.12-58c1eb84e977@kernel.org>
References: <20261109201015-failed-6.12-58c1eb84e977@kernel.org>
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
[ kas: keep arm64_enter_nmi()/arm64_exit_nmi() in __sdei_handler() ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/kernel/entry-common.c | 21 ++++++++++++-
 arch/arm64/kernel/sdei.c         | 53 ++++++++++++++++++++++++++------
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 8539e75a2b7e..4033ee7005a4 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -1088,7 +1088,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
-	unsigned long vbar;
+	unsigned long elr, spsr, esr, far, vbar;
 	unsigned long ret;
 
 	/*
@@ -1113,6 +1113,17 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
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
@@ -1132,6 +1143,14 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
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
index c867baa9f9f6..a6d78ceb1364 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -203,6 +203,31 @@ unsigned long sdei_arch_get_entry_point(int conduit)
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
@@ -219,6 +244,7 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 	int i, err = 0;
 	int clobbered_registers = 4;
 	u64 elr = read_sysreg(elr_el1);
+	u64 nested_elr, nested_esr, nested_far;
 	u32 kernel_mode = read_sysreg(CurrentEL) | 1;	/* +SPSel */
 
 	if (arm64_kernel_unmapped_at_el0())
@@ -231,18 +257,27 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
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

