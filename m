Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466344;
	b=jfsEtb/t6TxKsTB/p1Thp/szt41PMmOgr4Hv2J4ytk13QcHsh+o11qhYFWiLLvdE38kq
	 BrdOny+w4G/1+ckfYJWkxIwR3ZF2/mrcAlNT/XDkZPkMs9QM91driGD+MTGNPaXKJD0Bv
	 U++rHyYPasQqsKUku9Y2kJLjpXFNi9awahMjMQ8Kkm2gJE5/3vj+PYT+u6xNvuPoEQA67
	 FoKo4J7LiwxMzeDgZM/CzjrnwZhVegNde6XZC5Wm5qbNoBVV679QFWGdUBXY/EepSIQNB
	 fj/pUOxiZ6TNC8RVFAMaEGQ0JsZaPrziebrdI2elM8IXjUdICfhHe8oWJ07Uj4Mp55w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466344;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gkS9ftmwyumR33E1KbpJsRDJoGUI0UTaeRfRU3fysUo=;
	b=UE7ocNxIswR8PAVfxFdlUtQUNnIlawXeS84Yuqk30ZwB63ABSQkOqMyN2EByVSzTRP/3
	 mbU4ctegHYr1FZYh6spbwWo/cCLebricFP4/kKN1RuOx1Csb3HUw6niO2XwReSz16Hb2R
	 U6Et2YeyVHV1sLyMmCkcooD5euqLPxPFNAazegTX3cbknVKXmJ8FsNHUvM+0a56AlLb5O
	 qN195zeXWy2VDHbw0qXsvr4uExK6MK+v+y1dowsUmoIb9JFwdYgB2sRauXLMgyC4rcQ16
	 R76vVT27XSCOfRFxCfYqMFHyvsAEa1cgcilMOKljsRvLkXF0fTsLrOnjSjjQHQkCwJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efhac3fk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD8606A321;
	Sat, 31 Oct 2026 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efhac3fk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5740E1F00919;
	Sat, 31 Oct 2026 17:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466343;
	bh=gkS9ftmwyumR33E1KbpJsRDJoGUI0UTaeRfRU3fysUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=efhac3fkJIidzy3l/SSvft7/qBlWRwyQQIExLyJzE9pZ/JEYDjHEX14KHiW4PX1vX
	 nfxaoHIJ6MUTES11f+febda0QPigjiP5pJToBtVXShBWhOxib91SoaDSKjJ1/j22bd
	 hWfHy3ct8F4rezTGs9mrN9PZdv9fyG4b07v5jwucpLg++GrZ9jN3M8gOYIbcvHtM9z
	 L2D+/ViCxoak1pM2uBqkG8WZmeUc02Msgt7+ddseuXET6fgIsAbTrJezlcac7aYTBY
	 QbrUxC/JwsN0rIJqDHx++3mvGMSbPjoSqeCpD4e7IYutZUawwMwZKSL3gW0AZUTab/
	 nzOxeuycJzlrg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Factor out drain_offline_rq()
Date: Sat, 31 Oct 2026 07:05:40 -1000
Message-ID: <20261031170541.710939-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031170541.710939-1-tj@kernel.org>
References: <20261031170541.710939-1-tj@kernel.org>
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

Factor drain_offline_rq() out of rq_offline_scx() so that the drain can move
to handle_hotplug() in the following patch, which removes the rq_online and
rq_offline hooks. The drain is the rescue flush and the re-enqueue of an
offline cpu's tasks onto its local DSQ. No functional change.

Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 35 ++++++++++++++++++++---------------
 kernel/sched/sched.h   |  2 +-
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index cd923f9f1f2a..c75df42d8c6f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2428,7 +2428,7 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * list_add_tail() must be used. scx_bypass() and rq_offline_scx()
+	 * list_add_tail() must be used. scx_bypass() and drain_offline_rq()
 	 * depend on tasks being appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
@@ -4304,6 +4304,24 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 		scx_call_op_set_cpumask(sch, task_rq(p), p, (struct cpumask *)p->cpus_ptr);
 }
 
+static void drain_offline_rq(struct rq *rq)
+{
+	struct task_struct *p, *n;
+
+	scx_rescue_flush(rq);
+
+	/*
+	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
+	 * onto the local DSQ so that they run here and balance_push() moves
+	 * them off.
+	 */
+	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
+		if (p->scx.dsq == &rq->scx.local_dsq)
+			continue;
+		guard(sched_change)(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK);
+	}
+}
+
 static void handle_hotplug(struct rq *rq, bool online)
 {
 	struct scx_sched *sch = scx_root_protected();
@@ -4391,26 +4409,13 @@ static void rq_online_scx(struct rq *rq)
 
 static void rq_offline_scx(struct rq *rq)
 {
-	struct task_struct *p, *n;
-
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
 
 	/* sched domain rebuilds call rq_offline with the CPU staying alive */
 	if (cpu_active(cpu_of(rq)))
 		return;
 
-	scx_rescue_flush(rq);
-
-	/*
-	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
-	 * onto the local DSQ so that they run here and balance_push() moves
-	 * them off.
-	 */
-	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
-		if (p->scx.dsq == &rq->scx.local_dsq)
-			continue;
-		guard(sched_change)(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK);
-	}
+	drain_offline_rq(rq);
 }
 
 static bool check_rq_for_timeouts(struct rq *rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c7c5633524a..2cc16c01b168 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4294,7 +4294,7 @@ extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
  * Typically this must be called while holding task_rq_lock, since most/all
  * properties are serialized under those locks. There are currently two
  * exceptions to this rule in sched/ext which only hold rq->lock: scx_bypass()
- * and rq_offline_scx().
+ * and drain_offline_rq().
  */
 
 /*
-- 
2.56.0

