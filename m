Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880526;
	b=cRgPDmSRNBmtf+47kKJhP1Yu97ojVtFJQfs6jwpc2dLWt0X5HmG//p3CE/TUoj6QoWJ0
	 EWLecy8Gf2gLDXCQWkzCVTCyqNF1fb8F5GsYqas4zxXJrfYY8+uUlV0ZQ7oj7ERNzAPnd
	 /DkBZp5HVcDY0iiDdmzwQXKwaO6alboFpDB5DS8CVCLLiW/vdOH2PCCjU1Le3lUQ8zXjn
	 CykMLGMfHvmgFMpc2bh3KSpBU5R6g5AIkwpgC5B7VE1fAKZcozsufsNdVsuAkSGHrCWlb
	 KzrpWzy49ijF2IQezdQyWYm+OlN67f3+/ZhzD7fx+cn8TCEp2SGNhLBt5dfJ0MHF4bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880526;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=JjsV2eMXQqTjPV0yeAMpkXiT8dIOGL60A53AdNPhQL0=;
	b=PAbO7xKnyTXyxpkDq9E+IlEe2Z1FAKpzZsaG3EgWqGXiRM+n8KwaKZTWNH7H5p7N5gnD
	 d98Mv2wDHw7uQBhU96FfKUnkoxZkJKQD2PM9iOAfP/hFeEuetVIrqgJjXoNZWNRl7cxR5
	 rcatjQ9shZL+eF1g09AdZSPL7U+CIpekwMAxMVLORLMrhZ8nlA94sHjzf1yDu+vAK0zaQ
	 z22CskmC/uwp6GYHSHDdK0IjLCT9+PxXwBiCrxSCyMnhfZY82uENEvtYRFjHXMbDGHule
	 URE6cbIGPTGCXWXSDa3b6j765f3g2H9EpEXe1S72RAX7ZEdQBLKbmaXkwtZshfQLb3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=q7kgLdE+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1w2F6up1;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644B606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E644B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=q7kgLdE+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1w2F6up1
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 163E6EC0607
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:08:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 05 Nov 2026 07:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793880524; x=
	1793966924; bh=JjsV2eMXQqTjPV0yeAMpkXiT8dIOGL60A53AdNPhQL0=; b=q
	7kgLdE+0VJF5QE//nkz1fAodiokRQwHwiUu7HRpAroZO4DhgTtoLjAe+d5xxAcUq
	V4j7AQcwI60/gqloA1RsAeX/JabQ4knDhJ9JlPAHm20IT/UoRdxhBAy6zv7+qztE
	RS9pB8G6YbBjmUGAdQ8uOco7luYwQUhKIT0urdp6jWVKE640KVKYzUhBO6S+YgFt
	77ByP0FQd7YBQ+Xf/MjDytLJIAKJKz5TLQwAr5tcWfcpmFobdD0acM9TRwE7z/bk
	6/BKY04kpmWbbBfq8t0hxwHQfjhdTvnC5Lxh9DVvVVMU65yULnVIp2DloSeL9OYM
	NVQqIIuO9BCz5ghxzsZkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1793880524; x=1793966924; bh=J
	jsV2eMXQqTjPV0yeAMpkXiT8dIOGL60A53AdNPhQL0=; b=1w2F6up1EYrYcF3UJ
	XLYhC4tmZpMlGqcMGnYFCnuQXw9vdAeVyKvlsGQJMIk5UsWvwK1oWsJLAlcxVlRW
	3qYHGngSCiISNmPX3MloPDsqMeGTDDYWbhDiSkFC5aCdmsRdCNaB5+HB5TD8AJEn
	HVMXvQHP2fkJD+oBtsretwyUdhmo4Sv0Uc0KHI0QCCBM7AMHZZZ5W2rgNa2ZMRTE
	zym9RXCX+irAqAbcwBcq5fOSdovZz3AiJXiufpjgAd0aAX+0xYHmJyI3Qvr5z/Jc
	qJCWUjP+CvO5VYGIWOrxAqkp7HC/daxhS+StItlwHZ6SPTEIfPrug1Mq+tDQGSK+
	O3CKA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793880524; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HVUcX8kiX4lXKet5FME5A5ZnsuUs3FRAjztk61rDPzJ2vi5
	n+qJwKNA1qfBYxma9Q0ZKKxLaNlQ7FTUG1tkuXiLAiSfNjH5fPEbd4+/bThC04FE
	9QCS3KjX0cj5VgAxjWK9J0gwyZAbdSe8813iqo4s34bMuL55p8mzs6vOXOMjpU31
	L7n3IWtXU6TVuno8Alb/4koTZlC7O9hHCkTkl2LjJHlUiSd+Mrmi7KhtvOCI72k0
	ce5T5UNMwz8VbXzxp3c0C//z1cDG42Tblw2jbubDt2HWTHR+8wb+LH3rwqQgtwGS
	OLyX9wufb6RDAXCAbWkHIi+XKI5QYdaKrq3QTcA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yR2kcx28kaEe8CeyXNtJsh1sSozszmDhicKKA5z1OX0=:kxqigVy5QbPi66kmH2Rj363YeB+NJrHgOa9cYvFdDBA=;
X-ME-Sender: <xms:zHHsavfoaxe_7llC1ufdADAoFeL8AuRRPYPBipouuw6p7d7EE2BZNQ>
    <xme:zHHsasSxT6LWCuygwj9a4ptagGAPmooYgAz2-E7Vach2WRxMhVaMV0RB1q8OLeflc
    14VPIb0zOD5WE3gSGDl82eygzzoLiu4J0ywLiM0pOJcBTw9Gb6Ieak>
X-ME-Received: <xmr:zHHsagPqHpgTzSKwztFCOFvUV0piLkshbUScv6CkMlBWAmRfCFUiL3ad8Tw>
X-ME-Proxy-Cause: dmFkZTEHwup4BZFc52KRAGHxzOYIaa2sYBU6ww43+mB6HyAOvQAn3KBA0RSHS6jdPttSF6
    ke/n8jn9qCNGZK4H6kDcJDi7MztZMGerFklonhOopPBRfA4DdR5ybNuh6LVe/sllVuQjEX
    457oRixYUE4IWm3NC9j9YEvrxT6+ZpBIGvjfnrB9mFZyjx86HVaYbCMAs3ToPG+dYEw4s3
    xP+KOABtHnivG4j1iJ8lUPKvqwjPu2Sfmm3BNmjq22yAylca4MJ8on46FIbHTCpcdf5Lnc
    NVcN78iMJoniVTBvBCZWlgALX6fkwYU3bhAc16F0533stw+SXUDwcbSi2CpeYiOrCmfefW
    KEm2Awux9oEooJ9v1hYDnaKYYIg3cyhZ78/RyTgjXRI/jLYEflac0MeUs3NZCzPriPXt12
    tgQ6/qul3Bo6V56lTgRn12b5QtT3ZIFoXIEtgeDDK+eptNP2YG35KvmVWhT3zVSuxo31po
    qciNMmAt90jb3hLbt8vw5/wjuDCRAB7vfla0vKqLBYoWRiPY/Q4Fvy4BcKgiRKd0ue5aCk
    JCybQ37dEW0eYrTV05jZ6sV3Y7yTBj8uJkP+IRSZoDQl7tnWX8hqUTQvTsRXrB+7DnqSgw
    QQ6Bmup/U41BfEPJORdbwwAsRE0HmTuAS5jt2fRiwZn4Jn3PUZumIUFbDSpg
X-ME-Proxy: <xmx:zHHsanUJO6prkQwy1gB_-6l2kN2CKPotFbIwhFIWs7UZsun0EqVX0g>
    <xmx:zHHsaoYyODKpr0A0heTXUToHloQz5S_9rMlmGwaQrggQ6BQNvwtjDA>
    <xmx:zHHsakuYq0THBJeXxmyIjHgujr_4CTbHLSEryzKeeI-Y17RPAV7QvQ>
    <xmx:zHHsank-NnIWZZUn9dphMB81__OMr-vgubzEY8FFEchpWAVcHsfiwg>
    <xmx:zHHsavy3AkAPxZVRBTBrldc4Q4TKFemNYipPFp4muqOhxxZ3Cq7EQ8pz>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 07:08:43 -0500 (EST)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Usama Arif <usama.arif@linux.dev>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Breno Leitao <leitao@debian.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Huth <thuth@redhat.com>,
	Dawei Li <dawei.li@linux.dev>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: sdei: Preserve the interrupted context's exception registers
Date: Thu,  5 Nov 2026 12:08:34 +0000
Message-ID: <20261105120835.3321912-3-kirill@shutemov.name>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105120835.3321912-1-kirill@shutemov.name>
References: <20261105120835.3321912-1-kirill@shutemov.name>
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

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

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
---
 arch/arm64/kernel/entry-common.c | 21 ++++++++++++-
 arch/arm64/kernel/sdei.c         | 53 ++++++++++++++++++++++++++------
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 8a17e3720f81..64d287e1533b 100644
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
index 260c13106009..1b902da8ba43 100644
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

