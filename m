Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700014B4864
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948706; cv=none; b=kMnzj0kbFxH+gGXjrjBRYmeqvH/BikLOIewcHlbzif2wOWrlDVkbgzvMEVBFKNz4qYSK+uuGTmKMxDyrvr2gU8o/9nFOhn98c/4udYRmVaAidayjsmk7z78nG981R+RYfulPfNTZeP4SFV9j14bIx560Bu0sTmDn6JPc0o3hIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948706; c=relaxed/simple;
	bh=vHEqCQk7l054SLRaQnd/WgsTXRC1xS9TIJGyyf9KnpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vazm5Qii48XhFSF/dcsbQiIQJYKPPODtz80brSpYNr8dj2y9mUf44iZeblX+rxAY03AkHDLK6y6rH93PcUkrcipReR0nYQjpUMvN+ZUb4yt99oaM1TjfTuvLJrEwpDb726uMpsOSpfhhjA2obIDfYq2h0jluMeUjItn60smWgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWZ4IrJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWZ4IrJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE321F00A3F;
	Wed,  9 Sep 2026 10:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948702;
	bh=M/qjUvFQnOAJe5/leBtPTRhu4FpRxJi5UHyP3ZAW35Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DWZ4IrJKkjpW792L220RFFxDUVyOTLRi2z7CKdZB8s+QzZjnEbJ1CWSbW9NKJmgip
	 ZNVm5mNA983lBmHKGco1mvst+RHE0ZI3XacHN88kGcli18NNZsbjvRM6JeNdW+ATTh
	 eKMeCgCO6ZQfI9k1H2f7G2xdjOAc3pl+Fee6aQNu+CXGKA1soGuSMCuPAc4OP5MYSQ
	 cmwgccXmv5I9ii79sJkegf+Jvc6XYvzO4Y/uclVOUqdC89itN7R7eo+SqBQeH/2G4t
	 HJgpHef+BVNj4L2jdMqFAdKfVlBfnTf8h88m/yR8VnCO9MTB8Y0mMREyFqHjovV7MK
	 uxj6neAC0t1cQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] sched/core: Make core-sched flips wait for in-flight selections
Date: Wed,  9 Sep 2026 06:11:40 -0400
Message-ID: <20260909101140.1462154-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909101140.1462154-1-sashal@kernel.org>
References: <2026090310-heftiness-overbite-2cac@gregkh>
 <20260909101140.1462154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c  | 22 ++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 10206603f6ae8..1a173f7f5053f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -401,6 +401,17 @@ static void __sched_core_flip(bool enabled)
 
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
 
@@ -6092,6 +6103,8 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 		return __pick_next_task(rq, rf);
 	}
 
+	rq->core->core_pick_in_flight++;
+
 	/*
 	 * If there were no {en,de}queues since we picked (IOW, the task
 	 * pointers are all still valid), and we haven't scheduled the last
@@ -6286,6 +6299,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	}
 
 out_set_next:
+	rq->core->core_pick_in_flight--;
 	put_prev_set_next_task(rq, rq->donor, next);
 	if (rq->core->core_forceidle_count && next == rq->idle)
 		queue_core_balance(rq);
@@ -6482,6 +6496,13 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
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
@@ -8553,6 +8574,7 @@ void __init sched_init(void)
 		rq->core_forceidle_count = 0;
 		rq->core_forceidle_occupation = 0;
 		rq->core_forceidle_start = 0;
+		rq->core_pick_in_flight = 0;
 
 		rq->core_cookie = 0UL;
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 620d0e347ed88..0073c5b7d07a3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1330,6 +1330,7 @@ struct rq {
 	unsigned int		core_forceidle_seq;
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
+	unsigned int		core_pick_in_flight;
 #endif /* CONFIG_SCHED_CORE */
 
 	/* Scratch cpumask to be temporarily used under rq_lock */
-- 
2.53.0

