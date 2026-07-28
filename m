Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4C7262A
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209160; cv=none; b=UYvgP+iNGFqw4et5b5HEzPTAgoTnrN9fGBSOYIubTFEx2zq9TbUKxxUUucsNJlROL6c2QJ2Ywsd9greG4nzgQN4tP0JkkqTiHfyB5neVsCVH2w1licNtFC9Ar9CNN0xheT5rfdItP25O611sqJcpELiFue+A6rqVSThWMNQKDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209160; c=relaxed/simple;
	bh=iUXQFqbMDycMexnJ9NjJ+eVWehn5GmB32Vz/eqswcbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMeUeQAeZFVVfmiJJMD4QxotxOrsoxddQjdAYaj9VqoubqatoKSXFSAOOfpL4xG/V8cRLR7JCM1rHR19M2+QBCjYMuiPr6mLtiG0D6jXxxq+JL6/yCNqkwNJ5S1pjfKItKDyFp2CMMnn0ZgJEB0YhFWTxcpYvIS64zMRhHnyHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoTXLnsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoTXLnsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E84B1F000E9;
	Tue, 28 Jul 2026 03:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785209158;
	bh=o8XIdphOFrygSRNFL1fR0pla2Q8Seqxp4bxtnIGMFuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JoTXLnsclSQprFQ/tnVzBIRs8+KVvnPCMA0mNsK2mNZx6sfoTB78hhN69klZ6obQZ
	 ptbB5YBlmKSQ7lQJrHVdYgfFBuMB92SgwrRuSKLGgsixhWmxQ6OKYdWBhyixE2HaLQ
	 3alxdi4OPInMIv9fqR/9tWd2HuWTO16ciynXUH+sBfg4lu+6bDDR6zgUXmOwN1YQlR
	 9RrM82RWpMJBxPNI2+dIDqvHuNJN+XYeVp1IMdnxZrWl8i8yaypath6OCx4YQ72tql
	 VkmO245KsIr2RyMgah3F7XljCrpK8XwWWGg5VHgkpElk3Q1RtzE24m80ntNLurBlqX
	 7QWS4g66mtAyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com,
	Jann Horn <jannh@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()
Date: Mon, 27 Jul 2026 23:25:55 -0400
Message-ID: <20260728032555.3151279-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072059-washing-grew-2574@gregkh>
References: <2026072059-washing-grew-2574@gregkh>
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

