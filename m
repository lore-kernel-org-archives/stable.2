Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513268;
	b=TQbyHlcpj0E45rV1v9VHRqXEUDadoB6Ec77PnnZpiHhbdOjALzur2Ekqqdctgxbhy7l0
	 V0yMTHCBJh/3QXGjmiXhNBlXYLA2RBLp1/fh56w0yQulZE95GC16YWiIR0YAtqevgJKIC
	 EdoTQxi5UsgYHBEmcewaE4xv+td+uMfj2mIj+yY9i7xg+zTJ+xzlk5C4A1Q1uvkf85Dmq
	 3c2R+aFG1XzrqnCadSbMSDSs1qhZbuZIFAjoDaf3HN3EW16awa/PjHY9+ZhCiCKvfCHLs
	 ZFRzTNy3LAzB0xPxpHhp5XS+BjWjDZqtx08Y+c46c9NnZor62Bc1Huz5Z4fcCztL3Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513268;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=NuIlpaMiYTHMQPmZ3V/JomVHe0nIq9gdD5u1MrfR3i4=;
	b=3UQJp16PDVQAtI3ahxS3/Q84qhIAVJVeabw6X/h7DEl6xj02MSSix176VHl+fYpdRcHR
	 b/qYgQ78TFuTUGE/32UZ8AiTx4pF1C0r86+IHvHDF/4/AWJUMZjOvSoaTuLH9VM6nFkJi
	 ufsWVIe1kGabkLMUf8NhqLVdkDvNaiWMJWIJpKnYkMx+3zEy+UabIB+v+vZVdpArJ0gFh
	 XZ3Hd01hnPbGnKrPagb8N5PzEdiYD8ZsqJjo/y8RegT7enNEKkF91wSjie7qvMkBkwBKS
	 ApqPk4pmTDBqMFX+EOamqcf/9VeUY0w6ejVlaz7NIwee1934TY99r1gZhyE+a7wPTBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=B0SDCiQ4;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FE606A33E;
	Tue, 24 Nov 2026 09:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 978FE606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=B0SDCiQ4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795513265; x=1827049265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NuIlpaMiYTHMQPmZ3V/JomVHe0nIq9gdD5u1MrfR3i4=;
  b=B0SDCiQ46dDtpkoJTLFP4Na3w2+SqPRZo4BdE2km1SbSo22DhNyVGFrY
   sRI9c/e73Se6ZkZsaDzHhPBXj7AawPMmP7ADVlpo6yA17AYQ544WEOrtE
   et0rzfyRdMoY0EiTZ13vJt11uRFMX5umLhItS2h6JPblJJNHSKh88XlSr
   jF59Jg/fcTIJNz6jDhVKRRdcq2Ma5GFjpJNs1kNaTiMfF7S2liw4zTG/w
   4OlJhVDlMsKRA51qa4yQHTFS7MOsWSJtNmJvPZBG+e6O5ntGwiHm+vzNp
   zQT/z5z5FfmZ9WWBjJvVjkvMw3L7RqZ4eyK39baNAwl0GPnWCYeN5LaiW
   w==;
X-CSE-ConnectionGUID: 7R0bqCtFQH2Ztt/M3gwEqw==
X-CSE-MsgGUID: iXdy9ZjnTs2L6ir5aLeSGA==
X-IronPort-AV: E=Sophos;i="6.27,230,1787011200"; 
   d="scan'208";a="34944075"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:41:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:21440]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.204:2525] with esmtp (Farcaster)
 id faae0fa9-fa9e-45e9-8752-cdd1a246c23b; Tue, 24 Nov 2026 09:41:02 +0000 (UTC)
X-Farcaster-Flow-ID: faae0fa9-fa9e-45e9-8752-cdd1a246c23b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Tue, 24 Nov 2026 09:41:02 +0000
Received: from dev-dsk-sieberf-metal-1a-7543e84d.eu-west-1.amazon.com
 (172.19.116.227) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Tue, 24 Nov 2026
 09:40:58 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Fernand Sieber <sieberf@amazon.com>, Karl Mehltretter
	<kmehltretter@gmail.com>, <stable@vger.kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Daniel
 Bristot de Oliveira" <bristot@kernel.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, Josh Don <joshdon@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<nh-open-source@amazon.com>, Fahad Mubeen <fmubeen@amazon.de>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Misha Karataiev <karataev@amazon.com>,
	Hendrik Borghorst <hborghor@amazon.de>, Ibrahim Elshahed <lshahed@amazon.de>
Subject: [PATCH 1/2] sched/deadline: Keep forced idle uncharged when a sibling ends it
Date: Tue, 24 Nov 2026 11:40:30 +0200
Message-ID: <0eb24d6c957d45f9f7274eb9e92d9dbd3c76117d.1795510960.git.sieberf@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795510960.git.sieberf@amazon.com>
References: <20261124080737.1988-1-kmehltretter@gmail.com> <cover.1795510960.git.sieberf@amazon.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Commit f4626e1c3c14 ("sched/deadline: Don't charge core-sched forced
idle to the DL servers") keeps forced idle from being charged to the
fair and ext servers. But it tests forced_idle_rq() when the idle time
is charged, not when the idle task started running. When the sibling
ends the forced idle, the test reads false by then and the forced-idle
span is charged anyway.

The timeline below describes the issue:

  Setup. CPU0 and CPU1 are SMT siblings.
  - CPU1 runs R, a SCHED_FIFO task with cookie X, which spins and
    sleeps briefly in a loop.
  - CPU0 has C, a CFS task with no cookie, which only runs through
    CPU0's fair server.

  t0, CPU0 is forced idle. The core cookie is X and CPU0 has no
  cookie-X task, so CPU0 runs idle. core_forceidle_count is set and
  idle->se.exec_start is stamped.

  t1, R blocks. CPU1 does the core-wide pick. No cookie-X task is
  left, so forced idle ends: the pick clears core_forceidle_count and
  picks C for CPU0.

  t2, CPU0 switches from idle to C. update_curr_idle() charges the
  idle time since its last update to the fair and ext servers.
  forced_idle_rq(rq0) reads false, since t1 cleared the count, so the
  forced-idle span up to t1 is charged.

  t3, result. The fair server spends its runtime on time in which C
  could not run, and C gets throttled. With R spinning 800us and
  sleeping 10us (HZ=1000, 2-core 2-thread KVM guest), C gets 0.8-1.8%
  of the CPU instead of the 5% reservation.

With this patch, the core-wide pick settles the idle time of each idle
sibling under the state from before the pick: at t1 it drops CPU0's
forced-idle span, and a pick that starts forced idle charges the idle
time before it. As only this pick changes core_forceidle_count,
forced_idle_rq() then holds for the whole span that update_curr_idle()
charges.

With this, C gets 5.6-5.8% in the same setup.

Fixes: f4626e1c3c14 ("sched/deadline: Don't charge core-sched forced idle to the DL servers")
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Closes: https://lore.kernel.org/all/20261124080737.1988-1-kmehltretter@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
---
 kernel/sched/core.c  |  8 ++++++++
 kernel/sched/idle.c  | 25 +++++++++++++++++++------
 kernel/sched/sched.h |  1 +
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ea89471d4743c..825d9bbea3128 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6451,6 +6451,14 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
 			update_rq_clock(rq_i);
 
+		/*
+		 * This pick can start or end forced idle on rq_i while its
+		 * idle task runs on, and the old state is already reset.
+		 * Charge the idle time so far under the old state.
+		 */
+		if (rq_i->curr == rq_i->idle)
+			charge_idle_to_dl_servers(rq_i, fi_before && rq_i->nr_running);
+
 		p = pick_task(rq_i, rf);
 		if (unlikely(p == RETRY_TASK)) {
 			/* rq lock may have been dropped, clocks invalidated */
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 451b4846219d5..0449ccefba6c7 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -561,7 +561,14 @@ prio_changed_idle(struct rq *rq, struct task_struct *p, u64 oldprio)
 	BUG();
 }
 
-static void update_curr_idle(struct rq *rq)
+/*
+ * Charge the time the idle task of @rq ran since its se.exec_start to the
+ * fair and ext servers, and advance se.exec_start to now. Nothing is
+ * charged if @span_was_forced_idle: forced idle was not time available to
+ * any class on @rq, so the deferred servers must not consume their runtime
+ * on it.
+ */
+void charge_idle_to_dl_servers(struct rq *rq, bool span_was_forced_idle)
 {
 	struct sched_entity *se = &rq->idle->se;
 	u64 now = rq_clock_task(rq);
@@ -573,11 +580,7 @@ static void update_curr_idle(struct rq *rq)
 
 	se->exec_start = now;
 
-	/*
-	 * Forced idle was not time available to any class on this rq, so
-	 * don't let the deferred servers consume their runtime on it.
-	 */
-	if (forced_idle_rq(rq))
+	if (span_was_forced_idle)
 		return;
 
 	dl_server_update_idle(&rq->fair_server, delta_exec);
@@ -586,6 +589,16 @@ static void update_curr_idle(struct rq *rq)
 #endif
 }
 
+/*
+ * Only the core-wide pick starts or ends forced idle, and it charges the
+ * idle time up to that point under the old state, so the current state is
+ * the state of the whole span here.
+ */
+static void update_curr_idle(struct rq *rq)
+{
+	charge_idle_to_dl_servers(rq, forced_idle_rq(rq));
+}
+
 /*
  * Simple, special scheduling class for the per-CPU idle tasks:
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 32f76551a0c5e..1c61a1a9309a0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3005,6 +3005,7 @@ static inline bool sched_fair_runnable(struct rq *rq)
 
 extern struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf);
 extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
+void charge_idle_to_dl_servers(struct rq *rq, bool span_was_forced_idle);
 
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
-- 
2.47.3




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07

