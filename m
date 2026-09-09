Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FBD5437DF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953469; cv=none; b=PavGaQXk5b8xeb6Ns6z7suNoji5WbpF7ZEd0w4sfhHQvSZo+2bFdhKmW0iBtlH23HhBMvvZ+PsZT5K2gU5VKxuxwsH52gz0V6+KW28Lf/os91Bc3nVT9dFriOSfqhAQ2J6yA+3TmUTja6ShTmIyEkCfGxhj1fMTGUw7WUK8HY4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953469; c=relaxed/simple;
	bh=dlBw+Dh69WFnRAnY8CNu6jKif3XkygUebncWsi9DRjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sx2lQxyqCF+qOPYimVlmfl754DQPFOefm8ponv4/nXYnR2PyvktnB6YL/JbkUVoL9NlfFZGvHnakexhMF2/2eRBJtCc9k+lRHDKKnhNXJMp4+vctdRUTD2RTST4qn4WWMF8KBb5+svrbw5LECsvYsQcO0NJNTEIV699/dkt55HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1O51l6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1O51l6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B2D1F00A3A;
	Wed,  9 Sep 2026 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953467;
	bh=9HfS4GzH/gwS41e8Mt2pVqOz8705GdqaQaVaR7uPkvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i1O51l6SAUG0rNy1JjGqPjgTT2TWlkPYAcuokA1fqlDhRIR/gWOdp9thobEXndCzr
	 Km0wAXYFjxfeKEw05A3W3yd7Knp/WqzBrkWBJnADoCMELS3NgcnB8SdC/hDos0b/aH
	 HqMBM5fYdXzEQt+uN62dbTBAjxxf1k/O6nrNkkwpbuC0HP3gmXs4yvHEyq2gqd1d/H
	 +xd5aJQhr4nhH1Vmo8MXgs994TnL2T6Nklia2vgN3Eo8DE1FDMw6BV4lzzXjGfipD0
	 04fPt8AdaDf9/9JrrkOanYjbkW/Ie7I6TT3YzjJ8iR4ajK7dWUatvnS2luuOARSBBC
	 m8mJ0kFc31pHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] sched/core: Make core-sched flips wait for in-flight selections
Date: Wed,  9 Sep 2026 07:31:05 -0400
Message-ID: <20260909113105.1863245-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090312-earlobe-rendering-b0fe@gregkh>
References: <2026090312-earlobe-rendering-b0fe@gregkh>
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
[ adapted counter decrements to 5.15’s done: label and direct-return cached-selection path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c  | 23 +++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4e9fac7507a9..22a34f826093a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -274,6 +274,17 @@ static void __sched_core_flip(bool enabled)
 
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
 
@@ -5789,6 +5800,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		return __pick_next_task(rq, prev, rf);
 	}
 
+	rq->core->core_pick_in_flight++;
+
 	/*
 	 * If there were no {en,de}queues since we picked (IOW, the task
 	 * pointers are all still valid), and we haven't scheduled the last
@@ -5810,6 +5823,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 
 		rq->core_pick = NULL;
+		rq->core->core_pick_in_flight--;
 		return next;
 	}
 
@@ -5992,6 +6006,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 done:
+	rq->core->core_pick_in_flight--;
 	set_next_task(rq, next);
 	return next;
 }
@@ -6181,6 +6196,13 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 	core_rq->core_forceidle     = rq->core_forceidle;
 	core_rq->core_forceidle_seq = rq->core_forceidle_seq;
 
+	/*
+	 * A stale leftover would bias the count forever if this CPU later
+	 * returns as its own leader. Move, don't copy.
+	 */
+	core_rq->core_pick_in_flight       = rq->core_pick_in_flight;
+	rq->core_pick_in_flight            = 0;
+
 	/* install new leader */
 	for_each_cpu(t, smt_mask) {
 		rq = cpu_rq(t);
@@ -9551,6 +9573,7 @@ void __init sched_init(void)
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
 		rq->core_forceidle = false;
+		rq->core_pick_in_flight = 0;
 
 		rq->core_cookie = 0UL;
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f58040a51e334..cb89d36146a63 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1110,6 +1110,7 @@ struct rq {
 	unsigned long		core_cookie;
 	unsigned char		core_forceidle;
 	unsigned int		core_forceidle_seq;
+	unsigned int		core_pick_in_flight;
 #endif
 };
 
-- 
2.53.0

