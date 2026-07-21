Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8B435ED0;
	Tue, 21 Jul 2026 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620512; cv=none; b=bBr0VNuA5j6R+6Biy7FFDstVKBhrLoyrG5S09AcFhzqinJ8UmA6YBFEswyPPxNZemZX2ku2fQLwawc4WmSadxr62fK+MBss1cNA83ZWQkgX/whUiG7hb7oNooA+1UswFA+dhV4ctW5cNK6Y4xPIEmntm+xaw7X7DGd5EVXq/mZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620512; c=relaxed/simple;
	bh=LEyffTHmMPKmvxE1F8/aui1m0CrC9UpAk6uIZV8NrRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c689aJW5qtTXJBpgPOISuNAW8NBDRM7Tj5Q/PKbRnAx67gBX+d1RAYcwwlO5lXEdZ27CTbwmYqG9JkqI2W/OC26z5vIki1paGouaNL/XFWta84BfqUPw/r3QIbVucUjfgbOmnE5FUZgk/zjdsf5I/pQFgAZryznexvMCpVFD8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCeU/yxw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCeU/yxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36261F000E9;
	Tue, 21 Jul 2026 07:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620510;
	bh=b7vYQhguU740syKNSWYQ0h3PqXT9T6A3fFsJKPmQ218=;
	h=From:To:Cc:Subject:Date;
	b=lCeU/yxwsO6vP0Bhs//tpwFPhJlyk1tFMBJDQSO2JKYCbYVphdHb34KgjdiKccjpR
	 74C4nFRIPdwMdbu9XF4EjcnX9bgRAbeUkSJR5aCRNdSbfhhDpv3+9GO1Mlq+OD56CV
	 msCZJA/M22K2PE8wqNmRKYMlOpAVF8q7CvkVNFEB+83M68TanntEeY+tyUp3exLao8
	 jpvaaRc4TrRM3rkZFS7MWkDgvmBrAm8hxlYlOEND0Z90kIn63NOH1LLOwJu7d8wHUG
	 9midjPYX09kGziQ8EEFW4STUhaHflo/z5fFASyI/wEiU28qn7neuu0O2rvGklPuHLj
	 dh18RM3oMyDEQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <laijs@cn.fujitsu.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Keenan Dong <keenanat2000@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [STABLE v5.10 1/2] rtmutex: Use waiter::task instead of current in remove_waiter()
Date: Tue, 21 Jul 2026 08:54:53 +0100
Message-ID: <20260721075459.1970132-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: 8161239a8bcc ("rtmutex: Simplify PI algorithm and make highest prio task get lock")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit d8cce4773c2b23d819baf5abedc62f7b430e8745)
[Lee: Backported to linux-5.10.y from linux-6.1.y]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 kernel/locking/rtmutex.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c6a2dafd4a3b..2ab2d6cce004 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1061,20 +1061,23 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
  *
  * Must be called with lock->wait_lock held and interrupts disabled. I must
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
+	raw_spin_unlock(&waiter_task->pi_lock);
 
 	/*
 	 * Only update priority if the waiter was the highest priority
@@ -1110,7 +1113,7 @@ static void remove_waiter(struct rt_mutex *lock,
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK, lock,
-				   next_lock, NULL, current);
+				   next_lock, NULL, waiter_task);
 
 	raw_spin_lock_irq(&lock->wait_lock);
 }
-- 
2.55.0.229.g6434b31f56-goog

