Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1A441027;
	Fri,  7 Aug 2026 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136546; cv=none; b=ZWoc7zOlZDHXn+gTaSyoOesc+C7aJsA9XdlUOdfFKnhGmVm9MkZC94Hl4pUHvJ0b68GhzPVlZV9qo2tw+uoCdN+VLmXlv511jSv7QNtL8JfBbNm1P8O5EOOZ62gzOI7QACzhAISpLrWMW7T4NKrAQQRWvwyYs2m5+MwTv6wq0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136546; c=relaxed/simple;
	bh=/xYohbKNrK3CHcgm0QnsUVhGPkF6U9AYTxdgmp0RpIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkI0Ki2pvpqYOCIlsgz+P+VvJnuvcl1lm2m0B16CIpv3fwZgMoj+DpVBCDsqrEx7oxf9j56Vg7u1CRVdWjRzBoew5mka8qHvHDbiEzK8uiBgjxgDoAQzsBxEXq92uty6vljgVjENyOszkzUgsQTaIs/qjxaW0nHMwqS0w2wm6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuAsbrXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuAsbrXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395691F000E9;
	Fri,  7 Aug 2026 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786136544;
	bh=qSAqcU+XPHaeo8sAaBoIKSnc09umbGksKwTgeB+hizk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HuAsbrXBiWoxagWRk5vNjBr9/mqB+cGxMtBRTWLQXq4Ggs64ETy/WZ4nIWCNwc9mS
	 5cSmNqGmUwEEhQoXlK8h4VAyIcOx6wBayoZIvnTVfvYQfPO/17Rmoou1ibsHYKtwpt
	 xdcz9Jo/d78IIkispUedphU1v4JNFZgCXDQSnLsvypwlA8hXIuFryP5wxmt7lmFbC7
	 6i0NpXam+PB5CO2f1wCbRVsxqsUlHrh3j+KDwIO/fD9z5/56dtoHXB8y2GyUavcPBd
	 2FAtgQYtlQd+uKSxX7nOy84sCd8IbKl/gBMEQZgo5Puh2vx0ecoY6NUYQEZzzuinyt
	 xJthoMX9DZ3fg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Peter Zijlstra <peterz@infradead.org>,
	ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/6] sched/core: Make core-sched flips wait for in-flight selections
Date: Fri,  7 Aug 2026 11:02:17 -1000
Message-ID: <20260807210221.232543-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807210221.232543-1-tj@kernel.org>
References: <20260807210221.232543-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core scheduling's pick_next_task() operates on all sibling rqs under one
acquisition of the shared core-wide lock. A ->pick_task() that releases the
rq lock leaves every sibling __lock momentarily free, letting
__sched_core_flip(false) complete mid-selection and rebind rq_lockp() under
it. The selection resumes on the split locks, touching sibling state it no
longer protects, and __schedule() finally releases a lock that was never
taken while leaking the one that was.

Count in-flight core-wide selections in the leader's rq->core_pick_in_flight
and make __sched_core_flip() wait for the count to drain. The count only
changes under the shared lock, which the flip holds while sampling, so no
other ordering is needed. The wait can repeat while selections overlap, but
the flip backs off between samples and flips are rare cookie-lifetime
events.

sched_core_cpu_deactivate() moves the count to the new leader - a stale copy
left behind would bias it forever if that CPU later returns as its own
leader.

Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c  | 22 ++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 84ef83316562..0130463798f8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -443,6 +443,17 @@ static void __sched_core_flip(bool enabled)
 
 		sched_core_lock(cpu, &flags);
 
+		/*
+		 * A core-wide selection may have the shared rq lock temporarily
+		 * released by a lock-dropping ->pick_task(). Flipping would
+		 * rebind rq_lockp() under it. Wait it out.
+		 */
+		while (cpu_rq(cpu)->core->core_pick_in_flight) {
+			sched_core_unlock(cpu, &flags);
+			cpu_relax();
+			sched_core_lock(cpu, &flags);
+		}
+
 		for_each_cpu(t, smt_mask)
 			cpu_rq(t)->core_enabled = enabled;
 
@@ -6236,6 +6247,8 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 		return __pick_next_task(rq, rf);
 	}
 
+	rq->core->core_pick_in_flight++;
+
 	/*
 	 * If there were no {en,de}queues since we picked (IOW, the task
 	 * pointers are all still valid), and we haven't scheduled the last
@@ -6450,6 +6463,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	}
 
 out_set_next:
+	rq->core->core_pick_in_flight--;
 	put_prev_set_next_task(rq, rq->donor, next);
 	if (rq->core->core_forceidle_count && next == rq->idle)
 		queue_core_balance(rq);
@@ -6644,6 +6658,13 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 	core_rq->core_forceidle_seq        = rq->core_forceidle_seq;
 	core_rq->core_forceidle_occupation = rq->core_forceidle_occupation;
 
+	/*
+	 * A stale leftover would bias the count forever if this CPU later
+	 * returns as its own leader. Move, don't copy.
+	 */
+	core_rq->core_pick_in_flight       = rq->core_pick_in_flight;
+	rq->core_pick_in_flight            = 0;
+
 	/*
 	 * Accounting edge for forced idle is handled in pick_next_task().
 	 * Don't need another one here, since the hotplug thread shouldn't
@@ -9060,6 +9081,7 @@ void __init sched_init(void)
 		rq->core_forceidle_count = 0;
 		rq->core_forceidle_occupation = 0;
 		rq->core_forceidle_start = 0;
+		rq->core_pick_in_flight = 0;
 
 		rq->core_cookie = 0UL;
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 56acf502ba26..450b6a04669f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1358,6 +1358,7 @@ struct rq {
 	unsigned int		core_forceidle_seq;
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
+	unsigned int		core_pick_in_flight;
 #endif /* CONFIG_SCHED_CORE */
 
 	/* Scratch cpumask to be temporarily used under rq_lock */
-- 
2.55.0

