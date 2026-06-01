Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E739339A040
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309566; cv=none; b=mxHR3YKhvTJtHFHuKk+2Hw46EJaDJ5hv3/nXx02FKzFtwBUxyLhDLKcuIp/K6jnEhWc+M6y1ueSaIJNDd/vkXFanN+0Ck+n4uyWsoaP31Xl7QA6K3TdbWlPO//LCHEnt1a24z1ydlQvW+UnfQP/HT2pakFczbASIwggbsuegfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309566; c=relaxed/simple;
	bh=IDmFn6DRAMwtPw7uA//W1es7+SS83hUZ3Y+LdpLEMdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7+eR0wnpyHl87CmeUCH1VmEwwCPv4HVCzK1l0vIaJZzIgJ+pnHmY1YvYd4DMqf5Y2gdSl5XVqbdIA7gRWXQH+1e7oSXuvA08pmLyjsL7OC50Nj0WDWRJqW9h/cKRCUw46LMhsNDPT8EweRLuFCPNIudibEk6+nXGZ28MlwIybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uEpeg/20; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VKUTbx/g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uEpeg/20";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VKUTbx/g"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnZFs0PVSLC0pgeG8qqJVjB5PdoQUTV5448mSjmxa30=;
	b=uEpeg/20luSXK0cUR0w5mYrZ7KY66OYYFtXkEnh4T3twoHvJcl/w+d/ouMChxOqqZWkR3Z
	4i08+KO2INZzpXBf0O/zyZS7G6iDsQs2ml7hO4431DzIA6N1xXVjPChF5TvUGQYrxZCS21
	D6s6N6QgIxY5/sKW6PkjeNfeSndWZ/gDsR4sgUzGUjYYwamR9hdMWhwq233upU2jvdHFX7
	1NrOrU1bWhZrTaaNCMGMUQ0CdebcClC01D7GG0bbZttTX8M22CMM28eUB9xJj4ZhLP0XuF
	Uv+LPh40E/QwjIHMjxj/xbio1UmWoAs/XQlMPvHRMF6dMGcPqK7f8y81iporlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnZFs0PVSLC0pgeG8qqJVjB5PdoQUTV5448mSjmxa30=;
	b=VKUTbx/gVarBM/pOBn1qTj1dBMgQXEOf/0kYF07meuY4tL11Y08T8312HOzJQ/a6GmQaJZ
	3TM7LHPEXkKZZMDQ==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 09/15] arm64: debug: refactor reinstall_suspended_bps()
Date: Mon,  1 Jun 2026 12:25:48 +0200
Message-ID: <20260601102554.233076-10-bigeasy@linutronix.de>
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

Upstream commit 80691d35523de3292b64c2ffa444aab3d55e51ba

`reinstall_suspended_bps()` plays a key part in the stepping process
when we have hardware breakpoints and watchpoints enabled.
It checks if we need to step one, will re-enable it if it has
been handled and will return whether or not we need to proceed with
a single-step.

However, the current naming and return values make it harder to understand
the logic and goal of the function.

Rename it `try_step_suspended_breakpoints()` and change the return value
to a boolean, aligning it with similar functions used in
`do_el0_undef()` like `try_emulate_mrs()`, and making its behaviour
more obvious.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-9-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |  6 +++---
 arch/arm64/kernel/debug-monitors.c      |  2 +-
 arch/arm64/kernel/hw_breakpoint.c       | 25 ++++++++++++-------------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/a=
sm/debug-monitors.h
index 5319da0f0ca4e..24c7981abeb0b 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -83,11 +83,11 @@ int kernel_active_single_step(void);
 void kernel_rewind_single_step(struct pt_regs *regs);
=20
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-int reinstall_suspended_bps(struct pt_regs *regs);
+bool try_step_suspended_breakpoints(struct pt_regs *regs);
 #else
-static inline int reinstall_suspended_bps(struct pt_regs *regs)
+static inline bool try_step_suspended_breakpoints(struct pt_regs *regs)
 {
-	return -ENODEV;
+	return false;
 }
 #endif
=20
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index a28482e25c4c3..b95a135ef10a9 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -195,7 +195,7 @@ static int single_step_handler(unsigned long unused, un=
signed long esr,
 	 * If we are stepping a pending breakpoint, call the hw_breakpoint
 	 * handler first.
 	 */
-	if (!reinstall_suspended_bps(regs))
+	if (try_step_suspended_breakpoints(regs))
 		return 0;
=20
 	if (call_step_hook(regs, esr) =3D=3D DBG_HOOK_HANDLED)
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_break=
point.c
index d7eede5d869c2..309ae24d45480 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -847,36 +847,35 @@ NOKPROBE_SYMBOL(watchpoint_handler);
 /*
  * Handle single-step exception.
  */
-int reinstall_suspended_bps(struct pt_regs *regs)
+bool try_step_suspended_breakpoints(struct pt_regs *regs)
 {
 	struct debug_info *debug_info =3D &current->thread.debug;
-	int handled_exception =3D 0, *kernel_step;
-
-	kernel_step =3D this_cpu_ptr(&stepping_kernel_bp);
+	int *kernel_step =3D this_cpu_ptr(&stepping_kernel_bp);
+	bool handled_exception =3D false;
=20
 	/*
 	 * Called from single-step exception handler.
-	 * Return 0 if execution can resume, 1 if a SIGTRAP should be
-	 * reported.
+	 * Return true if we stepped a breakpoint and can resume execution,
+	 * false if we need to handle a single-step.
 	 */
 	if (user_mode(regs)) {
 		if (debug_info->bps_disabled) {
 			debug_info->bps_disabled =3D 0;
 			toggle_bp_registers(AARCH64_DBG_REG_BCR, DBG_ACTIVE_EL0, 1);
-			handled_exception =3D 1;
+			handled_exception =3D true;
 		}
=20
 		if (debug_info->wps_disabled) {
 			debug_info->wps_disabled =3D 0;
 			toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL0, 1);
-			handled_exception =3D 1;
+			handled_exception =3D true;
 		}
=20
 		if (handled_exception) {
 			if (debug_info->suspended_step) {
 				debug_info->suspended_step =3D 0;
 				/* Allow exception handling to fall-through. */
-				handled_exception =3D 0;
+				handled_exception =3D false;
 			} else {
 				user_disable_single_step(current);
 			}
@@ -890,17 +889,17 @@ int reinstall_suspended_bps(struct pt_regs *regs)
=20
 		if (*kernel_step !=3D ARM_KERNEL_STEP_SUSPEND) {
 			kernel_disable_single_step();
-			handled_exception =3D 1;
+			handled_exception =3D true;
 		} else {
-			handled_exception =3D 0;
+			handled_exception =3D false;
 		}
=20
 		*kernel_step =3D ARM_KERNEL_STEP_NONE;
 	}
=20
-	return !handled_exception;
+	return handled_exception;
 }
-NOKPROBE_SYMBOL(reinstall_suspended_bps);
+NOKPROBE_SYMBOL(try_step_suspended_breakpoints);
=20
 /*
  * Context-switcher for restoring suspended breakpoints.
--=20
2.53.0

