Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571153;
	b=F+F2EYfO38vBzu4b8SIUKpxXSY8Yjrel7sT+oenptoM1uSlfHuRjabA+O1tXxbjIpqhd
	 dzqHaHVQoHexTTfKUjQ9pgTJji5tUUm5rjUE5TLdrUeEf5XHutL3V9w8h/igZSBi0uK8W
	 Uj6pJn6mqNjAXMrfXiW3sM2/57J6KPYRPov79iMurVsIX9ACskfXbEJLdC65tx3SrZSPL
	 rBIqRFpWuvis+2gJMe/IKbZBZPc4DjXRi4efZJfHJwooM4az4I1cxfhLQYpa3q/0Ab+AB
	 bvqUP+OEAbwrW1Smuf55jqa3bAmmoZaEejffdULUhjmvU5HdivNc9j8NjXL7ane/VWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571153;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=O1xTtR8bYZgc9ttKCOcN7tWHfrNZC+O68gXNav3eZMg=;
	b=gEg9aBjNV5F2/0Jzp5M1KGz78Gw8AFYF0qdpPhKmS0bKwyYPT1DspniQ095eP667N1Lb
	 e45/WgGtAljhMgBIaX/xJ8LpuffAOgpPWA3WuIsxKZRkKvBvvdX6GKHks/4hYT69BtnTt
	 d2A4N1e/9dxQnQ8QrKdH9KqooKlcnLi9mUq2Dmr94XX8G9fCG6M6GK8wlekK9XPZk8M0C
	 pr2VPfN+jkMj+l48BuFd8B2mZ2uzW7kJ1slmXABYuI779Ajx7lc257Ksi5GPunhNClkSo
	 Mop3YvajbEbIyT1sYLZttykt81Am3yyaly9lA7Rwaj7DRmAoZi+LkukPoIlnk0caMnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=T5GPnble;
	arc=none smtp.remote-ip=52.26.1.71
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4232C606A326;
	Sun,  1 Nov 2026 22:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4232C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=T5GPnble
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793571153; x=1825107153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O1xTtR8bYZgc9ttKCOcN7tWHfrNZC+O68gXNav3eZMg=;
  b=T5GPnbledqpuAqSGV2CG64tuhs/dth6/0M6je66HX2rgpX2J/zCMCqD5
   ZuR87SZMJD0p5KF/tgEP3wWEPwfTGN+OvuCumI68y+5wvpB/XHN2QyCLr
   WNyYGdwe502OnLjH4+Uegis4JX3wa/yjOdtZvqh9bp3bZ9GzpY9RbPqMD
   CX69vookRtBZtD97lNCvtnLNUdu8x5NbGRtiqnuQH8JVXLVDY3qKOLAkp
   e/UpaoNs2AEmL6Ixqvgd3yhHhAiechATFlQp6/rM3Ij/QxIJxeo0E5cKK
   /WjqtrL52Q6ge5imkX4XO0B+q2KE0q9eTfYDGVjb5M3ptObJ0l4EGJMOs
   A==;
X-CSE-ConnectionGUID: 0ho+LU4oR2WGGz7NnctnkA==
X-CSE-MsgGUID: xOBQIBMTQxGYPYUKY6Ck6Q==
X-IronPort-AV: E=Sophos;i="6.27,190,1787011200"; 
   d="scan'208";a="32853302"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 22:12:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:23905]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.65:2525] with esmtp (Farcaster)
 id aa741cc0-9725-44bf-b19c-348e2cc752b1; Sun, 1 Nov 2026 22:12:30 +0000 (UTC)
X-Farcaster-Flow-ID: aa741cc0-9725-44bf-b19c-348e2cc752b1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sun, 1 Nov 2026 22:12:29 +0000
Received: from dev-dsk-araoof-1b-23e02486.eu-west-1.amazon.com (10.253.65.187)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sun, 1 Nov 2026 22:12:27 +0000
From: Ahmed Abdelraoof <araoof@amazon.de>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Vineeth Pillai (Microsoft)"
	<vineethrp@gmail.com>, Josh Don <joshdon@google.com>
CC: Ahmed Abdelraoof <araoof@amazon.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/core: keep offline cpus out of core-wide selections
Date: Sun, 1 Nov 2026 22:12:18 +0000
Message-ID: <20261101221219.118052-1-araoof@amazon.de>
X-Mailer: git-send-email 2.47.3
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Ahmed Abdelraoof <araoof@amazon.com>

During CPU hotplug in start_secondary(), the incoming CPU joins the
core-scheduling sibling sets by calling set_cpu_sibling_map() from
ap_starting(). Next, it runs notify_cpu_starting(), where
sched_core_cpu_starting() points the CPU's rq->core at the group's
leader. Finally, the CPU is set online via set_cpu_online().

This creates a narrow race leading to potentially silent corruptions: an
online CPU o performs a core-wide selection via pick_next_task() and
encounters an incoming CPU i that has joined the sibling set but has not
yet pointed its rq->core at the group's leader. o calls pick_task() on
i's runqueue and sets i's rq->core_pick while holding only o's rq lock,
which is not the lock serializing i's runqueue.

The same window has another ordering that leads to crashes. o can
complete the first walk of the sibling set before i joins it, leaving
i's rq->core_pick NULL. If set_cpu_sibling_map() then publishes i
before o starts the second walk, that walk visits i, reads the NULL
rq->core_pick and passes it to cookie_equals(), which dereferences
it, leading to crashes.

Skip offline CPUs during the initial core-wide pick. Use the resulting
non-NULL rq->core_pick values to identify participants in the later
passes as online mask can change between walks.

Opportunistically also, exclude offline CPUs from the single-pass
forced-idle accounting.

Fixes: 539f65125d20 ("sched: Add core wide task selection and scheduling")
Fixes: bc9ffef31bf5 ("sched/core: Simplify core-wide task selection")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmed Abdelraoof <araoof@amazon.com>
---
 kernel/sched/core.c       | 12 ++++++++++++
 kernel/sched/core_sched.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d7c3b43158de..f55f6a0befcc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6413,6 +6413,9 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 */
 	max = NULL;
 	for_each_cpu_wrap(i, smt_mask, cpu) {
+		if (!cpu_online(i))
+			continue;
+
 		rq_i = cpu_rq(i);
 
 		/*
@@ -6448,6 +6451,8 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	for_each_cpu(i, smt_mask) {
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick;
+		if (!p)
+			continue;
 
 		if (!cookie_equals(p, cookie)) {
 			p = NULL;
@@ -6760,6 +6765,13 @@ static inline void sched_core_cpu_dying(unsigned int cpu)
 
 	if (rq->core != rq)
 		rq->core = rq;
+
+	/*
+	 * Core-wide selections skip offline siblings and rely on a NULL
+	 * core_pick to tell them apart from participants.
+	 */
+	rq->core_pick = NULL;
+	rq->core_dl_server = NULL;
 }
 
 #else /* !CONFIG_SCHED_CORE: */
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 43e0bde3038e..1efde88da76e 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -273,7 +273,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 		delta = div_u64(delta, rq->core->core_forceidle_occupation);
 	}
 
-	for_each_cpu(i, smt_mask) {
+	for_each_cpu_and(i, smt_mask, cpu_online_mask) {
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick ?: rq_i->curr;
 
-- 
2.47.3

