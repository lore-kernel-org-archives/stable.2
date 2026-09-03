Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C84BC00B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445965; cv=none; b=qeJ1a0Hh8HCtdzva6NbwQ33YS+kLUTYzInch8PGQG+aU3E77Z2wvLwgWevT/mvfzUdvR3Upam1RoxzM5TQiJ+vcFn18QWAx3oKLUOjczsgnUO5TBtt0FO0C3zU+7jqDEXHsGsmnOszx37RoqnEhjeXNZasLnUn/x+szcgXeoXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445965; c=relaxed/simple;
	bh=+L4iDsjQYuKaSCpglmcszmlDqGJsbWms4/jijOq3z3A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hjkUH/SZAWAZ6fPRnzKUtVaxrcjLrDeUU5Cy0zw7M6PYLl3s5Qp1oYbWlGjP+7Zq2+BeVx4Wj2KbjOheAcWsiDu1WEETkU9taetHdAFihml3zmNd7J4+PCUyPrfR/bYkZkEMUciDZaKDGHwKLQrSPV5XVHRkiax6QTfm4RfTHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZQsXBZ3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQsXBZ3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C8C1F000E9;
	Thu,  3 Sep 2026 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445954;
	bh=saNmn6/Q88tiN19joFzu+Jy3aHreAfZJGlzvX8NMswA=;
	h=Subject:To:Cc:From:Date;
	b=ZQsXBZ3SFOmakvU4NYXSwCf/RxIYOBwrzgIqlFGYF69OYXSxQ+bD5ZSLq6IDyHW43
	 rXD7WPquWxu+rh0Vng/1fLr75bKCPpFE2LvEpHwY6Dbtm6W3cZVs+8FARGVnJlRn1r
	 p/n//YqVtRGO2zfRllAzz8h5N5HvBnzeoJQmtiqs=
Subject: FAILED: patch "[PATCH] sched/core: Make core-sched flips wait for in-flight" failed to apply to 5.15-stable tree
To: tj@kernel.org,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:13:12 +0200
Message-ID: <2026090312-earlobe-rendering-b0fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f3629c63a4af3e491381780bc6c123cb498c4c40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090312-earlobe-rendering-b0fe@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f3629c63a4af3e491381780bc6c123cb498c4c40 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 7 Aug 2026 11:02:17 -1000
Subject: [PATCH] sched/core: Make core-sched flips wait for in-flight
 selections

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

