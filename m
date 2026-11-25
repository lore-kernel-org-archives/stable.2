Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633714;
	b=iiWz+fNu2bcuUhjEmmVkHNUEiKv/D7WzwLi9wq461X74BhUymm5QEyGTcRxZo1lR90CK
	 HaI6s1Ie00p1Lo3QF+/lV3UP02r1pT58GhdgAFFY0elHTZ7+KRSUV3+tRoapaXLxYkBb9
	 Or8EaWattfGgPo4lrbzmSeukf3+9Jizp2nyl6/nxw5wosQSFyzV1RwgZAIgK6VVSHkdsJ
	 kS6H43otXHTlq19mNAZR49Fzgr6cQfee95x8uA2eNGCbiGPOCmhyojtuzPpPNH7FDnrpu
	 0MJHHYKoyq6JXHXG9RPVusGy2OXfYA68RmtJx5saGnOXndpdHuvTzp7IshtnNnexWGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633714;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7Nb2MEcjqHRG8+hp02U0dqUPGCYQeAHVfXqG3uf8ZNk=;
	b=St7cnrtC4J43atFktNli74USQqIe1cBeVj0YRB/IG5B4S6+JNCfmLUQwm/qxp5MknirV
	 TBzme61d7yY/aQWcBONmVyCtPHMombznvomkoIVvo4iVPJOYvkJ4VSnbp4/mz/F4sjISe
	 /8sGLbzPViQ+/797D+Qv3Bva8GVP1mLoaPKUwt1W261OqlavqqXWjHXQL0/Z6XxENEbYg
	 ebM8c9YaB/2XpjHVFJD+NrKeI5ftF28UgU4pz5mKt7qS/MlrIfCwx9hwrm00Zg7AeL+Ws
	 95YxNBfjyLJ87WmWxUCTYGJhcG9ViAJZnEL0Cd+qrj774jmdFkQcH98yXDLtWzO9e6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUc5lf+t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432F606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUc5lf+t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0BE1F000C6;
	Wed, 25 Nov 2026 19:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633713;
	bh=7Nb2MEcjqHRG8+hp02U0dqUPGCYQeAHVfXqG3uf8ZNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EUc5lf+t7iiYJ55M6rjjmIAE4kUWnCVVQmDqhKSN55WkQzsiI4DRS7vIt57UCYWK1
	 oexZUElCkDfOzgIOB3mtS6+rBXAMaWoMS4y+xRWtunIIWagVir2+k6vYk0DeY8VXee
	 OjBVwVI5z+dX5sfCqj2jMCT6cTAMuQP4qgx0ReXLUyzdUAaWn/x72kuNp16mBf4Jqi
	 l+BD5NNEAzFLV4RPBe3ELbWCCJY3rg8n+hUmsmZpeMrfUgojB3bQlskbo6nnhOjnAo
	 n1schu5KecPO1jfZz3lB6JEQL/xVf9gCPNu44cl6InWZRtHdwfa8DA2TdpC4y9a1zU
	 w3S28O7WQeiQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] sched_ext: Factor out drain_offline_rq()
Date: Wed, 25 Nov 2026 14:08:31 -0500
Message-ID: <20261125190820.1175265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-energy-proven-d70f@gregkh>
References: <2026112517-energy-proven-d70f@gregkh>
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

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 1826e5aa068cf6c21791773f160b4a2ce5d5f9a5 ]

Factor drain_offline_rq() out of rq_offline_scx() so that the drain can move
to handle_hotplug() in the following patch, which removes the rq_online and
rq_offline hooks. The drain is the rescue flush and the re-enqueue of an
offline cpu's tasks onto its local DSQ. No functional change.

Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
[ sashal: Omitted upstream's scx_rescue_flush() call in the new drain_offline_rq() helper since that function doesn't exist here, and applied the edits to kernel/sched/ext.c instead of the split ext/ directory. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c   | 32 ++++++++++++++++++--------------
 kernel/sched/sched.h |  2 +-
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b3a6d60709403..eef7401e6e92a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1369,7 +1369,7 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * list_add_tail() must be used. scx_bypass() and rq_offline_scx()
+	 * list_add_tail() must be used. scx_bypass() and drain_offline_rq()
 	 * depend on tasks being appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
@@ -2650,6 +2650,22 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 				 p, (struct cpumask *)p->cpus_ptr);
 }
 
+static void drain_offline_rq(struct rq *rq)
+{
+	struct task_struct *p, *n;
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
 	struct scx_sched *sch = scx_root;
@@ -2696,27 +2712,15 @@ static void rq_online_scx(struct rq *rq)
 
 static void rq_offline_scx(struct rq *rq)
 {
-	struct task_struct *p, *n;
-
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
 
 	/* sched domain rebuilds call rq_offline with the CPU staying alive */
 	if (cpu_active(cpu_of(rq)))
 		return;
 
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
 
-
 static bool check_rq_for_timeouts(struct rq *rq)
 {
 	struct scx_sched *sch;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ad7b72317f0f2..3da117130a23a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3925,7 +3925,7 @@ extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
  * Typically this must be called while holding task_rq_lock, since most/all
  * properties are serialized under those locks. There are currently two
  * exceptions to this rule in sched/ext which only hold rq->lock: scx_bypass()
- * and rq_offline_scx().
+ * and drain_offline_rq().
  */
 
 /*
-- 
2.53.0

