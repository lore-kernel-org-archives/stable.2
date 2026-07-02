Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC67331EB8
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007282; cv=none; b=fB4WNXDZ/jmXq+qBs1dxJXH3eTOAl7nebgC/mYGMibjLyZqUBy/YJUe1mHCX3ETw2DjgMVqct6QbDcB1Nzei9wmau+dv7lti+DL3TnGIVDFeajhtkC1a6z1jij5S/m4X+VB8ziyWEn6w5LsyCfP/Q0M+Ht4nPGoeO3PhLkfRE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007282; c=relaxed/simple;
	bh=TrQW5UemVAlFuuD0GxqbaLvlUiQTB9onE1DD0liH96w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=saJtgYy4qT9HumbW550yToIuAjpKA8felLygjPt50CMHUCPMLkqTwfvhIoZdL+LDA8WUw9sUgQwzs4TdDMQA2wgRvYGZXAY52l3U0slcXJzYTeOaTkDObEl8FkETvp2i2qUQQtdMhOq3PLOr7h5Mx272+dHIXNVvv/kr890zMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBWlRlX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBWlRlX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC46F1F000E9;
	Thu,  2 Jul 2026 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783007281;
	bh=KW+OUpv2i7wd5JHW28ZoLgu+GNhhnlMj+OCvgMXdeFw=;
	h=Subject:To:Cc:From:Date;
	b=XBWlRlX8OBgrVjWfba3b9r5lS38nBFtipNPlnAMD85Yb+pOu6dpUBy2hstBv4ij9L
	 rbfmJk8Op1eNuygRmj0EIEaBUzcflzR0KZohzA67hrPfMJvYNDtbFGMnaOF5Djr14k
	 FVZ+JZvT7OKmPR65L8eDT3GJbrR4LQKdXhksQh7g=
Subject: FAILED: patch "[PATCH] locking/rtmutex: Make sure we wake anything on the wake_q" failed to apply to 6.12-stable tree
To: jstultz@google.com,peterz@infradead.org,spasswolf@web.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 17:48:11 +0200
Message-ID: <2026070211-activist-immorally-4371@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4a077914578183ec397ad09f7156a357e00e5d72
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070211-activist-immorally-4371@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4a077914578183ec397ad09f7156a357e00e5d72 Mon Sep 17 00:00:00 2001
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Dec 2024 14:21:33 -0800
Subject: [PATCH] locking/rtmutex: Make sure we wake anything on the wake_q
 when we release the lock->wait_lock

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

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e858de203eb6..697a56d3d949 100644
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
@@ -1596,6 +1602,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
  *			 or TASK_UNINTERRUPTIBLE)
  * @timeout:		 the pre-initialized and started timer, or NULL for none
  * @waiter:		 the pre-initialized rt_mutex_waiter
+ * @wake_q:		 wake_q of tasks to wake when we drop the lock->wait_lock
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
@@ -1603,7 +1610,8 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 					   struct ww_acquire_ctx *ww_ctx,
 					   unsigned int state,
 					   struct hrtimer_sleeper *timeout,
-					   struct rt_mutex_waiter *waiter)
+					   struct rt_mutex_waiter *waiter,
+					   struct wake_q_head *wake_q)
 	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
@@ -1634,7 +1642,13 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
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
@@ -1708,7 +1722,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 
 	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk, wake_q);
 	if (likely(!ret))
-		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
+		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter, wake_q);
 
 	if (likely(!ret)) {
 		/* acquired the lock */
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 33ea31d6a7b3..191e4720e546 100644
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

