Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792727213;
	b=NOcAiVXbp3IU+htqdKv1qWmGDAhwMSGyK81qUlsno+GDLcAq/8qLSp8OHQ0J9HYZdCnM
	 mKs0gfTV248lzdW1vqUH1ekRlXGuICSnWpygtItVTGphW/CcjLiixVcG4gY+NrMa0wFFy
	 6PXLa2V0OANVNpXL90Q4jRPj6N1j4TBNR9AxUHiV7Z0aH4dgMqjSoYg+Oxr0WHuwylljg
	 duaYI00jTucb3sEBNBhYejG1Co04MZnGlzP1YxrYNN+86lNVBcyEzQJgl0NT95lHKj5nv
	 B0RZKItX5u73eucUNcY0TypSIoqEBUd64JhFbp6tFfXpO2t4BWFMksAsg3DbQ1w+zYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792727213;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=/zfyKeokjNedSUS7yMiHAkGIRA5q0HB0PWWuzOAnAKI=;
	b=4UOIT5IHo2HQyz4ELlYRAAMvLPtQTv3rzIT3M7um08rWnsuSd3KLoO5bMKEHrG9/gBzy
	 4PKjrJFvfOLKNq2054x9xrVZ1fsb3XwsN73W31kfvwupp3b04J7o7ZiHO+jtMh/wSrGFE
	 Oqlwy+YfF2C4Bhzg9u/ZWlKWoJGF5gabypkqNLYeHVasHzOBpToXmrziQA2vVvNYGdmeF
	 dCVOnR9PDfzDoOPt7we1c/frhkwtmqGNTZ4DHUxnJq23sYdmZ8Xhb9OeevJsWBdbV3kRr
	 yOOijq3wnfXpqU5wbEJzlbTU2eyqp4BCDjJJnlKMylKfyt/lDkoRdHtWcFtm9vShvTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hjgnsGdn;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B20D606A319;
	Fri, 23 Oct 2026 03:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B20D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hjgnsGdn
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/zfyKeokjNedSUS7yMiHAkGIRA5q0HB0PWWuzOAnAKI=;
	b=hjgnsGdnjFB1cVo2ZZejGdIcvkNG4tEFj+0NQ1IKK2wzzAkfDCZgQli6HNJCuWOCw5SUzuyxH
	2bhZteWso3txWqAKPRB1c+A2jBTWJMci0isfJN2BlVcecs5BUXjoReZre9VXWW6aa6zdVO374+6
	Tk/HiTi9XwF3hf0p4zZ/YcM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4j9pq92x1szLlTc;
	Fri, 23 Oct 2026 11:46:45 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B62440586;
	Fri, 23 Oct 2026 11:46:48 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 23 Oct 2026 11:46:47 +0800
From: Yao Kai <yaokai34@huawei.com>
To: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>, Yao Kai
	<yaokai34@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH] rseq: Prevent self-preemption when granting a time slice extension
Date: Fri, 23 Oct 2026 12:04:39 +0800
Message-ID: <20261023040439.3829110-1-yaokai34@huawei.com>
X-Mailer: git-send-email 2.43.0
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Read the clock in the interrupt disabled section after the reschedule
request has been cleared.

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

