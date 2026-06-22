Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315739B481
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122132; cv=none; b=tkraCuiI0gud3RFsIckki2Yb5u1xfrXaNrsbvYqjTmSr+5OdbYiztr0+OhGmlSftchRohvhEVxbZCZvc50uIkHsVTfduDDUMCxtEbrLxEmcRJs5eFdd7KeNBEwkoU0xm4ynrouiK929ecNQM+EtPHnxJA2rorUwwt3rug/tTSLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122132; c=relaxed/simple;
	bh=KBjFfM0AlCBfQn8aN+nIBfNoy0XUZet9wyMlcpBdgzc=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cSgwLpMPjJdeuvV9PLdItWEFUW3jZGFJMKe50AhWi9NyC3w7Ys4rCdDTj9RSThvpuj6HCUFS/sFyMl0ZUn0MGJlJ9m0NqFSCN4YsyzLP+KrsbTg0eCQWARIOtKFUBjA+i5o1aBrZ6xOqqr+a/fcCs9Yf0jct/S75NM49NdCh16c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqcrwPG9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqcrwPG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1D91F00A3A;
	Mon, 22 Jun 2026 09:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122129;
	bh=Bj6Nr9Lghornkb1lScRXQ71k/1BtiboIa/ZzcaDjw4I=;
	h=Date:From:To:Cc:Subject:References;
	b=nqcrwPG9yEZMb3Zy86ZsyTTRN0oTQ4kOzabj/mJFAvcItIxx8xiwHk3dj/TwivW9M
	 VFNTLxackgci1MzvQC/n7Fl/vxx6PFXY9LYwq/WLi6j1as+WYqD0bz80fiO++KWcgT
	 wnx1GSRDTkHyLVrIdzMwrU/5I+yvX7Hoj0olsFz3QcKPn9sgURzQv/F0Jk0CTmCS3Q
	 2DMjNkyo4zOo3g+/D/L/XktzWqnM0JoaUe4NuPOLHCQ4cIF1lre6C9DS11CODcyr5p
	 p9DiPNkqdw2LZlm6DPzU9YBQqJ8Eq+i6GmXbPhjon6QawGdRLyf07SMSNbPqZzTUWR
	 T6nUftwb/YHnw==
Date: Mon, 22 Jun 2026 11:55:26 +0200
Message-ID: <20260622092952.240785554@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.6.y,
 v6.12.y 4/4] debugobjects: Dont call fill_pool() in early boot hardirq
 context
References: <20260622092400.929691694@kernel.org>
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
 lib/debugobjects.c |   44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)
---
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -605,20 +605,48 @@ static inline bool debug_objects_is_pi_b
 #endif
 }
 
-static void debug_objects_fill_pool(void)
+static inline bool can_fill_pool(void)
 {
 	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
-	 * on the fact that spinlock_t and raw_spinlock_t are basically the
-	 * same type and this lock-type inversion works just fine.
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
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
-	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
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
+static void debug_objects_fill_pool(void)
+{
+	if (can_fill_pool()) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
-		 * the preemptible() condition above.
+		 * the preemptible() condition in can_fill_pool().
 		 */
 		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
 		lock_map_acquire_try(&fill_pool_map);

