Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35A486430;
	Thu, 15 Oct 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058448; cv=none; b=QHUbpsfKFDnhNvxMej/u0FCjkF0cMFKRehWZdEAVGUAZzshL1ts9nKP2b2Zyl+9egH0MGA/JbAewdtQYj8DzMR6POfgXAE6dGuvwcxL/ecJPxuot2aH7jFDpEzar3KvD1RAk9XbpO3+FREYo6bZcNnj8W7H+hExoVmFn92j5GYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058448; c=relaxed/simple;
	bh=qyT+GWnOgIbM/kTPtc7t6qJ6PLgnoI8u4KNA4gegbl0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g7jd1wOmNzilUT3Ae0GbrZNxMlUcAcMomyRf9UYf/MFQiQAagP4VaIopWrcAfRawQEE4OLvbP/CiIkssrICqMm238IPwj3gLq5ulUR3L4XISLcmHTrwM6nLi2uDddcvy2AdMfSSEGfSt03a49bgDO1MJq8Ju9lkxRcz8DYma2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ytHvQbiq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AvTM2nXr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ytHvQbiq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AvTM2nXr"
Date: Thu, 15 Oct 2026 10:00:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792058438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BHiFOfpjtXTsxEmjjuBd/Sm9w6WJ7WJcANWvibo74c=;
	b=ytHvQbiq679kNG312vj3zelRyfWpu5GnTjLrfOqBP1sUKasa6LazD5xso4YDammVWQYrfC
	0a+WsJz7wmYk9nTUdxYz+qn1VuBsjpRVyqMpyIDuzlxUXEiqv3QgexipOb2YqX5Eqr0lSO
	kGgA5B4bI3ULoh2ACHgz7HyrlOa0VJA/B0l0WBPrnR2PyUVWEI5FgmP9rFvrtpobxM1gh+
	+1TYBvT0JAkyRsEyffnVR9Y0A2kOkXmCR8O/QSfdJUky/LU2oKgH63wn4FgjI6I26BAvK6
	Gh142wEZKkgCYp9QgDfMrE2H8S+CWvokzTw9FY8J4zu7niyikNx2BfoL37pAlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792058438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BHiFOfpjtXTsxEmjjuBd/Sm9w6WJ7WJcANWvibo74c=;
	b=AvTM2nXrIkeZEWGtykuZRY1i8vGAaVCa91R6AHfy53mfQVh0pQ/w1EZzTmRNNXcaCf7Uyi
	WoxkVu8DhdaMNOBQ==
From: "tip-bot2 for Karl Mehltretter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/atmel-aic[5]: Disable interrupts in the
 irq_pm_shutdown() callbacks
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260926004124.88221-1-kmehltretter@gmail.com>
References: <20260926004124.88221-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179205843670.2666988.14590268030733717470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     0ca21fe111457c843624a835641bb490e704bb2f
Gitweb:        https://git.kernel.org/tip/0ca21fe111457c843624a835641bb490e70=
4bb2f
Author:        Karl Mehltretter <kmehltretter@gmail.com>
AuthorDate:    Sat, 26 Sep 2026 02:41:24 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 15 Oct 2026 11:59:22 +02:00

irqchip/atmel-aic[5]: Disable interrupts in the irq_pm_shutdown() callbacks

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
commit 33517881ede7 ("irqchip/brcmstb-l2: Use _irqsave locking variants in no=
n-interrupt code")
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
index 1dcc527..4a7935e 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -123,7 +123,7 @@ static void aic_pm_shutdown(struct irq_data *d)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
=20
-	guard(raw_spinlock)(&gc->lock);
+	guard(raw_spinlock_irqsave)(&gc->lock);
 	irq_reg_writel(gc, 0xffffffff, AT91_AIC_IDCR);
 	irq_reg_writel(gc, 0xffffffff, AT91_AIC_ICCR);
 }
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic=
5.c
index 1f14b40..07a317e 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -217,7 +217,7 @@ static void aic5_pm_shutdown(struct irq_data *d)
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
 	int i;
=20
-	guard(raw_spinlock)(&bgc->lock);
+	guard(raw_spinlock_irqsave)(&bgc->lock);
 	for (i =3D 0; i < dgc->irqs_per_chip; i++) {
 		irq_reg_writel(bgc, i + gc->irq_base, AT91_AIC5_SSR);
 		irq_reg_writel(bgc, 1, AT91_AIC5_IDCR);
