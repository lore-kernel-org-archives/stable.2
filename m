Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8191B3F39C5
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534716; cv=none; b=CJsTqDFF/nFs0PZokzZC3LwRshCv4CQKKsiBqLhyCCVXnM95mXZaGkarCl3KNKGwBIsgGdSGOJQzJIWTx6xVqjvTJp/Ik5wNr4XamNjwQzFwwcQK+vBkRTlkTLjvux9ezyJ6GiUvhkL4sGfEPxkQMHFX/Tu25Z/XlgVcfTmt8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534716; c=relaxed/simple;
	bh=mqbkLD4sZuAFS5J+OJoLi6FGPbeXNBt/RLAY9JghGmI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cBf0JI1N67/35cpwjMwa1HTZDmY0lFZf7+d5f0fHa1XSn+fLyNMcJ38mLMbIWyPeh0chikmB5X4+kmvwzia7WdwmSo4tXPQlbD9rzA+woYdzxgGxMBHyaaa8239W/f4joSgDKecqDFAfqyjl2rTvH+3494kfwDgjiNKvBsnJEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ULGHZz4+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ULGHZz4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1D21F000E9;
	Mon, 15 Jun 2026 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534715;
	bh=gxfQYXUTUXPrxb5Ki3nrllYhFUIz9Xx5RCMG3nppwyM=;
	h=Subject:To:Cc:From:Date;
	b=ULGHZz4+LPYdf/w9MnvgQeXG7HUIRYYgHfoR84Mtu4X8xG2Wv2YH4GudFEEkBng/n
	 +75l6Z3yFeza1qXt2W25tFQQF8s4aqK6uAwLMcdo951qgtASmogOmeqXoueda6QZm9
	 36YUpCKkCslTbawWBupFaoA4AvixpcJ+6SB69wWo=
Subject: FAILED: patch "[PATCH] debugobjects: Don't call fill_pool() in early boot hardirq" failed to apply to 7.0-stable tree
To: longman@redhat.com,bigeasy@linutronix.de,tglx@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:31:58 +0200
Message-ID: <2026061558-amiable-showman-7ea7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 0d046ae106255cba5eb83b23f78ee93f3620247d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061558-amiable-showman-7ea7@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0d046ae106255cba5eb83b23f78ee93f3620247d Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Fri, 5 Jun 2026 13:30:38 -0400
Subject: [PATCH] debugobjects: Don't call fill_pool() in early boot hardirq
 context

When booting a debug PREEMPT_RT kernel on an ARM64 system, a "inconsistent
{HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage" lockdep warning message was
reported to the console.

During early boot, interrupts are enabled before the scheduler is
enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts can
fire and in the hard interrupt context handler attempt to fill the pool

This can lead to a deadlock when the interrupt occurred when the interrupt
hits a region which holds a lock that is required to be taken in the
allocation path.

Add a new can_fill_pool() helper and reorder the exception rule and forbid
this scenario by excluding allocations from hard interrupt context.

Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260605173038.495075-1-longman@redhat.com

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 772ddabcbe7d..1fa156c45c09 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -720,6 +720,41 @@ static inline bool debug_objects_is_pi_blocked_on(void)
 #endif
 }
 
+static inline bool can_fill_pool(void)
+{
+	/*
+	 * On !RT enabled kernels there are no restrictions and spinlock_t and
+	 * raw_spinlock_t are the same types.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		return true;
+
+	/*
+	 * On RT enabled kernels, the task must not be blocked on a lock as
+	 * that could corrupt the PI state when blocking on a lock in the
+	 * allocation path.
+	 */
+	if (debug_objects_is_pi_blocked_on())
+		return false;
+
+	/*
+	 * On RT enabled kernels the pool refill should happen in preemptible
+	 * context.
+	 */
+	if (preemptible())
+		return true;
+
+	/*
+	 * Though during system boot before scheduling is set up, preemption is
+	 * disabled and the pool can get exhausted. Before scheduling is active
+	 * a task cannot be blocked on a sleeping lock, but it might hold a lock
+	 * and if interrupted then hard interrupt context might run into a lock
+	 * inversion. So exclude hard interrupt context from allocations before
+	 * scheduling is active.
+	 */
+	return system_state < SYSTEM_SCHEDULING && !in_hardirq();
+}
+
 static void debug_objects_fill_pool(void)
 {
 	if (!static_branch_likely(&obj_cache_enabled))
@@ -734,18 +769,11 @@ static void debug_objects_fill_pool(void)
 	if (likely(!pool_should_refill(&pool_global)))
 		return;
 
-	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
-	 * on the fact that spinlock_t and raw_spinlock_t are basically the
-	 * same type and this lock-type inversion works just fine.
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
-	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
+	if (can_fill_pool()) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
-		 * the preemptible() condition above.
+		 * the preemptible() condition in can_fill_pool().
 		 */
 		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
 		lock_map_acquire_try(&fill_pool_map);

