Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046982;
	b=hvj/eH7WXY4qukwyp2cp2QsZkRPdCpOsGHv+ZntcFNB7MGttHQLLnA2wjWUF/OUzPjP0
	 zddl7gHaFacifB//csRxrUXH/OlV3n6JALo3kfwTQlxNvOmFmPahAQpEofCAgOoz3YWj/
	 022XFDB6eoiHP4fMT8TCiw2UJOCqKAjOC5SXSDey3UpWvOW9/4r1WMGYh/RVRBOFDVFNd
	 aUFBsUVf+rZBTcJ/kpZUgpeOdxTAs8n0tyDwxZ5Kmvq4K3gJTW4dcJoNZSWDhVaq/xJjz
	 nDCNjx2rpGeQwUQzhg9AWziuuW9dATqwoZLMlh7MennCvIgcc3p3H9JaW4DpK3h6vpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=n/yXD6rf7y20+r/3La4F6aV1S7FsbHeczw64Mw0MC5k=;
	b=rx12xUJZgDl2mhumNnoemp4PLlrSAA39qHBpFoAdfB8A8It/2sf94t01gn0ePP8n1Qn3
	 rUiz7jeZPCwdKfKrSLjzLPfhnimjkHpw0NjfOh8qxKZuNn6RxEIQ5JxnTUegkXX/4e7LC
	 8/4Ay19ecqpCKndraiof2sqV9p8dACBiRTLtCT5RC5Ni4UvD3Gnywm3Y2OVIaL+0hl9Ep
	 XR1F97ZTM8tpdk24NfmDZbuktr+jp1EF6KjoxGjNyH2SH6LJmf+ybZEICSi1kFkKRY3hu
	 xtIcAJEORJRszZT1Tpt6UlxMSY23FgDWrPoyWx0RvcabYkGSnlnA2z8YXplK8suyr/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ni+Sp/yg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D320606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ni+Sp/yg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53A51F0089F;
	Sat,  7 Nov 2026 10:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046982;
	bh=n/yXD6rf7y20+r/3La4F6aV1S7FsbHeczw64Mw0MC5k=;
	h=From:To:Cc:Subject:Date;
	b=Ni+Sp/yghYm2bEh4F7+a86l/9ZmlHqSVaUuoN5C/cMDLrtZbYsdxTU5/Z0EFZ3Las
	 80E5KeqJvF8fDuXI2O1Ou4oG/lZwHryZk5qJsnI8HbhVKpp+hMMVxEziwj/0ZKFj1l
	 EQfkAnrEBPv74jZGETg3VgVe2JNcRwSTgsO8b5cyFt5Wqb6rOJrua7MJpxQ16vzAkT
	 vcJCYOE9lqKyQgv8y6CFtanAZOzIi5rCLJVoBPayZa9b6AGwMQNqDDy4+XooPSQO9f
	 a9YL/aChl8m/Tn0KKIV2zhxsyAkiVEh8AgH1KKdlrPPvCAh9/JP3c3EzUnRJj4mtUS
	 B3Itg9HlPNLeQ==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	tglx@kernel.org,
	radu@rendec.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] irqchip/atmel-aic[5]: Disable interrupts in the irq_pm_shutdown() callbacks" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:00 -0500
Message-ID: <20261107052300-failed-6.12-0ca21fe11145@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0ca21fe111457c843624a835641bb490e704bb2f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052300-failed-6.12-0ca21fe11145@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




