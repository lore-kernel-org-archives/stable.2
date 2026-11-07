Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048832;
	b=SClLEYvVnaQN4fONLlB6YSLfQ8XuAoFNiykPbksURg/ntmTG0o5hH5SzBP4+L/6EatJ3
	 M++8xILoAXMDEdlBUem7pMIbINL2TRRFe6TZ4fqS5esbp026JzKEdGmEHlvLTndVw0LNh
	 dBX3YXRe4P4gJwnsIqmD1sht2lDO0Mo2EoulDrAbNqTBbf4XadcxGYkHXtWHoYE/V1ILE
	 +2zoG6dkDTDXuH4Dbe8lrjYoyymqS2W3wfGeeF59v1r3SBBsuWrcD02jjf6OhqGkO2EmI
	 fi3kqwQcewTXafsJKz7fqZnRzPO6pzk+WdxvxJJ+Tqoc97+EuKGmPdx4buT4wRgJeUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=F6ko1T6UeUCiK9AwvHL7J2QTEl7Wz4HaUPFYWMLXmDo=;
	b=tvbZlYWmSwTYJeMFq8+aoc40+xqKR4OffnGzAvxnrq9Q/8nNWH6IpUDjy+sWSUVzrXgH
	 gU/4DL1NcsmSLdpQ0Yc4YqEU0QSPJ2bFR5FN5I2l3t/9yF2/8ELhRy57gWU7Y6VtZvSee
	 hk/GiEC8ZHCAaoiQMipZeFMkNUvVLS2laql7xVkrqAatjSFCcAa9hc9MGfgZT4B3mQHEJ
	 LM5oMISeEy0ICPbfihoLezq3qrgokc0pRkc+A1dL9VxGNyQisvsTwttPgtLYokiis7GNC
	 K9XY06zjoNHFNtA/3NbuyPnnKeZPHx1PvhJ0kMgDN1HoovHLgjAXZgwG2BD1wy43x5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DULuw5BW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A8606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DULuw5BW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B1D1F0089F;
	Sat,  7 Nov 2026 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048832;
	bh=F6ko1T6UeUCiK9AwvHL7J2QTEl7Wz4HaUPFYWMLXmDo=;
	h=From:To:Cc:Subject:Date;
	b=DULuw5BWnR3YVZwEN4zD0XbJYJiBEu6TJ/C7JmnD2vRabLRjUYjcWac4RoAHoyAJr
	 22SS7Eq4FdLTg4/gwV6TaAwyq0wgrayq4L1XAAsUs+99SNy/sQ9UESOgAw45O1vLDL
	 M2q2DHnLA/0lmZIBGEhcwJ/pzS/Z9NRcW3gQMiQBO+tXCtcrAYSiDf7OhJWrzprk4T
	 g/eT9vW+3+OfBnse66iRN0tNrHsxRhKEbIhcbcwCnGJurS1FD9jQHEnH62QvJccApx
	 3Cakxa83M4h5t2Z+Ej/MhEikjzLLnWfj4F6I03Qha1VKkMxgSXWwIt5OCQOQL9b9cz
	 AL/pV6Mxu6dpg==
From: Sasha Levin <sashal@kernel.org>
To: iav@iav.lv,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:50 -0500
Message-ID: <20261107055350-failed-6.1-717862eac6ef@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 717862eac6eff0eea8ac30a0c0de0bed84922aab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055350-failed-6.1-717862eac6ef@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 717862eac6eff0eea8ac30a0c0de0bed84922aab Mon Sep 17 00:00:00 2001
From: Igor Velkov <iav@iav.lv>
Date: Thu, 15 Oct 2026 21:51:50 +0300
Subject: [PATCH] genirq/kexec: Do not take the bus lock of an interrupt chip
 on the crash path

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
 kernel/irq/internals.h |  1 +
 kernel/irq/kexec.c     |  2 +-
 kernel/irq/manage.c    | 43 +++++++++++++++++++++++-------------------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 0ce21dd454047..4dff3ccae1812 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -81,6 +81,7 @@ enum {
 #include "settings.h"
 
 extern int __irq_set_trigger(struct irq_desc *desc, unsigned long flags);
+extern int __irq_set_irqchip_state(struct irq_desc *desc, enum irqchip_irq_state which, bool val);
 extern void __disable_irq(struct irq_desc *desc);
 extern void __enable_irq(struct irq_desc *desc);
 
diff --git a/kernel/irq/kexec.c b/kernel/irq/kexec.c
index 1a3deffe6b5b6..f245b98764225 100644
--- a/kernel/irq/kexec.c
+++ b/kernel/irq/kexec.c
@@ -25,7 +25,7 @@ void machine_kexec_mask_interrupts(void)
 			 * First try to remove the active state from an interrupt which is forwarded
 			 * to a VM. If the interrupt is not forwarded, try to EOI the interrupt.
 			 */
-			check_eoi = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
+			check_eoi = __irq_set_irqchip_state(desc, IRQCHIP_STATE_ACTIVE, false);
 		}
 
 		if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 57eff26fa646a..bdb47837c66fc 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2735,6 +2735,28 @@ int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which, bool *
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
  * irq_set_irqchip_state - set the state of a forwarded interrupt.
  * @irq:	Interrupt line that is forwarded to a VM
@@ -2749,25 +2771,8 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which, bool val)
 {
-	scoped_irqdesc_get_and_buslock(irq, 0) {
-		struct irq_data *data = irq_desc_get_irq_data(scoped_irqdesc);
-		struct irq_chip *chip;
-
-		do {
-			chip = irq_data_get_irq_chip(data);
-
-			if (WARN_ON_ONCE(!chip))
-				return -ENODEV;
-
-			if (chip->irq_set_irqchip_state)
-				break;
-
-			data = irqd_get_parent_data(data);
-		} while (data);
-
-		if (data)
-			return chip->irq_set_irqchip_state(data, which, val);
-	}
+	scoped_irqdesc_get_and_buslock(irq, 0)
+		return __irq_set_irqchip_state(scoped_irqdesc, which, val);
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_set_irqchip_state);
-- 
2.53.0




