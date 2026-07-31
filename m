Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359F31AF1B;
	Fri, 31 Jul 2026 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785468601; cv=none; b=Bnym0V4XeqSH1q9/QMEQJ6p9Pi6J9j1ROgsdkh/QAn91zx+xZXBnXNmAC0CB9xSeaGBDwUkLMRSgI5TvwSuZKNIzuBH9btDqFj3jSvpjvuCgBECCI9DN9Rm/RgNO2pOONl24eE+6QNFKYs6oeXx9p0AUcgWYvMkjUZPXK2mkvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785468601; c=relaxed/simple;
	bh=SizCvG8mrb2naaSlE2obB5LCGkAQXOaMM17ZjJVmbZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8zh7x4g7MKnfgfDa570uuf6b+24edNEjKh1g+H46sTuTC5FuOmEYesCKx3YNISegI+2OIfIrNNeaF0kYMZoezkamqGsmJDWEcGQaRBpdbuyxhHsodBI8pYUKxDn0RunF8PbFdJ6RqzNiISEKp5TM9ZJpTzw9jUyNog1ldl5MK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlFLqLHA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlFLqLHA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785468599; x=1817004599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SizCvG8mrb2naaSlE2obB5LCGkAQXOaMM17ZjJVmbZE=;
  b=XlFLqLHABmAvk9Wa96qmc9Au62Xnsvtb5lf1Yf1Q9Y84sQdWrm2LHHH+
   ugW+yWPQrQhf+UC3ok5r96lN2w4HUJ5A9a3JzX8G393zc/sFV+j9WOnGD
   tA/czGPt2x4y9IHLtQb57V3//deLDIZeJnxuyYgdI5ET+wS9eTnDhnDBB
   67LVudfXRRmBdZZVkevKMAWNwkZJCOrhjCJ8Ig/vtsu1D35ZqwcmFU2uB
   6eZrKiFgBdS0OkwUzxCtqjoFZPKqWt9FBzZ6MgyrmcHT1D8rYlyOshBUU
   q6L08lh2WQcI78vokvLwgwUhMLACT8Scc4fvvPagviUFt8ESUZVkPZMt7
   w==;
X-CSE-ConnectionGUID: 5CVpVlKTSpm/tG078efLCA==
X-CSE-MsgGUID: ORy5wiyFQnCoxC+ydMcuaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="103631610"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="103631610"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 20:29:58 -0700
X-CSE-ConnectionGUID: rCS5jVQSTOKmW1+KnT/hRg==
X-CSE-MsgGUID: 6248gJzeTDeu3cFfmPm3PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="258680354"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 20:29:56 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] gpio: ml-ioh: use raw_spinlock_t for the register lock
Date: Fri, 31 Jul 2026 11:27:47 +0800
Message-ID: <20260731032747.2987292-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
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
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 drivers/gpio/gpio-ml-ioh.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

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

base-commit: a02b8950d619123da64f69b70fe1dadef217dfe4
-- 
2.43.0

