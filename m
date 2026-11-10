Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334701;
	b=Y+JFeasTSh8AE7/sEI4lnSHB3Pam2S+Od6ml5TCwykeEz9af2VCXIsX625xjqrnyu9QY
	 Pe4W8cWSZeIS+x8YRN0BYKlFSxNZOv2C9Lo/b1YVYiCavN1Ari7OYWe21KDfb0QncFeQD
	 ex2FPVfy9Xar/HGzrd7WvCWpiW4OPV1TQiFKsGGEjRN+uAjbkXn7kEnjnFxouVnTwNjQu
	 jlbZhaij3c/S7pNoMC51xlgT42CElNN/Il1fuIx+OtTPmuqYe1fwzsSSEU5n5p0pfBlH0
	 BfYP+KG703HTZwCur5TU3PaaBsVIQTzo28fPM0AeO4bfacE/nlS33eXmiDzuagrUm+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334701;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7XnCyax4/xxPFFGkM4nlj1eWMzelUaJbMNtRO1z9aos=;
	b=GI8rDI0AjUYQFbQZpaHu+zXnUKoZ/BxoL3opwa5gUJW+YkixU8d36BaFDwjMKkpXQkDt
	 XtK+ig8yH6oELbBCgAXxLpv9AEm30dyOGuvYRlRK8XyflorCO6syyHUkoqQsWDLT4qR9q
	 +q7C31x4Mp9Qh7AKWXfKIAHIGWLmR0v4iXbvD8Il4/YTJKo3AHCDwI9n6Jjq8kGiD0aEj
	 pLiyGTK/+dmNSnIRn56mA/kxdeaAFRS45qdtj3PKBW2NlJrrgV5COPNPBYCp66mSrF7Il
	 6m2maDlDuttMJCTuA1vHmcz7OOui0/6iQsEDl3vtGIyG03eSVK6f5rH5JEanzcDYgVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J40Sd2gA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75C606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J40Sd2gA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7981F008A5;
	Tue, 10 Nov 2026 18:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334701;
	bh=7XnCyax4/xxPFFGkM4nlj1eWMzelUaJbMNtRO1z9aos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J40Sd2gAe93lA9mXWejL8kZ/6vtYeUq5YlWH5P2/AFb+XckTzW47iPLNj+H57dVPy
	 hhxcssQ5P374aJq3eIqhQf7AKfO1QlKPQ8tVDknf604K4PMpMoc/e/0g0uthaH2iAD
	 cye8K3wIZsU/1egvJls+RWXZAR47g0XdvxgAQcbkJk3o8Y2dtUqul1qs1ZjIfYh7zi
	 6/wkmK+jTYbyQ3Yy3CKPXNMAAFpyJ8BizKZBqZGGuArDXQELqCkQp4eAO4KhSca/Fe
	 S38k4Crsjaf5ynS45xZMaoVLKoe9jhvfF4FvtkoJULCaedwnQtPtHGFcyByL+6L1Lk
	 NgkGfNhEh/kSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] irqchip/atmel-aic[5]: Disable interrupts in the irq_pm_shutdown() callbacks
Date: Tue, 10 Nov 2026 13:18:18 -0500
Message-ID: <20261110181810.3128146-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110181810.3128146-1-sashal@kernel.org>
References: <20261107052300-failed-6.12-0ca21fe11145@kernel.org>
 <20261110181810.3128146-1-sashal@kernel.org>
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

From: Karl Mehltretter <kmehltretter@gmail.com>

[ Upstream commit 0ca21fe111457c843624a835641bb490e704bb2f ]

irq_gc_shutdown() calls the irq_pm_shutdown() callbacks from
syscore_shutdown() with interrupts enabled. aic_pm_shutdown() and
aic5_pm_shutdown() take the generic chip lock with raw_spin_lock(), and
irq_gc_eoi() takes the same lock from the interrupt handler. An
interrupt from the chip while the lock is held spins in irq_gc_eoi()
and hangs the reboot.

Lockdep reports this on every reboot of a SAM9X75 Curiosity board:

  WARNING: inconsistent lock state
  inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
  busybox/101 [HC0[0]:SC0[0]:HE1:SE1] takes:
  c1c2b434 (&gc->lock){?.-.}-{2:2}, at: aic5_pm_shutdown+0x34/0xd8
  {IN-HARDIRQ-W} state was registered at:
    ...
    irq_gc_eoi+0x28/0x60
    handle_fasteoi_irq+0x120/0x214
  ...
   aic5_pm_shutdown from irq_gc_shutdown+0x4c/0x58
   irq_gc_shutdown from syscore_shutdown+0x5c/0x9c
   syscore_shutdown from kernel_restart+0x34/0x78
   kernel_restart from sys_reboot+0x180/0x25c

Use the irqsave guard, as
commit 33517881ede7 ("irqchip/brcmstb-l2: Use _irqsave locking variants in non-interrupt code")
did for brcmstb-l2.

Fixes: b1479ebb7720 ("irqchip: atmel-aic: Add atmel AIC/AIC5 drivers")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Assisted-by: LLM
Reviewed-by: Radu Rendec <radu@rendec.net>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260926004124.88221-1-kmehltretter@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-atmel-aic.c  | 2 +-
 drivers/irqchip/irq-atmel-aic5.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 03aeed39a4d29..c5f9b4adc1a7c 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -123,7 +123,7 @@ static void aic_pm_shutdown(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 
-	guard(raw_spinlock)(&gc->lock);
+	guard(raw_spinlock_irqsave)(&gc->lock);
 	irq_reg_writel(gc, 0xffffffff, AT91_AIC_IDCR);
 	irq_reg_writel(gc, 0xffffffff, AT91_AIC_ICCR);
 }
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 548ed1518fda7..516538f691ca7 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -217,7 +217,7 @@ static void aic5_pm_shutdown(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	int i;
 
-	guard(raw_spinlock)(&bgc->lock);
+	guard(raw_spinlock_irqsave)(&bgc->lock);
 	for (i = 0; i < dgc->irqs_per_chip; i++) {
 		irq_reg_writel(bgc, i + gc->irq_base, AT91_AIC5_SSR);
 		irq_reg_writel(bgc, 1, AT91_AIC5_IDCR);
-- 
2.53.0

