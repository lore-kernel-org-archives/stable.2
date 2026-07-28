Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE725B09D
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207726; cv=none; b=Vd6c7TVDxukSqZatMxeZmXjY+ElinZCKFuI4w/wsv0GKabhGNiR1GWdXWu/fPSHFxJcqZr0SRKn3zsvfV6ISVjU/ulnsljA9xKwXaK21jjQgw/MkRRVAbSBQaXgFijZ0bGfNoffsOb7E6tuw6poeQ83+QmR9uB7VuRW/ix2swaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207726; c=relaxed/simple;
	bh=iUXQFqbMDycMexnJ9NjJ+eVWehn5GmB32Vz/eqswcbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0crfQD5lm2pZkYhuJSKkbSUWsjz4a2QwJvSNr6p9/x6eWrjF0enY70jCDjw5XOZlvYfE9Qfa5FPXp9gXhnsqJeaIRA8bARkV8EA2caywDnTCVBpx5r+d0TuRQFqsfI0Iyg2zLTVusRrYeKh1Qwvp19jMHochhcHKW3n9vxTfTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6KTM80l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6KTM80l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB711F000E9;
	Tue, 28 Jul 2026 03:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785207724;
	bh=o8XIdphOFrygSRNFL1fR0pla2Q8Seqxp4bxtnIGMFuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G6KTM80lPnMpl8+MtlDzhawq6q7HSka+/dYZ0jRcNTaD0kULIyT420+R9qWcaqjgh
	 guUgayVe1OcL/cXiYPjOlBFbQiV2koeSZzU54+fxT4Sv61W6QMOGpnIS0sw/m8r7cr
	 Q20kCe2G3Z5CH3DvZrtAJ6UECIVzIP2+tfT+xR2ctlREg+tac8BYDnya9CAOZk+hDw
	 cZbwwTVdUtUIem/xg9KB+hHdMtF8nmKgwRqhr8Ep9YmXCpDYB68GtnAK3l4BFHHhOg
	 XY2KMOp0XY0SHEBfvyk91APWn0V0SzZS3ADm5pen5OSsPYcJd49tcYEsYKtTNduWjG
	 ovyfQzA0p3imQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com,
	Jann Horn <jannh@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()
Date: Mon, 27 Jul 2026 23:02:02 -0400
Message-ID: <20260728030202.3123520-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072059-baffle-blaspheme-edd9@gregkh>
References: <2026072059-baffle-blaspheme-edd9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@kernel.org>

[ Upstream commit 89038cc87d80c77e7aa6f42a64b2573b74af339f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/spinlock_rt.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 48a19ed8486d8e..2c0fd2c7a3c13f 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -77,10 +77,27 @@ void __sched rt_spin_unlock(spinlock_t *lock)
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
 
@@ -255,17 +272,21 @@ void __sched rt_read_unlock(rwlock_t *rwlock)
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
 
 void __sched rt_write_unlock(rwlock_t *rwlock)
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
 
-- 
2.53.0

