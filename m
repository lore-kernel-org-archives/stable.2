Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A210F2;
	Sun, 21 Jun 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782035661; cv=none; b=GvP2Kq+NzxuZN9JOvZP1eGWdP0orJh8iytKWslubYonn0OCC/fbO2+stY0NoRG0/uvVz4SEUSh/BtcnvqtTNled+gAyUAaAQ+yTi7X+2oj+MzRSvL9L3YPztkS6Ep+fn/WMZpsxFUe10qo3HTSM8cAJIaxAhgkn64P53+fPncBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782035661; c=relaxed/simple;
	bh=lBtfDoKT4Nzk55qPWnSHwcEbJy8/LJs3g+2iw+E23yo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EgWUcl7cnIpYXyZnT9WdqiJa7lo2emUyHUbS8RYDIcmMOpUMwKKuC1BUWlhe+YhZO/IGjv1eEsfDu5Dygrp2aO9QBVzLnODAYo7KclvLntyKuXk6rXrjKoPMf2EYbY/mufSV6/yaFxEQ/9sCzY10YCqAUNLSPNAFuQlzMoJpDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CpjmSpuH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ifbOgLiY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CpjmSpuH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ifbOgLiY"
Date: Sun, 21 Jun 2026 09:54:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782035657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmL0oJEGp72/s3UmGEs3nIJNIJh133j+EHDCqRAauwQ=;
	b=CpjmSpuHwrq+DGO1+adYFzUGKZunq2brydgvkjjAX72Pou4khnr3XdBzorGwNprmabW0k1
	f3LGXq1fFcXDJQUHr6VZsLxmt8ex5shAg38WSK/pJhITn+lw172CZJelLRukMH4ZvUyIZA
	Bupy8E8e9admBg8Q0zbd3DVv8HXH2wLxKJ8M+tfht9mrVvDfi4Qm7q0n9QKtKDJEHXjE+f
	QnIdIlZ9VGp4/p+Um9ZFe86SGIkWNbC6GanadqBcvNZIxtzxmKOEX6AbKKsUXqBJvOMG1A
	ciBVwri9jYUmP7YTWP6rEembvrj8sHsfcTNzrYxxQHGl26YkMOt8gcFDiOjTSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782035657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmL0oJEGp72/s3UmGEs3nIJNIJh133j+EHDCqRAauwQ=;
	b=ifbOgLiY691ITmkTN/twAl46ZGoyeICTtWex9wdEaOZewPORqfGU8BC6CJG+QHj7qw+WQ9
	hVfwMVECEcM3T7Cw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rt: Fix the incorrect RCU protection in
 rt_spin_unlock()
Cc: syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com,
 Thomas Gleixner <tglx@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87jyrud75z.ffs@fw13>
References: <87jyrud75z.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178203565559.2745857.7687609911978199169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     89038cc87d80c77e7aa6f42a64b2573b74af339f
Gitweb:        https://git.kernel.org/tip/89038cc87d80c77e7aa6f42a64b2573b74a=
f339f
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Fri, 19 Jun 2026 14:52:08 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 21 Jun 2026 11:51:13 +02:00

locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()

rt_spin_unlock() releases the RCU protection before unlocking the
lock. That opens the door for the following UAF scenario:

 T1					T2
 spin_lock(&p->lock);		rcu_read_lock();
 invalidate(p);			p =3D rcu_dereference(ptr);
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
---
 kernel/locking/spinlock_rt.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index db1e11b..1d5e1b3 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -79,10 +79,27 @@ void __sched rt_spin_unlock(spinlock_t *lock) __releases(=
RCU)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	migrate_enable();
-	rcu_read_unlock();
=20
 	if (unlikely(!rt_mutex_cmpxchg_release(&lock->lock, current, NULL)))
 		rt_mutex_slowunlock(&lock->lock);
+
+	/*
+	 * This must be last to prevent the following UAF:
+	 *
+	 * T1					T2
+	 * spin_lock(&p->lock);			rcu_read_lock();
+	 * invalidate(p);			p =3D rcu_dereference(ptr);
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
=20
@@ -262,17 +279,21 @@ void __sched rt_read_unlock(rwlock_t *rwlock) __release=
s(RCU)
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
=20
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
=20
