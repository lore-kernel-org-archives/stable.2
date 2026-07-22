Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042BC3E172F
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736904; cv=none; b=RbqVoGreZRsia6c7vpyxh9mDhFYA4SrofVWE1INAuk/q14baaViGzosHr9l0w6XydAj9bcU08D16+UF80N6Cg9/kNO5qVPmoN5PEKq4uojHVj1IuQySbUtKKOy2XIWMtp1bfTNwKEXqNFnbr5sPRpSsBcZCHPZ7xy0nfzMNBp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736904; c=relaxed/simple;
	bh=39DhfKuT+fICKGRNvAOQQZe/TYVbUNHmRGbiAwgZnPw=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VpfYLhumfY4ThwsBNPm4t+a20obc/XRqq9oscQwJf+/a0ZLtSUHgJji3s9+0bn9QGi4pGrTrOOMStmfeuqe32pYZruvJjDI67UKr37vIT/Vdg1fxt1PHBNRirLlwJ0Y67ag2QTeOQEi6CORD6/hV5sMdA6aL+sDEMCnxQ/RfZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtoXiw6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtoXiw6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0736B1F000E9;
	Wed, 22 Jul 2026 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736902;
	bh=CJ3X6F1KbQicFusnEWK3tKFLSOc4Qj7LBRJzzpClQ6c=;
	h=Date:From:To:Cc:Subject:References;
	b=AtoXiw6VZ5r4bSB8oJMltvhmztRVR+BE7kigFg6ap22fG4Qkgsx3U5tDdxdu8JF86
	 vd8LhnM0rbebxesflUjn7PZL1gnuSWcfLHlkgzr0xFQGSPsE8pPfT34PcN5XsRC4Fc
	 gsk2wLNKOXHqLQTCHz9v4DqCzDumPX1iepVEa6QG7D1e0OtcoTiJS6/uYh6QVxFkZY
	 AN94wRG5HreVllSmy3yF7GfNjThYNpyfbHVrbmn4UedxEK7Nw1CfrX92EmBgZ2CzAB
	 pxUJoRb10kVCVH1mnRwHFAjsoCb5Y40JWXdv/5EuCeOANvPABP7KAQJ44+7vIyUOeO
	 Crv2/lkkJt7ag==
Date: Wed, 22 Jul 2026 18:14:59 +0200
Message-ID: <20260722155238.973818077@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: tglx@kernel.org,
 Yuan Tan <yuantan098@gmail.com>,
 Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>,
 Keenan Dong <keenanat2000@gmail.com>
Subject: [patch 5.15.y 1/2] rtmutex: Use waiter::task instead of current in
 remove_waiter()
References: <2026072141-ravage-display-0696@gregkh>
 <20260722155049.973195593@kernel.org>
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
 kernel/locking/rtmutex.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1500,20 +1500,23 @@ static bool rtmutex_spin_on_owner(struct
  *
  * Must be called with lock->wait_lock held and interrupts disabled. It must
  * have just failed to try_to_take_rt_mutex().
+ *
+ * When invoked from rt_mutex_start_proxy_lock() waiter::task != current !
  */
 static void __sched remove_waiter(struct rt_mutex_base *lock,
 				  struct rt_mutex_waiter *waiter)
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
+	struct task_struct *waiter_task = waiter->task;
 	struct rt_mutex_base *next_lock;
 
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
@@ -1549,7 +1552,7 @@ static void __sched remove_waiter(struct
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK, lock,
-				   next_lock, NULL, current);
+				   next_lock, NULL, waiter_task);
 
 	raw_spin_lock_irq(&lock->wait_lock);
 }

