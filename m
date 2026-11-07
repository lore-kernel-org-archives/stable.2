Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049614;
	b=zCL/9MfSZUbKn3lIlekg0KZY9lyOZ6nGGIgWjTsoJhRGXsRM0QH+SEM9/idzdgyUROU6
	 hhjEzpdBn1igVhP2rHjEOOTYhX9XHqq1P0YhxyBhkVCHzu/DSxl7GHoSsl+JrxVwxUkoP
	 Z27ee2uQqMPayOWkNXe+4e1WNAXrxzb3Dk5F9Qioaf9XIwfPTwhVfUJAts6DzajSWF2se
	 bIZBo5k+DuJq6X/F4ZAYBJ7F6xwEkkk0IiajzahyHlx+yt/eB3l9Oy+8EsBB1mtbFiFAi
	 kODuenYaaUn1MgmYj45KUHDRImaIrxpLVUIIRUECz7UCSHvtWUCogWm2ae5esScaJTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049614;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AqoGru6uQgzgSEcu/viJaJmee2AduNGr/q2pV0ReuUk=;
	b=SG/iTUmHJ7jlF6dJfygciM76MwBS7h7y0D08W6A32hgBSHmbTbWAjc1PVToRxsSsVrym
	 MXGCvbnK1xMji4sSfH0qr8kIX45irhIBQJEPEj615suyyVUM9SZfTGFZT4QX/2VcGBkuf
	 12DOzL8AG+fLCP5uGDpAxcAASAQPtVY8MpVYTA1yS0Qe2CuTxZFUb9YXKBI28FZYEC7DC
	 A5QrJxAXmUtsR7z31uuHzqz3KmWKUKy3WJU09gXmnVxTyRVXPsuVq87dry4SE3bsNFO2t
	 GqGZg55kx7PFYtNQiqizDa+mhbDreqs7mKfPpbBG6sRyaI94tq7qOYYVWKjlobh/k/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gV7zeNU8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC5606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gV7zeNU8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D97C1F008A2;
	Sat,  7 Nov 2026 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049614;
	bh=AqoGru6uQgzgSEcu/viJaJmee2AduNGr/q2pV0ReuUk=;
	h=From:To:Cc:Subject:Date;
	b=gV7zeNU8HJEOAzumUm+T7GgmUgfC6ZyBHvwStNSoaHj6xOfBY0h0qWHRz4FEUDhFA
	 a55SuNpTRpAKttYoU0Zy6q0Vr/z7hQRtC2ie0q0smTjl97luJldnuAlfKjn1+MtafG
	 9bnuKxvuLSa6ffO4ulZ6HwDBFCO4Oss1J+29OF+RGIkExshbR973APj3PAXX6iHY+2
	 JGJ8fGFRrwy1UUWPFJD3sG7uE5D7alhWdz3sYUrekdRv9mlXEttZoaZtom+l9IV/Wf
	 SokzdRCci/hCWtXNY71wh84wfoH/6mjtQRZpyMpzYU2sKHfkbItatyofaHmkMY6opb
	 Il2O+c1DxwUjQ==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	tglx@kernel.org,
	radu@rendec.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] irqchip/atmel-aic[5]: Disable interrupts in the irq_pm_shutdown() callbacks" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:06:52 -0500
Message-ID: <20261107060652-failed-5.15-0ca21fe11145@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0ca21fe111457c843624a835641bb490e704bb2f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060652-failed-5.15-0ca21fe11145@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




