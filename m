Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790641;
	b=4Nzxo2+fj25ponHg4nBjCWrnGFQ9MPRkNo44ZfEiCFLsqJUpyb0iLd7EfJcbqDsjlgZp
	 ms2F1Jrt4XYm7aruZyVMUyV3AjFK2P+yFE5NSvbRD7cO6khmOKu1/uvLsbjVtyRKDGy6l
	 Lp+uoSSuYQVt4lK9PimmOhbp/zva9x6SJP3n3A7ODf0bph6vtub4BHDL58TxzPG8rfMKT
	 dRKXfYh72JDSzo2WbUJSUEU2o71GlwakdDTvCy7Vg3oFOHbZAAfukqI7A/UqvWXjerXxa
	 2Dy97BTj1ivsxkCLFrBuPV+u+XLIkGapyrt7RIRJxTTFkJWExy5zpMfalLXR6O+37+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790641;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=8zNIwem/ycMreXfdXv1Mt4MnSZiagxZFx6brOMbPyG4=;
	b=goZ7qyShNIjAADh2bAyKCQv/Yl9GizVL7XFM0JDZg6HVD6TlTCWSWfrue1M+CmG0gptl
	 ew/cryLJt4BzC4QgdPY0QDqeU9KUazetHU2mYEZ5ONXwmiuRkkyzqMJL73s3Q7uRpVZ6g
	 C3XKZ5PC+GOoReQM9kiCW7MQv3hdQbOGBpqPS2jKrz2wLETpSqurtBts7KCFxOEbUa9Kb
	 E97c7l3j4uHnGav/FXQtzmDK4uqGAFYKNVZnk/ztPg+pcKsIUT7NiCclgV8Lfrxfj6tiU
	 VXXxkW/TunR+iJP2tmdEM93iQYdH8hUOfenjexrD4yPDFnBlvBOZf55HQ7k9H1MXMhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=efwY2+dP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KmArqzE8;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D656606A31E;
	Fri, 23 Oct 2026 21:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D656606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=efwY2+dP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KmArqzE8
Date: Fri, 23 Oct 2026 21:23:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792790638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zNIwem/ycMreXfdXv1Mt4MnSZiagxZFx6brOMbPyG4=;
	b=efwY2+dPoeFVJ1G7R2UWkX6MvSA1AeZ+5FAc5nY0XZznpzChN9iSvyHh/SB34Ku7EtP4dO
	URsGPdpBItEz5waV/mBiQkkaGZnie7EzxKIRJhM5m0lgXqMsUIXe48cVBMP02b+TqcV0ZD
	WWZYvfzGbwOz6dR1HE5y+Qv8gP9SnqpxSQbb7Yw5I66X1JLXue6TD1rT3aGAzPsGzf7C1B
	X2e5HtztrvEsf+T4R10quMRI9Kbg52qeSAyaBRdfOUTuNpaieaJTdpiIQX8wiY3A0ABHwD
	iqMFer27xX8RbUsywV6GXmGAHFCbfALqz7xtj07TUfdQkXDP3IjXolmC6z/rQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792790638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zNIwem/ycMreXfdXv1Mt4MnSZiagxZFx6brOMbPyG4=;
	b=KmArqzE8Lb2ROqMJWanjUi03gP7nmkEsNuHSeTbc7fmQJKUo2GygYK+HP0hnQe1Hu+Q2R+
	BxbAviSDBQZkZSCA==
From: "tip-bot2 for Igor Velkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/kexec: Do not take the bus lock of an
 interrupt chip on the crash path
Cc: Thomas Gleixner <tglx@kernel.org>, Igor Velkov <iav@iav.lv>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20261015-kexec-irq-bus-lock-v2-1-2af15f0757b6@iav.lv>
References: <20261015-kexec-irq-bus-lock-v2-1-2af15f0757b6@iav.lv>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179279063639.3012171.17648535454243722657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     717862eac6eff0eea8ac30a0c0de0bed84922aab
Gitweb:        https://git.kernel.org/tip/717862eac6eff0eea8ac30a0c0de0bed849=
22aab
Author:        Igor Velkov <iav@iav.lv>
AuthorDate:    Thu, 15 Oct 2026 21:51:50 +03:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 23 Oct 2026 23:16:39 +02:00

genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path

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
Link: https://patch.msgid.link/20261015-kexec-irq-bus-lock-v2-1-2af15f0757b6@=
iav.lv
---
 kernel/irq/internals.h |  1 +-
 kernel/irq/kexec.c     |  2 +-
 kernel/irq/manage.c    | 43 ++++++++++++++++++++++-------------------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 0ce21dd..4dff3cc 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -81,6 +81,7 @@ enum {
 #include "settings.h"
=20
 extern int __irq_set_trigger(struct irq_desc *desc, unsigned long flags);
+extern int __irq_set_irqchip_state(struct irq_desc *desc, enum irqchip_irq_s=
tate which, bool val);
 extern void __disable_irq(struct irq_desc *desc);
 extern void __enable_irq(struct irq_desc *desc);
=20
diff --git a/kernel/irq/kexec.c b/kernel/irq/kexec.c
index 1a3deff..f245b98 100644
--- a/kernel/irq/kexec.c
+++ b/kernel/irq/kexec.c
@@ -25,7 +25,7 @@ void machine_kexec_mask_interrupts(void)
 			 * First try to remove the active state from an interrupt which is forwar=
ded
 			 * to a VM. If the interrupt is not forwarded, try to EOI the interrupt.
 			 */
-			check_eoi =3D irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
+			check_eoi =3D __irq_set_irqchip_state(desc, IRQCHIP_STATE_ACTIVE, false);
 		}
=20
 		if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 57eff26..bdb4783 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2735,6 +2735,28 @@ int irq_get_irqchip_state(unsigned int irq, enum irqch=
ip_irq_state which, bool *
 }
 EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
=20
+int __irq_set_irqchip_state(struct irq_desc *desc, enum irqchip_irq_state wh=
ich, bool val)
+{
+	struct irq_data *data =3D irq_desc_get_irq_data(desc);
+	struct irq_chip *chip;
+
+	do {
+		chip =3D irq_data_get_irq_chip(data);
+
+		if (WARN_ON_ONCE(!chip))
+			return -ENODEV;
+
+		if (chip->irq_set_irqchip_state)
+			break;
+
+		data =3D irqd_get_parent_data(data);
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
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which, bo=
ol val)
 {
-	scoped_irqdesc_get_and_buslock(irq, 0) {
-		struct irq_data *data =3D irq_desc_get_irq_data(scoped_irqdesc);
-		struct irq_chip *chip;
-
-		do {
-			chip =3D irq_data_get_irq_chip(data);
-
-			if (WARN_ON_ONCE(!chip))
-				return -ENODEV;
-
-			if (chip->irq_set_irqchip_state)
-				break;
-
-			data =3D irqd_get_parent_data(data);
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
