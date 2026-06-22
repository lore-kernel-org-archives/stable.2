Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2034B3346A0
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122097; cv=none; b=PhYmy1Sb7uO4r1Wg6fLfz/43Xir4yRXdJ0tMDjAw9DRpmckx+Bo+lxbvGpRMtyvv2beHYEqLE6tqOiux/c0qfWXhm99UaztvfIPYsKn1rkJ1fjEB/cjmCOfdmtzlm+PBFsjoQWRZXeFlDCbgnoMRcEHBKx4r/X57QVnDeKedvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122097; c=relaxed/simple;
	bh=YRMeC43kwGuUXSIuQ2nIwaz+X6MM6SHCq/3VvgUupds=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jenQXwjEe3W6qJx1n5xK1nxQVf8lMVeLmIZ7kIHv81XdGomXq7Lks11fCKsPTJ9Bu7k08JBYas7mpUCydkhHSaYNFYpeiWoE0VUpJCgjl+5/kgkFL4sLueGiL9ZxvZw77EmDH0wAlC/xJgr7KsYKk8BGVQ0KTiEDELnOHecAXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8JagKhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8JagKhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE86A1F000E9;
	Mon, 22 Jun 2026 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122094;
	bh=t37RrlgvpWnB2/6etC1Fs5LJ/NDzTJQqsIB6qvnBd98=;
	h=Date:From:To:Cc:Subject:References;
	b=e8JagKhI7AsJlADuJsHj6iOrnEnZn/R2gMp0k8iXS3psI4lBf2smu6IENesAce+LW
	 cpv10JsEnqNgKNYs6/vAOq2P/RBWn2XXFXzc5rGX8b6jrd9DJ+kdvKO65U5bg/CIP/
	 qpUoho0RZc3wz72U35H1sQ40i/d5pKPKMibPYdNusluBUW5Zlm84nmlPRvNzUedcfy
	 l0bcKEhXE+Wg3BvCDQl9NczdihJ9QAqVOasZfv/sCw7d3SxGKd4xGnv0j9L8uMju9o
	 LNW4sOu4rm//FsvwkLvDOGx0TNJBbENzlM/QsGViKrm/n8+s+rL4FI9J2vutK2rsag
	 Reo/dlFQHtTcg==
Date: Mon, 22 Jun 2026 11:54:51 +0200
Message-ID: <20260622093321.691179482@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 stable@vger.kernel.org
Subject: [patch v6.18.y 4/4] debugobjects: Dont call fill_pool() in early boot
 hardirq context
References: <20260622093040.582177124@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Waiman Long <longman@redhat.com>

commit 0d046ae106255cba5eb83b23f78ee93f3620247d upstream.

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
---
 lib/debugobjects.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)
---
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index cbd025dae5ce..17f116247bb4 100644
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

