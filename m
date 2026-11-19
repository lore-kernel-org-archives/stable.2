Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105303;
	b=Ml4O8kQozrEa3FYElcuEhCT/EixKDY5mfO9nEv7WslklfkfsWtPleZFcHrSJAMCHPKmK
	 FeSmg+H7dnEemMTGLnsSFouApl6Ku6SNLmv/vMYTnth0VV3hmS1Xw4xssketdclpT+Esj
	 ktlVwlpf1stXwRnsoMSSI1prrvR90BFSUYR0DCsi2uzFT5biqXQDRi/uNdZYKsA98f1ZA
	 RQ0htPJbeuRYkpOTq3rNYkQBGw+bVA1+ToIiRphCu/ILBSkM5NaEe3HUKGU0PyN5Zt9Wy
	 JDWYs4y6l5NNXIxPc/ohI7Y8bR1bA2ZNDwF+FgN8ElDNdIh2hbe+stOqOlPy8FR9cdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105303;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J+xqGM/XTVoLXbet9Pqsqr3DEOW4nOHD7WQm9LFTgGg=;
	b=TAbQ7Fwt6DJV/TQbEABtVzy++YbyZnTQJb7Vfnb9bH0wWm6a7paX0gl06VKyWd/r7z4o
	 W95WoiDGlqndT4V4UYHH1k0ZxBs8AXng3wA1aZ5wOVguN/GaudZ/NHwNK2R5GKT8DMvrh
	 Mjc3zeFMbnbsT8FGPGTdsmXJ6/W0u7KpTjjvth2ADT6ZDyFCs9Z20/Z6+yxmmV6vexUt6
	 3mBaXj+iOXF+GSMPhWbMXxvJuPNVqALW1dil8W3Vu8oXZgU7OA0Af+9P97LUf/m/cOuxe
	 XoY86EILrjTFFqSx+iZKsIREyprdaEIWlnjfGPyRjAHkuHzbTJFjr4+JmOSnQR0gR1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=WZDIu15N;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA060A2628;
	Thu, 19 Nov 2026 16:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0BA060A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=WZDIu15N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795105301;
	bh=J+xqGM/XTVoLXbet9Pqsqr3DEOW4nOHD7WQm9LFTgGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZDIu15N83G8mSAF6XASc8PhGXZlNkHw1SjeFhm+O5RZ9iXe2cLxMKWjE/qqBR9m7
	 ro8C0LtRnQG92Al4nnHPUx9Ea6IyPZ8eMF3H4TGFjRtp6rQRvOH5zcDVs1iM4M0lF6
	 5pA8J+rtsepVKmrGT4WNXlpvQZxa98gZ2rAuLnWRF3t/Ris2zBjMoQ8LvcWcG/Fq7Y
	 2SEuF8Bof1uqp0hzapf1efSwOpQ4/g6qtMGYCNd6982HIL+V0ZSKkyE4P9SZM0Rk6+
	 jfENqtPeE/DaDwlVxSRoIjGDWI+HhN3vDVBah4xk8GsSMQeohD4TegpN1x8oBEevBw
	 /lu3rLRh3cQPA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVkHn3ky8zSSr;
	Thu, 19 Nov 2026 11:21:41 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrea Parri <parri.andrea@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v4 14/17] sched/deadline: Check SCHED_DEADLINE affinity under the rq lock
Date: Thu, 19 Nov 2026 11:21:35 -0500
Message-Id: <2051d70ce37924806b86b8883abe9a62ae6fae8d.1795103339.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
References: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
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

From: Andrea Parri <parri.andrea@gmail.com>

A task can end up SCHED_DEADLINE with an affinity narrower than its root
domain when sched_setaffinity() and sched_setattr() race on it. Both
calls succeed, although each fails when made after the other:
sched_setattr() with -EPERM, sched_setaffinity() with -EBUSY.

__sched_setaffinity() calls dl_task_check_affinity() before
__set_cpus_allowed_ptr() takes task_rq_lock(), whereas
__sched_setscheduler() runs its admission test and switches the policy
under a single task_rq_lock(). So both calls can pass their checks:

  CPU 1: sched_setaffinity(p, cpu0)    CPU 2: sched_setattr(p, DEADLINE)

  dl_task_check_affinity()
    !task_has_dl_policy(p): return 0
                                       task_rq_lock()
                                       admission test passes
                                       p->policy = SCHED_DEADLINE
                                       task_rq_unlock()
  __set_cpus_allowed_ptr()
    task_rq_lock()
    p->cpus_mask = cpu0

The window includes CPU 1 spinning on task_rq_lock() while CPU 2 holds
it. With one thread narrowing a sleeping task to CPU 0 while another
makes it SCHED_DEADLINE, 923514, 959547 and 983997 of 1000000 rounds
ended with both calls succeeding on three boots of a 4-CPU guest.

Move the check into __set_cpus_allowed_ptr_locked(), next to the
PF_NO_SETAFFINITY re-check, under the same lock as the admission test.
Whichever call takes task_rq_lock() second then sees the other's
result: sched_setaffinity() fails with -EBUSY if p is already
SCHED_DEADLINE, and sched_setattr() fails with -EPERM if p's affinity
is already cpu0.

A new SCA_DL_CHECK flag selects the check, and only
__sched_setaffinity() sets it, so sched_setaffinity() and
relax_compatible_cpus_allowed_ptr() keep the check and other callers
stay unchecked. restrict_cpus_allowed_ptr() already does its deadline
check this way.

__sched_setaffinity() clears SCA_DL_CHECK before the second
__set_cpus_allowed_ptr() call it makes after racing with a cpuset
update, so the cpuset mask still wins there, as it does when
cpuset_update_tasks_cpumask() narrows a deadline task. SCA_CHECK stays
set for the PF_NO_SETAFFINITY re-check.

With this applied, the same test ends with both calls succeeding in 0
of 1000000 rounds on each of three boots, and sched_setaffinity()
fails with -EBUSY whenever it loses.

The race was reported by Sebastian. The fix was written with the help
of an LLM.

Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Closes: https://lore.kernel.org/20261103081149.DuyWNhVe@linutronix.de
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/core.c     | 11 +++++++++++
 kernel/sched/sched.h    |  1 +
 kernel/sched/syscalls.c | 12 +++++++-----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ed660f099a5..32fe889e02fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3195,6 +3195,17 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 		goto out;
 	}
 
+	/*
+	 * Check under the same lock that __sched_setscheduler() holds for
+	 * its admission test, so that p cannot become SCHED_DEADLINE
+	 * between this check and the mask update below.
+	 */
+	if (ctx->flags & SCA_DL_CHECK) {
+		ret = dl_task_check_affinity(p, ctx->new_mask);
+		if (ret)
+			goto out;
+	}
+
 	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
 		if (cpumask_equal(&p->cpus_mask, ctx->new_mask)) {
 			if (ctx->flags & SCA_USER)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 92134ce326a4..20ad13f388cb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2972,6 +2972,7 @@ extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
 #define SCA_MIGRATE_DISABLE	0x02
 #define SCA_MIGRATE_ENABLE	0x04
 #define SCA_USER		0x08
+#define SCA_DL_CHECK		0x10
 
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b87b878be63f..5983232476a9 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1225,11 +1225,7 @@ int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 	cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
 
 	ctx->new_mask = new_mask;
-	ctx->flags |= SCA_CHECK;
-
-	retval = dl_task_check_affinity(p, new_mask);
-	if (retval)
-		goto out_free_new_mask;
+	ctx->flags |= SCA_CHECK | SCA_DL_CHECK;
 
 	retval = __set_cpus_allowed_ptr(p, ctx);
 	if (retval)
@@ -1258,6 +1254,12 @@ int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 			if (empty)
 				cpumask_copy(new_mask, cpus_allowed);
 		}
+
+		/*
+		 * The cpuset mask must win here, as it does when
+		 * cpuset_update_tasks_cpumask() sets it on a deadline task.
+		 */
+		ctx->flags &= ~SCA_DL_CHECK;
 		__set_cpus_allowed_ptr(p, ctx);
 		retval = -EINVAL;
 	}
-- 
2.47.3

