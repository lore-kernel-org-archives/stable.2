Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144508;
	b=2qpg+vG/SmnS48cdSRqo81CzKbj3WjIach+3x5Db45OPwkV7f47umss+6JDwFrl/R9iO
	 el9KAI6mtF4pl9r6Zp2G2zi9ZqyK0YE508juueSQc8nnPWYCCNp7zXqG8MlUg9bN1xPI2
	 2kIDY1+2b6QCN1MXnH1ALR9WkBAx9Tc4Lr9usSScgfKOHKRmjpsVsAd2kYVcr2It3WogK
	 E9Dr0JQxgtXajq8qZ9RviFBfGwzLm2zwRq+4S02Qjr2EPlRETbcYRN/oAxrnEVOh3QuxK
	 S2AEcrJwkhkXn8QszszvjY7cF0bZTNrv74rL/dRB0KHdHEvtPL66pjYv60hPa5IRz7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=lhS7dKn58LbnkCFuq1c0W0WnbhAsxOSnxkZUAoZjE8w=;
	b=1xvRZQi/1+gDmOqF/ix3b2Nh9rzflvaKQqo3OoW7i86kP/kIMt1b9Ij/8eBHdt11fLJJ
	 ywsenouVTFgkBsyi4MzIaNoyFP8ZMcfQkbNIQ2xOHSeVYUz5PXZI9PvQThWBRZBnoZ1ha
	 TsnerRBjK9MTWyal1N2o7x/cYM/Sdfv2EnGazACjxtM+IzhTsrcGVcjxLUgIMYFMury6c
	 HVlIP/pR8LLk+HI+oHcx2133vhrJi7E4aUwzAPg1LweibZ+iQkxmrz86sM4jtizyFUocU
	 MiycCWfUAjWl4rd/u1IlYuCeP8cKKJqnqi+HfFbW6wqMhox71GJAASqLGiG+66QCp4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBT+Xa7w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DD606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBT+Xa7w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F4A1F0089F;
	Sun,  8 Nov 2026 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794144507;
	bh=lhS7dKn58LbnkCFuq1c0W0WnbhAsxOSnxkZUAoZjE8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FBT+Xa7wbjeEW8J5tx/RjdNvw25YzMpO8S6WUTkd67lEI8d5EUpLhJGJWdC2hB9PH
	 arXxbWlKKFe+OF7NADglgXKTxOSXbLjSAaFos+lCCMF4iLKXaKhP64kIwEJjNfhof/
	 l+8tQv1V0SCDuRNWVmuuSjL+r+EyJvW3CdOt80jmqjx3MnLaQF3o4kTyRmNwX1CD/K
	 7b5akur5ISKiL5SGauXeHCugClqU250sj1InO9XYptAC1KMHvib/t0VnFlvvXkZ6Si
	 Z6SxtXHpy4ml91h4BNUREgc93cvrvHBtXsywvRBCkbZPx5iSFmfpKP7EZbdD3edpUp
	 31A6kujKfUIUA==
From: Thomas Gleixner <tglx@kernel.org>
To: Sasha Levin <sashal@kernel.org>, iav@iav.lv
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y, 6.1.y, 5.15.y, 5.10.y] genirq/kexec: Do not take the
 bus lock of an interrupt chip on the crash path
In-Reply-To: <20261107053823-failed-6.6-717862eac6ef@kernel.org>
References: <20261107053823-failed-6.6-717862eac6ef@kernel.org>
Date: Sun, 08 Nov 2026 14:28:23 +0100
Message-ID: <877binwiyw.ffs@fw13>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

From: Igor Velkov <iav@iav.lv>

commit 717862eac6eff0eea8ac30a0c0de0bed84922aab upstream.

machine_kexec_mask_interrupts() calls irq_set_irqchip_state() for every
started interrupt. That function takes the bus lock of the chip and
desc->lock, and syncs the chip when it drops them. On the crash path
interrupts are off and the other CPUs are stopped, so a chip whose bus
transfer is completed by an interrupt never returns from the sync.

On RK3399 boards with an RK808 PMIC the RTC alarm interrupt belongs to
the regmap-irq chip of the RK808, which sits on I2C. rk808_irq_chip sets
init_ack_masked, so regmap_irq_sync_unlock() writes the ack register on
every unlock, and the I2C controller needs its own interrupt to finish
the transfer. A panic with a crash kernel loaded prints

  SMP: stopping secondary CPUs

and then nothing until the watchdog resets the board.

machine_kexec_mask_interrupts() takes neither lock for the other
operations on the descriptor. Move the search for the chip that
implements irq_set_irqchip_state() into __irq_set_irqchip_state(), which
takes no locks, and call it from machine_kexec_mask_interrupts().

Fixes: 78fd584cdec0 ("arm64: kdump: implement machine_crash_shutdown()")
Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Igor Velkov <iav@iav.lv>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261015-kexec-irq-bus-lock-v2-1-2af15f0757b6@iav.lv
---
 arch/arm64/kernel/machine_kexec.c |    2 -
 include/linux/interrupt.h         |    1 
 kernel/irq/manage.c               |   49 +++++++++++++++++++-------------------
 3 files changed, 27 insertions(+), 25 deletions(-)
---
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -234,7 +234,7 @@ static void machine_kexec_mask_interrupt
 		 * First try to remove the active state. If this
 		 * fails, try to EOI the interrupt.
 		 */
-		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
+		ret = __irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
 
 		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
 		    chip->irq_eoi)
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -505,6 +505,7 @@ extern int irq_get_irqchip_state(unsigne
 				 bool *state);
 extern int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 				 bool state);
+extern int __irq_set_irqchip_state(struct irq_desc *desc, enum irqchip_irq_state which, bool val);
 
 #ifdef CONFIG_IRQ_FORCED_THREADING
 # ifdef CONFIG_PREEMPT_RT
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2844,6 +2844,28 @@ int irq_get_irqchip_state(unsigned int i
 }
 EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
 
+int __irq_set_irqchip_state(struct irq_desc *desc, enum irqchip_irq_state which, bool val)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip;
+
+	do {
+		chip = irq_data_get_irq_chip(data);
+
+		if (WARN_ON_ONCE(!chip))
+			return -ENODEV;
+
+		if (chip->irq_set_irqchip_state)
+			break;
+
+		data = irqd_get_parent_data(data);
+	} while (data);
+
+	if (data)
+		return chip->irq_set_irqchip_state(data, which, val);
+	return -EINVAL;
+}
+
 /**
  *	irq_set_irqchip_state - set the state of a forwarded interrupt.
  *	@irq: Interrupt line that is forwarded to a VM
@@ -2860,36 +2882,15 @@ int irq_set_irqchip_state(unsigned int i
 			  bool val)
 {
 	struct irq_desc *desc;
-	struct irq_data *data;
-	struct irq_chip *chip;
 	unsigned long flags;
-	int err = -EINVAL;
+	int err;
 
 	desc = irq_get_desc_buslock(irq, &flags, 0);
 	if (!desc)
-		return err;
-
-	data = irq_desc_get_irq_data(desc);
-
-	do {
-		chip = irq_data_get_irq_chip(data);
-		if (WARN_ON_ONCE(!chip)) {
-			err = -ENODEV;
-			goto out_unlock;
-		}
-		if (chip->irq_set_irqchip_state)
-			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-		data = data->parent_data;
-#else
-		data = NULL;
-#endif
-	} while (data);
+		return -EINVAL;
 
-	if (data)
-		err = chip->irq_set_irqchip_state(data, which, val);
+	err = __irq_set_irqchip_state(desc, which, val);
 
-out_unlock:
 	irq_put_desc_busunlock(desc, flags);
 	return err;
 }
