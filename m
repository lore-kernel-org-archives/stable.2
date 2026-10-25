Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792964842;
	b=OgAuX+8Vim7HSYPPdyyUOsWUXesDX0f/ajEG+zyxe5bik7x6mNHRy5b7lGcW6bFdxYPG
	 tcErxPUE218mL6lsijfi9HV1/9/Cw3MPVa7LzszDhF50vzQf5SsEJYsWRA1lISBbWRcVw
	 fh/tWrhAMuizN+UUqAq5uaEeN7t+dnoVieIubQ6yMrMqLsm8yAGm81CrM/ZwZnqLDIWgG
	 zZXAKOXVjjx8xfm6dCgX2ZgyuUDbUB/pKpyi2XQgDx1gRNtAowoRmMRMQYcPkTrU1kU+h
	 y54uxO10B4htUGFMxW+rvxr3igJL6BEaLe1b2J0idXoDdfH2Q6o0hOarbUtOUxisf6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792964842;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=T+ITjdvCOkHuMDbhDF/DyLg8tYNRLR+eOzIsCAUj6UE=;
	b=LQZ5N3f4HWYIcGGr7KRE4bz8Sp5SW9xg9MKuZ726ZLKdvGUz6BAwjrszSay1wAvXn0rL
	 IebtETSLWVy3d/W2j0vrvYDlfuVaRxvHFqubLfU/OwSRLLf8bcveLmLRymgj3ZwyuTljW
	 zSiyPn2VHGi1WuxxU8y1brxzD7NWDrTm2aa53zdOWFiLye7ghcsf1ZhzLBRs+UfZi3oIY
	 zJSQcP42Y3QeVfdjiS7Fc7Uec6nfl5wdJTV9w3b3Vv9lvkRkWeUU6TataZSBLxy6/6o6M
	 ocFJCy+jg04FrpVZJPhsU3xrP5N1b+YaCwuYhX3hqRRpTCXdmCRPWee8XtGJXFaTHBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Q2Ph5IjB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=zcMLyGB4;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F02606A31B;
	Sun, 25 Oct 2026 21:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18F02606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Q2Ph5IjB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=zcMLyGB4
Date: Sun, 25 Oct 2026 21:47:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792964832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+ITjdvCOkHuMDbhDF/DyLg8tYNRLR+eOzIsCAUj6UE=;
	b=Q2Ph5IjB1Z8cfW5sIaCIJzTd0EISmZvGV5Ff8H8u0kYw1yxBiEfXhgvY7uqUfvFBI19eZV
	4MznrLn7ZJVdtJw5cclQGU9iDCNPPXM/G7E88QWa0CSjO4RRbMmp6w485CLAS4OlvcSVL3
	HpaTOLbJFscXe57blHzsH4wwfbZny75Isb1gtM1/8bFZSeyqbeDkbWzTTixjChougFltP5
	CI7vyxdEgCP5gzDYmemomcfe0XwJUGDIOwEK5SeH2ROzc1o5PHYJM0PnFFH1nZHNsk967B
	pygYE1n6Tx+74kVAtL01fngMrLxANfKLg9JFvai/dgoi4592Vyeh7wsdDM/c2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792964832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+ITjdvCOkHuMDbhDF/DyLg8tYNRLR+eOzIsCAUj6UE=;
	b=zcMLyGB4qi/EThDaY5KgZM5GfVDlRkkXHYr7Dv06hvDHqwkb9wkUBCzogLwiPLwQ4A6JXb
	BtOamr/UHwRKpqBA==
From: "tip-bot2 for Peng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/nohz: Reevaluate the tick for kicks flushed
 outside hardirq
Cc: Frederic Weisbecker <frederic@kernel.org>,
 He Rongguang <herongguang@linux.alibaba.com>,
 Peng Wang <peng_wang@linux.alibaba.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261023145101.8217-1-peng_wang@linux.alibaba.com>
References: <20261023145101.8217-1-peng_wang@linux.alibaba.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179296483052.4109677.11660675165338211997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     e389ae428847a2e6a3b698b5967df68ccf90361c
Gitweb:        https://git.kernel.org/tip/e389ae428847a2e6a3b698b5967df68ccf9=
0361c
Author:        Peng Wang <peng_wang@linux.alibaba.com>
AuthorDate:    Fri, 23 Oct 2026 22:51:00 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 25 Oct 2026 22:43:19 +01:00

tick/nohz: Reevaluate the tick for kicks flushed outside hardirq

The nohz full kick relies on interrupt exit to reevaluate the
tick. However, a remote kick can also be flushed from task context without
an interrupt exit guaranteed to follow. If a tick dependency is set or an
earlier timer is queued after the idle-exit reevaluation, the required tick
update can be delayed until another interrupt.

Reevaluate the tick directly from the callback outside hardirq context.
Keep the existing interrupt exit handling for hardirq callbacks. The
offline flush remains harmless because tick_sched_timer_dying() has already
cleared TS_FLAG_NOHZ.

Fixes: 4b44a21dd640 ("irq_work, smp: Allow irq_work on call_single_queue")
Fixes: a5183862e76f ("tick/nohz: Conditionally restart tick on idle exit")
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: He Rongguang <herongguang@linux.alibaba.com>
Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
Signed-off-by: Peng Wang <peng_wang@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261023145101.8217-1-peng_wang@linux.alibaba.=
com
---
 kernel/time/tick-sched.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6c3fea3..baa3ac9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -400,9 +400,21 @@ static bool can_stop_full_tick(int cpu, struct tick_sche=
d *ts)
 	return true;
 }
=20
+static void tick_nohz_full_update_tick(struct tick_sched *ts);
+
 static void nohz_full_kick_func(struct irq_work *work)
 {
-	/* Empty, the tick restart happens on tick_nohz_irq_exit() */
+	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
+
+	if (WARN_ON_ONCE(!tick_nohz_full_cpu(smp_processor_id())))
+		return;
+
+	/* Task-context flushes may not be followed by an IRQ exit. */
+	if (!in_hardirq()) {
+		if (WARN_ON_ONCE(tick_sched_flag_test(ts, TS_FLAG_INIDLE)))
+			return;
+		tick_nohz_full_update_tick(ts);
+	}
 }
=20
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =3D
