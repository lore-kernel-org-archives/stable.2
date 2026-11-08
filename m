Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794156220;
	b=mMBuYhv2CxMsJRXSrXUGLTcHhWD2PGHfPswFPEF3CvJc9+HDXftWZz96mhVysP4+gPOx
	 qGcySHoKUobWSewSHRocVSgbi/CnjF5CQM4VZkp0o8cNBfKeitPHxYUctlQbaMASlk3Tx
	 MAHivKqiQk0BpfW3SzBKJEcrSS0DW136XH3isuMGEQQzQnzl5Qxr9LCuURY+kLqdbpQPi
	 TNuB3kX2kbQAeMGxz5d3on/VMIP2+wQN04UFytJiMSPlanUwtFbxh4vDihTmBWjwmXS6Q
	 myMP4mLMeI7ALJBnFAU0FtFz4VNT5NdnsUyE4IwDAlrDrCAKjqJhGZ92agWihKrtclg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156220;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=XS7KcQ/jusU85uSxpEuVq0L35T8SYD+yDI+1sezZ8mE=;
	b=sD6yQfFc34Q1yxf0pv1NMiM7c1hPEHZSDdiyr2s4ehIXltGXeydg8J8qpXSFyGklkOLa
	 mY7D4GdNIJEhvPjkva754fWoXvfQYwgUkWwkvTYJFQxECeWk938bgAIk0OK6zhaFwq/2t
	 MDe7+8egZilb1o7/+DjPYcnb7WidrPYsQEjJpPLa+BEdrD4G3168yhnYGaEG7wauKedvR
	 bkdUM9/O8NiYhWZabC1RFRdlNxQ3gzVQP3z4M7NRa2FMeY7us6yvKE8IAO5cAT6ck9qlB
	 ip2wg3RSc9TcGVNmfI+nO9HzD+HXcBQ4oY1L/6TAwqdMhUBHDUnuHaw2AhMbbBWa6bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OIChspOn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cVY3G2s5;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8557606A31C;
	Sun,  8 Nov 2026 16:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8557606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OIChspOn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cVY3G2s5
Date: Sun, 08 Nov 2026 16:43:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794156217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XS7KcQ/jusU85uSxpEuVq0L35T8SYD+yDI+1sezZ8mE=;
	b=OIChspOn6XEJ/X3ZDS98qLQ153ecZRhXt/aRV3PaKLPdo7zKpixoLQmUke2Lhpq9Yhlp79
	hJOAe3UV+rPpf3PDvrwjrbwhObktPr4t8iuIwc4ftFCQcpuYdpFYVbwjN3T1Jk2ixODBLz
	HWOo3lAD4ZAtYCGhiHJinEHnb/U9mIzkKUETF/mEbgnifGpRWG+93QgmaXRl8/j3jvPbji
	q7mdiIL/KcDnABToWRnRTrQuKtcVStmCxbiVlHk3te0A83Qyn0898fLa5y8hz36wbE1PwG
	aovj9dxGMACrKJFTTDt+ovXOB+l1rIpgK6kuGeaMcN7Vjk02oNoFOoEw+CiOTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794156217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XS7KcQ/jusU85uSxpEuVq0L35T8SYD+yDI+1sezZ8mE=;
	b=cVY3G2s53dHUGNIzvocbmB4tjQFISoNB0NtWn4lwr+a8M9ozy3+JMiamsnJvTXqjJNxXd8
	fWN7aNf0DEyBcrCg==
From: "tip-bot2 for Rosen Penev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Ignore tot_count for handle_percpu_irq() interrupts
Cc: Rosen Penev <rosenp@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20261106051959.901861-1-rosenp@gmail.com>
References: <20261106051959.901861-1-rosenp@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179415621568.2093942.17213332873129529330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     39512299c085723a334a5c50b999d661d9de64af
Gitweb:        https://git.kernel.org/tip/39512299c085723a334a5c50b999d661d9d=
e64af
Author:        Rosen Penev <rosenp@gmail.com>
AuthorDate:    Thu, 05 Nov 2026 21:19:59 -08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 08 Nov 2026 17:39:43 +01:00

genirq: Ignore tot_count for handle_percpu_irq() interrupts

handle_percpu_irq() only increments the per CPU statistics and leaves
desc::tot_count untouched, but nothing marks the descriptors that use it
as per CPU. Both /proc/interrupts and kstat_irqs_desc() treat such an
interrupt as a device interrupt and trust desc::tot_count, which stays
zero.

Since /proc/interrupts started to emit zeros for device interrupts with
a zero desc::tot_count, every MIPS CPU interrupt reads as zero there,
including the timer and every device behind it. /proc/interrupts also
missed NMIs handled by handle_fasteoi_nmi(), which kstat_irqs_desc()
already excluded. The /proc/stat counts of handle_percpu_irq() users
have been zero since kstat_irqs_desc() started to use desc::tot_count.

Add irq_desc_has_tot_count(), which covers per CPU interrupts, NMIs and
handle_percpu_irq() users, and use it in both places.

Seen on ASUS RT-N16 and TP-LINK Archer C7 v2 (both MIPS 74K) router, where
the "gpio, ttyS0" lines stayed at zero while the GPIO interrupts chained
behind it counted.

Fixes: 0179464391af ("genirq/proc: Utilize irq_desc::tot_count to avoid evalu=
ation")
Fixes: 1136b0728969 ("genirq: Avoid summation loops for /proc/stat")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261106051959.901861-1-rosenp@gmail.com
---
 kernel/irq/internals.h | 12 ++++++++++++
 kernel/irq/irqdesc.c   |  4 +---
 kernel/irq/proc.c      |  7 +++----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index daa1507..13c247d 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -302,6 +302,18 @@ static inline bool irq_is_nmi(struct irq_desc *desc)
 	return desc->istate & IRQS_NMI;
 }
=20
+/*
+ * Per CPU interrupts, NMIs and interrupts handled by handle_percpu_irq()
+ * only update the per CPU statistics and leave desc::tot_count alone.
+ */
+static inline bool irq_desc_has_tot_count(struct irq_desc *desc)
+{
+	return !irq_settings_is_per_cpu_devid(desc) &&
+	       !irq_settings_is_per_cpu(desc) &&
+	       !irq_is_nmi(desc) &&
+	       desc->handle_irq !=3D handle_percpu_irq;
+}
+
 #ifdef CONFIG_PM_SLEEP
 void irq_pm_handle_wakeup(struct irq_desc *desc);
 void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 7cbcc3f..3f7bfe0 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -1020,9 +1020,7 @@ static unsigned int kstat_irqs_desc(struct irq_desc *de=
sc, const struct cpumask=20
 	unsigned int sum =3D 0;
 	int cpu;
=20
-	if (!irq_settings_is_per_cpu_devid(desc) &&
-	    !irq_settings_is_per_cpu(desc) &&
-	    !irq_is_nmi(desc))
+	if (irq_desc_has_tot_count(desc))
 		return data_race(desc->tot_count);
=20
 	for_each_cpu(cpu, cpumask)
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 0c0df16..c985515 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -559,11 +559,10 @@ static int irq_seq_show(struct seq_file *p, void *v)
 	seq_putc(p, ':');
=20
 	/*
-	 * Always output per CPU interrupts. Output device interrupts only when
-	 * desc::tot_count is not zero.
+	 * Always output interrupts which do not maintain desc::tot_count.
+	 * Output the others only when desc::tot_count is not zero.
 	 */
-	if (irq_settings_is_per_cpu(desc) || irq_settings_is_per_cpu_devid(desc) ||
-	    data_race(desc->tot_count))
+	if (!irq_desc_has_tot_count(desc) || data_race(desc->tot_count))
 		irq_proc_emit_counts(p, &desc->kstat_irqs->cnt);
 	else
 		irq_proc_emit_zero_counts(p, num_online_cpus());
