Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B736309B
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309566; cv=none; b=EGS9kZELYlFot1e+rYD/1i4Gnis5fBjVY5ku1hkmMD1Xrv4Z8+x+J8IYS5Vq0Y6hVKWRUgqDOOzjvo+/U3ju6bFBVX28oT0lAwkBbZ3mL3TIyugg+EVo07vZjF3gtHq5857PQhqT46lASErXivW15Uz8RCnCXG8GPmZxKBf0Otk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309566; c=relaxed/simple;
	bh=PWa5BapfG+jxUIXo4s0N/4L9ubQM4b/QYuFdTH7k1KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUE8/AonyHDJuKT5EL5Wi0UMlIp8HZchVRSktT6G/lf6kD3PGy8PBC7Iijret8+FNpuC4CPfM60v5obFuU5vO22xbNOLV/VJTf7/cprknC1kNlgsOtoUshOniRbltFtGGKeWy9ZSnM48dPBJnjwywpG3VPI5+C/crSFcSM9NvCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=asF8hNJZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kul7DWIT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="asF8hNJZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kul7DWIT"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKFgSFcL/nFxPHao79g2hdeTajYI6s8vY4DV2cHzpno=;
	b=asF8hNJZk/XCfCegXXchZDBPtgbdHxXTmUhlLy4v2rwC/KLfW+iJhhEtyzbFpbmFhlZgfH
	vq1ILKrqCs+3NhRB8iaKLjqs1ovhSXE2j6ZtJoa5D1O+QtweTjQSGzeaf4RRtZbJorDEYH
	QI+K6yhj575Ru2ee8/Cto8lNTXXCsjwzRxCD2Lzok8IneOVCqamR3bLwkQU9XM3wwyuyKO
	Lvr0s38FACafT0t62N16UKmcBtCVP1jd9MfesmQ9aviV18JVr3w+NaqDYz5hjrwG3Jqx4P
	/hZ9uFTvv7SDTgWtNjNtx+0pMnVdNiKxPEmnFxS3ozrpjBvUc9/ynpjrQLPClg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKFgSFcL/nFxPHao79g2hdeTajYI6s8vY4DV2cHzpno=;
	b=Kul7DWITslhGGvYi5PjhgZlQd2DDbBYI7WW1W6q9kcsZJldcz7eE8Zx2ezlxQtKcOTdaTY
	zj6Mlx+oL1T0XXDw==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 06/15] arm64: debug: remove break/step handler registration infrastructure
Date: Mon,  1 Jun 2026 12:25:45 +0200
Message-ID: <20260601102554.233076-7-bigeasy@linutronix.de>
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

Upstream commit d4e0b12620946a4011ad695490211fc38bf5cb42

Remove all infrastructure for the dynamic registration previously used by
software breakpoints and stepping handlers.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-6-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h | 24 ----------
 arch/arm64/kernel/debug-monitors.c      | 63 -------------------------
 2 files changed, 87 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/a=
sm/debug-monitors.h
index 3eeea1c9f0666..5319da0f0ca4e 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -62,30 +62,6 @@ struct task_struct;
 #define DBG_HOOK_HANDLED	0
 #define DBG_HOOK_ERROR		1
=20
-struct step_hook {
-	struct list_head node;
-	int (*fn)(struct pt_regs *regs, unsigned long esr);
-};
-
-void register_user_step_hook(struct step_hook *hook);
-void unregister_user_step_hook(struct step_hook *hook);
-
-void register_kernel_step_hook(struct step_hook *hook);
-void unregister_kernel_step_hook(struct step_hook *hook);
-
-struct break_hook {
-	struct list_head node;
-	int (*fn)(struct pt_regs *regs, unsigned long esr);
-	u16 imm;
-	u16 mask; /* These bits are ignored when comparing with imm */
-};
-
-void register_user_break_hook(struct break_hook *hook);
-void unregister_user_break_hook(struct break_hook *hook);
-
-void register_kernel_break_hook(struct break_hook *hook);
-void unregister_kernel_break_hook(struct break_hook *hook);
-
 u8 debug_monitors_arch(void);
=20
 enum dbg_active_el {
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index f929b107840de..a28482e25c4c3 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -159,46 +159,6 @@ NOKPROBE_SYMBOL(clear_user_regs_spsr_ss);
 #define set_regs_spsr_ss(r)	set_user_regs_spsr_ss(&(r)->user_regs)
 #define clear_regs_spsr_ss(r)	clear_user_regs_spsr_ss(&(r)->user_regs)
=20
-static DEFINE_SPINLOCK(debug_hook_lock);
-static LIST_HEAD(user_step_hook);
-static LIST_HEAD(kernel_step_hook);
-
-static void register_debug_hook(struct list_head *node, struct list_head *=
list)
-{
-	spin_lock(&debug_hook_lock);
-	list_add_rcu(node, list);
-	spin_unlock(&debug_hook_lock);
-
-}
-
-static void unregister_debug_hook(struct list_head *node)
-{
-	spin_lock(&debug_hook_lock);
-	list_del_rcu(node);
-	spin_unlock(&debug_hook_lock);
-	synchronize_rcu();
-}
-
-void register_user_step_hook(struct step_hook *hook)
-{
-	register_debug_hook(&hook->node, &user_step_hook);
-}
-
-void unregister_user_step_hook(struct step_hook *hook)
-{
-	unregister_debug_hook(&hook->node);
-}
-
-void register_kernel_step_hook(struct step_hook *hook)
-{
-	register_debug_hook(&hook->node, &kernel_step_hook);
-}
-
-void unregister_kernel_step_hook(struct step_hook *hook)
-{
-	unregister_debug_hook(&hook->node);
-}
-
 /*
  * Call single step handlers
  * There is no Syndrome info to check for determining the handler.
@@ -264,29 +224,6 @@ static int single_step_handler(unsigned long unused, u=
nsigned long esr,
 }
 NOKPROBE_SYMBOL(single_step_handler);
=20
-static LIST_HEAD(user_break_hook);
-static LIST_HEAD(kernel_break_hook);
-
-void register_user_break_hook(struct break_hook *hook)
-{
-	register_debug_hook(&hook->node, &user_break_hook);
-}
-
-void unregister_user_break_hook(struct break_hook *hook)
-{
-	unregister_debug_hook(&hook->node);
-}
-
-void register_kernel_break_hook(struct break_hook *hook)
-{
-	register_debug_hook(&hook->node, &kernel_break_hook);
-}
-
-void unregister_kernel_break_hook(struct break_hook *hook)
-{
-	unregister_debug_hook(&hook->node);
-}
-
 static int call_break_hook(struct pt_regs *regs, unsigned long esr)
 {
 	if (user_mode(regs)) {
--=20
2.53.0

