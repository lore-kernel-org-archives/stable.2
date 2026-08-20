Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A4378D93
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264894; cv=none; b=txNFXzPmKasodPET3vE4g9LiF6SMemD0JRPea4x1tAEmwY2WyoN6F7cCsiPiIMeEUTcpwZADsPYICAjPHKV9LqHcpykN9B2KEXtexk50qpUEyftsG8PvPamavnecXjcgTnIA6aONhWc6HUKgfqUt190bto8N8qsfyC4k+3AKCyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264894; c=relaxed/simple;
	bh=epM0fBIpiYt4K/qU6j6znNeRqBtMf6RCVhXXKnRgbXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWo0Yzyrd/XlHFbS1Zae5s7hLC+GOgLk8F5BzC1TPWF8szMwqwhAjIHDjlYZtA332Dvj2c2up+tGU2U248wKFv/RQCe1e/LSoWVj/GcFxB20d0irunlTPng34qdREQUdX7VPY0rc+pX3xVVaBFWAWj3wypa/7GLrU5EbC08pjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THSWJZ+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THSWJZ+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB91F00A3E;
	Thu, 20 Aug 2026 22:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787264892;
	bh=EjcyIa5bXbGBHIPOFbUNP0K9nvBFbbGrcTe0BZybzsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=THSWJZ+rM+oFAqFaH1PS85EEkodtL6+CAbwGaraOJdYReh1N1JpsyQj383iAOggQc
	 7plTRrrZ34g3LRNuRpFbnKT6GYVf7ohIuo21P0uWKnf42Q3TbuCsQA8UqiOlZV06C4
	 BCa+4FHljM5mYvsf+NzJdZyC0VqXgkbNm9kS4idwq+BJlS2OQmpPcpX6MhIjsjLWb3
	 Y9bGgCHMh/Jrh/0pT3MX144ZS4WAX8v1ef1PIUKftAHX4X2Nrf9Ao4ksbop5bFXGwi
	 Gc7i1yh/0tGQNbcF4DzrM6a8B+t3Qw6Z7O/G8pwX1ebLpmRaHedEfcXH/QDP2BP61+
	 4TYmMtpelSOhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] perf: Unify perf_event_free_task() / perf_event_exit_task_context()
Date: Thu, 20 Aug 2026 18:28:09 -0400
Message-ID: <20260820222810.2320933-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081730-clay-squid-bf75@gregkh>
References: <2026081730-clay-squid-bf75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 90661365021a6d0d7f3a2c5046ebe33e4df53b92 ]

Both perf_event_free_task() and perf_event_exit_task_context() are
very similar, except perf_event_exit_task_context() is a little more
generic / makes less assumptions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lkml.kernel.org/r/20250307193723.274039710@infradead.org
Stable-dep-of: 42c5ca1f0a28 ("perf/core: Fix group leader use-after-free after sibling detach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 96 ++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 70 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d45bce2acdbc7..e4e375376f455 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2393,6 +2393,7 @@ __perf_remove_from_context(struct perf_event *event,
 		perf_cgroup_event_disable(event, ctx);
 
 	perf_event_set_state(event, min(event->state, state));
+
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
@@ -13276,13 +13277,11 @@ perf_event_exit_event(struct perf_event *event,
 	perf_event_wakeup(event);
 }
 
-static void perf_event_exit_task_context(struct task_struct *child)
+static void perf_event_exit_task_context(struct task_struct *child, bool exit)
 {
 	struct perf_event_context *child_ctx, *clone_ctx = NULL;
 	struct perf_event *child_event, *next;
 
-	WARN_ON_ONCE(child != current);
-
 	child_ctx = perf_pin_task_context(child);
 	if (!child_ctx)
 		return;
@@ -13305,7 +13304,8 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	 * in.
 	 */
 	raw_spin_lock_irq(&child_ctx->lock);
-	task_ctx_sched_out(child_ctx, EVENT_ALL);
+	if (exit)
+		task_ctx_sched_out(child_ctx, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
@@ -13314,7 +13314,7 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	RCU_INIT_POINTER(child->perf_event_ctxp, NULL);
 	put_ctx(child_ctx); /* cannot be last */
 	WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
-	put_task_struct(current); /* cannot be last */
+	put_task_struct(child); /* cannot be last */
 
 	clone_ctx = unclone_ctx(child_ctx);
 	raw_spin_unlock_irq(&child_ctx->lock);
@@ -13327,13 +13327,31 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	 * won't get any samples after PERF_RECORD_EXIT. We can however still
 	 * get a few PERF_RECORD_READ events.
 	 */
-	perf_event_task(child, child_ctx, 0);
+	if (exit)
+		perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
 		perf_event_exit_event(child_event, child_ctx, 0);
 
 	mutex_unlock(&child_ctx->mutex);
 
+	if (!exit) {
+		/*
+		 * perf_event_release_kernel() could still have a reference on
+		 * this context. In that case we must wait for these events to
+		 * have been freed (in particular all their references to this
+		 * task must've been dropped).
+		 *
+		 * Without this copy_process() will unconditionally free this
+		 * task (irrespective of its reference count) and
+		 * _free_event()'s put_task_struct(event->hw.target) will be a
+		 * use-after-free.
+		 *
+		 * Wait for all events to drop their context reference.
+		 */
+		wait_var_event(&child_ctx->refcount,
+			       refcount_read(&child_ctx->refcount) == 1);
+	}
 	put_ctx(child_ctx);
 }
 
@@ -13361,7 +13379,7 @@ void perf_event_exit_task(struct task_struct *child)
 	}
 	mutex_unlock(&child->perf_event_mutex);
 
-	perf_event_exit_task_context(child);
+	perf_event_exit_task_context(child, true);
 
 	/*
 	 * The perf_event_exit_task_context calls perf_event_task
@@ -13372,27 +13390,6 @@ void perf_event_exit_task(struct task_struct *child)
 	perf_event_task(child, NULL, 0);
 }
 
-static void perf_free_event(struct perf_event *event,
-			    struct perf_event_context *ctx)
-{
-	struct perf_event *parent = event->parent;
-
-	if (WARN_ON_ONCE(!parent))
-		return;
-
-	mutex_lock(&parent->child_mutex);
-	list_del_init(&event->child_list);
-	mutex_unlock(&parent->child_mutex);
-
-	put_event(parent);
-
-	raw_spin_lock_irq(&ctx->lock);
-	perf_group_detach(event);
-	list_del_event(event, ctx);
-	raw_spin_unlock_irq(&ctx->lock);
-	free_event(event);
-}
-
 /*
  * Free a context as created by inheritance by perf_event_init_task() below,
  * used by fork() in case of fail.
@@ -13402,48 +13399,7 @@ static void perf_free_event(struct perf_event *event,
  */
 void perf_event_free_task(struct task_struct *task)
 {
-	struct perf_event_context *ctx;
-	struct perf_event *event, *tmp;
-
-	ctx = rcu_access_pointer(task->perf_event_ctxp);
-	if (!ctx)
-		return;
-
-	mutex_lock(&ctx->mutex);
-	raw_spin_lock_irq(&ctx->lock);
-	/*
-	 * Destroy the task <-> ctx relation and mark the context dead.
-	 *
-	 * This is important because even though the task hasn't been
-	 * exposed yet the context has been (through child_list).
-	 */
-	RCU_INIT_POINTER(task->perf_event_ctxp, NULL);
-	WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
-	put_task_struct(task); /* cannot be last */
-	raw_spin_unlock_irq(&ctx->lock);
-
-
-	list_for_each_entry_safe(event, tmp, &ctx->event_list, event_entry)
-		perf_free_event(event, ctx);
-
-	mutex_unlock(&ctx->mutex);
-
-	/*
-	 * perf_event_release_kernel() could've stolen some of our
-	 * child events and still have them on its free_list. In that
-	 * case we must wait for these events to have been freed (in
-	 * particular all their references to this task must've been
-	 * dropped).
-	 *
-	 * Without this copy_process() will unconditionally free this
-	 * task (irrespective of its reference count) and
-	 * _free_event()'s put_task_struct(event->hw.target) will be a
-	 * use-after-free.
-	 *
-	 * Wait for all events to drop their context reference.
-	 */
-	wait_var_event(&ctx->refcount, refcount_read(&ctx->refcount) == 1);
-	put_ctx(ctx); /* must be last */
+	perf_event_exit_task_context(task, false);
 }
 
 void perf_event_delayed_put(struct task_struct *task)
-- 
2.53.0

