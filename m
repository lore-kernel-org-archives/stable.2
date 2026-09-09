Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF353B61A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950720; cv=none; b=VPOmKCZZqkVWeY+OQ5kHuQv9DYgljvNzVC0kTdLks0jVvZLJB7pgNdkaG3Bq/qJMZOEYh5HiccSSnCTrDhBJNXp+z5MqBAHFvHZKUEQbF/QfvikHV2+8PPx3+WneW1yhHgqO8yYFopxFKuP9qRo2uUqznxlwCYnTtufu6mhgvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950720; c=relaxed/simple;
	bh=4Jx6SExSECoesgi5NE14tPnd4MyloKGzk/ktNEHkvUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVuobPt53fxaDWnbSqyxaShaExjc3MhJjSqVPaBd43mf4S39yIR9/ZFNhG+Rnduk+OvDwOkeGVqeYJm1m2VFpW+TcHBw5lHPnP9cf3BOhhdXz7h4gjMyzgWIWvCwzrvBQ513A4aTeP4XZMcyOG1ttqLWsLfOKU5OZujLZLolSc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkBnj3wD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkBnj3wD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82CA1F00A3D;
	Wed,  9 Sep 2026 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950719;
	bh=M5m48214VJgCO4iL8iu1bI1kKcgZLTiDg8+LlfBpLOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PkBnj3wDSaMk7mZR+aYCD6nGOJnlwPA6KsmxahamxT01KongDt+rSgJ4K4zh5AJ1V
	 cN4Nfugz7aSXGhY+NXgDDFp2moJkeKamj/3qiHjx2T8wDXZ1Ftnnn986yrhDEqpzHO
	 C2PXpNMoB2Q10L6+h0It5CIDpreSuhwYaQ8IaQh6MdBiNMhG32eWBZ7+ZjdeRDs9uO
	 ur5Mzq7LpjEcZppg5oXgIbvwE+ieaW92ccZ8MI90N122qhCUuGVv4g4BBmm/u/NIP3
	 +Ou2xkCXySZ1Ym2h+OvdG7v9nI/oOYbqChgqBpQPGXCuC34A3EJEUKxRTxFTq4lWqb
	 CuN+buX8dY14A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] sched/core: Make core-sched flips wait for in-flight selections
Date: Wed,  9 Sep 2026 06:45:17 -0400
Message-ID: <20260909104517.1560988-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090311-paramedic-jaybird-0ada@gregkh>
References: <2026090311-paramedic-jaybird-0ada@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit f3629c63a4af3e491381780bc6c123cb498c4c40 ]

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

Fixes: 539f65125d20 ("sched: Add core wide task selection and scheduling")
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[ Moved the counter decrement from out_set_next to out to accommodate 6.6’s cached-selection path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c  | 22 ++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 797b81dcf69ab..9051ce93d730b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -366,6 +366,17 @@ static void __sched_core_flip(bool enabled)
 
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
 
@@ -6094,6 +6105,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		return __pick_next_task(rq, prev, rf);
 	}
 
+	rq->core->core_pick_in_flight++;
+
 	/*
 	 * If there were no {en,de}queues since we picked (IOW, the task
 	 * pointers are all still valid), and we haven't scheduled the last
@@ -6287,6 +6300,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 out_set_next:
 	set_next_task(rq, next);
 out:
+	rq->core->core_pick_in_flight--;
 	if (rq->core->core_forceidle_count && next == rq->idle)
 		queue_core_balance(rq);
 
@@ -6483,6 +6497,13 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
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
@@ -10074,6 +10095,7 @@ void __init sched_init(void)
 		rq->core_forceidle_count = 0;
 		rq->core_forceidle_occupation = 0;
 		rq->core_forceidle_start = 0;
+		rq->core_pick_in_flight = 0;
 
 		rq->core_cookie = 0UL;
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 65ff0254659ac..47aebf155c3a0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1158,6 +1158,7 @@ struct rq {
 	unsigned int		core_forceidle_seq;
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
+	unsigned int		core_pick_in_flight;
 #endif
 
 	/* Scratch cpumask to be temporarily used under rq_lock */
-- 
2.53.0

