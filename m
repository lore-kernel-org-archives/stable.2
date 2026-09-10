Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A907F4A99A7
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054672; cv=none; b=WGvi6sNy+o1WIFjaIyuv38uqFGFVujJnwFqRoSdH85zDx3J+gYuPgq8T68/MdrJpZ1G4e6NyUsahYbAN4UTkAiq35xa+pYR36DALvqj7us0bAEF3SjXrYC8CbFEX03ZmXByku4aWJqGs7s35sNmN9RnLA+7RHj4FL9dSY7dkwPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054672; c=relaxed/simple;
	bh=AKs2Rb5vNsPnyve4aRySOuhYwPe1zsOvm1Vn4OSMtr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jg+37sP+RemmFaqsWOuKJ9pwHQTBzVU0pKyz/YfwZRldUcCJkNL8vfionrY5xWiu5S4/Rj+pG3mmKiigBAk0htRBwh/WrySi1F+LfmAddMc1r70pfMBVELv+vfvoKc9HRoDueZqGpaH9lfg6jFrmWqOtPELI0gevRUyXVQh7CLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp2aDSW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp2aDSW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7B81F000FF;
	Thu, 10 Sep 2026 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054670;
	bh=ow8StEg6IbtBDw+jyWRHupVqZ3rRErCQbTZUjnzL3b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wp2aDSW2d1+xAxkevqbCilPYBqo8EbCmtRfM7huO5HXi3eFJHjhbogHCpszqijr7S
	 TdWe9rfgImXXDNPOEes7NIikrJNj1HTNn+m1K+mljLBBxX8TzuBzYsorae7caEiGH7
	 bHnsp1UpFRIo2FwFnnt/5WXF+CdOIg0GfLLdAvzgumtykZA+teFGNz1qaSoRtsJVaK
	 sfjm/q6L80AqKxzVb4MJle6E/GuEGTPOoLZyicca2jtYuRSKVuwzuEmcFB6rCFkwLR
	 PyjTizdG+uKFxspdBeCp+L2/UaZAsOpbOpga/Z8PrnKjbLdmVwSriu4jaDIeO269mC
	 hKXJkRfo47jnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] irqchip/stm32-exti: Split MCU and MPU code
Date: Thu, 10 Sep 2026 11:37:47 -0400
Message-ID: <20260910153748.993578-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090813-gallery-jackpot-25e8@gregkh>
References: <2026090813-gallery-jackpot-25e8@gregkh>
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

Backport dependency adaptation for Linux 6.1:

The stable driver predates STM32MP_EXTI selection, standard device PM,
interrupts-extended mappings, and secure/RIF event handling. Importing the
upstream split would pull in those unrelated changes and new functions.
Limit this dependency to relocating the existing combined MCU/MPU driver
to irq-stm32mp-exti.c and updating its existing STM32_EXTI Makefile entry.
Keep Kconfig, syscore PM, interrupt mappings, and all existing functions.

Retain the upstream removal of unused hwspinlock handling from the MCU
set-type callback: MCU host initialization never assigns a hwspinlock.
This leaves the MPU callback as the only timeout user, so the target's
macro rename fixes all remaining users without leaving an undefined name.

Match the upstream timeout-definition context, including its two register
macros, so d31fbbade43f880b7e59e2b3a72722fe2725d93f applies unchanged. The
register macros remain unused; no secure/RIF behavior is introduced.

[ sashal: Reduced backport -- upstream 350755e2e548c touches 4 file(s), this
  backport carries 2. Not backported here:
  drivers/irqchip/irq-stm32-exti.c
  drivers/irqchip/Kconfig
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: d31fbbade43f ("irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/Makefile                      |  2 +-
 .../{irq-stm32-exti.c => irq-stm32mp-exti.c}  | 21 ++++++-------------
 2 files changed, 7 insertions(+), 16 deletions(-)
 rename drivers/irqchip/{irq-stm32-exti.c => irq-stm32mp-exti.c} (98%)

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index f88cbf36a9d28..16a8e5e152a18 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -86,7 +86,7 @@ obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
-obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
+obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32mp-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
 obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
 obj-$(CONFIG_ARCH_SYNQUACER)		+= irq-sni-exiu.o
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
similarity index 98%
rename from drivers/irqchip/irq-stm32-exti.c
rename to drivers/irqchip/irq-stm32mp-exti.c
index 9c150c402f0ba..71a46e76d8320 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -22,9 +22,12 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#define IRQS_PER_BANK 32
+#define IRQS_PER_BANK			32
 
-#define HWSPNLCK_TIMEOUT	1000 /* usec */
+#define HWSPNLCK_TIMEOUT		1000 /* usec */
+
+#define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
+#define EXTI_HWCFGR1			0x3f0
 
 struct stm32_exti_bank {
 	u32 imr_ofst;
@@ -306,33 +309,21 @@ static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
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
 
-- 
2.53.0

