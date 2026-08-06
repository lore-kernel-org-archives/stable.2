Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCF025B09D
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982889; cv=none; b=ODtNfdxbdkQ6nyd8a83RZW8L1CDnf66iLzJgkZPaMbA/gknJbQiQbaRkJpUnTqzxW/Ws9Nrhbby4X3PBywcw6QtsFuFAjoruibig4JJ63S/QObKgP56aHgNHehnRJU1Xhr6i6YlTh3W20R4++CH5Hs1AW/+J4x5zzarjhEzZBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982889; c=relaxed/simple;
	bh=y/+vnKDrXgFHJzhGoLbaQM23qYbXB8gD2q22EFCKllk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7CNS+lPTAOuFZWvjKS49N12iLVycRGhu1IwM6+0baMofotdBjZPkN+KrRi83iEs9WHNEsWwQPifNEWgR4i7+8ChyeHe7ikb1Df0VoHzy2/WgMCRaRv/C0tSLM1FUZy08LuyvrLbd6ZscFvCANmP3X/Zh+9D8jOvxahJQg2xHxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kz90dG4F; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kz90dG4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785982888; x=1817518888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y/+vnKDrXgFHJzhGoLbaQM23qYbXB8gD2q22EFCKllk=;
  b=Kz90dG4FoYhsOLDqkK35TEAdB8RTBxPZzt31oo3DwxYFKBwZJfqvLXMM
   O3SQ9zFbGk3KmQJE8/V+xf5ExO2JD5Vgql5KgVvsS8tdcj95/+Yd6iVep
   jmzaydfrpyPPHl2RVD6hT1KweACvfX/7dS8whrykAGj9ILk+vNoLFb+ye
   xPAahpuEx2j8OxwRQL3sEUv8UeD6zfsf9XRnBMUZmcHxT4YvsQEZFEHgm
   1yx7U+sxJvwCfkd5H6gG2W3NXi247oflKDgc7DtA12v79t1L2q+u6g9CJ
   tJsYQJIonGULAIuQknxvREYEzEoiYJg21tBvEFDyvEljYohiZoNQNLWXh
   g==;
X-CSE-ConnectionGUID: eolTZDUrTZe6pcgEFeT6xQ==
X-CSE-MsgGUID: X3LE9hsGQOiFXb3D5NJnhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="112121619"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="112121619"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:21:27 -0700
X-CSE-ConnectionGUID: Ld+bS1mPS1+kttn9C55Ggw==
X-CSE-MsgGUID: KLfS0gCRT5mGyKpHv4xXTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="255717678"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:21:26 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: stable@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6.12.y] gpio: pch: use raw_spinlock_t for the register lock
Date: Thu,  6 Aug 2026 10:20:31 +0800
Message-ID: <20260806022031.3226009-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026080539-hurry-caption-f45e@gregkh>
References: <2026080539-hurry-caption-f45e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pch_irq_type() is registered as the irq_chip .irq_set_type callback and
takes chip->spinlock with spin_lock_irqsave().  This callback is reached
from __setup_irq() -> __irq_set_trigger() -> chip->irq_set_type() while
the caller holds desc->lock, a raw_spinlock_t, with hardirqs disabled.
That context is not sleepable, but on PREEMPT_RT a regular spinlock_t is
an rtmutex-backed sleeping lock, so acquiring it there is invalid.

This was confirmed on a PREEMPT_RT kernel with lockdep
(PROVE_RAW_LOCK_NESTING and DEBUG_ATOMIC_SLEEP).  A grounded PoC mirrored
pch_irq_type()'s locking and drove it through the real genirq carrier
irq_set_irq_type() -> __irq_set_trigger() -> chip->irq_set_type(), i.e.
the same __irq_set_trigger() edge that __setup_irq() takes for a
requested IRQ.  With the original spin_lock_irqsave() edge lockdep
reported an invalid wait context, immediately followed by:

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 95, name: insmod
  hardirqs last disabled at (3784): _raw_spin_lock_irqsave+0x4f/0x60
   rt_spin_lock+0x3a/0x1c0
   repro_irq_set_type+0x64/0xa0 [pch_repro]
   __irq_set_trigger+0x69/0x140
   irq_set_irq_type+0x78/0xd0

Switching the mirrored lock to raw_spinlock_t made both splats go away.

Convert the register lock to raw_spinlock_t.  The same lock also
serializes the GPIO direction/value callbacks and the suspend/resume
register save/restore, but all of those critical sections only perform
MMIO register accesses (ioread32()/iowrite32()) and
irq_set_handler_locked(); none of them contain sleepable operations.
Keeping this register lock non-sleeping is therefore appropriate for the
irqchip callbacks and does not change the GPIO-side locking contract.

This is the same class of issue and fix as recently addressed for other
GPIO controllers, e.g. commit 286533cb14a3 ("gpio: sch: use raw_spinlock_t
in the irq startup path") and commit 90f0109019e6 ("gpio: eic-sprd: use
raw_spinlock_t in the irq startup path").

Fixes: 38eb18a6f92d ("gpio-pch: Support interrupt function")
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260723014129.1129730-1-junjie.cao@intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
(cherry picked from commit a02b8950d619123da64f69b70fe1dadef217dfe4)
---
 drivers/gpio/gpio-pch.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
index 63f25c72eac2..75dd65957e4a 100644
--- a/drivers/gpio/gpio-pch.c
+++ b/drivers/gpio/gpio-pch.c
@@ -96,7 +96,7 @@ struct pch_gpio {
 	struct pch_gpio_reg_data pch_gpio_reg;
 	int irq_base;
 	enum pch_type_t ioh;
-	spinlock_t spinlock;
+	raw_spinlock_t spinlock;
 };
 
 static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
@@ -105,7 +105,7 @@ static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 	struct pch_gpio *chip =	gpiochip_get_data(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	reg_val = ioread32(&chip->reg->po);
 	if (val)
 		reg_val |= BIT(nr);
@@ -113,7 +113,7 @@ static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 		reg_val &= ~BIT(nr);
 
 	iowrite32(reg_val, &chip->reg->po);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static int pch_gpio_get(struct gpio_chip *gpio, unsigned int nr)
@@ -131,7 +131,7 @@ static int pch_gpio_direction_output(struct gpio_chip *gpio, unsigned int nr,
 	u32 reg_val;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	reg_val = ioread32(&chip->reg->po);
 	if (val)
@@ -145,7 +145,7 @@ static int pch_gpio_direction_output(struct gpio_chip *gpio, unsigned int nr,
 	pm |= BIT(nr);
 	iowrite32(pm, &chip->reg->pm);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -156,12 +156,12 @@ static int pch_gpio_direction_input(struct gpio_chip *gpio, unsigned int nr)
 	u32 pm;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pm = ioread32(&chip->reg->pm);
 	pm &= BIT(gpio_pins[chip->ioh]) - 1;
 	pm &= ~BIT(nr);
 	iowrite32(pm, &chip->reg->pm);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -263,7 +263,7 @@ static int pch_irq_type(struct irq_data *d, unsigned int type)
 		return 0;
 	}
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	/* Set interrupt mode */
 	im = ioread32(im_reg) & ~(PCH_IM_MASK << (im_pos * 4));
@@ -275,7 +275,7 @@ static int pch_irq_type(struct irq_data *d, unsigned int type)
 	else if (type & IRQ_TYPE_EDGE_BOTH)
 		irq_set_handler_locked(d, handle_edge_irq);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 	return 0;
 }
 
@@ -372,7 +372,7 @@ static int pch_gpio_probe(struct pci_dev *pdev,
 	chip->ioh = id->driver_data;
 	chip->reg = chip->base;
 	pci_set_drvdata(pdev, chip);
-	spin_lock_init(&chip->spinlock);
+	raw_spin_lock_init(&chip->spinlock);
 	pch_gpio_setup(chip);
 
 	ret = devm_gpiochip_add_data(dev, &chip->gpio, chip);
@@ -405,9 +405,9 @@ static int __maybe_unused pch_gpio_suspend(struct device *dev)
 	struct pch_gpio *chip = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pch_gpio_save_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -417,11 +417,11 @@ static int __maybe_unused pch_gpio_resume(struct device *dev)
 	struct pch_gpio *chip = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	iowrite32(0x01, &chip->reg->reset);
 	iowrite32(0x00, &chip->reg->reset);
 	pch_gpio_restore_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
-- 
2.43.0

