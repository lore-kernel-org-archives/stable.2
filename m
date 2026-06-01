Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1084397AFD
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309568; cv=none; b=eBtyBtlm6/PvMxV89o/4etYvWZYIOsjafv+/BaIhCn+wT03/xLlQR57SXi3CnAHP+Lg6JdOnnvIVFVGZkaNg7j/bqGk+JkppNR+ZISjxqp6k4dQxidWWREAw7wbyFfMfakhifzpKpjsl6+FM3zn9mxpuWvClj+6Gj+lM04JySjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309568; c=relaxed/simple;
	bh=QYEzzsjolM0fO5luv60KcCdT4tnzq0ag8KjybHtMne4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h87ouJA6zusRJa2P1Y+ZP0GmBumto9JakDuspY+PLsHF3jupXBuCoDTv3QVwEkrfDIeQAOtSYf9klBt6klPondngjkdb+SYUpgMsFAMO83M7eANITNc2W19yXNY22ePSOVGNACKh07eicpC03OeKcPOMd1eshB5DvVGf5FFiP0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXbXO02m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dc1HhVLc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXbXO02m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dc1HhVLc"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7jg7NBPh9QUeNOdV4NPOqb+WGmhnB/6GzUdXTAffH8=;
	b=LXbXO02m94bU6bwmVkfz0/dnycN1OceWmQ8oBRjr7P7I+PQYoqVgQasHLJx5cBV3ICR22O
	OPQGi8ykZ6z0c86KAm3M5x3ikY7tXq9nartF97YGB7bx0UcC3a56qhUp8cHho3pIHs98X+
	yN1QQ7TLx3ZW+dlTRXJHz5gxCYTLs6+W4yNW3nb394d3hWIy8g/OgLmXdLAx/EIgOE7435
	oagbz5vjYpXHLceLHjUcVLazM22SlWiPXZ9bwGh4iOjI/fTaqg/oYa33xD1ondWUsldRJw
	eNE5waIejHJ6kM7VAUO/B/xkQuFjuvlvT7NIjXh85YhH4QKiJahMuMTGi08CNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7jg7NBPh9QUeNOdV4NPOqb+WGmhnB/6GzUdXTAffH8=;
	b=Dc1HhVLc3OvYGmd5fVgXpYaGRwQhyVaub2gqO+b/kXTsVwuK/FdahVbjAdpl1aLPQdcy+O
	tPllKNsBdDRb8MDw==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 07/15] arm64: entry: Add entry and exit functions for debug exceptions
Date: Mon,  1 Jun 2026 12:25:46 +0200
Message-ID: <20260601102554.233076-8-bigeasy@linutronix.de>
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

Upstream commit eaff68b3286116d499a3d4e513a36d772faba587

Move the `debug_exception_enter()` and `debug_exception_exit()`
functions from mm/fault.c, as they are needed to split
the debug exceptions entry paths from the current unified one.

Make them externally visible in include/asm/exception.h until
the caller in mm/fault.c is cleaned up.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-7-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/exception.h |  4 ++++
 arch/arm64/kernel/entry-common.c   | 22 ++++++++++++++++++++++
 arch/arm64/mm/fault.c              | 22 ----------------------
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/ex=
ception.h
index f296662590c7f..b1d6a65f6d225 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -77,4 +77,8 @@ void do_serror(struct pt_regs *regs, unsigned long esr);
 void do_signal(struct pt_regs *regs);
=20
 void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, u=
nsigned long far);
+
+void debug_exception_enter(struct pt_regs *regs);
+void debug_exception_exit(struct pt_regs *regs);
+
 #endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-com=
mon.c
index d23315ef7b679..2e04e04aaf2ad 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -441,6 +441,28 @@ static __always_inline void fpsimd_syscall_exit(void)
 	__this_cpu_write(fpsimd_last_state.to_save, FP_STATE_CURRENT);
 }
=20
+/*
+ * In debug exception context, we explicitly disable preemption despite
+ * having interrupts disabled.
+ * This serves two purposes: it makes it much less likely that we would
+ * accidentally schedule in exception context and it will force a warning
+ * if we somehow manage to schedule by accident.
+ */
+void debug_exception_enter(struct pt_regs *regs)
+{
+	preempt_disable();
+
+	/* This code is a bit fragile.  Test it. */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "exception_enter didn't work");
+}
+NOKPROBE_SYMBOL(debug_exception_enter);
+
+void debug_exception_exit(struct pt_regs *regs)
+{
+	preempt_enable_no_resched();
+}
+NOKPROBE_SYMBOL(debug_exception_exit);
+
 UNHANDLED(el1t, 64, sync)
 UNHANDLED(el1t, 64, irq)
 UNHANDLED(el1t, 64, fiq)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2d1ebc0c3437f..7c87d2b3b06ea 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -939,28 +939,6 @@ void __init hook_debug_fault_code(int nr,
 	debug_fault_info[nr].name	=3D name;
 }
=20
-/*
- * In debug exception context, we explicitly disable preemption despite
- * having interrupts disabled.
- * This serves two purposes: it makes it much less likely that we would
- * accidentally schedule in exception context and it will force a warning
- * if we somehow manage to schedule by accident.
- */
-static void debug_exception_enter(struct pt_regs *regs)
-{
-	preempt_disable();
-
-	/* This code is a bit fragile.  Test it. */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "exception_enter didn't work");
-}
-NOKPROBE_SYMBOL(debug_exception_enter);
-
-static void debug_exception_exit(struct pt_regs *regs)
-{
-	preempt_enable_no_resched();
-}
-NOKPROBE_SYMBOL(debug_exception_exit);
-
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long es=
r,
 			struct pt_regs *regs)
 {
--=20
2.53.0

