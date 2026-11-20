Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198816;
	b=lwasCbPKG3RqtMR/ptRIlo2z5+/U437m8ZYVO2a2Zdyg0VRu66SUxldoSSrW6IV/FmAC
	 RxOHFjeA45MDq0FFJ+hoCm1lYizUl3Enk7HlSWZT6VOdL0c2LHhSIywN2Hlb2GL44skmq
	 KHn7XtxjZkM7ubmMdaV+3nhU4uGWXxI5BqoUCW8FPc/hrNakxnUQvWzf/5wcNx172AA6S
	 R9e0FL4KUZ7tSbCrusYP99VW2CdIWep7a4y9aJ9Ax+JAgYNy0upXJ+HhEKnLYjufjc6Ra
	 eHGTOjZwezAOCI4kjLjdRE4ZfQHwqpgliDZ6iFNroEHGfn3B+3FoknsW+HgbVRdtGlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YPedKILbu01eoY33ZLm37PxOMYs+jBP0a8L+1xgzvhk=;
	b=Q7i1+w2AMEtLPt372VPk9jNDEOAC/V4GwPfY9IO3TlJ4u+MbjTNp127JWhq7o/qjubIj
	 qeJVl5v2GtFrju2gH9yJIq5s7iYwksa5F98hbItsX5sEDn3K6bxFWdiiM14vUweKG7czh
	 EivJR9U56zp4hjpWMsjklbQ77g5SwtElDT05Y4sKTjYZMWtSK8W3oURCb16z8qR/nM7uc
	 5/WylvAZdZcP+Cq8TaKA5pc77f8uMwe0oU7PFq1kbOWpA+D21UJ639wBLyNDNOC0N58z/
	 T3Mci57nPHkap896HFB9E8/CQuajkpr+mshJalkAq8894G+JrrdcJczuB4ESxSPE/YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TAtG2F7i;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCAB606A88B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BCAB606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TAtG2F7i
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so929085f8f.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198811; x=1795803611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YPedKILbu01eoY33ZLm37PxOMYs+jBP0a8L+1xgzvhk=;
        b=TAtG2F7i8knZDS6lI+q/JHc/lqry777i0ApnZnw6o7PEMSyV2PtPZuHuzTtnQZGwBj
         WAXVWQJPp4lU6AWorMuCbOaoNeSd9mzCb+xV9OLgUXtXsU8Xi3Qmo3Bw+iGGpkucJ8BD
         LcJ7kBzbkH5SZhoOTLpPmjnjreqxT5cZR11ks6WVBQSojwsyDOOZjXvPVAlFLL/JOtNL
         XHc79wJAqKUhV0b8Exbfg61OBSYRx876D1g7RxG0LooIJXO4bxCdDIEwO50oioW19z1f
         7QpCglokUtVOOK4DBPEQLffpgFBTMTfagMTRmrjLUjsgm0VqjAMVe6lnHUelpM8yyZ1X
         B41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198811; x=1795803611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YPedKILbu01eoY33ZLm37PxOMYs+jBP0a8L+1xgzvhk=;
        b=Qo1h6SSgOP8BkO47g93h1uqnTOGzJCNeQP/pnmDJQaiF/6bwYYY3wQV2RXJeJjJtjc
         d51nxPFXIbDJSzgcbWs/1bNCmmDfvHHGuv8NvG7ylSMzcrg/a7AJJvTinZ/DQkCkm6AO
         9yoXDwxAOr+G2aKn4LnO1uKL3r/67eAQf1RILSqEjXu/3e2pyWevKyNPkLrruqjcetgH
         c/t/aKZ10bb3tg16n2LiIYZEex15OQobJHcTptWVJ5craRDtesMlVpD6U0YPjZVrZ3Cm
         K8GLV091+BHgA9JIKoj+fKI2C5A8wPT61d/l4Ix4npb7B1Mten9c9pZzXhMXn0Fps81g
         Be1A==
X-Gm-Message-State: APuU4Z/BLhlIOdZVj+xjyQAULMSDDfFsX7khLvMQ6ANZftC5rWxerj95
	8eSslsbaLioS3TqCl1caN+ODFpgaeqtXJBN9T+60pJYGOA4sXH0ONlarIujZoA==
X-Gm-Gg: AYBFou3RFxyTBm5aBTvxL7z6eu7sX/Lnnj5C7OVyg4/7yypal62nXX4TOMGSnH5c8aj
	t4b48AjUfD57MnxVAYRkrqnFZ5PfwMwzuqgosh7QIW3WXA8MQvp5cFqcIwSMjiv1DN5i9AloWHe
	TSvD6D7K2RpqmQ+UzjTWV0Ajay0sz6cjt+kt436xD7F16+TP3lCzzKvc1TRzu/vgp0h0BvwOUxt
	qSWBbjvsWCYNnIldoP5XRTyAt7n7u/+wucnbjzA1Y3219PWVK3EJrnWq88VwBPefZb4c18ObT6+
	a8+iMzxylS/KSr72KwYKGf07TiA+syVtat8YHrjFj+fCENm5nGp0AP2BogNjkXpcaaQi7BF4NQr
	rth1rFVp0zv0qYkP1xyFxVjLwGAjPQSfrQFI76eAmZlmtKddSOHtW8J/ILn4m4yQP73rOJRRYEG
	FL40PPc2oz9sU46T6oCJjuLNx9Lsnpasx9l2y2bCpHlXRseiAGBj+7bKRKd2G3yMIePKN8hoyNM
	GDUEzfk1/SxLs0OvpDpLB+3+6ftKaZ3r+IV1VQUlXirb3Cd/5avXfgua3idrasl6QuQBk3B1TmQ
	WhZ+JpWrhILApMcWJkwqzZFfNT5q1cRTb/nX358sWhFfsz3Y2TJEGdV+wN9RnZ8jtHXiks3GmRL
	n2u3phzAMbn+Ecb64BZwE18ShVw==
X-Received: by 2002:a05:600c:1546:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4bb887c2cb0mr98732575e9.2.1795198810472;
        Fri, 20 Nov 2026 10:20:10 -0800 (PST)
Received: from mbp-de-florent.lan (37.170.0.109.rev.sfr.net. [109.0.170.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm34789565e9.2.2026.11.20.10.20.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 10:20:10 -0800 (PST)
From: Florent Carli <fcarli@gmail.com>
To: stable@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: [PATCH 6.12.y 1/4] sched/deadline: Fix dl_server time accounting
Date: Fri, 20 Nov 2026 19:19:46 +0100
Message-Id: <20261120181949.7528-2-fcarli@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261120181949.7528-1-fcarli@gmail.com>
References: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
 <20261120181949.7528-1-fcarli@gmail.com>
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

From: Peter Zijlstra <peterz@infradead.org>

commit e636ffb9e31b4f7dde7fef5358669266b9ce02ec upstream.

The dl_server time accounting code is a little odd. The normal scheduler
pattern is to update curr before doing something, such that the old state is
fully accounted before changing state.

Notably, the dl_server_timer() needs to propagate the current time accounting
since the current task could be ran by dl_server and thus this can affect
dl_se->runtime. Similarly for dl_server_start().

And since the (deferred) dl_server wants idle time accounted, rework
sched_idle_class time accounting to be more like all the others.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251020141130.GJ3245006@noisy.programming.kicks-ass.net
[ Florent: rq->donor does not exist in 6.12, use rq->curr ]
Signed-off-by: Florent Carli <fcarli@gmail.com>
---
 kernel/sched/deadline.c | 40 +++++++++++++++-------------------------
 kernel/sched/fair.c     |  9 ++-------
 kernel/sched/idle.c     | 16 +++++++++++++++-
 kernel/sched/sched.h    |  3 +--
 4 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f5c64d1a0..2e3bd43af 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1216,8 +1216,12 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 		sched_clock_tick();
 		update_rq_clock(rq);
 
-		if (!dl_se->dl_runtime)
-			return HRTIMER_NORESTART;
+		/*
+		 * Make sure current has propagated its pending runtime into
+		 * any relevant server through calling dl_server_update() and
+		 * friends.
+		 */
+		rq->curr->sched_class->update_curr(rq);
 
 		if (dl_se->dl_defer_armed) {
 			/*
@@ -1594,35 +1598,16 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * as time available for the fair server, avoiding a penalty for the
  * rt scheduler that did not consumed that time.
  */
-void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	s64 delta_exec;
-
-	if (!rq->fair_server.dl_defer)
-		return;
-
-	/* no need to discount more */
-	if (rq->fair_server.runtime < 0)
-		return;
-
-	delta_exec = rq_clock_task(rq) - p->se.exec_start;
-	if (delta_exec < 0)
-		return;
-
-	rq->fair_server.runtime -= delta_exec;
-
-	if (rq->fair_server.runtime < 0) {
-		rq->fair_server.dl_defer_running = 0;
-		rq->fair_server.runtime = 0;
-	}
-
-	p->se.exec_start = rq_clock_task(rq);
+	if (dl_se->dl_server_active && dl_se->dl_runtime && dl_se->dl_defer)
+		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime = fair server disabled */
-	if (dl_se->dl_runtime)
+	if (dl_se->dl_server_active && dl_se->dl_runtime)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
@@ -1849,6 +1834,11 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_se->dl_runtime || dl_se->dl_server_active)
 		return;
 
+	/*
+	 * Update the current task to 'now'.
+	 */
+	rq->curr->sched_class->update_curr(rq);
+
 	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
 		return;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 020a39fe0..7e5179189 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1259,8 +1259,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		 *    against fair_server such that it can account for this time
 		 *    and possibly avoid running this period.
 		 */
-		if (dl_server_active(&rq->fair_server))
-			dl_server_update(&rq->fair_server, delta_exec);
+		dl_server_update(&rq->fair_server, delta_exec);
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
@@ -7114,12 +7113,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 	}
 
-	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
-		/* Account for idle runtime */
-		if (!rq->nr_running)
-			dl_server_update_idle_time(rq, rq->curr);
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
 		dl_server_start(&rq->fair_server);
-	}
 
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, 1);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 1f0f0d9a5..a2ab252e7 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -471,9 +471,11 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 	resched_curr(rq);
 }
 
+static void update_curr_idle(struct rq *rq);
+
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
-	dl_server_update_idle_time(rq, prev);
+	update_curr_idle(rq);
 	scx_update_idle(rq, false, true);
 }
 
@@ -521,6 +523,7 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
  */
 static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
 {
+	update_curr_idle(rq);
 }
 
 static void switched_to_idle(struct rq *rq, struct task_struct *p)
@@ -536,6 +539,17 @@ prio_changed_idle(struct rq *rq, struct task_struct *p, int oldprio)
 
 static void update_curr_idle(struct rq *rq)
 {
+	struct sched_entity *se = &rq->idle->se;
+	u64 now = rq_clock_task(rq);
+	s64 delta_exec;
+
+	delta_exec = now - se->exec_start;
+	if (unlikely(delta_exec <= 0))
+		return;
+
+	se->exec_start = now;
+
+	dl_server_update_idle(&rq->fair_server, delta_exec);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5e788dc39..598dd26fe 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -411,14 +411,13 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s6
  * naturally thottled to once per period, avoiding high context switch
  * workloads from spamming the hrtimer program/cancel paths.
  */
+extern void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_pick_f pick_task);
 
-extern void dl_server_update_idle_time(struct rq *rq,
-		    struct task_struct *p);
 extern void fair_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
-- 
2.39.3 (Apple Git-146)

