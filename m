Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6FB4749CD
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235667; cv=none; b=FEwQGOlKEi7gTVLSbh7TovvRiOwT2TOU956wu2dtX1PlRsPmVG8A3YFzL7mPntGrTvfrIDKdMGCRgBu+4bTBANoN3cqN0Dbpa9FMTasXkfWwdNpW+yqGywF8q3JJ139zZM6h3/ZIyGlHJCHz/gywuCScaHStw6e7paWwabwjAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235667; c=relaxed/simple;
	bh=2fe6/7eiHicbbA/ix/MRAeBQ4apQGOmaLpxprrcuk/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCwzlQ3s+x6mWGJeZQ1xr0cyqorudxv/bKtQMCvT2Olq7qZero46vUvyzlb58n5NEL4DDZF6roZEjI/l4vuX9kT69ltWPAXk9vn45ChLefcl80RCF5GJmoUl5e4JNAg/SFa44zQbjQ5ES2J1r1L95/9ds3broiZb/vmvA2Cygs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQjG+Lp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQjG+Lp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48E91F000E9;
	Thu, 20 Aug 2026 14:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787235664;
	bh=wKOpy0Ho8wpxP82OA8Sqjb0mfbSN++LnpuYjwxwt9ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DQjG+Lp9cK4qGWmEaVUaXHHnCJuLrh726yQMUOturLogqCxuKWU6UozfbRMeoHg9Z
	 ZqRXAwL9l+yncLigt+SAsRmUJ/CsJL2/oh6k3qVj0994cw4FqR/QSbxaO/7UXJUboV
	 353GjqdGcxNEFE0zRxL6FzHyp7CGHP3A+bZNHM+q0qSW+PAgGNeRfUgLHgQMKeUG4n
	 4f4idobT1meYpFxKxuW4lJp9W7aOMNqXPwNfDYXTnnP+lI/60Ek/sGOT5Uh2P760SW
	 aTegzMsgVJYc1bAc4qdP5NCPod8j7M7m5PvMluf6qTH/XCvEwxHPc+zMpK/DA4hbGv
	 ZfSVVWNEKIX7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] perf: Unify perf_event_free_task() / perf_event_exit_task_context()
Date: Thu, 20 Aug 2026 10:21:01 -0400
Message-ID: <20260820142102.1884457-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081729-cruelty-pouch-23ea@gregkh>
References: <2026081729-cruelty-pouch-23ea@gregkh>
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
 kernel/events/core.c | 93 ++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 68 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index da77f856e1c83..8e2629d5305e6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13522,13 +13522,11 @@ perf_event_exit_event(struct perf_event *event,
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
@@ -13551,7 +13549,8 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	 * in.
 	 */
 	raw_spin_lock_irq(&child_ctx->lock);
-	task_ctx_sched_out(child_ctx, NULL, EVENT_ALL);
+	if (exit)
+		task_ctx_sched_out(child_ctx, NULL, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
@@ -13560,7 +13559,7 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	RCU_INIT_POINTER(child->perf_event_ctxp, NULL);
 	put_ctx(child_ctx); /* cannot be last */
 	WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
-	put_task_struct(current); /* cannot be last */
+	put_task_struct(child); /* cannot be last */
 
 	clone_ctx = unclone_ctx(child_ctx);
 	raw_spin_unlock_irq(&child_ctx->lock);
@@ -13573,13 +13572,31 @@ static void perf_event_exit_task_context(struct task_struct *child)
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
 
@@ -13607,7 +13624,7 @@ void perf_event_exit_task(struct task_struct *child)
 	}
 	mutex_unlock(&child->perf_event_mutex);
 
-	perf_event_exit_task_context(child);
+	perf_event_exit_task_context(child, true);
 
 	/*
 	 * The perf_event_exit_task_context calls perf_event_task
@@ -13618,25 +13635,6 @@ void perf_event_exit_task(struct task_struct *child)
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
-	raw_spin_lock_irq(&ctx->lock);
-	perf_group_detach(event);
-	list_del_event(event, ctx);
-	raw_spin_unlock_irq(&ctx->lock);
-	put_event(event);
-}
-
 /*
  * Free a context as created by inheritance by perf_event_init_task() below,
  * used by fork() in case of fail.
@@ -13646,48 +13644,7 @@ static void perf_free_event(struct perf_event *event,
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

