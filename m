Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125002DD5F6
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224240; cv=none; b=rGjWfruS0YiNTBY9of9ZqhT0VYISDZg4baJarq3kurg7qKPaiFun/N6RyL4xtBQRRcUb2z612j8HuZB1Epu/yo4UxkrxIdAwvYHSCJ3GKKvWFYN4iWcLu5seHXzAYsVo6k0k1uaZkLWLQZGQ/wlAa1rtRPTOlvkjAHaQW0X0J68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224240; c=relaxed/simple;
	bh=E6ClqfqDTBOoMU9ssi7WZFwxXsWeYwxcqTJSUm+T1dE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YsSVBKNOjnir8Gtq7TQZV+0/NzWHTBwzQxZIkqr0YsKQHBkiQ5pwV2NxVCVJyI03OUFGy0FU1QXO6B76PD5Tc26cjzzSQcCc3NdmALTM3iiMqIuLM4Q/IFGRSzBNvI9HZalqMXmwxBzb6dlCnZ9drr74WAdB8f67kXC+i5ATR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o0VVTLxO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o0VVTLxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CCC1F000E9;
	Thu, 20 Aug 2026 11:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224238;
	bh=bmhnZ9aghqxrDvCU/w1/oxlOzE+HOheMwmKFKlZFN1I=;
	h=Subject:To:Cc:From:Date;
	b=o0VVTLxOAKiNRLnxlHXXTefP1QlS425vm5Ds9ovCB8lqwuyGoeZCGcN76QzNJTpjM
	 2++gFuLyyHa4jCyFICm8HiRGJ0BA66jYrtJRqtFQBczC4+LQldetJcQds82a86Tj3r
	 qKFzFutfQ0+rPL9XHWJgVHUikNnIRLzQPEFBkExs=
Subject: FAILED: patch "[PATCH] gpio: ml-ioh: use raw_spinlock_t for the register lock" failed to apply to 5.15-stable tree
To: junjie.cao@intel.com,linusw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:10:11 +0200
Message-ID: <2026082011-tint-thievish-c622@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 600411ea1f2443fdf5b1af9b6480f616d7aff9d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082011-tint-thievish-c622@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 600411ea1f2443fdf5b1af9b6480f616d7aff9d0 Mon Sep 17 00:00:00 2001
From: Junjie Cao <junjie.cao@intel.com>
Date: Fri, 31 Jul 2026 11:27:47 +0800
Subject: [PATCH] gpio: ml-ioh: use raw_spinlock_t for the register lock

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

diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index 6576e5dcb0ee..0a9d34b7636e 100644
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
@@ -95,7 +95,7 @@ static int ioh_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 	struct ioh_gpio *chip =	gpiochip_get_data(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	reg_val = ioread32(&chip->reg->regs[chip->ch].po);
 	if (val)
 		reg_val |= BIT(nr);
@@ -103,7 +103,7 @@ static int ioh_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 		reg_val &= ~BIT(nr);
 
 	iowrite32(reg_val, &chip->reg->regs[chip->ch].po);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -123,7 +123,7 @@ static int ioh_gpio_direction_output(struct gpio_chip *gpio, unsigned nr,
 	u32 reg_val;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pm = ioread32(&chip->reg->regs[chip->ch].pm);
 	pm &= BIT(num_ports[chip->ch]) - 1;
 	pm |= BIT(nr);
@@ -136,7 +136,7 @@ static int ioh_gpio_direction_output(struct gpio_chip *gpio, unsigned nr,
 		reg_val &= ~BIT(nr);
 	iowrite32(reg_val, &chip->reg->regs[chip->ch].po);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -147,12 +147,12 @@ static int ioh_gpio_direction_input(struct gpio_chip *gpio, unsigned nr)
 	u32 pm;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pm = ioread32(&chip->reg->regs[chip->ch].pm);
 	pm &= BIT(num_ports[chip->ch]) - 1;
 	pm &= ~BIT(nr);
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
 	ien &= ~BIT(d->irq - chip->irq_base);
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
 	ien |= BIT(d->irq - chip->irq_base);
 	iowrite32(ien, &chip->reg->regs[chip->ch].ien);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static irqreturn_t ioh_gpio_handler(int irq, void *dev_id)
@@ -440,7 +440,7 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 		chip->base = base;
 		chip->reg = chip->base;
 		chip->ch = i;
-		spin_lock_init(&chip->spinlock);
+		raw_spin_lock_init(&chip->spinlock);
 		ioh_gpio_setup(chip, num_ports[i]);
 		ret = devm_gpiochip_add_data(dev, &chip->gpio, chip);
 		if (ret) {
@@ -484,9 +484,9 @@ static int ioh_gpio_suspend(struct device *dev)
 	struct ioh_gpio *chip = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	ioh_gpio_save_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -496,11 +496,11 @@ static int ioh_gpio_resume(struct device *dev)
 	struct ioh_gpio *chip = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	iowrite32(0x01, &chip->reg->srst);
 	iowrite32(0x00, &chip->reg->srst);
 	ioh_gpio_restore_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }

