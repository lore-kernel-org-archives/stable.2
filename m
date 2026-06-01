Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADEF396590
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309566; cv=none; b=rxfMysGe8qYuagaJEqG1T2QwOCSobZstKKxtiXO8B3beEYs3EsTwFw+hrrFmPOZDV3r15CapsihStWAESDWswtJNSsbYJkkz/ubChODAIyvRb4euJUJi2BwDwRqvzzhfBSKQUbA2LN66FEByghxBNojhhsm4XocoWpSHXCdWSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309566; c=relaxed/simple;
	bh=Ol3diYrF+zsSp+nUEvfCaSmNuLVSdMjbjd7d8B/SLdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3ay+aawgKEYO1DcKe7Z6fROztF1z66rir9bn3Ep5ZTjCmYzmRzQm0GfYPsYYTUm9w5PsGr1K0gydOBXlPdeBM4vkFBb8Iifsk2UnM7YiWRWHjKKgsBXQQBePZ95bWzxT8GC4YevSwpTmaHCLGzASxAIKvL6zcRv+va7LA8+1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UVc25NhJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Youy69Oq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UVc25NhJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Youy69Oq"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Y9zMV9uYzkbKV4OImfuVkoMRFOUEZ1JRIa+aK1b3dc=;
	b=UVc25NhJbugSUQRoY7vJzXHG39pb3CewGtsyE1MjIbsRPsZ2sijsjBcKt+mVBpXm5bjgGT
	vNt4JmUte0rMWyp+b12yCvR3uTKXx5CzyjqOLwg3IFLA/9l3EHUSeY/79JNHBNI5bWvvBO
	VUKGgYyiivmw816Hbznu1hlnZNQjVSUr3RAwCyAqTRwlrGk0h4I7wQOnK+321Im6cd8zQt
	aDYg+vzssC+TDM8LZ3QLz5UNpjlnbLCVgHVJSxJqB6QC2OowNsbg7iJbFYhHUf47jWzz7p
	wVLTeBl7UCIArVa0V8LLxmthbb9qlC9TP8sxVKoes880D7CHtA0tY7rL81zwlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Y9zMV9uYzkbKV4OImfuVkoMRFOUEZ1JRIa+aK1b3dc=;
	b=Youy69OqPQBh1UsUQRZ5Ismp44dfJctnrRyRzsRGgeDOkrxuG2x1Hzl2AbY8jEpcGLMtv/
	QenNRZiohe5mQrAA==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 13/15] arm64: debug: split bkpt32 exception entry
Date: Mon,  1 Jun 2026 12:25:52 +0200
Message-ID: <20260601102554.233076-14-bigeasy@linutronix.de>
In-Reply-To: <20260601102554.233076-1-bigeasy@linutronix.de>
References: <20260601102554.233076-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Upstream commit fc5e5d0477c532054ce8692fd16fdaab2cb8946f

Currently all debug exceptions share common entry code and are routed
to `do_debug_exception()`, which calls dynamically-registered
handlers for each specific debug exception. This is unfortunate as
different debug exceptions have different entry handling requirements,
and it would be better to handle these distinct requirements earlier.

The BKPT32 exception can only be triggered by a BKPT instruction. Thus,
we know that the PC is a legitimate address and isn't being used to train
a branch predictor with a bogus address : we don't need to call
`arm64_apply_bp_hardening()`.

The handler for this exception only pends a signal and doesn't depend
on any per-CPU state : we don't need to inhibit preemption, nor do we
need to keep the DAIF exceptions masked, so we can unmask them earlier.

Split the BKPT32 exception entry and adjust function signatures and its
behaviour to match its relaxed constraints compared to other
debug exceptions.
We can also remove `NOKRPOBE_SYMBOL`, as this cannot lead to a kprobe
recursion.

This replaces the last usage of `el0_dbg()`, so remove it.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-13-ada.coupriediaz@arm=
.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/exception.h |  1 +
 arch/arm64/kernel/debug-monitors.c |  7 +++++++
 arch/arm64/kernel/entry-common.c   | 22 +++++++++-------------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/ex=
ception.h
index 7bc79602840fd..9b05c6f487ccf 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -72,6 +72,7 @@ void do_el0_softstep(unsigned long esr, struct pt_regs *r=
egs);
 void do_el1_softstep(unsigned long esr, struct pt_regs *regs);
 void do_el0_brk64(unsigned long esr, struct pt_regs *regs);
 void do_el1_brk64(unsigned long esr, struct pt_regs *regs);
+void do_bkpt32(unsigned long esr, struct pt_regs *regs);
 void do_fpsimd_acc(unsigned long esr, struct pt_regs *regs);
 void do_sve_acc(unsigned long esr, struct pt_regs *regs);
 void do_sme_acc(unsigned long esr, struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index 45e0dbe17c82f..ed03270fa3437 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -270,6 +270,13 @@ void do_el1_brk64(unsigned long esr, struct pt_regs *r=
egs)
 }
 NOKPROBE_SYMBOL(do_el1_brk64);
=20
+#ifdef CONFIG_COMPAT
+void do_bkpt32(unsigned long esr, struct pt_regs *regs)
+{
+	arm64_notify_die("aarch32 BKPT", regs, SIGTRAP, TRAP_BRKPT, regs->pc, esr=
);
+}
+#endif /* CONFIG_COMPAT */
+
 bool try_handle_aarch32_break(struct pt_regs *regs)
 {
 	u32 arm_instr;
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-com=
mon.c
index ba114bfdb32b5..9a1ea5a6e6b72 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -834,18 +834,6 @@ static void noinstr el0_brk64(struct pt_regs *regs, un=
signed long esr)
 	exit_to_user_mode(regs);
 }
=20
-static void noinstr __maybe_unused
-el0_dbg(struct pt_regs *regs, unsigned long esr)
-{
-	/* Only watchpoints write FAR_EL1, otherwise its UNKNOWN */
-	unsigned long far =3D read_sysreg(far_el1);
-
-	enter_from_user_mode(regs);
-	do_debug_exception(far, esr, regs);
-	local_daif_restore(DAIF_PROCCTX);
-	exit_to_user_mode(regs);
-}
-
 static void noinstr el0_svc(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
@@ -1003,6 +991,14 @@ static void noinstr el0_svc_compat(struct pt_regs *re=
gs)
 	exit_to_user_mode(regs);
 }
=20
+static void noinstr el0_bkpt32(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_user_mode(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	do_bkpt32(esr, regs);
+	exit_to_user_mode(regs);
+}
+
 asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
 {
 	unsigned long esr =3D read_sysreg(esr_el1);
@@ -1046,7 +1042,7 @@ asmlinkage void noinstr el0t_32_sync_handler(struct p=
t_regs *regs)
 		el0_watchpt(regs, esr);
 		break;
 	case ESR_ELx_EC_BKPT32:
-		el0_dbg(regs, esr);
+		el0_bkpt32(regs, esr);
 		break;
 	default:
 		el0_inv(regs, esr);
--=20
2.53.0

