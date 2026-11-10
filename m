Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335981;
	b=IbVZ9dOnce7rV5GjhKQI6ezt2sQfaTETXj1cpC2MPNAMtcKvLCYUhFkFyMXVgNdnQyyO
	 pAjuZSZwMzL6vo+6WiO/d4hHnIBPDZKTEMFUIf6e9dWZmnpQW9RgJOAJ4XH7I94swxAe1
	 nzCYgh0DMEur/7c4/VqdukYMmNDPGO2IzbaB4lOMgsOzlbFfOtHA6sMfa67ZyqDrBvdQK
	 yCchIgwIDvVIyCoAs92RsSB12F808hKUJ6k17THMJ83Mh1+NohYUk2AM0zgfo2H70mAKm
	 bTDnMmYmyvqtracq42pSU4kpP2wZleQuIGacDrc16pSQjfXMzxwPxFN/nkLp5B2BBXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335981;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2cWMqfj6UqmpO5lP97vfc+Yrj9XmSBRxTjRD6pc6nys=;
	b=PXd6o9a4h4ZRkTev26QaSI4D2oL1nWcHKyU0cnpjN0lOPWZamWkE6bAnn7rzG75iY+ia
	 QP9xdEM0NAAyYONqNRAITSiMNNL1EQtHZ2oxBEET+JWTpkdicWzdHB0qnKGhpupMG3xW6
	 dAwjw0fnbuwZzsQYHTCKKl+RMQl+MxpF22O5mPFNy4mEw0HAyci1KGFxHnHOgyq3rhyxX
	 QbSBDnL5HEOEhI4ec5sPtQelj5ay8Qix39F8R9aLX8TZ/IGG5s86pdjCdYzqaZu9CgMUI
	 Sklpxa5Mj1pHItuiKshA4vjc+4mEIBfhos+HAlF265i6GBYU3wBRato16AQqYPUi9Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqR5w+wS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11DF60A2610
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqR5w+wS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51E51F0089F;
	Tue, 10 Nov 2026 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335980;
	bh=2cWMqfj6UqmpO5lP97vfc+Yrj9XmSBRxTjRD6pc6nys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CqR5w+wSw4t4XIgdjdNi+vXYszJfqV6gfmstdLusqZimnKwpgnUGwYZEXCL81taw7
	 OxQOENeMO+pV4qwhpGV7Ny+sI44U/2Xw+K+rtWIMq7RO296tqK+RnELuCNevNhQPFu
	 KyS2FyQ2PVLnT8VPg74OGLHOjNzEtS+968dnnvN+aiFT0HaXpdMV1Fapyx4kZUDWOg
	 ifC4gu2mJ5jAzcTyeSlW6o5nT/drbJgSjKmkyOrmYxI2Ed7bkMcGxXyeQp5xRSz2Hx
	 YvBuCJkyA0b+BKsiYvYeEyUsgnfNxPprXFDAzDbhMvFynYk+I2W9AE1SggnWYH1fID
	 lVYAsPkoKZ4cA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] irqchip/atmel-aic[5]: Disable interrupts in the irq_pm_shutdown() callbacks
Date: Tue, 10 Nov 2026 13:39:38 -0500
Message-ID: <20261110183723.3302809-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054944-failed-6.1-0ca21fe11145@kernel.org>
References: <20261107054944-failed-6.1-0ca21fe11145@kernel.org>
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
[ sashal: replaced scoped spinlock guards with explicit irq_gc_lock_irqsave() and irq_gc_unlock_irqrestore() calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-atmel-aic.c  | 5 +++--
 drivers/irqchip/irq-atmel-aic5.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 4631f68479537..120ec1ae95d7b 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -126,11 +126,12 @@ static void aic_resume(struct irq_data *d)
 static void aic_pm_shutdown(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	irq_reg_writel(gc, 0xffffffff, AT91_AIC_IDCR);
 	irq_reg_writel(gc, 0xffffffff, AT91_AIC_ICCR);
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 #else
 #define aic_suspend		NULL
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 145535bd75605..61636866b4916 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -224,15 +224,16 @@ static void aic5_pm_shutdown(struct irq_data *d)
 	struct irq_domain_chip_generic *dgc = domain->gc;
 	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(domain, 0);
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
 	int i;
 
-	irq_gc_lock(bgc);
+	irq_gc_lock_irqsave(bgc, flags);
 	for (i = 0; i < dgc->irqs_per_chip; i++) {
 		irq_reg_writel(bgc, i + gc->irq_base, AT91_AIC5_SSR);
 		irq_reg_writel(bgc, 1, AT91_AIC5_IDCR);
 		irq_reg_writel(bgc, 1, AT91_AIC5_ICCR);
 	}
-	irq_gc_unlock(bgc);
+	irq_gc_unlock_irqrestore(bgc, flags);
 }
 #else
 #define aic5_suspend		NULL
-- 
2.53.0

