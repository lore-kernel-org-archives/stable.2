Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC006372EF5
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785210268; cv=none; b=I4DBlR9GAUFUp/5qGcV/L/mVLCfi1dGOPGjkdDmcMX7UZW0nHBXD3SNKCv5vDwxHfxaGPBAPcpdn3V9iKUgCci4tL1A4+cqm0iMGnAG5pTzwDe4v96sLzR2PSE3k+mkuBk1V7rOKY4b41WATXWLyNPlVfJR8qfWTBPPoKQJ/eAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785210268; c=relaxed/simple;
	bh=JL/Dh23FbC/z8QhiYjotMDdUVcdhJSsHqbbn808Jf/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MICzNy4hM1gbEdO6x86GTU71XShiLlzjh3fKIw+lnfMcafwP1ejc8oIWd2ejMsKKFPFZleX9VJVoZ8zyuw6vVAjk/wS9BqRVfW72PW67SqVtW3awpKTDgasUh1w5meXVyK4qCMFtKXSBK/KNdA9YKgM2MvUPObLL64qIm4ff3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+tsUKQb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+tsUKQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9501F000E9;
	Tue, 28 Jul 2026 03:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785210266;
	bh=aJwyYv1+Ef83FMdMJXUInHW6EHNQWFBNd3J5Z86Uv6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D+tsUKQbUBV/MqCXd99ibyNunz/vhMkBid+O3AhB9jMEXmoHNQmygEtrYRp1BOEQz
	 qfJXC5FWbSEtKgwGnnRqjwdVnADM/UmYbJenqUWTK+Qh4rlyh/X/0M9mLFqJSA269n
	 JJXscJ4mW0je6eTbn6as7NroXQL8GkiEFKh1DKE04J/kwHEPnXELI+AlVWo1AepbTy
	 OSVsysLWTFrybaoge4gr/tpnsrdr6IefhXaVgzXr7McDPvCuKtyl4UsucDqbfO1dR8
	 P6Oti42AspQ4ir3P3GN/9AcaCRxAtjujcWRVTF+RJnJY7exiJkvAQ6Zu7qO70rHNRT
	 41Hwy5jBkuewA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com,
	Jann Horn <jannh@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()
Date: Mon, 27 Jul 2026 23:44:23 -0400
Message-ID: <20260728034423.3162660-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072059-deliverer-unstuffed-ac64@gregkh>
References: <2026072059-deliverer-unstuffed-ac64@gregkh>
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
index d2912e44d61fdb..845ddeabbcf4e5 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -66,10 +66,27 @@ void __sched rt_spin_unlock(spinlock_t *lock)
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
 
@@ -232,17 +249,21 @@ void __sched rt_read_unlock(rwlock_t *rwlock)
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

