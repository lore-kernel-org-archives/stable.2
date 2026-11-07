Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048586;
	b=5HojV0gxO5CjLMT4y1GsWjvr1ALBR5DeS4H+FdV1IpSD/5prRdShMaVoKbLskD6FksWt
	 5xVO6L1vVM5VkIFHNDQdeufgDHVsJva/rxcQ7ndX344T5sxsJ781KZJq4F8C8J+sNe5/l
	 2OUqSc/X32Ee6tyTMp4h1tsv3tRTSiNzZYksqhTpuS7UjKK9Wl8Y2XYlyn3ZDEeDb44Y+
	 xk7cX9tVyGK1bDh721WcmIeBZnZoUwvPBXouZlh7mFhgp9h52O9Bbjv9Sk+jFlLEL9El1
	 qxFEaKEgI9XokoOhuIr9dO5csxRY20lsMBdpBDCpOsCWAp93jxE9YCEBCXY9i5zR+ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048586;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ggtp6QSwtoMkYVJh5THjVyMVmaRlyVoJBcoTbXLANJs=;
	b=yHwTjABJDWuftCY3LGErp6nLgtGwJPKEbRl0wDB9xErPwa1dV5vgEvqVkkEywFvtX/zR
	 KG1HSlVqZ0PwCoRWoOJ3fKqripj/CWJboRu5KP0ri+Ga2EOseBhr6L2Fe+ZCQ6AQfTgw0
	 eDR9L94Ug5y+K3+ju/WK4/Rt3xMi5YeVtzhk4FUkRvblbA60N5//w5Bao0HfaKIb7wU+7
	 8AgeNWi69mtzDqkTe//+G2Bh2rWlXdptWXN/kywjsd0NOjMvWOEUENfLQY6Ul+TzOWJhz
	 HSbRgu+bbaf+8DEyDXRY+KfkIZaXG1LJUCbzh9LxKqHjj6Cfv+ibJHIcSbj2sdn556g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asfTTUhm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3AB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asfTTUhm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A86F1F0089F;
	Sat,  7 Nov 2026 10:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048586;
	bh=Ggtp6QSwtoMkYVJh5THjVyMVmaRlyVoJBcoTbXLANJs=;
	h=From:To:Cc:Subject:Date;
	b=asfTTUhmbRkj/sc97uW4rqYBQWZtZVzguaJFjTDmZtJHQcnHqqfQ9gv/olj5DzZF2
	 4e3dfPWyQ7aBWPJYz+cKQMOoOEeoYiWtBIDHU+A77pRfqjuHhIrOYoHXl7gFs1JDRp
	 QplByZ4OSQUT0r/GbNX1/E+JWtrsAKpAjBWHvWT5hV0ncKGGvyZfMe4EXoPVZKbZkb
	 VpldcfTVutzKJSlaAZCKUyzULzGTEvCFCcFYF4xKveowvZR1ERtPo7T0u4LHx0G/Xi
	 9DfHfVneKT8CyS+UPsqG+OL087fbuFvDBHG8AqOmHTfNRJc9qxY3JX8C7qJdaEg9EW
	 LHrBAP+DF9zQg==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	tglx@kernel.org,
	radu@rendec.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] irqchip/atmel-aic[5]: Disable interrupts in the irq_pm_shutdown() callbacks" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:44 -0500
Message-ID: <20261107054944-failed-6.1-0ca21fe11145@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0ca21fe111457c843624a835641bb490e704bb2f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054944-failed-6.1-0ca21fe11145@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0ca21fe111457c843624a835641bb490e704bb2f Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Sat, 26 Sep 2026 02:41:24 +0200
Subject: [PATCH] irqchip/atmel-aic[5]: Disable interrupts in the
 irq_pm_shutdown() callbacks

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
---
 drivers/irqchip/irq-atmel-aic.c  | 2 +-
 drivers/irqchip/irq-atmel-aic5.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 1dcc52760ecae..4a7935e75e4dd 100644
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
index 1f14b401f71d0..07a317ed06ef4 100644
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




