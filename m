Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7111AA1F4;
	Sat, 15 Aug 2026 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786755935; cv=none; b=NJ8FtqzSEiai9t7A3mmT6f18aY4+LePZFPpG5+04i5zaLQgEIthhSEb2ZYA/bm8nhb+ljHiKbjAkO4jO3UsfDIuH5Bq1fatFsmg6H3mUssCHTwW1dbHRqa/4lxv5Y+c3MpnB4U7XIyRve/6rF5R9GtopyTixWn6Pj1sjzYDWrAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786755935; c=relaxed/simple;
	bh=cNcobW1b41iii25NuePYuUmFdEiCX4HEIhT13MYqVxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gs9ILIfrisHB7+Znrpg9ak7B4TCtDpb+4M7V/Cm0VnFulz7i+yK5uX1XLmCjpH4OdtBhBWROQSG8M5Y/MJodlVuupEGwrY646agXuB3IaMtON/J/SlEIXyF6Qx8VhwrZ7A6WZzF26+V3tOg9gWLo1IlhqUxDKcIGEQtqK8SC6SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+r1R3YW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+r1R3YW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CEB1F00A3A;
	Sat, 15 Aug 2026 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786755934;
	bh=HB85Mtjx9Do8tibomc3opxJBZ+BjRcCZ/pOQhku/D3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X+r1R3YWauDHFD8nuNU0PbBiKNuDRzhRKDiev8ibkpSC8wksMwlw7nzwKxnnkp+IW
	 fttLrz6PVkB6GO6Rsb5/3iUuaLsDxfL/a0XMghbPwhtX7tYybviEll6kiN7cJ66b6Y
	 o+CWoKe/P8956Sgga7Ee5qQEguq9HF6XhjSKohzKNChqZaVejeHKerFbJh81+AFT0B
	 +lvjS+M3ssANjz/VWqMY0bgJiOTIeUUTOkeud0iWNMkm1ROSRDYUi3VezLdJimBcP8
	 MmHBwZhKzRck9I7YTnJc0TwQES1NSFKxSPbzFBKvwLOgkWEdNmeqKTJds7rXRuR+qg
	 QynE9fZRhiL+Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] sched_ext: Keep kick_sync waiting on the rq's own CPU
Date: Fri, 14 Aug 2026 15:05:30 -1000
Message-ID: <20260815010532.3663253-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815010532.3663253-1-tj@kernel.org>
References: <20260815010532.3663253-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kick_sync_wait_bal_cb() assumes it runs on the rq's CPU from the
__schedule() tail: the snapshots it compares against live in that CPU's
percpu area and the busy-wait runs with the rq lock dropped and IRQs
enabled.

However, dispatch can now drop the rq lock while the callback sits queued,
and rq lock takers in that window (the sched class change paths, the scx
task iterator) flush pending balance callbacks on release, running the
callback on a foreign CPU. Such a run compares against unrelated snapshots
and can deadlock when the executing CPU is itself a wait target.

Bail on a foreign CPU and leave the wait state alone. The wait only observes
progress that the resched kicks already guarantee and the rq's next wait
picks up the stale cpus_to_sync bits.

Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 2adf2bde0cb1..4867517b71a4 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3269,11 +3269,26 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 
 static void kick_sync_wait_bal_cb(struct rq *rq)
 {
-	struct scx_kick_syncs __rcu *ks = __this_cpu_read(scx_kick_syncs);
-	unsigned long *ksyncs = rcu_dereference_sched(ks)->syncs;
+	struct scx_kick_syncs __rcu *ks;
+	unsigned long *ksyncs;
 	bool waited;
 	s32 cpu;
 
+	/*
+	 * This callback is queued and normally flushed within @rq's own
+	 * scheduling pass. However, dispatch can drop the rq lock while it sits
+	 * queued, and lock takers in that window (the sched class change paths,
+	 * the scx task iterator) flush pending balance callbacks on release,
+	 * running this one on a foreign CPU whose snapshots are unrelated. The
+	 * kicked CPUs are already on their way to advance the kick_syncs being
+	 * waited on. Don't get in the way.
+	 */
+	if (unlikely(cpu_of(rq) != smp_processor_id()))
+		return;
+
+	ks = __this_cpu_read(scx_kick_syncs);
+	ksyncs = rcu_dereference_sched(ks)->syncs;
+
 	/*
 	 * Drop rq lock and enable IRQs while waiting. IRQs must be enabled
 	 * — a target CPU may be waiting for us to process an IPI (e.g. TLB
-- 
2.55.0

