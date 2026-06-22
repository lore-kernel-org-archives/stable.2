Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E83A5430
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122173; cv=none; b=T4ZVaHVtkAkhsn8x0BKtJH7mXObiqmnOZjmpNQEMXyiANcitR+I44hAUTnf+dHsMU2nwttHYDooCH9HVO9BmAm7GjltA4BIl83QwWK8rmbbcrQMVOFay/FVCC1kuK9MR+tFMGSHH/2ueA9TPR7eUOyfEGRkDOXPQ1JlhI5kXzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122173; c=relaxed/simple;
	bh=gU1hAbIFH/xa/hYrmGYHw8hV1kinhcFLanBG87oiwag=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Hi7WCxgo+nQk4lRzRpZyGDjKuaS3vNK6LKhFsPeNVgHVgO0NUzhpJhgOAsrgTAvBFJ93SC5Ey1YhBFxs1AEYKHKn7SnmZ5fQXUCydDuwQzK+P8AR3kwTTc390EbNToOQW+CQDfUdUV4Sx5T4UbOVBGwkEX2D75rBGZT05tddRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH71PTIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH71PTIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370E21F000E9;
	Mon, 22 Jun 2026 09:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122169;
	bh=xBgWuMW0ZtH315BOBobbh/t2mBePIm63ZkBL1s/PMn8=;
	h=Date:From:To:Cc:Subject:References;
	b=OH71PTIlSdOXV9wRjZLOe32VNsspjp0ofnEoAYsW6k+N2DVawcYAJsXNdIw38mYd5
	 KLRbGJuaAbsGWCaHR5x4Q+8czwlG2bcHlPKEWFn40LObq7bNoJp+ZxL4mmuKCtw/SQ
	 +JiTYGNFZmcES8N21w3rSef8O0J1KBo+EFp4mG8XV1X3Xoz9CvJEKvdsqMCLHk1nuJ
	 czlyHuOoGsP1ICS7PfMejhplNButhoiZ3G9bWuBV0U87Iu77GMZQ/Z9TgSQS/Nl0mj
	 s9AZz+tKgHRhlsVPuiucURrLZvXivYLUnVvEaMXfuuZSF6xdp/w7GlTjy/7SwHAN7s
	 R1zQ6490HllaA==
Date: Mon, 22 Jun 2026 11:56:07 +0200
Message-ID: <20260622094802.314769410@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.1.y 5/5] debugobjects: Dont call fill_pool() in early boot
 hardirq context
References: <20260622094345.511524619@kernel.org>
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
@@ -606,20 +606,48 @@ static inline bool debug_objects_is_pi_b
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

