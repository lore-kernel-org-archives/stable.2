Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361596;
	b=g60R1GlRnV6cRO47S4O8WX47RogcYhG9ExhR6v/uHUNCUN/evQ+7Bu3ldv/53WTRFVuj
	 4qabj8nymMmQPUmhSO17uME8X0N8GoBAMxXnZXX9u81Pwr+mSPzK98Y4RNhEva+4DYlSY
	 LBZWrA0iZ68lkGghZaEH5yi4XIh0uluoR44P6BUHP3ad5KasonSN9Xbsghs0OMs+BOCf5
	 AtoBUHvS/3CJxPRkpXUuxEECq+YgKmM2PoKrz9IMAIJOxdnFcwhtW2LGcfflRxj7TZZGu
	 opf72GvcBo6qMTjAmqDVcDr6D7yT49NV4mXhVlFbL/yZgYkHVKBCJE2cqdgGYq1gA8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361596;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=7q91tY9/c4a2cldLk5rrSs+ays6kIzsfOFx+KRDseXk=;
	b=L3f0CjqsZfzZx41Bh8Mxq2aW34ewA9nLgaxDXIfEVDHcqqcisuSjIsuYXqrAx2sGQxy2
	 +HbTZhYjnqufDdJSauVRDwI255u7itku2zwfesLHbIS7A8zgEF1X+fATdrhKdpJYzz6Ah
	 Zh5ganNUC6j7UO9FiyIabOJLcN6bdZNXHrNYyuBtcDCy4K+cWKNyhVNM/8S3M6V80r/CE
	 ixCvJT+r0NbnqnpCfxvt1w7M20z8XlgAPiAnbk64LOKP0njVxEpoGUki3JyPxxxb1NIsx
	 RCMjLSfCCoRmU+91r6wuIBgLsfqklsrh0UoOuVEnKdYL2cpot0dfw97ibss8Iq/4Odw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ncMwP996;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42379606A31C;
	Wed, 11 Nov 2026 01:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42379606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ncMwP996
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7q91tY9/c4a2cldLk5rrSs+ays6kIzsfOFx+KRDseXk=;
	b=ncMwP996WzK6KsEOCm1WPmOEXlqqBP/5RaGdJj3ZatOInk60HbeSuNqX8a7DcdiwUSyKinji8
	P5BnJpyG0BTXBKP16o9N4KzzPHyuFwlipXJZ5fOgqpovBhcPDQ0TcZOZoNlZK5jcThm82zEdUkH
	UmXo5CcGVZA921ZEQzV9Ghc=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jPRFN43jqzLlTD;
	Wed, 11 Nov 2026 09:46:16 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id 96A794056C;
	Wed, 11 Nov 2026 09:46:31 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 09:46:31 +0800
From: Yao Kai <yaokai34@huawei.com>
To: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>, Yao Kai
	<yaokai34@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] rseq: Prevent self-preemption when granting a time slice extension
Date: Wed, 11 Nov 2026 10:04:06 +0800
Message-ID: <20261111020406.3352241-1-yaokai34@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023040439.3829110-1-yaokai34@huawei.com>
References: <20261023040439.3829110-1-yaokai34@huawei.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemr500006.china.huawei.com (7.185.36.185)

__rseq_grant_slice_extension() makes the grant visible to user space and
then reads the clock to compute the expiry time before it clears the
pending reschedule request. This runs in the exit to user mode loop with
interrupts enabled.

Clocksource read functions are free to disable and enable preemption.
kvm_clock_read(), xen_clocksource_read() and the arm64 architected timer
counter accessors, which are used when a counter erratum workaround is
active, do so. With full or lazy preemption, when the request which
triggered the grant is a non-lazy TIF_NEED_RESCHED, e.g. a lazy request
upgraded by the scheduler tick, then preempt_enable_notrace() in the clock
read function schedules right away, e.g. in a KVM guest:

  __schedule
  preempt_schedule_notrace
  preempt_schedule_notrace_thunk
  kvm_clock_get_cycles
  ktime_get_mono_fast_ns
  irqentry_exit
  asm_sysvec_apic_timer_interrupt

The task is preempted with the grant already handed out to user space,
i.e. in the middle of the critical section which the extension is supposed
to protect. The stale grant is cleaned up when the task goes back to user
space, so the damage is limited to the extension silently not working for
such preemptions on systems which use one of these clocksources.

Unlike a preemption by an interrupt which hits after the grant has been
handed out, this does not depend on timing. The request which the grant
is made for is still pending when the clock is read, so every grant for a
non-lazy request is voided. With full preemption, where all requests are
non-lazy, the extension does not work at all on such systems.

Read the clock in the interrupt disabled section after the reschedule
request has been cleared.

The window between handing out the grant and disabling interrupts, in
which an interrupt can still preempt the task via
irqentry_exit_cond_resched(), is not affected by this change. That's a
race against a handful of instructions, which existed before.

Fixes: dfb630f548a7 ("rseq: Implement rseq_grant_slice_extension()")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Kai <yaokai34@huawei.com>
---
 include/linux/rseq_entry.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index 31ce349ed42c..3e6a339175f8 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -174,8 +174,6 @@ static __always_inline bool __rseq_grant_slice_extension(bool work_pending)
 	rseq_stat_inc(rseq_stats.s_granted);
 
 	curr->rseq.slice.state.granted = true;
-	/* Store expiry time for arming the timer on the way out */
-	curr->rseq.slice.expires = data_race(rseq_slice_ext_nsecs) + ktime_get_mono_fast_ns();
 	/*
 	 * This is racy against a remote CPU setting TIF_NEED_RESCHED in
 	 * several ways:
@@ -222,6 +220,18 @@ static __always_inline bool __rseq_grant_slice_extension(bool work_pending)
 	scoped_guard(irq) {
 		clear_tsk_need_resched(curr);
 		clear_preempt_need_resched();
+		/*
+		 * Store expiry time for arming the timer on the way out.
+		 *
+		 * Read the clock only after the reschedule request has been
+		 * cleared and with interrupts disabled. Clocksource read
+		 * functions, e.g. kvm_clock_read(), may disable and enable
+		 * preemption, which would otherwise schedule right here on a
+		 * pending request and void the grant which was just handed
+		 * out to user space.
+		 */
+		curr->rseq.slice.expires = data_race(rseq_slice_ext_nsecs) +
+					   ktime_get_mono_fast_ns();
 	}
 	return true;
 
-- 
2.43.0

