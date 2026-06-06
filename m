Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5B302146;
	Sat,  6 Jun 2026 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749521; cv=none; b=e4V67viGqZEA3GNHto5WihaM9+bR2e4Z5Xq5tWvUavwtLrrezs6aC/aE3TYRzWP93uXuDFXUFc2QZyyKo9BjvP47pfjAy01fGd/Xk04JL2IY10jXhwoUaBuNL2zkF3HcaJn588ce/0MjKcpzAZgmj+pMScsn5ahmNZjs5B9GWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749521; c=relaxed/simple;
	bh=4DcdfDavvzpaMrsec9abF9ROi5PiTZk2inhE88BT95U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mHrYS3wVuLpqGH2xEQdlDuX/m21RcS7SapdLizV2xHYX+SlN2x+bI0rw3MDm9H9TsFiSKy1cjGPcTjXBETWQzUOPF/xuVEJxUOTBlxmbefq5JEOKTalgq9EbuJdQWLaWLEvVQM5V8xWomQwKGetrNB1MenTPI0Ho+XZnEzhWZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lisJpv1k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V0yTsJIZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lisJpv1k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V0yTsJIZ"
Date: Sat, 06 Jun 2026 12:38:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780749513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQjnBrGn/CdTM6aPrZoHIzwgAu7bVALWZBDj4MEXjQM=;
	b=lisJpv1kIr3zI9egeMAbSTd1dRpfK7i5A3GYegbbIiQoVPOUHHe34bd5dCw6KMW5WSW+PP
	vJYu32CsGkaUB9wwKgky8dd313+tghpD6+HuQ7L8qtjdMZF1nt620eR4Fl3ibhspvvT0sg
	Q/BO1IjHiaXSigK5JcQV03QnFUdAI0GjE/sOp9/tCb0bMVf4QZzzmZ/oPiQibrhix7W6Sn
	cNhyVycmpEYxDZiNVK6s1LDrvSWrUrKUJ29TmAXIhkP9ikRR34CWTaNUcNJr/OIVsb0Abf
	lK2qSMZ1ZBu6Rh3vbwFqcN5ib1yDF/+Ac/a3q/7qvsOuaA25m78R46WxXC8kqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780749513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQjnBrGn/CdTM6aPrZoHIzwgAu7bVALWZBDj4MEXjQM=;
	b=V0yTsJIZzi/3occIDDs2h0Ysr03RcLWOxWly8Wk69vviPHc62hz2vsBerqC4zeUfd53js5
	W7Cg4xF6zfqAhjBA==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] debugobjects: Don't call fill_pool() in early boot
 hardirq context
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260605173038.495075-1-longman@redhat.com>
References: <20260605173038.495075-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178074951101.529383.11383795000581228374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     0d046ae106255cba5eb83b23f78ee93f3620247d
Gitweb:        https://git.kernel.org/tip/0d046ae106255cba5eb83b23f78ee93f362=
0247d
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 05 Jun 2026 13:30:38 -04:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sat, 06 Jun 2026 14:36:25 +02:00

debugobjects: Don't call fill_pool() in early boot hardirq context

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

Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SC=
HEDULING")
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260605173038.495075-1-longman@redhat.com
---
 lib/debugobjects.c | 46 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 772ddab..1fa156c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -720,6 +720,41 @@ static inline bool debug_objects_is_pi_blocked_on(void)
 #endif
 }
=20
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
=20
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
