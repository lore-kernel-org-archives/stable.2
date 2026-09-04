Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E0419FC5;
	Fri,  4 Sep 2026 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502553; cv=none; b=MEq25YGi3FLRLB8+MQVl5+oYDRDCiNiCmnW5TeBAK/3lgaR6rR70V0VuEiKLn1l2MiV7wxFRk96zjV6gEzKwkNzJDyaJyFC4I5EWa4B+fv1R4kgisvjCyU6HOUFLGAQ40sp8brw7TH8AQPoY2pfDx7r0hGA5y7oPdeTrLWe5p70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502553; c=relaxed/simple;
	bh=SSF/ODoH1hWI8LNvU2KFZrn/Rr+pMa9UmLANysbUfak=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d+wxkDVs+mqp2GPjiUxXxDKVgNpmSv97g3h163fhQMXCcKJY/QavWB2orxpwyP95tDQC5gskuzMhjRQf7kppEb/SbTRhXgaKJJ/TYWXnEslQT6JtdIAhN2SlmqPLSaRRk7amtLYCGurAs4qgR6PwixU4c6FKNJ8FLdicbY5blv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N9YNLiv3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6p3jbfWL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N9YNLiv3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6p3jbfWL"
Date: Fri, 04 Sep 2026 06:15:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788502549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUdKDc/Wg5EHKgG4giHJA+LHGo60MVh8xOPek4fiFO8=;
	b=N9YNLiv3VNVTJfSLXrLdVAeRHwNeD2dUArJyZKLAi21p1IjkDz784vw8l/XVtRkbL+caqY
	6A/HDcY3Zk0uHRlwzdXMXrQqtvxQNJPOQkFdh8tn+sK2g+owi6my6IkPGiuPHYdHQbgVtf
	n70WVa+2ejxtaoJ0DmJJ8DWnt+fmJcV8U7sLRVBVhFuZUzSgxEeQBhW+uCQCFqlwGbfu41
	0EWKhZ0oxaGLfiZ7NaRRfzB/bQJeMsgm7bzcmPILrh4Jmnn+WCsWTWJZGvwaeFBRH3wzG/
	/GLUuZHEIwdpd8tyRSGV6ushUb667XIGuN0EFBPMyAoUo6gTKRgm/VzUmYOu8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788502549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUdKDc/Wg5EHKgG4giHJA+LHGo60MVh8xOPek4fiFO8=;
	b=6p3jbfWLs3uS3pKudFH/jAWxTuEaQyJJ+QIHVipXgL2b1TfjqZRIKC78w2RRygliXRIcYb
	D6dRQDO8engkRPAQ==
From: "tip-bot2 for Yao Kai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] futex: Prevent rcuwait use-after-free during requeue PI
Cc: Yao Kai <yaokai34@huawei.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260901135453.3121948-3-bigeasy@linutronix.de>
References: <20260901135453.3121948-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178850254720.3717435.17296001352461108074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     a3b8d46fe401cba3a5c46dea610e6eb3dc15370e
Gitweb:        https://git.kernel.org/tip/a3b8d46fe401cba3a5c46dea610e6eb3dc1=
5370e
Author:        Yao Kai <yaokai34@huawei.com>
AuthorDate:    Tue, 01 Sep 2026 15:54:52 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 04 Sep 2026 08:14:15 +02:00

futex: Prevent rcuwait use-after-free during requeue PI

On PREEMPT_RT, FUTEX_CMP_REQUEUE_PI can trigger a KASAN report
(slab-out-of-bounds) in futex_requeue_pi_complete() invocation of
rcuwait_wake_up().

The futex_q used by futex_wait_requeue_pi() is allocated on the waiter's
stack. An early wakeup can race with a PI requeue as follows:

        waiter                          requeue task
        ------                          ------------
futex_wait_requeue_pi()
  futex_do_wait()
    schedule()
                                       futex_requeue
                                         futex_proxy_trylock_atomic()
                                           futex_requeue_pi_prepare()
                                            Q_REQUEUE_PI_NONE -> Q_REQUEUE_PI=
_IN_PROGRESS
* timeout/ signal wakes waiter *
  futex_requeue_pi_wakeup_sync()
   Q_REQUEUE_PI_IN_PROGRESS -> Q_REQUEUE_PI_WAIT
                                           requeue_pi_wake_futex
                                             futex_requeue_pi_complete()
                                               cmpxchg Q_REQUEUE_PI_WAIT -> Q=
_REQUEUE_PI_LOCKED
    rcuwait_wait_event()
      if (atomic_read(&q->requeue_state) !=3D Q_REQUEUE_PI_WAIT)
       break /* no schedule() */

 /* q.pi_state->owner =3D=3D current */
 futex_private_hash_put()
 /* return from syscall */
                                              rcuwait_wake_up(&q->requeue_wai=
t)
                                                /* q is gone */

futex_requeue_pi_complete() publishes Q_REQUEUE_PI_LOCKED before
calling rcuwait_wake_up(). The waiter observes this state in
rcuwait_wait_event() before invoking schedule() in rcuwait_wait_event().
Here, the waiter is free leave the syscall before requeue task can
complete the wake.

To address this race skip rcuwait_wake_up() in the Q_REQUEUE_PI_LOCKED
case.
This state is only published by requeue_pi_wake_futex(), which saves
q->task before futex_requeue_pi_complete() and wakes the waiter via
wake_up_state().

This wake is intended to wake the waiter from its futex_do_wait() sleep.
If the waiter is still sleeping there, it can not get into the
Q_REQUEUE_PI_WAIT state (and require this removed wake).
Should the waiter be woken up from futex_do_wait() by other means (as in
this example) and sleep in futex_requeue_pi_wakeup_sync() then the
wake_up_state() from requeue_pi_wake_futex() will wake it, too.
Should the waiter task terminate before wake_up_state() had a chance to
wake the task then the task pointer does not become invalid because the
futex_hash_bucket::lock is held and the task pointer is RCU protected.

[bigeasy: Updated comment and commit message]

Fixes: 07d91ef510fb1 ("futex: Prevent requeue_pi() lock nesting issue on RT")
Signed-off-by: Yao Kai <yaokai34@huawei.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901135453.3121948-3-bigeasy@linutronix.de
---
 kernel/futex/requeue.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 79823ad..b3f4a4b 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -154,8 +154,16 @@ static inline void futex_requeue_pi_complete(struct fute=
x_q *q, int locked)
 	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
=20
 #ifdef CONFIG_PREEMPT_RT
-	/* If the waiter interleaved with the requeue let it know */
-	if (unlikely(old =3D=3D Q_REQUEUE_PI_WAIT))
+	/*
+	 * The waiter in futex_requeue_pi_wakeup_sync() can interleave with the
+	 * wake below: It will assign Q_REQUEUE_PI_IN_PROGRESS and here it will
+	 * be updated to Q_REQUEUE_PI_LOCKED (locked =3D 1). The rcuwait_wait_event=
()
+	 * will already read Q_REQUEUE_PI_LOCKED and skip the schedule() invocation,
+	 * leading to an access of futex_q::requeue_wait after the waiter returned.
+	 * In this case only we skip the wake here and rely on following wake in
+	 * requeue_pi_wake_futex() to perform the wake if needed.
+	 */
+	if (unlikely(old =3D=3D Q_REQUEUE_PI_WAIT) && new !=3D Q_REQUEUE_PI_LOCKED)
 		rcuwait_wake_up(&q->requeue_wait);
 #endif
 }
