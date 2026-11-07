Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050890;
	b=S5+LyU7CF5zK0k/TGuqlsGqn50P4WM2EwjrYM2JUoNPcnZZSylHP7osOA5t8nXNyv2Rg
	 Z832yf2ArfbG/EAFY4wf6U8DLWl42RX50cPYDkMR7J4lZAzAbdfmzTNO+eWSdahr6YPa3
	 WwGLqIFyk9SWmuxZYG+XjQlrms7Rjo3bjNvJE0HzhVejAITHhkTpllDzA/+w9qfkNtyqQ
	 HP2FabzN8TzYNzW1viBsUAvPKbomqzdfSYcz9cBI5on1quGYXvrhOI2or2/OICcI305v4
	 fuI/CsgcFVHIrWCkKjbiDgfIpprXe+4hgfr0zPOem0ECBnlC/CnVGI6Tv93Cmk853RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050890;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R1S/NWzL4e8qXToj5LgNOJHIfvbYHBtuDoKJae536cg=;
	b=IokJUjS4ZVY8AP0lZxn58urHFlWofO80FxMgFvv6HMz65R4wNFvfTDce/DjzisRfHeLF
	 RXEYiYTp7M8+FtcrJTNFMipmozMY9hY50qjoghy5bZK+uGmOj1C8vD+ALc47/ggMwrA73
	 UcSdjkRr5MtDVzqg7ruD9dV8NdcSqzEZujxoRfUFY1oMrspX0d5MoSPjMhrI+8CqoFd+0
	 fmSQqbP4bD9vlJdIL+zUV8v6prBSmDLY1Nb9f2Kn9T0r7r4AkRBZglmgNDpuI4d9k74xh
	 qiN7EfS2sUtuae8w/VgZdFVhnGt+k5wsltu0e2pWcmVgNR82/yEF/NNU7wzJ0Lu8sRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acHCXc9B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acHCXc9B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7071F0089F;
	Sat,  7 Nov 2026 11:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050890;
	bh=R1S/NWzL4e8qXToj5LgNOJHIfvbYHBtuDoKJae536cg=;
	h=From:To:Cc:Subject:Date;
	b=acHCXc9BMLZbChOoIcyUCZNltuQk2zIwY7LvTdMcRCdLtb/Z1d6PObSOy/lLkdT2s
	 9yARV20bWHA9sXCkTMEeESDsTmwbXi5agRadMatsmkGBAP51IQrb/mjTNMS2ZdHtJa
	 8F/S82gPY/uMgqdlFdB/Ne5ZStc09HAwcn0bE5JukiplHqEo4NzpDTHb4vE3HzHmoB
	 vcsqFv/jo1Bi6QiJrF9+9mc5Dp1TllSUs1/pX6pvIiPyLm6JWGKSQDOLFG1dyKwEbe
	 VlyWBwOfpHcv59jgVyR4WonN35YL8Cr6qVwpsmtCXwTgLd/LLr0am6hxhr0G9ZtDBB
	 6xSwkb5NQwLTA==
From: Sasha Levin <sashal@kernel.org>
To: iav@iav.lv,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:08 -0500
Message-ID: <20261107062808-failed-5.10-717862eac6ef@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 717862eac6eff0eea8ac30a0c0de0bed84922aab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062808-failed-5.10-717862eac6ef@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




