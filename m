Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239226;
	b=bilTB9nEfXP8DQmibAnIhIkaHlrsgIu1vVZtIDd5RVqF81ztZH/MfrqILE/gkM1mi37/
	 Oosc0Hanecji96FrzzTNjopUUzs7KrcalcTnFNFOMK+A7i/d/o4D4fGMFUBT0SGu2IJSC
	 rOtWjpiPBhzbiw6lqUUQ8rwpRyvWRL+KFF93/Z350GM7BxOEoMyOXGnAyqOpkdIJF68wB
	 nclVg8Ye6DkbhNbSZpH4u4TytUI6709370PG+XPOzavsCLJE+ngsi9zBJAv1HITNIGrCG
	 IhAcc865Osrni5JeZp5tSKlgpuNVpdLznbf36NN/v8OpNHW60o09GpKRLu1pElHyjPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239226;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=PL+oxLY6mvYG5pGB/Nsx7MJwGOzVQ4K6Xsiuf4W1MLo=;
	b=3iyb5qcWzQTYyN+UPFY4YhgoP7aqsi3R8eGxGvXweDPmWhUk1EnCHmLCh5XnEkDKpypJ
	 W/vNSVjuTRPC3QIjXlJ+Dmn/E0WEWIfDIJsl+i42p5Uj/mVKdFa+YdryVMwrp+hDFMLS/
	 yET24Hv9pxtQZFmBWeRgeMtKG2Rl3QqWT79QaScwmn1nsGhxxR+D8BkSTk9pjCalgULsr
	 EhI1iZ5HLmTmGzV63jsM2JuAojhtwuuK39DTryXF1jZuteVsdBaFEAnxBUH9zpoUCxf/B
	 5zUeLWOlx2IFvmfd/n3NPj4e5O9IMILI1/ICIiRf8mFX850YIdK5gR0qUapy4iYZR9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oIAe/0MJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02992606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIAe/0MJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30511F0089F;
	Mon,  9 Nov 2026 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239225;
	bh=PL+oxLY6mvYG5pGB/Nsx7MJwGOzVQ4K6Xsiuf4W1MLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=oIAe/0MJQCqhFQgt2bJMb2nlkX+NMY7BxUMsF69do6eYFD6BjV7hEcVlHOo63oOLA
	 1CLriN8+thWbBIeBDXo6BZaNkW4xEqgTC5UlfvlOwvunpo/FItr2JYeIh5fVlNjsKh
	 rti2uEUKVJSj6InMVYsCqKLDkczN2XxPbUVcCU0qMow9cbB6i+BUO/8hnHAdvY1T+m
	 iC8ktaqouQuXBdjAXjQAelF4nr8n/sDLrwaR9sbW0IwC0AUy0NE4dSVscuYTe6gEkK
	 G+Vg3gfR9Qzf/iTlNXO0jc33q9WYpPgAeCULT1X0QNJK06ivHWpINMzivso66BxAIL
	 +IieVyAQsYUgw==
From: Thomas Gleixner <tglx@kernel.org>
To: Sasha Levin <sashal@kernel.org>, iav@iav.lv
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 6.6.y, 6.1.y, 5.15.y, 5.10.y] genirq/kexec: Do not take
 the bus lock of an interrupt chip on the crash path
In-Reply-To: <2026-11-08-1-daily-reply-0008-genirq-kexec-6-6@kernel.org>
References: <877binwiyw.ffs@fw13>
 <2026-11-08-1-daily-reply-0008-genirq-kexec-6-6@kernel.org>
Date: Mon, 09 Nov 2026 16:47:02 +0100
Message-ID: <87eccuuhvt.ffs@fw13>
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
V2: Use the proper argument for __irq_set_irqchip_state() - Igor, Sasha
---
 arch/arm64/kernel/machine_kexec.c |    2 -
 include/linux/interrupt.h         |    1 
 kernel/irq/manage.c               |   49 +++++++++++++++++++-------------------
 3 files changed, 27 insertions(+), 25 deletions(-)
---
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -230,7 +230,7 @@ static void machine_kexec_mask_interrupt
 		 * First try to remove the active state. If this
 		 * fails, try to EOI the interrupt.
 		 */
-		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
+		ret = __irq_set_irqchip_state(desc, IRQCHIP_STATE_ACTIVE, false);
 
 		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
 		    chip->irq_eoi)
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -518,6 +518,7 @@ extern int irq_get_irqchip_state(unsigne
 				 bool *state);
 extern int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 				 bool state);
+extern int __irq_set_irqchip_state(struct irq_desc *desc, enum irqchip_irq_state which, bool val);
 
 #ifdef CONFIG_IRQ_FORCED_THREADING
 # ifdef CONFIG_PREEMPT_RT
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2848,6 +2848,28 @@ int irq_get_irqchip_state(unsigned int i
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
@@ -2864,36 +2886,15 @@ int irq_set_irqchip_state(unsigned int i
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
