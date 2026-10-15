Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323451E432;
	Thu, 15 Oct 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058448; cv=none; b=W2WwlnOiXG6CRTvnhX1P8+4cNuDW1q02/04/uVON6iLXyUdnwHOLAIXgKLiVG0BKju2HpzPIGsO7t6rA+q+e3GyuK+3lpzeuUsoJITBRhVgzjolmbwDX1rjNn43S1lulH3pbLlkA51hTn4c/3NLYuqHs0WHH3ZoKrqjmtqAHHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058448; c=relaxed/simple;
	bh=QbIN93EEaUwasdfVFO+zHVjH1+qYXP1ZK+Wyo01XCjY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MvY5J+6BKGkYSTjuKpqUcSQqpPdUdXmV/htUUu+FM0qjWXh0c5k2KYMjogdnB+tvU/+1z2sNcZiTqrYnTLyvrWJm3JMUySTtmx4GOKRbhR33JZzGW2tkBLApofj8RrFmBdPC0XnhBINq0hPysV0GYQjvY4iosjMRLBSo5nZdzGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NlbKmglz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HI4ElblI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NlbKmglz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HI4ElblI"
Date: Thu, 15 Oct 2026 10:00:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792058436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzL+mBaBQR2jziuCJZJ6qL7q3hEd/29DV2TOnBwV5uE=;
	b=NlbKmglzr8ffqJ2ULtBXde4dVQ8adDnieOD29n2mByH6LnmDMfLPMKlNzL6kIROXI5r2lt
	0vgzORebqDJ05x/Cr+/J5EyejbeydE+c53FRf0F2JNQWLG0XPZHZ3LgSHELRekMWmOb8qG
	BTnUk+XUYxfFzFnpliHpwzICHYuIKZsUX4zc+AbitCfnQ1bpARfywhaxKdZuJxlbiXSqmh
	yF0bEG6RHJ/7Uq897n2+fl4apxtCee3u1+ETK6ffi1cfDqKIL5QdY1+nP/Iv2IxQNnpZwF
	I3Ks2qBNRCVmffepFynFAt40F0ZDcobQnCJlmqf1Y5EgaRTh9rpHh1L9KMeDig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792058436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzL+mBaBQR2jziuCJZJ6qL7q3hEd/29DV2TOnBwV5uE=;
	b=HI4ElblIUrlujpGhwWRHJMMViKPw/1IplcFKnqyZkj5wvo9CO078SH/BIRVdh3XKUEiblN
	DsNDnaZ7CONNS7BA==
From: "tip-bot2 for Karl Mehltretter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/jcore-aic: Fix lost IPIs on SMP
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260928035408.25871-1-kmehltretter@gmail.com>
References: <20260928035408.25871-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179205843503.2666988.11091083191154009161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     f556f008f704a8777c73fb3a4177dc57c0dbe769
Gitweb:        https://git.kernel.org/tip/f556f008f704a8777c73fb3a4177dc57c0d=
be769
Author:        Karl Mehltretter <kmehltretter@gmail.com>
AuthorDate:    Mon, 28 Sep 2026 05:54:08 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 15 Oct 2026 11:59:22 +02:00

irqchip/jcore-aic: Fix lost IPIs on SMP

Since commit bdf4e2ac295fe ("genirq: Allow per-cpu interrupt sharing for
non-overlapping affinities"), handle_percpu_devid_irq() only runs an
action whose affinity mask contains the current CPU. Only actions set up
through the percpu_devid request functions have such a mask.

handle_jcore_irq() passes every per-CPU interrupt to
handle_percpu_devid_irq(). The J2 IPI is not a percpu_devid interrupt.
j2_prepare_cpus() requests it with request_irq() and IRQF_PERCPU, so its
action has no affinity mask and cpumask_test_cpu() reads through a NULL
pointer. J2 has no MMU to catch this. The read returns whatever is at
address 0, the action is not found, and IPIs are dropped as spurious
("Spurious percpu IRQ20 on CPU1", printed once).

Pass only percpu_devid interrupts (the PIT) to handle_percpu_devid_irq()
and the other per-CPU interrupts to handle_percpu_irq() again, as before
commit d7e3fd658248f ("irqchip/jcore-aic, clocksource/drivers/jcore: Fix
jcore-pit interrupt request").

Found with a two-CPU J2 model simulated from the J-Core RTL. Without
this change the boot stalls with both CPUs idle shortly after
"smp: Brought up 1 node, 2 CPUs". With it, the boot reaches userspace.

Fixes: bdf4e2ac295fe ("genirq: Allow per-cpu interrupt sharing for non-overla=
pping affinities")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Assisted-by: LLM
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260928035408.25871-1-kmehltretter@gmail.com
---
 drivers/irqchip/irq-jcore-aic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 94c05cf..b4fee02 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -37,8 +37,10 @@ static struct irq_chip jcore_aic;
=20
 static void handle_jcore_irq(struct irq_desc *desc)
 {
-	if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
+	if (irq_is_percpu_devid(irq_desc_get_irq(desc)))
 		handle_percpu_devid_irq(desc);
+	else if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
+		handle_percpu_irq(desc);
 	else
 		handle_simple_irq(desc);
 }
