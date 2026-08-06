Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA793B19A9
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982794; cv=none; b=FtbvPOnNS5y0lrMI9EnQXIuhBrYvHM0gSqIhP8y11waSW9yPscGlAosB+L4xYGa9y4KwtQsumM1uPBXkxR7C75k64MwmbJSrCPHVPilNT/AxxgFuHzW65ZxMgE0ZO9NSa9LKegxYYKsO3yQAfR3sR4hXvk3Z/yFc8IdFSW8zn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982794; c=relaxed/simple;
	bh=OeFI9SxAk54qgGtrl8ujO5O2Hr6PTa8OIJLudBaPo9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhG4rZVoCohWmW90Q9Ee4glal3okZnmumTbZV3mpKYH19AkbjBgKE+x1QeNn5WoFRSUW9egVYdT0iUONkPERS3FN57uM2TUPHL+47D+LxIRlEo9T6NEX/LWEV6SzDQQUjtG2BYK2mEEQs9bSbCl+abZ0JqZQVr/krhyVFbD/VxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXuz+9Sf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXuz+9Sf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785982792; x=1817518792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OeFI9SxAk54qgGtrl8ujO5O2Hr6PTa8OIJLudBaPo9c=;
  b=mXuz+9SfTJgRhm6wjWbLZJ3vPYNvpXuIHZB1v9R/Oo+MzuzR9yJDjkrm
   rgnfRS8CfHQKBbJqTLCDZkL8KwKCIHJXcIRURE5EETN1l81vguuuxohW8
   nI034Lb7DUxz2dR1g4G3biCLcP7WM4cr2V4KqfjewYQzSg4dG6VQhUJBj
   P+P+j5x7mpvr167GbvV4ieuvsXe4HmK64N6TNDLcGVF/5XHvORwEcaAyJ
   goklCmIqdY+j++Kp7qpxYUM38ZSzPm5fQPki8v4L5eqTSkpHixDyMP/K0
   3lM3yJHNUOuKqyFEKoOZkUtbSAImTp25ZUeQ1nAhkR22gTmVIyOu32603
   g==;
X-CSE-ConnectionGUID: Sj6+mPNTQ/OcrdGEF9mDPQ==
X-CSE-MsgGUID: vB4HVHpgT8+poEa9JJYrZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="97930921"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="97930921"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:19:50 -0700
X-CSE-ConnectionGUID: Xpt06nfZSj2HmMhfqeyBdA==
X-CSE-MsgGUID: p78r5YckSmuAu60GPIP6Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="265453186"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:19:49 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: stable@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6.1.y] gpio: pch: use raw_spinlock_t for the register lock
Date: Thu,  6 Aug 2026 10:18:46 +0800
Message-ID: <20260806021846.3225202-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026080540-ventricle-uncross-946f@gregkh>
References: <2026080540-ventricle-uncross-946f@gregkh>
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
index ee37ecb615cb..77e84e0e6c1b 100644
--- a/drivers/gpio/gpio-pch.c
+++ b/drivers/gpio/gpio-pch.c
@@ -97,7 +97,7 @@ struct pch_gpio {
 	struct pch_gpio_reg_data pch_gpio_reg;
 	int irq_base;
 	enum pch_type_t ioh;
-	spinlock_t spinlock;
+	raw_spinlock_t spinlock;
 };
 
 static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
@@ -106,7 +106,7 @@ static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 	struct pch_gpio *chip =	gpiochip_get_data(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	reg_val = ioread32(&chip->reg->po);
 	if (val)
 		reg_val |= BIT(nr);
@@ -114,7 +114,7 @@ static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 		reg_val &= ~BIT(nr);
 
 	iowrite32(reg_val, &chip->reg->po);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static int pch_gpio_get(struct gpio_chip *gpio, unsigned int nr)
@@ -132,7 +132,7 @@ static int pch_gpio_direction_output(struct gpio_chip *gpio, unsigned int nr,
 	u32 reg_val;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	reg_val = ioread32(&chip->reg->po);
 	if (val)
@@ -146,7 +146,7 @@ static int pch_gpio_direction_output(struct gpio_chip *gpio, unsigned int nr,
 	pm |= BIT(nr);
 	iowrite32(pm, &chip->reg->pm);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -157,12 +157,12 @@ static int pch_gpio_direction_input(struct gpio_chip *gpio, unsigned int nr)
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
@@ -264,7 +264,7 @@ static int pch_irq_type(struct irq_data *d, unsigned int type)
 		return 0;
 	}
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	/* Set interrupt mode */
 	im = ioread32(im_reg) & ~(PCH_IM_MASK << (im_pos * 4));
@@ -276,7 +276,7 @@ static int pch_irq_type(struct irq_data *d, unsigned int type)
 	else if (type & IRQ_TYPE_EDGE_BOTH)
 		irq_set_handler_locked(d, handle_edge_irq);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 	return 0;
 }
 
@@ -373,7 +373,7 @@ static int pch_gpio_probe(struct pci_dev *pdev,
 	chip->ioh = id->driver_data;
 	chip->reg = chip->base;
 	pci_set_drvdata(pdev, chip);
-	spin_lock_init(&chip->spinlock);
+	raw_spin_lock_init(&chip->spinlock);
 	pch_gpio_setup(chip);
 
 	ret = devm_gpiochip_add_data(dev, &chip->gpio, chip);
@@ -406,9 +406,9 @@ static int __maybe_unused pch_gpio_suspend(struct device *dev)
 	struct pch_gpio *chip = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pch_gpio_save_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -418,11 +418,11 @@ static int __maybe_unused pch_gpio_resume(struct device *dev)
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

