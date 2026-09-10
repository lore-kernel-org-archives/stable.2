Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5048EC78
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053075; cv=none; b=bSUXtEhCQ/rjCVVTtrtqlVOP+mW2+Wnvw8noxQcAobt4q/WyF/jhx050d3Q8aLRN+DIddQE2QU115AhC94hFp6CezdBb+s+IU8lcgfiDlw99Xw9Y3ErwgweCQKchRKZQzAfsV9PmS6MQH8XOIGAxV5UcScKlTyZmO4ypvqkT7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053075; c=relaxed/simple;
	bh=5EponPXRtGn8zNA07KVCbsSMbgpzTU7SN4Tu/issER4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3JeYM2LzQ3pIyyefzdjB7ucBzsoO5QIG4bASTxzoVlgpjQfmP75tAcTDVlF9enyzmKE/FbakI/XdDksO25TNuOOZeKoTDOuHEqugCB1CQl0Av6leajDMXhR7q8cKBs1Zau1+vkj0kRtgB0vSQHPy1jDJJgBUb1/VycMT+yqcPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx4OwJYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx4OwJYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC6F1F0089A;
	Thu, 10 Sep 2026 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053066;
	bh=gKIRsHOcS99Wd1OQSO5c2bmFo9wWPOYCAq/P9EhIjn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kx4OwJYgMyWfgkfC8JUxEyqKzY8w5qfTLxVki0d7Jwn/I7TDBwtlUjFXAfgF5vQsP
	 D2JU4ExzhdIxIaMKYprlHqE501VpffARnyHyrT4qDyywOkYyJhV2FPG3+Oc88s2X9V
	 62G+G5dF3XDuXoWYit+7YTzbkcDUwUkOaPuMEMyWxPNG2ZVl8ffO7ifo6v9ygYWxpU
	 uawYswU+dwP1sxJPQlYZBAsMlCa7k1kHHt1PiRY4hmGl1mvqWzzbbhYhN6Ohhs6jAE
	 zLSoUGvpYjMu9hvsRKnjx+UfoyuRyzpC2UT2wSZrnczzdkhiWPz9hxuPetXdJt9sWi
	 5cw0tSZ8VtMPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] irqchip/stm32-exti: Split MCU and MPU code
Date: Thu, 10 Sep 2026 11:11:03 -0400
Message-ID: <20260910151104.853748-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090812-banker-manhandle-d0d6@gregkh>
References: <2026090812-banker-manhandle-d0d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Antonio Borneo <antonio.borneo@foss.st.com>

[ Upstream commit 350755e2e548ccbe941d045900b57233efa906cb ]

Keep only the code for ARMv7m STM32 MCUs in in stm32-exti.c and split out
the code for ARMv7a & ARMv8a STM32MPxxx MPUs into stm32mp-exti.c

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240620083115.204362-5-antonio.borneo@foss.st.com

Adapt the split to Linux 6.6 without importing the intervening standard-PM,
interrupts-extended, secure-event, or RIF changes. Move the existing MPU
implementation, including its syscore callbacks and platform remove hook,
to irq-stm32mp-exti.c. Keep the MCU-only cleanup from the upstream split.
Existing functions are moved or reused; no new functions are introduced.

The stable tree has no STM32MP_EXTI selector, so add it and select the MCU
or MPU driver from the corresponding ARM architecture configuration. Keep
the timeout unchanged for d31fbbade43f880b7e59e2b3a72722fe2725d93f, which
applies cleanly to the split MPU driver with Git's three-way application.

Stable-dep-of: d31fbbade43f ("irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-stm32/Kconfig        |   3 +-
 drivers/irqchip/Kconfig            |   5 +
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-stm32-exti.c   | 622 +-------------------------
 drivers/irqchip/irq-stm32mp-exti.c | 694 +++++++++++++++++++++++++++++
 5 files changed, 708 insertions(+), 617 deletions(-)
 create mode 100644 drivers/irqchip/irq-stm32mp-exti.c

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 98145031586f1..9b70f1ab4b081 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -11,7 +11,8 @@ menuconfig ARCH_STM32
 	select CLKSRC_STM32
 	select PINCTRL
 	select RESET_CONTROLLER
-	select STM32_EXTI
+	select STM32_EXTI if ARM_SINGLE_ARMV7M
+	select STM32MP_EXTI if ARCH_MULTI_V7
 	help
 	  Support for STMicroelectronics STM32 processors.
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4ff91df769478..c42eead1d02de 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -392,6 +392,11 @@ config LS_SCFG_MSI
 config PARTITION_PERCPU
 	bool
 
+config STM32MP_EXTI
+	bool
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
+
 config STM32_EXTI
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ffd945fe71aa2..96625e7b9c235 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
+obj-$(CONFIG_STM32MP_EXTI)		+= irq-stm32mp-exti.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
 obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 971240e2e31b4..e3fa9473272c5 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -1,31 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
- * Copyright (C) STMicroelectronics 2017
+ * Copyright (C) STMicroelectronics 2017-2024
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
  */
 
 #include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/hwspinlock.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/platform_device.h>
-#include <linux/syscore_ops.h>
 
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-#define IRQS_PER_BANK 32
-
-#define HWSPNLCK_TIMEOUT	1000 /* usec */
+#define IRQS_PER_BANK			32
 
 struct stm32_exti_bank {
 	u32 imr_ofst;
@@ -34,12 +24,8 @@ struct stm32_exti_bank {
 	u32 ftsr_ofst;
 	u32 swier_ofst;
 	u32 rpr_ofst;
-	u32 fpr_ofst;
-	u32 trg_ofst;
 };
 
-#define UNDEF_REG ~0
-
 struct stm32_exti_drv_data {
 	const struct stm32_exti_bank **exti_banks;
 	const u8 *desc_irqs;
@@ -49,7 +35,6 @@ struct stm32_exti_drv_data {
 struct stm32_exti_chip_data {
 	struct stm32_exti_host_data *host_data;
 	const struct stm32_exti_bank *reg_bank;
-	struct raw_spinlock rlock;
 	u32 wake_active;
 	u32 mask_cache;
 	u32 rtsr_cache;
@@ -60,11 +45,8 @@ struct stm32_exti_host_data {
 	void __iomem *base;
 	struct stm32_exti_chip_data *chips_data;
 	const struct stm32_exti_drv_data *drv_data;
-	struct hwspinlock *hwlock;
 };
 
-static struct stm32_exti_host_data *stm32_host_data;
-
 static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.imr_ofst	= 0x00,
 	.emr_ofst	= 0x04,
@@ -72,8 +54,6 @@ static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.ftsr_ofst	= 0x0C,
 	.swier_ofst	= 0x10,
 	.rpr_ofst	= 0x14,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
@@ -92,8 +72,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b1 = {
 	.ftsr_ofst	= 0x04,
 	.swier_ofst	= 0x08,
 	.rpr_ofst	= 0x88,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
@@ -103,8 +81,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
 	.ftsr_ofst	= 0x24,
 	.swier_ofst	= 0x28,
 	.rpr_ofst	= 0x98,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
@@ -114,8 +90,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
 	.ftsr_ofst	= 0x44,
 	.swier_ofst	= 0x48,
 	.rpr_ofst	= 0xA8,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
@@ -129,180 +103,12 @@ static const struct stm32_exti_drv_data stm32h7xx_drv_data = {
 	.bank_nr = ARRAY_SIZE(stm32h7xx_exti_banks),
 };
 
-static const struct stm32_exti_bank stm32mp1_exti_b1 = {
-	.imr_ofst	= 0x80,
-	.emr_ofst	= UNDEF_REG,
-	.rtsr_ofst	= 0x00,
-	.ftsr_ofst	= 0x04,
-	.swier_ofst	= 0x08,
-	.rpr_ofst	= 0x0C,
-	.fpr_ofst	= 0x10,
-	.trg_ofst	= 0x3EC,
-};
-
-static const struct stm32_exti_bank stm32mp1_exti_b2 = {
-	.imr_ofst	= 0x90,
-	.emr_ofst	= UNDEF_REG,
-	.rtsr_ofst	= 0x20,
-	.ftsr_ofst	= 0x24,
-	.swier_ofst	= 0x28,
-	.rpr_ofst	= 0x2C,
-	.fpr_ofst	= 0x30,
-	.trg_ofst	= 0x3E8,
-};
-
-static const struct stm32_exti_bank stm32mp1_exti_b3 = {
-	.imr_ofst	= 0xA0,
-	.emr_ofst	= UNDEF_REG,
-	.rtsr_ofst	= 0x40,
-	.ftsr_ofst	= 0x44,
-	.swier_ofst	= 0x48,
-	.rpr_ofst	= 0x4C,
-	.fpr_ofst	= 0x50,
-	.trg_ofst	= 0x3E4,
-};
-
-static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
-	&stm32mp1_exti_b1,
-	&stm32mp1_exti_b2,
-	&stm32mp1_exti_b3,
-};
-
-static struct irq_chip stm32_exti_h_chip;
-static struct irq_chip stm32_exti_h_chip_direct;
-
-#define EXTI_INVALID_IRQ       U8_MAX
-#define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_BANK)
-
-/*
- * Use some intentionally tricky logic here to initialize the whole array to
- * EXTI_INVALID_IRQ, but then override certain fields, requiring us to indicate
- * that we "know" that there are overrides in this structure, and we'll need to
- * disable that warning from W=1 builds.
- */
-__diag_push();
-__diag_ignore_all("-Woverride-init",
-		  "logic to initialize all and then override some is OK");
-
-static const u8 stm32mp1_desc_irq[] = {
-	/* default value */
-	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
-
-	[0] = 6,
-	[1] = 7,
-	[2] = 8,
-	[3] = 9,
-	[4] = 10,
-	[5] = 23,
-	[6] = 64,
-	[7] = 65,
-	[8] = 66,
-	[9] = 67,
-	[10] = 40,
-	[11] = 42,
-	[12] = 76,
-	[13] = 77,
-	[14] = 121,
-	[15] = 127,
-	[16] = 1,
-	[19] = 3,
-	[21] = 31,
-	[22] = 33,
-	[23] = 72,
-	[24] = 95,
-	[25] = 107,
-	[26] = 37,
-	[27] = 38,
-	[28] = 39,
-	[29] = 71,
-	[30] = 52,
-	[31] = 53,
-	[32] = 82,
-	[33] = 83,
-	[46] = 151,
-	[47] = 93,
-	[48] = 138,
-	[50] = 139,
-	[52] = 140,
-	[53] = 141,
-	[54] = 135,
-	[61] = 100,
-	[65] = 144,
-	[68] = 143,
-	[70] = 62,
-	[73] = 129,
-};
-
-static const u8 stm32mp13_desc_irq[] = {
-	/* default value */
-	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
-
-	[0] = 6,
-	[1] = 7,
-	[2] = 8,
-	[3] = 9,
-	[4] = 10,
-	[5] = 24,
-	[6] = 65,
-	[7] = 66,
-	[8] = 67,
-	[9] = 68,
-	[10] = 41,
-	[11] = 43,
-	[12] = 77,
-	[13] = 78,
-	[14] = 106,
-	[15] = 109,
-	[16] = 1,
-	[19] = 3,
-	[21] = 32,
-	[22] = 34,
-	[23] = 73,
-	[24] = 93,
-	[25] = 114,
-	[26] = 38,
-	[27] = 39,
-	[28] = 40,
-	[29] = 72,
-	[30] = 53,
-	[31] = 54,
-	[32] = 83,
-	[33] = 84,
-	[44] = 96,
-	[47] = 92,
-	[48] = 116,
-	[50] = 117,
-	[52] = 118,
-	[53] = 119,
-	[68] = 63,
-	[70] = 98,
-};
-
-__diag_pop();
-
-static const struct stm32_exti_drv_data stm32mp1_drv_data = {
-	.exti_banks = stm32mp1_exti_banks,
-	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
-	.desc_irqs = stm32mp1_desc_irq,
-};
-
-static const struct stm32_exti_drv_data stm32mp13_drv_data = {
-	.exti_banks = stm32mp1_exti_banks,
-	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
-	.desc_irqs = stm32mp13_desc_irq,
-};
-
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data = gc->private;
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	unsigned long pending;
-
-	pending = irq_reg_readl(gc, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		pending |= irq_reg_readl(gc, stm32_bank->fpr_ofst);
 
-	return pending;
+	return irq_reg_readl(gc, stm32_bank->rpr_ofst);
 }
 
 static void stm32_irq_handler(struct irq_desc *desc)
@@ -322,7 +128,7 @@ static void stm32_irq_handler(struct irq_desc *desc)
 		while ((pending = stm32_exti_pending(gc))) {
 			for_each_set_bit(n, &pending, IRQS_PER_BANK)
 				generic_handle_domain_irq(domain, irq_base + n);
- 		}
+		}
 	}
 
 	chained_irq_exit(chip, desc);
@@ -358,33 +164,21 @@ static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct stm32_exti_chip_data *chip_data = gc->private;
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
 	u32 rtsr, ftsr;
 	int err;
 
 	irq_gc_lock(gc);
 
-	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
-		if (err) {
-			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
-			goto unlock;
-		}
-	}
-
 	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
 	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
 
 	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
 	if (err)
-		goto unspinlock;
+		goto unlock;
 
 	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
 	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
 
-unspinlock:
-	if (hwlock)
-		hwspin_unlock_in_atomic(hwlock);
 unlock:
 	irq_gc_unlock(gc);
 
@@ -472,282 +266,10 @@ static void stm32_irq_ack(struct irq_data *d)
 	irq_gc_lock(gc);
 
 	irq_reg_writel(gc, d->mask, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		irq_reg_writel(gc, d->mask, stm32_bank->fpr_ofst);
 
 	irq_gc_unlock(gc);
 }
 
-/* directly set the target bit without reading first. */
-static inline void stm32_exti_write_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	void __iomem *base = chip_data->host_data->base;
-	u32 val = BIT(d->hwirq % IRQS_PER_BANK);
-
-	writel_relaxed(val, base + reg);
-}
-
-static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	void __iomem *base = chip_data->host_data->base;
-	u32 val;
-
-	val = readl_relaxed(base + reg);
-	val |= BIT(d->hwirq % IRQS_PER_BANK);
-	writel_relaxed(val, base + reg);
-
-	return val;
-}
-
-static inline u32 stm32_exti_clr_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	void __iomem *base = chip_data->host_data->base;
-	u32 val;
-
-	val = readl_relaxed(base + reg);
-	val &= ~BIT(d->hwirq % IRQS_PER_BANK);
-	writel_relaxed(val, base + reg);
-
-	return val;
-}
-
-static void stm32_exti_h_eoi(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-
-	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
-
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_eoi_parent(d);
-}
-
-static void stm32_exti_h_mask(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-	chip_data->mask_cache = stm32_exti_clr_bit(d, stm32_bank->imr_ofst);
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_mask_parent(d);
-}
-
-static void stm32_exti_h_unmask(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst);
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_unmask_parent(d);
-}
-
-static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
-	void __iomem *base = chip_data->host_data->base;
-	u32 rtsr, ftsr;
-	int err;
-
-	raw_spin_lock(&chip_data->rlock);
-
-	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
-		if (err) {
-			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
-			goto unlock;
-		}
-	}
-
-	rtsr = readl_relaxed(base + stm32_bank->rtsr_ofst);
-	ftsr = readl_relaxed(base + stm32_bank->ftsr_ofst);
-
-	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
-	if (err)
-		goto unspinlock;
-
-	writel_relaxed(rtsr, base + stm32_bank->rtsr_ofst);
-	writel_relaxed(ftsr, base + stm32_bank->ftsr_ofst);
-
-unspinlock:
-	if (hwlock)
-		hwspin_unlock_in_atomic(hwlock);
-unlock:
-	raw_spin_unlock(&chip_data->rlock);
-
-	return err;
-}
-
-static int stm32_exti_h_set_wake(struct irq_data *d, unsigned int on)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
-
-	raw_spin_lock(&chip_data->rlock);
-
-	if (on)
-		chip_data->wake_active |= mask;
-	else
-		chip_data->wake_active &= ~mask;
-
-	raw_spin_unlock(&chip_data->rlock);
-
-	return 0;
-}
-
-static int stm32_exti_h_set_affinity(struct irq_data *d,
-				     const struct cpumask *dest, bool force)
-{
-	if (d->parent_data->chip)
-		return irq_chip_set_affinity_parent(d, dest, force);
-
-	return IRQ_SET_MASK_OK_DONE;
-}
-
-static int __maybe_unused stm32_exti_h_suspend(void)
-{
-	struct stm32_exti_chip_data *chip_data;
-	int i;
-
-	for (i = 0; i < stm32_host_data->drv_data->bank_nr; i++) {
-		chip_data = &stm32_host_data->chips_data[i];
-		raw_spin_lock(&chip_data->rlock);
-		stm32_chip_suspend(chip_data, chip_data->wake_active);
-		raw_spin_unlock(&chip_data->rlock);
-	}
-
-	return 0;
-}
-
-static void __maybe_unused stm32_exti_h_resume(void)
-{
-	struct stm32_exti_chip_data *chip_data;
-	int i;
-
-	for (i = 0; i < stm32_host_data->drv_data->bank_nr; i++) {
-		chip_data = &stm32_host_data->chips_data[i];
-		raw_spin_lock(&chip_data->rlock);
-		stm32_chip_resume(chip_data, chip_data->mask_cache);
-		raw_spin_unlock(&chip_data->rlock);
-	}
-}
-
-static struct syscore_ops stm32_exti_h_syscore_ops = {
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= stm32_exti_h_suspend,
-	.resume		= stm32_exti_h_resume,
-#endif
-};
-
-static void stm32_exti_h_syscore_init(struct stm32_exti_host_data *host_data)
-{
-	stm32_host_data = host_data;
-	register_syscore_ops(&stm32_exti_h_syscore_ops);
-}
-
-static void stm32_exti_h_syscore_deinit(void)
-{
-	unregister_syscore_ops(&stm32_exti_h_syscore_ops);
-}
-
-static int stm32_exti_h_retrigger(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	void __iomem *base = chip_data->host_data->base;
-	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
-
-	writel_relaxed(mask, base + stm32_bank->swier_ofst);
-
-	return 0;
-}
-
-static struct irq_chip stm32_exti_h_chip = {
-	.name			= "stm32-exti-h",
-	.irq_eoi		= stm32_exti_h_eoi,
-	.irq_mask		= stm32_exti_h_mask,
-	.irq_unmask		= stm32_exti_h_unmask,
-	.irq_retrigger		= stm32_exti_h_retrigger,
-	.irq_set_type		= stm32_exti_h_set_type,
-	.irq_set_wake		= stm32_exti_h_set_wake,
-	.flags			= IRQCHIP_MASK_ON_SUSPEND,
-	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : NULL,
-};
-
-static struct irq_chip stm32_exti_h_chip_direct = {
-	.name			= "stm32-exti-h-direct",
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_ack		= irq_chip_ack_parent,
-	.irq_mask		= stm32_exti_h_mask,
-	.irq_unmask		= stm32_exti_h_unmask,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_set_wake		= stm32_exti_h_set_wake,
-	.flags			= IRQCHIP_MASK_ON_SUSPEND,
-	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? irq_chip_set_affinity_parent : NULL,
-};
-
-static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
-				     unsigned int virq,
-				     unsigned int nr_irqs, void *data)
-{
-	struct stm32_exti_host_data *host_data = dm->host_data;
-	struct stm32_exti_chip_data *chip_data;
-	u8 desc_irq;
-	struct irq_fwspec *fwspec = data;
-	struct irq_fwspec p_fwspec;
-	irq_hw_number_t hwirq;
-	int bank;
-	u32 event_trg;
-	struct irq_chip *chip;
-
-	hwirq = fwspec->param[0];
-	if (hwirq >= host_data->drv_data->bank_nr * IRQS_PER_BANK)
-		return -EINVAL;
-
-	bank  = hwirq / IRQS_PER_BANK;
-	chip_data = &host_data->chips_data[bank];
-
-	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
-	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
-	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
-
-	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
-
-	if (!host_data->drv_data->desc_irqs)
-		return -EINVAL;
-
-	desc_irq = host_data->drv_data->desc_irqs[hwirq];
-	if (desc_irq != EXTI_INVALID_IRQ) {
-		p_fwspec.fwnode = dm->parent->fwnode;
-		p_fwspec.param_count = 3;
-		p_fwspec.param[0] = GIC_SPI;
-		p_fwspec.param[1] = desc_irq;
-		p_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
-
-		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
-	}
-
-	return 0;
-}
-
 static struct
 stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 					   struct device_node *node)
@@ -771,8 +293,6 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 		goto free_chips_data;
 	}
 
-	stm32_host_data = host_data;
-
 	return host_data;
 
 free_chips_data:
@@ -797,15 +317,12 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	chip_data->host_data = h_data;
 	chip_data->reg_bank = stm32_bank;
 
-	raw_spin_lock_init(&chip_data->rlock);
-
 	/*
 	 * This IP has no reset, so after hot reboot we should
 	 * clear registers to avoid residue
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
-	if (stm32_bank->emr_ofst != UNDEF_REG)
-		writel_relaxed(0, base + stm32_bank->emr_ofst);
+	writel_relaxed(0, base + stm32_bank->emr_ofst);
 
 	pr_info("%pOF: bank%d\n", node, bank_idx);
 
@@ -885,133 +402,6 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	return ret;
 }
 
-static const struct irq_domain_ops stm32_exti_h_domain_ops = {
-	.alloc	= stm32_exti_h_domain_alloc,
-	.free	= irq_domain_free_irqs_common,
-	.xlate = irq_domain_xlate_twocell,
-};
-
-static void stm32_exti_remove_irq(void *data)
-{
-	struct irq_domain *domain = data;
-
-	irq_domain_remove(domain);
-}
-
-static int stm32_exti_remove(struct platform_device *pdev)
-{
-	stm32_exti_h_syscore_deinit();
-	return 0;
-}
-
-static int stm32_exti_probe(struct platform_device *pdev)
-{
-	int ret, i;
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct irq_domain *parent_domain, *domain;
-	struct stm32_exti_host_data *host_data;
-	const struct stm32_exti_drv_data *drv_data;
-
-	host_data = devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
-	if (!host_data)
-		return -ENOMEM;
-
-	/* check for optional hwspinlock which may be not available yet */
-	ret = of_hwspin_lock_get_id(np, 0);
-	if (ret == -EPROBE_DEFER)
-		/* hwspinlock framework not yet ready */
-		return ret;
-
-	if (ret >= 0) {
-		host_data->hwlock = devm_hwspin_lock_request_specific(dev, ret);
-		if (!host_data->hwlock) {
-			dev_err(dev, "Failed to request hwspinlock\n");
-			return -EINVAL;
-		}
-	} else if (ret != -ENOENT) {
-		/* note: ENOENT is a valid case (means 'no hwspinlock') */
-		dev_err(dev, "Failed to get hwspinlock\n");
-		return ret;
-	}
-
-	/* initialize host_data */
-	drv_data = of_device_get_match_data(dev);
-	if (!drv_data) {
-		dev_err(dev, "no of match data\n");
-		return -ENODEV;
-	}
-	host_data->drv_data = drv_data;
-
-	host_data->chips_data = devm_kcalloc(dev, drv_data->bank_nr,
-					     sizeof(*host_data->chips_data),
-					     GFP_KERNEL);
-	if (!host_data->chips_data)
-		return -ENOMEM;
-
-	host_data->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host_data->base))
-		return PTR_ERR(host_data->base);
-
-	for (i = 0; i < drv_data->bank_nr; i++)
-		stm32_exti_chip_init(host_data, i, np);
-
-	parent_domain = irq_find_host(of_irq_find_parent(np));
-	if (!parent_domain) {
-		dev_err(dev, "GIC interrupt-parent not found\n");
-		return -EINVAL;
-	}
-
-	domain = irq_domain_add_hierarchy(parent_domain, 0,
-					  drv_data->bank_nr * IRQS_PER_BANK,
-					  np, &stm32_exti_h_domain_ops,
-					  host_data);
-
-	if (!domain) {
-		dev_err(dev, "Could not register exti domain\n");
-		return -ENOMEM;
-	}
-
-	ret = devm_add_action_or_reset(dev, stm32_exti_remove_irq, domain);
-	if (ret)
-		return ret;
-
-	stm32_exti_h_syscore_init(host_data);
-
-	return 0;
-}
-
-/* platform driver only for MP1 */
-static const struct of_device_id stm32_exti_ids[] = {
-	{ .compatible = "st,stm32mp1-exti", .data = &stm32mp1_drv_data},
-	{ .compatible = "st,stm32mp13-exti", .data = &stm32mp13_drv_data},
-	{},
-};
-MODULE_DEVICE_TABLE(of, stm32_exti_ids);
-
-static struct platform_driver stm32_exti_driver = {
-	.probe		= stm32_exti_probe,
-	.remove		= stm32_exti_remove,
-	.driver		= {
-		.name	= "stm32_exti",
-		.of_match_table = stm32_exti_ids,
-	},
-};
-
-static int __init stm32_exti_arch_init(void)
-{
-	return platform_driver_register(&stm32_exti_driver);
-}
-
-static void __exit stm32_exti_arch_exit(void)
-{
-	return platform_driver_unregister(&stm32_exti_driver);
-}
-
-arch_initcall(stm32_exti_arch_init);
-module_exit(stm32_exti_arch_exit);
-
-/* no platform driver for F4 and H7 */
 static int __init stm32f4_exti_of_init(struct device_node *np,
 				       struct device_node *parent)
 {
diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
new file mode 100644
index 0000000000000..6f607be9c9c43
--- /dev/null
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -0,0 +1,694 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics 2017-2024
+ * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/hwspinlock.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/syscore_ops.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define IRQS_PER_BANK			32
+
+#define HWSPNLCK_TIMEOUT		1000 /* usec */
+
+struct stm32_exti_bank {
+	u32 imr_ofst;
+	u32 rtsr_ofst;
+	u32 ftsr_ofst;
+	u32 swier_ofst;
+	u32 rpr_ofst;
+	u32 fpr_ofst;
+	u32 trg_ofst;
+};
+
+struct stm32_exti_drv_data {
+	const struct stm32_exti_bank **exti_banks;
+	const u8 *desc_irqs;
+	u32 bank_nr;
+};
+
+struct stm32_exti_chip_data {
+	struct stm32_exti_host_data *host_data;
+	const struct stm32_exti_bank *reg_bank;
+	struct raw_spinlock rlock;
+	u32 wake_active;
+	u32 mask_cache;
+	u32 rtsr_cache;
+	u32 ftsr_cache;
+};
+
+struct stm32_exti_host_data {
+	void __iomem *base;
+	struct stm32_exti_chip_data *chips_data;
+	const struct stm32_exti_drv_data *drv_data;
+	struct hwspinlock *hwlock;
+};
+
+static struct stm32_exti_host_data *stm32_host_data;
+
+static const struct stm32_exti_bank stm32mp1_exti_b1 = {
+	.imr_ofst	= 0x80,
+	.rtsr_ofst	= 0x00,
+	.ftsr_ofst	= 0x04,
+	.swier_ofst	= 0x08,
+	.rpr_ofst	= 0x0C,
+	.fpr_ofst	= 0x10,
+	.trg_ofst	= 0x3EC,
+};
+
+static const struct stm32_exti_bank stm32mp1_exti_b2 = {
+	.imr_ofst	= 0x90,
+	.rtsr_ofst	= 0x20,
+	.ftsr_ofst	= 0x24,
+	.swier_ofst	= 0x28,
+	.rpr_ofst	= 0x2C,
+	.fpr_ofst	= 0x30,
+	.trg_ofst	= 0x3E8,
+};
+
+static const struct stm32_exti_bank stm32mp1_exti_b3 = {
+	.imr_ofst	= 0xA0,
+	.rtsr_ofst	= 0x40,
+	.ftsr_ofst	= 0x44,
+	.swier_ofst	= 0x48,
+	.rpr_ofst	= 0x4C,
+	.fpr_ofst	= 0x50,
+	.trg_ofst	= 0x3E4,
+};
+
+static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
+	&stm32mp1_exti_b1,
+	&stm32mp1_exti_b2,
+	&stm32mp1_exti_b3,
+};
+
+static struct irq_chip stm32_exti_h_chip;
+static struct irq_chip stm32_exti_h_chip_direct;
+
+#define EXTI_INVALID_IRQ       U8_MAX
+#define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_BANK)
+
+/*
+ * Use some intentionally tricky logic here to initialize the whole array to
+ * EXTI_INVALID_IRQ, but then override certain fields, requiring us to indicate
+ * that we "know" that there are overrides in this structure, and we'll need to
+ * disable that warning from W=1 builds.
+ */
+__diag_push();
+__diag_ignore_all("-Woverride-init",
+		  "logic to initialize all and then override some is OK");
+
+static const u8 stm32mp1_desc_irq[] = {
+	/* default value */
+	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
+
+	[0] = 6,
+	[1] = 7,
+	[2] = 8,
+	[3] = 9,
+	[4] = 10,
+	[5] = 23,
+	[6] = 64,
+	[7] = 65,
+	[8] = 66,
+	[9] = 67,
+	[10] = 40,
+	[11] = 42,
+	[12] = 76,
+	[13] = 77,
+	[14] = 121,
+	[15] = 127,
+	[16] = 1,
+	[19] = 3,
+	[21] = 31,
+	[22] = 33,
+	[23] = 72,
+	[24] = 95,
+	[25] = 107,
+	[26] = 37,
+	[27] = 38,
+	[28] = 39,
+	[29] = 71,
+	[30] = 52,
+	[31] = 53,
+	[32] = 82,
+	[33] = 83,
+	[46] = 151,
+	[47] = 93,
+	[48] = 138,
+	[50] = 139,
+	[52] = 140,
+	[53] = 141,
+	[54] = 135,
+	[61] = 100,
+	[65] = 144,
+	[68] = 143,
+	[70] = 62,
+	[73] = 129,
+};
+
+static const u8 stm32mp13_desc_irq[] = {
+	/* default value */
+	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
+
+	[0] = 6,
+	[1] = 7,
+	[2] = 8,
+	[3] = 9,
+	[4] = 10,
+	[5] = 24,
+	[6] = 65,
+	[7] = 66,
+	[8] = 67,
+	[9] = 68,
+	[10] = 41,
+	[11] = 43,
+	[12] = 77,
+	[13] = 78,
+	[14] = 106,
+	[15] = 109,
+	[16] = 1,
+	[19] = 3,
+	[21] = 32,
+	[22] = 34,
+	[23] = 73,
+	[24] = 93,
+	[25] = 114,
+	[26] = 38,
+	[27] = 39,
+	[28] = 40,
+	[29] = 72,
+	[30] = 53,
+	[31] = 54,
+	[32] = 83,
+	[33] = 84,
+	[44] = 96,
+	[47] = 92,
+	[48] = 116,
+	[50] = 117,
+	[52] = 118,
+	[53] = 119,
+	[68] = 63,
+	[70] = 98,
+};
+
+__diag_pop();
+
+static const struct stm32_exti_drv_data stm32mp1_drv_data = {
+	.exti_banks = stm32mp1_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
+	.desc_irqs = stm32mp1_desc_irq,
+};
+
+static const struct stm32_exti_drv_data stm32mp13_drv_data = {
+	.exti_banks = stm32mp1_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
+	.desc_irqs = stm32mp13_desc_irq,
+};
+
+static int stm32_exti_set_type(struct irq_data *d,
+			       unsigned int type, u32 *rtsr, u32 *ftsr)
+{
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		*rtsr |= mask;
+		*ftsr &= ~mask;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		*rtsr &= ~mask;
+		*ftsr |= mask;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		*rtsr |= mask;
+		*ftsr |= mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void stm32_chip_suspend(struct stm32_exti_chip_data *chip_data,
+			       u32 wake_active)
+{
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+
+	/* save rtsr, ftsr registers */
+	chip_data->rtsr_cache = readl_relaxed(base + stm32_bank->rtsr_ofst);
+	chip_data->ftsr_cache = readl_relaxed(base + stm32_bank->ftsr_ofst);
+
+	writel_relaxed(wake_active, base + stm32_bank->imr_ofst);
+}
+
+static void stm32_chip_resume(struct stm32_exti_chip_data *chip_data,
+			      u32 mask_cache)
+{
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+
+	/* restore rtsr, ftsr, registers */
+	writel_relaxed(chip_data->rtsr_cache, base + stm32_bank->rtsr_ofst);
+	writel_relaxed(chip_data->ftsr_cache, base + stm32_bank->ftsr_ofst);
+
+	writel_relaxed(mask_cache, base + stm32_bank->imr_ofst);
+}
+
+/* directly set the target bit without reading first. */
+static inline void stm32_exti_write_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val = BIT(d->hwirq % IRQS_PER_BANK);
+
+	writel_relaxed(val, base + reg);
+}
+
+static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val;
+
+	val = readl_relaxed(base + reg);
+	val |= BIT(d->hwirq % IRQS_PER_BANK);
+	writel_relaxed(val, base + reg);
+
+	return val;
+}
+
+static inline u32 stm32_exti_clr_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val;
+
+	val = readl_relaxed(base + reg);
+	val &= ~BIT(d->hwirq % IRQS_PER_BANK);
+	writel_relaxed(val, base + reg);
+
+	return val;
+}
+
+static void stm32_exti_h_eoi(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+
+	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
+	stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
+
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_eoi_parent(d);
+}
+
+static void stm32_exti_h_mask(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+	chip_data->mask_cache = stm32_exti_clr_bit(d, stm32_bank->imr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_mask_parent(d);
+}
+
+static void stm32_exti_h_unmask(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_unmask_parent(d);
+}
+
+static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
+	void __iomem *base = chip_data->host_data->base;
+	u32 rtsr, ftsr;
+	int err;
+
+	raw_spin_lock(&chip_data->rlock);
+
+	if (hwlock) {
+		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
+		if (err) {
+			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
+			goto unlock;
+		}
+	}
+
+	rtsr = readl_relaxed(base + stm32_bank->rtsr_ofst);
+	ftsr = readl_relaxed(base + stm32_bank->ftsr_ofst);
+
+	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
+	if (err)
+		goto unspinlock;
+
+	writel_relaxed(rtsr, base + stm32_bank->rtsr_ofst);
+	writel_relaxed(ftsr, base + stm32_bank->ftsr_ofst);
+
+unspinlock:
+	if (hwlock)
+		hwspin_unlock_in_atomic(hwlock);
+unlock:
+	raw_spin_unlock(&chip_data->rlock);
+
+	return err;
+}
+
+static int stm32_exti_h_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
+
+	raw_spin_lock(&chip_data->rlock);
+
+	if (on)
+		chip_data->wake_active |= mask;
+	else
+		chip_data->wake_active &= ~mask;
+
+	raw_spin_unlock(&chip_data->rlock);
+
+	return 0;
+}
+
+static int stm32_exti_h_set_affinity(struct irq_data *d,
+				     const struct cpumask *dest, bool force)
+{
+	if (d->parent_data->chip)
+		return irq_chip_set_affinity_parent(d, dest, force);
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+
+static int __maybe_unused stm32_exti_h_suspend(void)
+{
+	struct stm32_exti_chip_data *chip_data;
+	int i;
+
+	for (i = 0; i < stm32_host_data->drv_data->bank_nr; i++) {
+		chip_data = &stm32_host_data->chips_data[i];
+		raw_spin_lock(&chip_data->rlock);
+		stm32_chip_suspend(chip_data, chip_data->wake_active);
+		raw_spin_unlock(&chip_data->rlock);
+	}
+
+	return 0;
+}
+
+static void __maybe_unused stm32_exti_h_resume(void)
+{
+	struct stm32_exti_chip_data *chip_data;
+	int i;
+
+	for (i = 0; i < stm32_host_data->drv_data->bank_nr; i++) {
+		chip_data = &stm32_host_data->chips_data[i];
+		raw_spin_lock(&chip_data->rlock);
+		stm32_chip_resume(chip_data, chip_data->mask_cache);
+		raw_spin_unlock(&chip_data->rlock);
+	}
+}
+
+static struct syscore_ops stm32_exti_h_syscore_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= stm32_exti_h_suspend,
+	.resume		= stm32_exti_h_resume,
+#endif
+};
+
+static void stm32_exti_h_syscore_init(struct stm32_exti_host_data *host_data)
+{
+	stm32_host_data = host_data;
+	register_syscore_ops(&stm32_exti_h_syscore_ops);
+}
+
+static void stm32_exti_h_syscore_deinit(void)
+{
+	unregister_syscore_ops(&stm32_exti_h_syscore_ops);
+}
+
+static int stm32_exti_h_retrigger(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
+
+	writel_relaxed(mask, base + stm32_bank->swier_ofst);
+
+	return 0;
+}
+
+static struct irq_chip stm32_exti_h_chip = {
+	.name			= "stm32-exti-h",
+	.irq_eoi		= stm32_exti_h_eoi,
+	.irq_mask		= stm32_exti_h_mask,
+	.irq_unmask		= stm32_exti_h_unmask,
+	.irq_retrigger		= stm32_exti_h_retrigger,
+	.irq_set_type		= stm32_exti_h_set_type,
+	.irq_set_wake		= stm32_exti_h_set_wake,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
+	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : NULL,
+};
+
+static struct irq_chip stm32_exti_h_chip_direct = {
+	.name			= "stm32-exti-h-direct",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= stm32_exti_h_mask,
+	.irq_unmask		= stm32_exti_h_unmask,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_wake		= stm32_exti_h_set_wake,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
+	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? irq_chip_set_affinity_parent : NULL,
+};
+
+static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
+				     unsigned int virq,
+				     unsigned int nr_irqs, void *data)
+{
+	struct stm32_exti_host_data *host_data = dm->host_data;
+	struct stm32_exti_chip_data *chip_data;
+	u8 desc_irq;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec p_fwspec;
+	irq_hw_number_t hwirq;
+	int bank;
+	u32 event_trg;
+	struct irq_chip *chip;
+
+	hwirq = fwspec->param[0];
+	if (hwirq >= host_data->drv_data->bank_nr * IRQS_PER_BANK)
+		return -EINVAL;
+
+	bank  = hwirq / IRQS_PER_BANK;
+	chip_data = &host_data->chips_data[bank];
+
+	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
+	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
+	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
+
+	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
+
+	if (!host_data->drv_data->desc_irqs)
+		return -EINVAL;
+
+	desc_irq = host_data->drv_data->desc_irqs[hwirq];
+	if (desc_irq != EXTI_INVALID_IRQ) {
+		p_fwspec.fwnode = dm->parent->fwnode;
+		p_fwspec.param_count = 3;
+		p_fwspec.param[0] = GIC_SPI;
+		p_fwspec.param[1] = desc_irq;
+		p_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
+
+		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
+	}
+
+	return 0;
+}
+
+static struct
+stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
+					   u32 bank_idx,
+					   struct device_node *node)
+{
+	const struct stm32_exti_bank *stm32_bank;
+	struct stm32_exti_chip_data *chip_data;
+	void __iomem *base = h_data->base;
+
+	stm32_bank = h_data->drv_data->exti_banks[bank_idx];
+	chip_data = &h_data->chips_data[bank_idx];
+	chip_data->host_data = h_data;
+	chip_data->reg_bank = stm32_bank;
+
+	raw_spin_lock_init(&chip_data->rlock);
+
+	/*
+	 * This IP has no reset, so after hot reboot we should
+	 * clear registers to avoid residue
+	 */
+	writel_relaxed(0, base + stm32_bank->imr_ofst);
+
+	pr_info("%pOF: bank%d\n", node, bank_idx);
+
+	return chip_data;
+}
+
+static const struct irq_domain_ops stm32_exti_h_domain_ops = {
+	.alloc	= stm32_exti_h_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+	.xlate = irq_domain_xlate_twocell,
+};
+
+static void stm32_exti_remove_irq(void *data)
+{
+	struct irq_domain *domain = data;
+
+	irq_domain_remove(domain);
+}
+
+static int stm32_exti_remove(struct platform_device *pdev)
+{
+	stm32_exti_h_syscore_deinit();
+	return 0;
+}
+
+static int stm32_exti_probe(struct platform_device *pdev)
+{
+	int ret, i;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct irq_domain *parent_domain, *domain;
+	struct stm32_exti_host_data *host_data;
+	const struct stm32_exti_drv_data *drv_data;
+
+	host_data = devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
+	if (!host_data)
+		return -ENOMEM;
+
+	/* check for optional hwspinlock which may be not available yet */
+	ret = of_hwspin_lock_get_id(np, 0);
+	if (ret == -EPROBE_DEFER)
+		/* hwspinlock framework not yet ready */
+		return ret;
+
+	if (ret >= 0) {
+		host_data->hwlock = devm_hwspin_lock_request_specific(dev, ret);
+		if (!host_data->hwlock) {
+			dev_err(dev, "Failed to request hwspinlock\n");
+			return -EINVAL;
+		}
+	} else if (ret != -ENOENT) {
+		/* note: ENOENT is a valid case (means 'no hwspinlock') */
+		dev_err(dev, "Failed to get hwspinlock\n");
+		return ret;
+	}
+
+	/* initialize host_data */
+	drv_data = of_device_get_match_data(dev);
+	if (!drv_data) {
+		dev_err(dev, "no of match data\n");
+		return -ENODEV;
+	}
+	host_data->drv_data = drv_data;
+
+	host_data->chips_data = devm_kcalloc(dev, drv_data->bank_nr,
+					     sizeof(*host_data->chips_data),
+					     GFP_KERNEL);
+	if (!host_data->chips_data)
+		return -ENOMEM;
+
+	host_data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(host_data->base))
+		return PTR_ERR(host_data->base);
+
+	for (i = 0; i < drv_data->bank_nr; i++)
+		stm32_exti_chip_init(host_data, i, np);
+
+	parent_domain = irq_find_host(of_irq_find_parent(np));
+	if (!parent_domain) {
+		dev_err(dev, "GIC interrupt-parent not found\n");
+		return -EINVAL;
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0,
+					  drv_data->bank_nr * IRQS_PER_BANK,
+					  np, &stm32_exti_h_domain_ops,
+					  host_data);
+
+	if (!domain) {
+		dev_err(dev, "Could not register exti domain\n");
+		return -ENOMEM;
+	}
+
+	ret = devm_add_action_or_reset(dev, stm32_exti_remove_irq, domain);
+	if (ret)
+		return ret;
+
+	stm32_exti_h_syscore_init(host_data);
+
+	return 0;
+}
+
+/* platform driver only for MP1 */
+static const struct of_device_id stm32_exti_ids[] = {
+	{ .compatible = "st,stm32mp1-exti", .data = &stm32mp1_drv_data},
+	{ .compatible = "st,stm32mp13-exti", .data = &stm32mp13_drv_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_exti_ids);
+
+static struct platform_driver stm32_exti_driver = {
+	.probe		= stm32_exti_probe,
+	.remove		= stm32_exti_remove,
+	.driver		= {
+		.name	= "stm32_exti",
+		.of_match_table = stm32_exti_ids,
+	},
+};
+
+static int __init stm32_exti_arch_init(void)
+{
+	return platform_driver_register(&stm32_exti_driver);
+}
+
+static void __exit stm32_exti_arch_exit(void)
+{
+	return platform_driver_unregister(&stm32_exti_driver);
+}
+
+arch_initcall(stm32_exti_arch_init);
+module_exit(stm32_exti_arch_exit);
-- 
2.53.0

