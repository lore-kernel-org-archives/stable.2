Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD53F3297
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736887; cv=none; b=WaOnmIOZzOEu+cIsPMpG/NIG14nOGIyVSJkyXqwwj8RtgO1uaLGPSvFseEo5TzTBEKEc/3cJBEzmGWquc4PPyJr7IHakSR75zXuCwO3/nXaDqsPX34ON9o/dv+OWtCqwyKRf/FbMHLYvFtL7cYZ3tA2Qe3C88fKX2fMbek05IoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736887; c=relaxed/simple;
	bh=rB5VNkCjU8TKrkcWH50o9mx8BAHlIuXNu1m7iKZjrFE=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NS0WJM2sDtxYXRgGNs5VFlfqARrctLCqRyqvQQ9jUk43rsj5JYt5zGOXKdz7VUF0QSyKzcP0TbIS00HHOzZidKX6Yy1MWu9bLcjPul6Gkxpu1h3qXKr701dvC+cEG2dpCCjcJBEqs1TDuDzDptG1w7WTLz8Dv3BIJkOI7/xO/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIvWQ6Cp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIvWQ6Cp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ABB1F000E9;
	Wed, 22 Jul 2026 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736884;
	bh=NimxU2soiMbfJhpmW5Qg5Q1M+0P/cUrPuIJ7YNj+DFg=;
	h=Date:From:To:Cc:Subject:References;
	b=TIvWQ6CpsODcFlNOulenzfv2IP1X6Anrrm/sXG6ZPIcWoAK9OrXGyenUKth5efgXz
	 7nAbo6MbNgVxtmIlKDHzGXvPAqlzu/t/98FOeUEa6OmE89K3xuJr4GEnsUXuJYQUaV
	 6qS0aLU9IrY7P2UGIg75ZG0/K4qlakfZIVyHEbsnPmktXhsil72QijSFpLfX4XC91a
	 w4IbdlZWle7iOFu108SUmbVmOEJp0gKMrUieCLlNNCaz6/RCYu9D2Nw0pE7DxSq+Rh
	 4NqeEb4paGLMm0VnjQjJB0OQnbkcAUuLkm2pSLhpG9Gq0BFah0KgSDw6GUROM3mpVQ
	 YcUYYjanMbDIA==
Date: Wed, 22 Jul 2026 18:14:41 +0200
Message-ID: <20260722153354.731490680@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: tglx@kernel.org
Subject: [patch 5.10.y 1/2] rtmutex: Use waiter::task instead of current in
 remove_waiter()
References: <2026072141-striking-reaffirm-3311@gregkh>
 <20260722152737.461825448@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Keenan Dong <keenanat2000@gmail.com>

commit 3bfdc63936dd4773109b7b8c280c0f3b5ae7d349 upstream.

remove_waiter() is used by the slowlock paths, but it is also used for
proxy-lock rollback in rt_mutex_start_proxy_lock() when invoked from
futex_requeue().

In the latter case waiter::task is not current, but remove_waiter()
operates on current for the dequeue operation. That results in several
problems:

  1) the rbtree dequeue happens without waiter::task::pi_lock being held

  2) the waiter task's pi_blocked_on state is not cleared, which leaves a
     dangling pointer primed for UAF around.

  3) rt_mutex_adjust_prio_chain() operates on the wrong top priority waiter
     task

Use waiter::task instead of current in all related operations in
remove_waiter() to cure those problems.

[ tglx: Fixup rt_mutex_adjust_prio_chain(), add a comment and amend the
  	changelog ]

[ tglx: Backport for 5.10.y and 5.15.y. The commit has not been backported
  	yet because the Fixes tag is wrong. Fixes: points now to the real
  	culprit. ]

Fixes: a1fb985f2e2 ("futex: Handle early deadlock return correctly") ]
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/locking/rtmutex.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1059,22 +1059,25 @@ static void mark_wakeup_next_waiter(stru
 /*
  * Remove a waiter from a lock and give up
  *
- * Must be called with lock->wait_lock held and interrupts disabled. I must
+ * Must be called with lock->wait_lock held and interrupts disabled. It must
  * have just failed to try_to_take_rt_mutex().
+ *
+ * When invoked from rt_mutex_start_proxy_lock() waiter::task != current !
  */
 static void remove_waiter(struct rt_mutex *lock,
 			  struct rt_mutex_waiter *waiter)
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
+	struct task_struct *waiter_task = waiter->task;
 	struct rt_mutex *next_lock;
 
 	lockdep_assert_held(&lock->wait_lock);
 
-	raw_spin_lock(&current->pi_lock);
+	raw_spin_lock(&waiter_task->pi_lock);
 	rt_mutex_dequeue(lock, waiter);
-	current->pi_blocked_on = NULL;
-	raw_spin_unlock(&current->pi_lock);
+	waiter_task->pi_blocked_on = NULL;
+	raw_spin_lock(&waiter_task->pi_lock);
 
 	/*
 	 * Only update priority if the waiter was the highest priority
@@ -1110,7 +1113,7 @@ static void remove_waiter(struct rt_mute
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK, lock,
-				   next_lock, NULL, current);
+				   next_lock, NULL, waiter_task);
 
 	raw_spin_lock_irq(&lock->wait_lock);
 }

