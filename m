Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC52AD2E
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982707; cv=none; b=C1/62YEXsoeEJN7ecbjmeWRz/gPSLWCVhe80KS5WtX06dmrMlK+fzsWVo5ALB0BvvZjJNHGoEtPYD6raORAS3IqOYtsSNxiMDfQR+f05DESQhHpBEZZqWTx5ZruDv63rYlW/+j4d1V0CXrk7itvVEKyr3YY3HtQA82/8oNiQOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982707; c=relaxed/simple;
	bh=d0Eoh51/sR2pbleVg/0KAG4jFDm2CabkVD0w0SSCXGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2txr6y3uiQ0eec25KboRmkl8RZh8L8XDJKT9tMBsWyL2FlBtn8dSNwmHgWXfFUDFiJvw0SlW/4s2sesd86sumjQUqbC2z07kGR5iNV9QF3ZY3FH91xag69j2QeU8uVXj+uAsSa5h8iuHGD/9a91TPEmR4Zzw85pHs1LRgyDStY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQqB97KI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQqB97KI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785982705; x=1817518705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d0Eoh51/sR2pbleVg/0KAG4jFDm2CabkVD0w0SSCXGY=;
  b=QQqB97KIjL7jmwurNcx8nzzHZsfEQKSgsNcvpvksSOJKvcIKVhWjYZl8
   LoMGKv6QDKxKUn/TQOJlne8uyoar6EcFP2G6OVcD4KPNi402EjsQf22Sa
   //6r8uv28on/9yt8bvZrxLHd/Wsmv2Cwu027DHxmDnL3qdOKWLKtHnc04
   u7uKEnygYxWsL8Cvv3VkIbZCfE9x0Yf1OTQulKMhTlTV1+vY6SrxZbeAU
   YOY41DmROzGlwpzy3F+JsvPXDoF67vCw9O6SJ2TXVSzGZvK/4xQI0+EGH
   PmV8Gmn947UTM3YYuGaKizhlGlCm9jraIAZ2J8k1lMxgIkcgdFXzLasm1
   g==;
X-CSE-ConnectionGUID: PHYCe9y+RyWOLL158O6xmA==
X-CSE-MsgGUID: zEgo6VP9TmKPOO8QfRl9mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86443059"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86443059"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:18:25 -0700
X-CSE-ConnectionGUID: 04jRUbZ+RhaiC3sTiC/8ow==
X-CSE-MsgGUID: tWXdAKETQuWW1saFStIL9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="260714064"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:18:24 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: stable@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 5.10.y] gpio: pch: use raw_spinlock_t for the register lock
Date: Thu,  6 Aug 2026 10:17:25 +0800
Message-ID: <20260806021725.3224574-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026080541-handyman-subsector-8c60@gregkh>
References: <2026080541-handyman-subsector-8c60@gregkh>
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
index a552df298a97..af4b3b7f3033 100644
--- a/drivers/gpio/gpio-pch.c
+++ b/drivers/gpio/gpio-pch.c
@@ -92,7 +92,7 @@ struct pch_gpio {
 	struct pch_gpio_reg_data pch_gpio_reg;
 	int irq_base;
 	enum pch_type_t ioh;
-	spinlock_t spinlock;
+	raw_spinlock_t spinlock;
 };
 
 static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
@@ -101,7 +101,7 @@ static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 	struct pch_gpio *chip =	gpiochip_get_data(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	reg_val = ioread32(&chip->reg->po);
 	if (val)
 		reg_val |= BIT(nr);
@@ -109,7 +109,7 @@ static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 		reg_val &= ~BIT(nr);
 
 	iowrite32(reg_val, &chip->reg->po);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static int pch_gpio_get(struct gpio_chip *gpio, unsigned int nr)
@@ -127,7 +127,7 @@ static int pch_gpio_direction_output(struct gpio_chip *gpio, unsigned int nr,
 	u32 reg_val;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	reg_val = ioread32(&chip->reg->po);
 	if (val)
@@ -141,7 +141,7 @@ static int pch_gpio_direction_output(struct gpio_chip *gpio, unsigned int nr,
 	pm |= BIT(nr);
 	iowrite32(pm, &chip->reg->pm);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -152,12 +152,12 @@ static int pch_gpio_direction_input(struct gpio_chip *gpio, unsigned int nr)
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
@@ -259,7 +259,7 @@ static int pch_irq_type(struct irq_data *d, unsigned int type)
 		return 0;
 	}
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	/* Set interrupt mode */
 	im = ioread32(im_reg) & ~(PCH_IM_MASK << (im_pos * 4));
@@ -271,7 +271,7 @@ static int pch_irq_type(struct irq_data *d, unsigned int type)
 	else if (type & IRQ_TYPE_EDGE_BOTH)
 		irq_set_handler_locked(d, handle_edge_irq);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 	return 0;
 }
 
@@ -378,7 +378,7 @@ static int pch_gpio_probe(struct pci_dev *pdev,
 
 	chip->reg = chip->base;
 	pci_set_drvdata(pdev, chip);
-	spin_lock_init(&chip->spinlock);
+	raw_spin_lock_init(&chip->spinlock);
 	pch_gpio_setup(chip);
 
 	ret = devm_gpiochip_add_data(&pdev->dev, &chip->gpio, chip);
@@ -415,9 +415,9 @@ static int __maybe_unused pch_gpio_suspend(struct device *dev)
 	struct pch_gpio *chip = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pch_gpio_save_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -427,11 +427,11 @@ static int __maybe_unused pch_gpio_resume(struct device *dev)
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

