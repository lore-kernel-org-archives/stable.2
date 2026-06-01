Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0719C553
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309562; cv=none; b=hhAREWH1h0FMc+BZEPn+qOBFRbGstj8TnAJvDjvEAjIy2xw8Lz9vuyOv9u7d+41TCu7rfQhCRei2OdJEB2J1h9l5/hFfDJfkzve64SPh1LS5mDVPklPjZqPazTRpV1vMKBxgoWi4wG2bcTt3a+HvLz5iBI0Gthu3mFGlTF6nvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309562; c=relaxed/simple;
	bh=MZhzyqjfo+4MEffpjFU8wUnaPElIMdZwdy7CzkU/kts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V97ET4MFYQrv15v+lYKmX9BOt1zc56S8ML9vYGomzuT6IABrViJgzq+z/KUKJK8UMQ2W0raOEvEzUvtsEk2tWx7RwN7uKbaAFJq+UvAM7CArzVMWHtaJM+qFvEg7FhAVg3dzReMVPqdmb6XTTDhlQGwkYY+6r8BY6ZEEO7LdL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S4rXIN3m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7PwGT1AL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S4rXIN3m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7PwGT1AL"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuNhU3Dn18OjkitdaE47/VFpsz27s8PtESQtw8pBeIk=;
	b=S4rXIN3mfc4D73NIIYbUM2uVvLIsksNF+Q5DpYAijJQr5IaNDutBeZ2UlvRC8n0zta5yZY
	NJaR7EqvyWCqNyeiOoT+Vg8j3Mhskee6Q+zDK4A4XE8LLHtQeOAAkxaGyQQZJsCJ3Mz3DW
	gckSuef4scPiuhEvknxQarGvnnlvp3tYZYl76Ks3VaAf5u25s9kEvzT928YMFQN0dPbSvv
	d9gN/C+XFiJPNOnCS98+hqS5DRVsbLFbYTwVJjUIFM8Z9sqJ36cpXiTKp49jNzj1jQTf+C
	QiLbrHilA481zPpMDkFKkzBW9sC2JakXSCuoQWc00jKkHlG9DtxkFUdkhCa1nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuNhU3Dn18OjkitdaE47/VFpsz27s8PtESQtw8pBeIk=;
	b=7PwGT1ALG6eDTG+xpwphrYyI/SKM/PnGcBCpdzXNv7KlPGTwojfXZxn7GZ48oN80x4oP6I
	9GjqaSZH28d8fKDA==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 03/15] arm64: refactor aarch32_break_handler()
Date: Mon,  1 Jun 2026 12:25:42 +0200
Message-ID: <20260601102554.233076-4-bigeasy@linutronix.de>
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

Upstream commit b1e2d95524e4d0f5b643394c739212869e95cf6a

`aarch32_break_handler()` is called in `do_el0_undef()` when we
are trying to handle an exception whose Exception Syndrome is unknown.
It checks if the instruction hit might be a 32-bit arm break (be it
A32 or T2), and sends a SIGTRAP to userspace if it is so that it can
be handled.

However, this is badly represented in the naming of the function, and
is not consistent with the other functions called with the same logic
in `do_el0_undef()`.

Rename it `try_handle_aarch32_break()` and change the return value to
a boolean to align with the logic of the other tentative handlers in
`do_el0_undef()`, the previous error code being ignored anyway.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20250707114109.35672-3-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |  2 +-
 arch/arm64/kernel/debug-monitors.c      | 10 +++++-----
 arch/arm64/kernel/traps.c               |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/a=
sm/debug-monitors.h
index 13d437bcbf58c..3eeea1c9f0666 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -115,7 +115,7 @@ static inline int reinstall_suspended_bps(struct pt_reg=
s *regs)
 }
 #endif
=20
-int aarch32_break_handler(struct pt_regs *regs);
+bool try_handle_aarch32_break(struct pt_regs *regs);
=20
 void debug_traps_init(void);
=20
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index b7a2155bca42b..8275b7f575462 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -335,7 +335,7 @@ static int brk_handler(unsigned long unused, unsigned l=
ong esr,
 }
 NOKPROBE_SYMBOL(brk_handler);
=20
-int aarch32_break_handler(struct pt_regs *regs)
+bool try_handle_aarch32_break(struct pt_regs *regs)
 {
 	u32 arm_instr;
 	u16 thumb_instr;
@@ -343,7 +343,7 @@ int aarch32_break_handler(struct pt_regs *regs)
 	void __user *pc =3D (void __user *)instruction_pointer(regs);
=20
 	if (!compat_user_mode(regs))
-		return -EFAULT;
+		return false;
=20
 	if (compat_thumb_mode(regs)) {
 		/* get 16-bit Thumb instruction */
@@ -367,12 +367,12 @@ int aarch32_break_handler(struct pt_regs *regs)
 	}
=20
 	if (!bp)
-		return -EFAULT;
+		return false;
=20
 	send_user_sigtrap(TRAP_BRKPT);
-	return 0;
+	return true;
 }
-NOKPROBE_SYMBOL(aarch32_break_handler);
+NOKPROBE_SYMBOL(try_handle_aarch32_break);
=20
 void __init debug_traps_init(void)
 {
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5e138cf5d4ade..c38ebf715be76 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -462,7 +462,7 @@ void do_el0_undef(struct pt_regs *regs, unsigned long e=
sr)
 	u32 insn;
=20
 	/* check for AArch32 breakpoint instructions */
-	if (!aarch32_break_handler(regs))
+	if (try_handle_aarch32_break(regs))
 		return;
=20
 	if (user_insn_read(regs, &insn))
--=20
2.53.0

