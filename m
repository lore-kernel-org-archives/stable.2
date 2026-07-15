Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F593B2FC2
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133180; cv=none; b=XZu3aegWPvzzIHs0/eIazw/lDUdo0alwWXTPHlFDZgL2zhX546C7pBZ8aiAOJFPhvTqS1X2FxOo40l3BhmT0XWCf/PLE6dBmEh3lmNrtk4q9UTDSHvak5HWKXbGPEIvpOAMKn43d5pAOpEVwK+pIg63SFNRozDji0PBsd7gWbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133180; c=relaxed/simple;
	bh=W+tXB8QGh+/OnxPYS8WJm/nXt/BC2cow/2IliRH6+50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfMMxhkOT/0voD8+o9oJ33rWkOTo2kc9dP7rSe9i1DsZVk3h8vrUqZF8vwoTmr0VkkOPnw4NBEcHIii6CQopjqC6tS2n8RlofDDvSUnsnVOYh6gKdLPFUiNJXEImQlZShplG0GieYEjm0yW+bv1pgjF67VYAIBy0dzv/xr/aL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKrE7KVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKrE7KVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1F81F000E9;
	Wed, 15 Jul 2026 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133178;
	bh=pDDq5nlGvqkFQBFM8o/SSfkqtwWi245wxwjtcyNyuOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aKrE7KVHcbAs4wPK+l8CiZjK9H/Xkctdv8T6bwTpkQW78WHOeOE5hDy+bF7JRs///
	 RlOkQmYZBuQdWQeVt5dqBdh7D2+uVZHJB++L4qc/rXmVSuCLLKzGesLeHtGSvdisJC
	 +DNwlY/yXbBPVwUZ7lLrkAZvWy4NVpwcnD36LY4YKOBY8ak2XHYNzYGbpmSV6mMNoX
	 ixUIb35aGnbcCLlNTjGB0b5AI5lvb1W911rAjZvNVp3RUEDvaWzUiME9yVZmgxCwkL
	 R/T/DIJEKBoiZUATbYd3BGNAwc6eqxgRrZ38kCV+hZwU8XV32JG4lymQNDmsiTCR2Q
	 WczP/wo7abvHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] gpio: sch: use raw_spinlock_t in the irq startup path
Date: Wed, 15 Jul 2026 12:32:56 -0400
Message-ID: <20260715163256.953315-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071321-marshy-mountain-21a1@gregkh>
References: <2026071321-marshy-mountain-21a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 286533cb14a3c8a8bd39ff64ea2fc8e1aa0f638b ]

sch_irq_unmask() enables the GPIO IRQ and then updates the controller
state through sch_irq_mask_unmask(), which takes sch->lock with
spin_lock_irqsave().  The callback can be reached from irq_startup()
while setting up a requested IRQ.  That path is not sleepable, but on
PREEMPT_RT a regular spinlock_t becomes a sleeping lock.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the request_threaded_irq() -> __setup_irq() ->
irq_startup() -> sch_irq_unmask() -> sch_irq_mask_unmask() carrier and
used the original spin_lock_irqsave(&sch->lock) edge.  Lockdep reported:

  BUG: sleeping function called from invalid context
  hardirqs last disabled at ... __setup_irq.constprop.0 ... [vuln_msv]
  sch_rt_spin_lock_irqsave+0x1c/0x30 [vuln_msv]
  sch_irq_mask_unmask.constprop.0+0x31/0x70 [vuln_msv]
  __setup_irq.constprop.0+0xd/0x30 [vuln_msv]

Convert the SCH controller lock to raw_spinlock_t.  The same lock is
also used by the GPIO direction and value callbacks, but those critical
sections only update MMIO-backed GPIO registers and do not contain
sleepable operations.  Keeping this register lock non-sleeping is
therefore appropriate for the irqchip callbacks and does not change the
GPIO-side locking contract.

Fixes: 7a81638485c1 ("gpio: sch: Add edge event support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Link: https://patch.msgid.link/20260617154035.1199948-2-runyu.xiao@seu.edu.cn
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
[ adjusted context for 6.6's pre-MMIO `iobase` port I/O and void `sch_gpio_set()` (no set_rv `return 0;`) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-sch.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index e48392074e4b86..a53946859c8c1f 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -38,7 +38,7 @@
 
 struct sch_gpio {
 	struct gpio_chip chip;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned short iobase;
 	unsigned short resume_base;
 
@@ -102,9 +102,9 @@ static int sch_gpio_direction_in(struct gpio_chip *gc, unsigned int gpio_num)
 	struct sch_gpio *sch = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GIO, 1);
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 	return 0;
 }
 
@@ -120,9 +120,9 @@ static void sch_gpio_set(struct gpio_chip *gc, unsigned int gpio_num, int val)
 	struct sch_gpio *sch = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GLV, val);
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 }
 
 static int sch_gpio_direction_out(struct gpio_chip *gc, unsigned int gpio_num,
@@ -131,9 +131,9 @@ static int sch_gpio_direction_out(struct gpio_chip *gc, unsigned int gpio_num,
 	struct sch_gpio *sch = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GIO, 0);
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 
 	/*
 	 * according to the datasheet, writing to the level register has no
@@ -193,14 +193,14 @@ static int sch_irq_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 
 	sch_gpio_reg_set(sch, gpio_num, GTPE, rising);
 	sch_gpio_reg_set(sch, gpio_num, GTNE, falling);
 
 	irq_set_handler_locked(d, handle_edge_irq);
 
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 
 	return 0;
 }
@@ -212,9 +212,9 @@ static void sch_irq_ack(struct irq_data *d)
 	irq_hw_number_t gpio_num = irqd_to_hwirq(d);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GTS, 1);
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 }
 
 static void sch_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t gpio_num, int val)
@@ -222,9 +222,9 @@ static void sch_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t gpio_num,
 	struct sch_gpio *sch = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GGPE, val);
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 }
 
 static void sch_irq_mask(struct irq_data *d)
@@ -265,12 +265,12 @@ static u32 sch_gpio_gpe_handler(acpi_handle gpe_device, u32 gpe, void *context)
 	int offset;
 	u32 ret;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 
 	core_status = inl(sch->iobase + CORE_BANK_OFFSET + GTS);
 	resume_status = inl(sch->iobase + RESUME_BANK_OFFSET + GTS);
 
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 
 	pending = (resume_status << sch->resume_base) | core_status;
 	for_each_set_bit(offset, &pending, sch->chip.ngpio)
@@ -336,7 +336,7 @@ static int sch_gpio_probe(struct platform_device *pdev)
 				 pdev->name))
 		return -EBUSY;
 
-	spin_lock_init(&sch->lock);
+	raw_spin_lock_init(&sch->lock);
 	sch->iobase = res->start;
 	sch->chip = sch_gpio_chip;
 	sch->chip.label = dev_name(&pdev->dev);
-- 
2.53.0

