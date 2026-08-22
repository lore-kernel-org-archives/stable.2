Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056ED2F1FED
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390002; cv=none; b=LiXo1tKuARnRR94WfCzk3JmChWErZMgYljfOBZ8H1TJmOOgQlrrZXxff3A0AcOVGu5Yv0lBO0VvH9z2eVsixy72bDLjuNfEcOc5IdIw5Kw9eJJuvhtuFjDq0uWVCGp8AJxkSh2eSD4sMFmHWnj606h05EDK4jnbjoVP1FDyG0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390002; c=relaxed/simple;
	bh=x7ii4Qzgpcau6qHESjjMT3rssPKPvGlt/yr5LMwEQHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pV4I3kdNVol501HQRIg59IB/41rNjuGXUmuXmvc3C5yc0LFXy+nO4InUn09qZFZ1CrG68uB/BeqGBbBxJ37PGuccuFumA1QlZAxYFDeDuJlCfHkmqX3cwCP5fyCsbP6Hwdifta+cvNhgXZhyD3b7FbtwPjWVNoGpFnmRZrCnr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W91yr/oP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W91yr/oP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787390000; x=1818926000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x7ii4Qzgpcau6qHESjjMT3rssPKPvGlt/yr5LMwEQHA=;
  b=W91yr/oPVzvMyJX/yhYOTTE+xqfJ1vqWn2+0UsnVzMoqrxK1JamZcNh5
   TNhLluf8rynhB/5bMYzjniSXkt2s08HPQaOkUL1md0uFvrc1vgoPL73Jk
   lK0Wkqee++OZp4+f7TvnW1fL5ErfCvr3i5Rk+a8grKM36AL7U9ekmFM1f
   QVaJ8znU22P3WaLbG581gubIwf/JEv/5U8sHNg6lIf5fmbeneA1Kk0P16
   e6DmQf972lPUqswZZISijmUA6YJsnx16/iyLwUqee9UC9jpjcMExrq4UY
   PJ87hY6Y+UWYwm1KBw0HcDAu4HGEjXVqTVZ17VedNWDk+oLTv89MCz+46
   Q==;
X-CSE-ConnectionGUID: /SiTSYMRTaCIt7pcjck4Jw==
X-CSE-MsgGUID: GMrlWlTsQ5arkLcIuykN4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="90438487"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="90438487"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2026 02:13:20 -0700
X-CSE-ConnectionGUID: RzQi63fRTeiivp3qg4LxpQ==
X-CSE-MsgGUID: Odp7+NP6SqOja4+00mB+0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="263919134"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2026 02:13:18 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: stable@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 5.15.y] gpio: ml-ioh: use raw_spinlock_t for the register lock
Date: Sat, 22 Aug 2026 17:13:15 +0800
Message-ID: <20260822091315.301739-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026082011-tint-thievish-c622@gregkh>
References: <2026082011-tint-thievish-c622@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 600411ea1f2443fdf5b1af9b6480f616d7aff9d0)
---
 drivers/gpio/gpio-ml-ioh.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index efa9acdc320a..83c2fd4f21e5 100644
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
@@ -254,7 +254,7 @@ static int ioh_irq_type(struct irq_data *d, unsigned int type)
 	dev_dbg(chip->dev, "%s:irq=%d type=%d ch=%d pos=%d type=%d\n",
 		__func__, irq, type, ch, im_pos, type);
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -294,7 +294,7 @@ static int ioh_irq_type(struct irq_data *d, unsigned int type)
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	iowrite32(ien | BIT(ch), &chip->reg->regs[chip->ch].ien);
 end:
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -324,11 +324,11 @@ static void ioh_irq_disable(struct irq_data *d)
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
@@ -338,11 +338,11 @@ static void ioh_irq_enable(struct irq_data *d)
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
@@ -439,7 +439,7 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 		chip->base = base;
 		chip->reg = chip->base;
 		chip->ch = i;
-		spin_lock_init(&chip->spinlock);
+		raw_spin_lock_init(&chip->spinlock);
 		ioh_gpio_setup(chip, num_ports[i]);
 		ret = gpiochip_add_data(&chip->gpio, chip);
 		if (ret) {
@@ -525,9 +525,9 @@ static int __maybe_unused ioh_gpio_suspend(struct device *dev)
 	struct ioh_gpio *chip = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	ioh_gpio_save_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -537,11 +537,11 @@ static int __maybe_unused ioh_gpio_resume(struct device *dev)
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
-- 
2.43.0

