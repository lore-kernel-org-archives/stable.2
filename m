Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312551;
	b=s79cr7i3QXJ4z4Cb3uoj9N2iZS7nEmDeHe7Q4irto1+AQqNogHEBV5VRWZwtwBpL56sN
	 HhKbGWbhxioDZU2GMFKl0OYz9ISjF+kQ2QV3PAO0wVfMoMsCtOghIiOHmLe36r0pIqvGn
	 haCK/kyk2Wmy+dS95nfIkEHhv780oH64o5Ttn/LFV30NloDf2qX8rcamin1uSrURL5l74
	 RmwHhg/Y1jTn1l0TQk98PMz8qi/74KsKtuMtW+ItIra/8b4NxSMbNZ8IUM3Wi/aEQwzbK
	 GvBA0nME3N/pdXaJYMlC/arTvTM92uzD6XkKv7ITrODX2sg4T/Fvc1cW5wllbEU3eMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312551;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PieBt80BPup+UmIbqAgOqsv+17nBFchevkRBu8ZT+pc=;
	b=XzIldnIqYNsvG5B2g8Uhgry/IhyXRodLORmBzDB48eOvR75eME0blJGREj0X5wVyBVk9
	 5BhIROhI6uDWaB8v4zMmMS7+FPbfYkQ3EBnxMjcOK1MqHNnd71ddFPThuZbxXbVB4x6tY
	 z5IIZjPfjiB+LR5YfiX8hSrnKuYiYkHggkVFiGoTIrQUlad+MqfTCsngv1sJzeb7fOGJO
	 wWIKQ9QJeq0h+8ziqn2+kiIknBvldBd9HADelYLkV4S0V/dPVZgX9hZeXugBYRwix/xr6
	 PewiaVYiwZPTEV1edPixM3LZurIwK/ceK2N5OkbAFsYn3BlnMLAfI1RcN8jQRE37ivQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DifivuAj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA4606D534
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DifivuAj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0397A1F0089F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312550;
	bh=PieBt80BPup+UmIbqAgOqsv+17nBFchevkRBu8ZT+pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DifivuAjOyueY7ZWvIvfvtLwBIMHvDKlalF6f49jhx6UxVcFbLvC4C0Nt5o4oKfhC
	 Ii9jdaiQmxOitizYXl/WCcR7KGIf95kpQHKVCzs0nDYCjcPH4a8DJDE752fzfF9Jar
	 u2u3D3IUT+ispjC6uQSAgwYqy/+OjfLciTwks1kDWuKB/ftr8BcRCQPbQrajrWArMU
	 SA8rwA60tyANn+/vG96cMje8QrlMhKQ8KB9jUHHY/1roXuSly9/Xq7kgzKAbiUcABF
	 2kfbgSmcyFlWfVh/+07B9udg6f7MKSWsAdQkrbl0LsaRHXp2ChH1SvT3KnsY+a4A8C
	 2Q1aw8aFjlSyQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 44DA4198003A;
	Tue, 10 Nov 2026 07:09:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 10 Nov 2026 07:09:08 -0500
X-ME-Sender: <xms:YwnzamGCbQf2HOxhLXt6UVvZkguJEzF-zxbfVlVrLBti3P2WQqim8w>
    <xme:YwnzauVpXj9YrWoBIAsoAQ2S1waG63Ouphi6IfjehNMbnoiZ6tjmizkieEFj46Qe_
    JXRa3Q6Q5wI6_z4afZfZgOdRmvs6pT1-wNesvWmvSBn-E6KTTahYZM>
X-ME-Received: <xmr:YwnzalLiXHHfdUu4Gy-cNjQH4nrflD8sC_PjL8XRZrxQJRN71vSvcSliU7o>
X-ME-Proxy-Cause: dmFkZTGBHyJLLKJKFF1yqV9yoM2aBlEIjb51YAwUUNwmA+6zS/+FQ51cysO4Ho3Uyd0AL9
    fbqWgmpo2xceUTkmijFv71rEOAcuon2h04LHiVCGs0x4fQ2jLxKMcIwfiW2TASq/K0jCf5
    i8+LGS5Yiy1Y97xb0ys9jmR5GGI7twgQmuX2wL5w6ALl0h/S3DYuf7/BXo7xfMo2Le/y8q
    yir31cLtlZad6SP1iqY+3Vwpxt2Kmzt27xY3i7EUdMDvoi2MEeeHV9Hb87v4BB2S3ODvNW
    ViB5LVGlnJU1FxqQhUfWgQdxj+fb8r0avbWXCwkcgpjf/LH8LVP89X8uyV/IXyOrULfCsh
    5PGsFsaWp2aC92FlpTMsvmiDISnUY3QvTxPElm/V7Re79c8gP1Ij3SkZH7GsfGqSY4kkyk
    iJm87+L6agYyB881kHsMRVjgHujsTzGOUSSDxFFHGTZWRxfvxG1X6SlMn3cdfwnwL3Rg8q
    IlVMUg3hlvNrJ1FwoZjzaa80mI5NplODfG+Rmi0hqyy6+kIBf5Qe1i4Jvb1eSk//PCuV49
    KIEvtlvSwcYldxwyrlp4Tr6qSYeDUL62MBhzODcWNnmGgplzVSswm7ZIPMUtKJaYZjtYvH
    gBdQr4Xud4XZ3QBb7VzrmHLa8Cy8Ev2lHl0enQm/CRoz5obJn+ObSg5tpGLg
X-ME-Proxy: <xmx:Ywnzau8WmlA5w47fNCgzooy8hIO-2iZ-5j2-Fvrly9q85Tyrq26SuA>
    <xmx:YwnzaoKzy9VdYefc9XWTNi08788xb3JHNNXIQuCUABdB_zJEl7OALg>
    <xmx:YwnzajmIcJFskoMF-Md4RNodxaQArIRJ3hdpHxOQOcRLB5I7RLvntw>
    <xmx:YwnzasNJxJEe4yAB8430mOVQC645FPDTnNaYzyMgPPToJuyy-cBkJA>
    <xmx:Ywnzap2AyZ-gdb3UkJm6fl0jie9cyUAIbRsd3WL5NpiWxBWH__1SUntk>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 07:09:07 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 6.6.y 2/2] arm64: sdei: Preserve the interrupted context's exception registers
Date: Tue, 10 Nov 2026 12:08:41 +0000
Message-ID: <20261110120845.373988-8-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109201453-failed-6.6-58c1eb84e977@kernel.org>
References: <20261109201453-failed-6.6-58c1eb84e977@kernel.org>
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
index 360cce9cbd9e..116377819ee6 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -924,7 +924,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
-	unsigned long vbar;
+	unsigned long elr, spsr, esr, far, vbar;
 	unsigned long ret;
 
 	/*
@@ -949,6 +949,17 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
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
@@ -968,6 +979,14 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
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
index c867baa9f9f6..26e44a69e8a2 100644
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

