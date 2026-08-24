Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09F339362
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583667; cv=none; b=A1UpP3703qrVRCPmqL8nBS+znKvOQ71Wf9NkuEg42XgBY7nAQHDdDjLgV2g+BnoAt/91LU1e2M3vaXxsu8NSj4+xg//jQd47gU4I0eRgOnrPe7U1ERX5QoSM5PQheE19oJapuF6uFgviolSEdL5cQP8Q5hN7u3BrW8c/wd7quos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583667; c=relaxed/simple;
	bh=tBzUE92F1UI+RsPPNKKP275VBgDpV1JIcXgRkOkNziU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gek16f1++sAGh5qfYW5Kl0Mtp8MB1W9AGlmmSYPOjA84Id9Plppy350ITniLTWm1WssLLB4fYSLRPfIyH8jhCtSS6MOPBVCFjSufsHe4N7a+RSNzQsl0V68Klzge9BionO51oQDnVGxa0IkFefrIfjuMg5pmDnrCJhjHtUOig2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8rT6hhn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8rT6hhn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66961F000E9;
	Mon, 24 Aug 2026 15:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583665;
	bh=lSKLeWU7uSnVXGeFvlVHjMv21qdDC5nWdgdCAxlMM9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R8rT6hhnc3UKn9pDkj5G61P/CAn5s9CLED5XNkzfcQHWpHWuhjRiUABSkzxlw97i/
	 LHAa6uwCxN3R22k0u/W50pSEMObxUAnpXzo4S2oLz3DGbotS1g/oxfm53zFF5mAWFM
	 gwbsTTX5SNTw07xXsvZOpIC7zc4fiP4+q0Y6r3HlnCSFv7B79Tcbm83Q91AdhTboOK
	 hOaELj39qmKRCQdtK5PmIJ22ehDfDhF8Jyuw6rL/SylUR4czr/Xpf7IS12ROXhYm7D
	 36qYFCLHbGITp+ladGSWnIcpQdhp9Qj8kdSk31kf6v6AqZkFHwjP5/mF9wKGFQaAdD
	 qdTo3dk5HvGCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junjie Cao <junjie.cao@intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] gpio: ml-ioh: use raw_spinlock_t for the register lock
Date: Mon, 24 Aug 2026 11:01:03 -0400
Message-ID: <20260824150103.3723586-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082012-sessions-framing-5b42@gregkh>
References: <2026082012-sessions-framing-5b42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junjie Cao <junjie.cao@intel.com>

[ Upstream commit 600411ea1f2443fdf5b1af9b6480f616d7aff9d0 ]

ioh_irq_type() is registered as the irq_chip .irq_set_type callback and
takes chip->spinlock with spin_lock_irqsave().  This callback is reached
from __setup_irq() -> __irq_set_trigger() -> chip->irq_set_type() while
the caller holds desc->lock, a raw_spinlock_t, with hardirqs disabled.
That context is not sleepable, but on PREEMPT_RT a regular spinlock_t is
an rtmutex-backed sleeping lock, so acquiring it there is invalid.
ioh_irq_enable() and ioh_irq_disable() take the same lock from the
.irq_enable/.irq_disable callbacks, which are likewise invoked with
desc->lock held.

Convert the register lock to raw_spinlock_t.  The same lock also
serializes the GPIO direction/value callbacks and the suspend/resume
register save/restore, and those critical sections only perform short
sequences of MMIO register accesses (ioread32()/iowrite32()); the
.irq_set_type callback additionally emits a dev_warn() on an unsupported
type.  None of these are sleepable operations, so keeping this register
lock non-sleeping is appropriate for the irqchip callbacks and does not
change the GPIO-side locking contract.

This is the same fix as commit a02b8950d619 ("gpio: pch: use
raw_spinlock_t for the register lock"); this driver shares the same
structure as gpio-pch.

Fixes: 54be566317b6 ("gpio-ml-ioh: Support interrupt function")
Cc: stable@vger.kernel.org
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260731032747.2987292-1-junjie.cao@intel.com
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-ml-ioh.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index 53d4abefa6ff2..d98c761b0d709 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -84,7 +84,7 @@ struct ioh_gpio {
 	u32 gpio_use_sel;
 	int ch;
 	int irq_base;
-	spinlock_t spinlock;
+	raw_spinlock_t spinlock;
 };
 
 static const int num_ports[] = {6, 12, 16, 16, 15, 16, 16, 12};
@@ -95,7 +95,7 @@ static void ioh_gpio_set(struct gpio_chip *gpio, unsigned nr, int val)
 	struct ioh_gpio *chip =	gpiochip_get_data(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	reg_val = ioread32(&chip->reg->regs[chip->ch].po);
 	if (val)
 		reg_val |= (1 << nr);
@@ -103,7 +103,7 @@ static void ioh_gpio_set(struct gpio_chip *gpio, unsigned nr, int val)
 		reg_val &= ~(1 << nr);
 
 	iowrite32(reg_val, &chip->reg->regs[chip->ch].po);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static int ioh_gpio_get(struct gpio_chip *gpio, unsigned nr)
@@ -121,7 +121,7 @@ static int ioh_gpio_direction_output(struct gpio_chip *gpio, unsigned nr,
 	u32 reg_val;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pm = ioread32(&chip->reg->regs[chip->ch].pm) &
 					((1 << num_ports[chip->ch]) - 1);
 	pm |= (1 << nr);
@@ -134,7 +134,7 @@ static int ioh_gpio_direction_output(struct gpio_chip *gpio, unsigned nr,
 		reg_val &= ~(1 << nr);
 	iowrite32(reg_val, &chip->reg->regs[chip->ch].po);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -145,12 +145,12 @@ static int ioh_gpio_direction_input(struct gpio_chip *gpio, unsigned nr)
 	u32 pm;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pm = ioread32(&chip->reg->regs[chip->ch].pm) &
 				((1 << num_ports[chip->ch]) - 1);
 	pm &= ~(1 << nr);
 	iowrite32(pm, &chip->reg->regs[chip->ch].pm);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -256,7 +256,7 @@ static int ioh_irq_type(struct irq_data *d, unsigned int type)
 	dev_dbg(chip->dev, "%s:irq=%d type=%d ch=%d pos=%d type=%d\n",
 		__func__, irq, type, ch, im_pos, type);
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -296,7 +296,7 @@ static int ioh_irq_type(struct irq_data *d, unsigned int type)
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	iowrite32(ien | BIT(ch), &chip->reg->regs[chip->ch].ien);
 end:
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -326,11 +326,11 @@ static void ioh_irq_disable(struct irq_data *d)
 	unsigned long flags;
 	u32 ien;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	ien &= ~(1 << (d->irq - chip->irq_base));
 	iowrite32(ien, &chip->reg->regs[chip->ch].ien);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static void ioh_irq_enable(struct irq_data *d)
@@ -340,11 +340,11 @@ static void ioh_irq_enable(struct irq_data *d)
 	unsigned long flags;
 	u32 ien;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	ien |= 1 << (d->irq - chip->irq_base);
 	iowrite32(ien, &chip->reg->regs[chip->ch].ien);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static irqreturn_t ioh_gpio_handler(int irq, void *dev_id)
@@ -441,7 +441,7 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 		chip->base = base;
 		chip->reg = chip->base;
 		chip->ch = i;
-		spin_lock_init(&chip->spinlock);
+		raw_spin_lock_init(&chip->spinlock);
 		ioh_gpio_setup(chip, num_ports[i]);
 		ret = gpiochip_add_data(&chip->gpio, chip);
 		if (ret) {
@@ -529,9 +529,9 @@ static int ioh_gpio_suspend(struct pci_dev *pdev, pm_message_t state)
 	struct ioh_gpio *chip = pci_get_drvdata(pdev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	ioh_gpio_save_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	ret = pci_save_state(pdev);
 	if (ret) {
@@ -563,11 +563,11 @@ static int ioh_gpio_resume(struct pci_dev *pdev)
 	}
 	pci_restore_state(pdev);
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	iowrite32(0x01, &chip->reg->srst);
 	iowrite32(0x00, &chip->reg->srst);
 	ioh_gpio_restore_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
-- 
2.53.0

