Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50E839A4D6
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309568; cv=none; b=G6Dq5aB4+0uZBoPJbmOIapZ07Dowglc0Gl0816WMoNl9iQX1f7EcKylwWIZb6VksCYpwbunir1AbD30jk1WBdfNWincKndq99oEoGMQMrhU84Gdtvt2Mto8YPFMxh503MhRgzr5qiE2NaZJZxlnz6Gug7WS0fXvbEccjTFJetTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309568; c=relaxed/simple;
	bh=EdRF4ZEM5zeTzjuHsikGBqD2glsBuO5ZlCHh50uSSxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SM15dRmhzF+XWGUdXCZGQJsiLPRb4ikvxNArwxG53BPpB4d4Rhjg0YkGQioNnTryo+iOjpzCnZ16/3KZXPR8vkwhQye1ECsMjxlN3V1/LNjP1rZ7ZBH8M0PWhjszadW9m8TjldngiLPo3/zY74neME3iXBMvh+18H0ucYzidKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fIz7NH0G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I1mLlmmy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fIz7NH0G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1mLlmmy"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r62GPuQUrKZ5MZJ2iR6jBJvEt1iUjLhZL1qFgG58WEw=;
	b=fIz7NH0G8WKLwGqJzFCurYoKKhd5RXfolNzONHJIRelF+pcr5n6e32zzaHyT23CIT1k9b4
	RsQt0ittKfVNwz+8KlOYryEOKh5miPaZncCWBhvD9TqL+CFQZTLJzBnIeIR7cNaOZ1yS1o
	bxBcifgzbYI8gVjSak8PnC1hzMW4iU8+oSZbBcKd1Cy2G3O8Ea8dfyQnUV2h/uLud/Skzp
	sOfkZqo0PlzqkHv2dKQtOdYamWGjGtjacSwFhu3HJdIJ6NeypvCqAcnN85SZUAe0G4ZwDM
	TB+A7W+I7U8T/1l6dDmCDEGkTWC6olQE3SLgV2x1lDOQ8woocsSBtlECQh72LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r62GPuQUrKZ5MZJ2iR6jBJvEt1iUjLhZL1qFgG58WEw=;
	b=I1mLlmmyJAt+WnCTSFcfp4QOTvfXOfd8ROKyxWS3LAg5SGNg8+Ld4500Z2yr6qLQuZ9QK0
	OUAoAg2fWpwJwzBA==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 15/15] arm64: debug: always unmask interrupts in el0_softstp()
Date: Mon,  1 Jun 2026 12:25:54 +0200
Message-ID: <20260601102554.233076-16-bigeasy@linutronix.de>
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

Upstream commit ea0d55ae4b3207c33691a73da3443b1fd379f1d2

We intend that EL0 exception handlers unmask all DAIF exceptions
before calling exit_to_user_mode().

When completing single-step of a suspended breakpoint, we do not call
local_daif_restore(DAIF_PROCCTX) before calling exit_to_user_mode(),
leaving all DAIF exceptions masked.

When pseudo-NMIs are not in use this is benign.

When pseudo-NMIs are in use, this is unsound. At this point interrupts
are masked by both DAIF.IF and PMR_EL1, and subsequent irq flag
manipulation may not work correctly. For example, a subsequent
local_irq_enable() within exit_to_user_mode_loop() will only unmask
interrupts via PMR_EL1 (leaving those masked via DAIF.IF), and
anything depending on interrupts being unmasked (e.g. delivery of
signals) will not work correctly.

This was detected by CONFIG_ARM64_DEBUG_PRIORITY_MASKING.

Move the call to `try_step_suspended_breakpoints()` outside of the check
so that interrupts can be unmasked even if we don't call the step handler.

Fixes: 0ac7584c08ce ("arm64: debug: split single stepping exception entry")
Cc: <stable@vger.kernel.org> # 6.17
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
[catalin.marinas@arm.com: added Mark's rewritten commit log and some whites=
pace]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/kernel/entry-common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-com=
mon.c
index b98d6d1a1dfd6..ea3876d99c2ec 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -796,6 +796,8 @@ static void noinstr el0_breakpt(struct pt_regs *regs, u=
nsigned long esr)
=20
 static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
 {
+	bool step_done;
+
 	if (!is_ttbr0_addr(regs->pc))
 		arm64_apply_bp_hardening();
=20
@@ -806,10 +808,10 @@ static void noinstr el0_softstp(struct pt_regs *regs,=
 unsigned long esr)
 	 * If we are stepping a suspended breakpoint there's nothing more to do:
 	 * the single-step is complete.
 	 */
-	if (!try_step_suspended_breakpoints(regs)) {
-		local_daif_restore(DAIF_PROCCTX);
+	step_done =3D try_step_suspended_breakpoints(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	if (!step_done)
 		do_el0_softstep(esr, regs);
-	}
 	exit_to_user_mode(regs);
 }
=20
--=20
2.53.0

