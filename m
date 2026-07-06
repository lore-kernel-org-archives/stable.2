Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AA241F7E2
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342209; cv=none; b=Xud/v7+FRquTxPfptCkS5qbMc5MD3bobaSxaPS9HQMH7+/SflEnBYq4oLVkPyvt06dKyqxPJolp4kRq3OEZq3kL5yn0A1Vt62kUHwjiG6S6ujMPcb0PjvJIwKdRPr9oRFpxyvpiaL4FDghIKwzAMmhsM5+04rb/dL7gxlxpJ5o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342209; c=relaxed/simple;
	bh=p5D2LcO4arCccyQpbLbBnDCwD0kBC19OhvkXdrSum4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8IyBwsWv+wH0eWQDVmBb1sdsEF0JQLmvRfRqWXs8+CjWvsulzXYJlw9zuwG0PzX1OGgvx+G3uBkxZrEfRsBEHqleOU0IScNtHAHRDWYf/oeGynTJUa4DmXGZi3VdZMLnkK+FemQ7dvpypwdSz2xyXYLMpawkbotW8WzMFElUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsRk9sp3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsRk9sp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DED91F000E9;
	Mon,  6 Jul 2026 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342207;
	bh=fUop6louVd7v86Eg0NdQ+SiNXl4dTQvETob+vmyIAKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HsRk9sp3mJu9THTtSxGdZTX+YMTfFUAbfj/Q36W6IgzQsKJ3Z+xzEu3WT9lQVsSUV
	 PzoDsAtQY5263Cyg10+li+cif8TC8X1ow+aPAUx0z5NHlc1qiQXXLRdS3Ta7Rcv/XS
	 RlT69bvfpuVuog7UCMLjbeQJLk8dbwGBQfNaqvuPHBxGBIk64CDeRm6SPsFMOe2iB1
	 WRw/7u013JZ5+xJRjSKLDFiQXA2ltvezevdgKSt0KTLSdUiy3fxd+KMWpOzPUh02c0
	 J7okxlRRKj2k2dJU3gy/QhwB2WVPrJzRjZESeqi/h+Hcf60i8IGnRP2tlgvDGxOGai
	 DxrJLW+cRiVUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Stultz <jstultz@google.com>,
	Bert Karwatzki <spasswolf@web.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] locking/rtmutex: Make sure we wake anything on the wake_q when we release the lock->wait_lock
Date: Mon,  6 Jul 2026 08:50:05 -0400
Message-ID: <20260706125005.2225064-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070211-activist-immorally-4371@gregkh>
References: <2026070211-activist-immorally-4371@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Stultz <jstultz@google.com>

[ Upstream commit 4a077914578183ec397ad09f7156a357e00e5d72 ]

Bert reported seeing occasional boot hangs when running with
PREEPT_RT and bisected it down to commit 894d1b3db41c
("locking/mutex: Remove wakeups from under mutex::wait_lock").

It looks like I missed a few spots where we drop the wait_lock and
potentially call into schedule without waking up the tasks on the
wake_q structure. Since the tasks being woken are ww_mutex tasks
they need to be able to run to release the mutex and unblock the
task that currently is planning to wake them. Thus we can deadlock.

So make sure we wake the wake_q tasks when we unlock the wait_lock.

Closes: https://lore.kernel.org/lkml/20241211182502.2915-1-spasswolf@web.de
Fixes: 894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::wait_lock")
Reported-by: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241212222138.2400498-1-jstultz@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/rtmutex.c     | 18 ++++++++++++++++--
 kernel/locking/rtmutex_api.c |  2 +-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 9b4bd06dd9acd8..9e99b9548e0a68 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1292,7 +1292,13 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	 */
 	get_task_struct(owner);
 
+	preempt_disable();
 	raw_spin_unlock_irq(&lock->wait_lock);
+	/* wake up any tasks on the wake_q before calling rt_mutex_adjust_prio_chain */
+	wake_up_q(wake_q);
+	wake_q_init(wake_q);
+	preempt_enable();
+
 
 	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
@@ -1602,6 +1608,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
  *			 or TASK_UNINTERRUPTIBLE)
  * @timeout:		 the pre-initialized and started timer, or NULL for none
  * @waiter:		 the pre-initialized rt_mutex_waiter
+ * @wake_q:		 wake_q of tasks to wake when we drop the lock->wait_lock
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
@@ -1609,7 +1616,8 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 					   struct ww_acquire_ctx *ww_ctx,
 					   unsigned int state,
 					   struct hrtimer_sleeper *timeout,
-					   struct rt_mutex_waiter *waiter)
+					   struct rt_mutex_waiter *waiter,
+					   struct wake_q_head *wake_q)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
 	struct task_struct *owner;
@@ -1639,7 +1647,13 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 			owner = rt_mutex_owner(lock);
 		else
 			owner = NULL;
+		preempt_disable();
 		raw_spin_unlock_irq(&lock->wait_lock);
+		if (wake_q) {
+			wake_up_q(wake_q);
+			wake_q_init(wake_q);
+		}
+		preempt_enable();
 
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
 			rt_mutex_schedule();
@@ -1713,7 +1727,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 
 	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk, wake_q);
 	if (likely(!ret))
-		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
+		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter, wake_q);
 
 	if (likely(!ret)) {
 		/* acquired the lock */
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 091b109acdc5ee..5b438aa71f8729 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -383,7 +383,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
-	ret = rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to, waiter);
+	ret = rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to, waiter, NULL);
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
-- 
2.53.0

