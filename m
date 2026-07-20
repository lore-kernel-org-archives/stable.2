Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497B43803B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562932; cv=none; b=ZYXNgWyKY7rAiYtmyMxExFUidKNhJaPHRGyY9xGa6sJAOO/8e34SmXTRh2pOhqprchPciyScj8BUslbJpsDbKPNNQ709c3jUMp3GfKndFvFLVETjFjq5GZLoE+8xIs9dRHUIic+KN2YlZDCLqTWqox7DMi9ZyWFZd/kzXyuVZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562932; c=relaxed/simple;
	bh=lGYZl6aKRdpxXTaa9IZc+qNJH3IeEXK1QFJDVsM0P04=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h7SCB1k+90mspqThkrsdJtHQS8vz7kMpDtKthDGyCYKOTcYGr2zivBpLSF1kvdhexCgkowXM9il2JaDziSQTx872NPDagPqxkNtPdnSUOv15Pbibby8SI0xFctSVTE+tXsG8Wmmhlt2FXmKxjVqZdVEZonhUfEVKQ1IdSCXpc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UILKbd6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UILKbd6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361D11F000E9;
	Mon, 20 Jul 2026 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562930;
	bh=wNsNAFMd5QOAixSR197Rl7RKQNm3x5tGBUty3sQTxjg=;
	h=Subject:To:Cc:From:Date;
	b=UILKbd6dEgYI8OT7rH80PBvwg9VV3A1rTUt3rmAXUgaJbMq7azZ/GNTP66C0gPvmS
	 qD/vD8xsJqCt3lxDB74cC7sZsxEvM8U23+QNBptXzfFS8S+9MsRvJaHIpHa2hruPoj
	 8+Du6m+e6loS0lOlxFdV6DfIdSPYEjJu+rud86WU=
Subject: FAILED: patch "[PATCH] locking/rt: Fix the incorrect RCU protection in" failed to apply to 5.15-stable tree
To: tglx@kernel.org,bigeasy@linutronix.de,jannh@google.com,viro@zeniv.linux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:49:00 +0200
Message-ID: <2026072059-deliverer-unstuffed-ac64@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 89038cc87d80c77e7aa6f42a64b2573b74af339f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072059-deliverer-unstuffed-ac64@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89038cc87d80c77e7aa6f42a64b2573b74af339f Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@kernel.org>
Date: Fri, 19 Jun 2026 14:52:08 +0200
Subject: [PATCH] locking/rt: Fix the incorrect RCU protection in
 rt_spin_unlock()

rt_spin_unlock() releases the RCU protection before unlocking the
lock. That opens the door for the following UAF scenario:

 T1					T2
 spin_lock(&p->lock);		rcu_read_lock();
 invalidate(p);			p = rcu_dereference(ptr);
 rcu_assign_pointer(ptr, NULL);	if (!p) return;
 spin_unlock(&p->lock);		spin_lock(&p->lock)
 				   lock(&lock->lock);
				   rcu_read_lock();
 kfree_rcu(p);			rcu_read_unlock();
				....
				spin_unlock(&p->lock)
				  rcu_read_unlock(); // Ends grace period
 rcu_do_batch()
   kfree(p);
			    UAF ->	  rt_mutex_cmpxchg_release(&lock->lock...)

Regular spinlocks keep preemption disabled accross the unlock operation,
which provides full RCU protection, but the RT substitution fails to
resemble that. Same applies for the rwlock substitution.

Move the rcu_read_unlock() invocation past the unlock operations to match
the non-RT semantics. This makes it asymmetric vs. rt_xxx_lock(), but
that's harmless as the caller needs to hold RCU read lock across the lock
operation. The migrate_enable() call stays before the unlock operation
because there is no per CPU operation in the unlock path which would
require migration to be kept disabled.

Fixes: 0f383b6dc96e ("locking/spinlock: Provide RT variant")
Reported-by: syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com
Decoded-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/87jyrud75z.ffs@fw13

diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index db1e11b45de6..1d5e1b3c60bf 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -79,10 +79,27 @@ void __sched rt_spin_unlock(spinlock_t *lock) __releases(RCU)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	migrate_enable();
-	rcu_read_unlock();
 
 	if (unlikely(!rt_mutex_cmpxchg_release(&lock->lock, current, NULL)))
 		rt_mutex_slowunlock(&lock->lock);
+
+	/*
+	 * This must be last to prevent the following UAF:
+	 *
+	 * T1					T2
+	 * spin_lock(&p->lock);			rcu_read_lock();
+	 * invalidate(p);			p = rcu_dereference(ptr);
+	 * rcu_assign_pointer(ptr, NULL);	if (!p) return;
+	 * spin_unlock(&p->lock);		spin_lock(&p->lock);
+	 * kfree_rcu(p);			rcu_read_unlock();
+	 *					....
+	 *					spin_unlock(&p->lock)
+	 *					  rcu_read_unlock(); // Ends grace period
+	 * rcu_do_batch()
+	 *   kfree(p);
+	 *			    UAF ->	  rt_mutex_cmpxchg_release(&p->lock.lock...)
+	 */
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
@@ -262,17 +279,21 @@ void __sched rt_read_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
 	migrate_enable();
-	rcu_read_unlock();
 	rwbase_read_unlock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+
+	/* This must be last. See comment in rt_spin_unlock() */
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_read_unlock);
 
 void __sched rt_write_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
-	rcu_read_unlock();
 	migrate_enable();
 	rwbase_write_unlock(&rwlock->rwbase);
+
+	/* This must be last. See comment in rt_spin_unlock() */
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_write_unlock);
 

