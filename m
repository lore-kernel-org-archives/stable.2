Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A9560AB8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874191; cv=none; b=T7fSNfqxyv6nKlFUpvSPl50p3WFu4h6YMXERGHRZvV/kipG3XX2nsAAryJOsLVEercS9PxPDQRXi9M2lauIk6NBFrVFOABJ1C69+Xbp9ec/MaH84rrkBcPqE4SOeJgXp4GR2c+zftMZfXE0Y25QWZyzQvfUGEa8WAe/zc7jogsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874191; c=relaxed/simple;
	bh=QuwGrxrZQjIxm0I+5r7AKR224LwMuq3ERtpeX88Di3A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kuFsqtLHpkvSF8gjf2Z9t52ce+DggxWuKc6Nje7ql8kGT7x+etUSAIP87blYS1cf6alWZScaeHvgUbWL2G04R33jdQsEjvlM9gZztouna5QvwiwdzAiRmqxfLHDcdiIAxWlcSJ+gVA8iwaddFXROIqi/zBuCTHM+gJVN54w9XQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qUN1+SwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qUN1+SwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CBD1F00A3D;
	Tue,  8 Sep 2026 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788874178;
	bh=7Dj6seXRE+dbAaUzgbcXb7kP3lVDdBsMtI9SotfSUI8=;
	h=Subject:To:Cc:From:Date;
	b=qUN1+SwTkKwwRR4O0dTJzMt5EaD3YbW/pE9RoVnaLNsA2X5pZYSbYXX3I5kS4PCNy
	 5qWlq1qJmBnXNGMkWD1v1NNN4z/mDidhZ/Srg4pwPPNps41MFT3KEM7TBjP/KnBAHk
	 ApBJWixQcN4VXDetEZuTym4xYZNX6Qe8kEXdEOas=
Subject: FAILED: patch "[PATCH] futex: Prevent rcuwait use-after-free during requeue PI" failed to apply to 5.15-stable tree
To: yaokai34@huawei.com,bigeasy@linutronix.de,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:18:26 +0200
Message-ID: <2026090826-jeep-tassel-64cd@gregkh>
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
git cherry-pick -x a3b8d46fe401cba3a5c46dea610e6eb3dc15370e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090826-jeep-tassel-64cd@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a3b8d46fe401cba3a5c46dea610e6eb3dc15370e Mon Sep 17 00:00:00 2001
From: Yao Kai <yaokai34@huawei.com>
Date: Tue, 1 Sep 2026 15:54:52 +0200
Subject: [PATCH] futex: Prevent rcuwait use-after-free during requeue PI

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
                                            Q_REQUEUE_PI_NONE -> Q_REQUEUE_PI_IN_PROGRESS
* timeout/ signal wakes waiter *
  futex_requeue_pi_wakeup_sync()
   Q_REQUEUE_PI_IN_PROGRESS -> Q_REQUEUE_PI_WAIT
                                           requeue_pi_wake_futex
                                             futex_requeue_pi_complete()
                                               cmpxchg Q_REQUEUE_PI_WAIT -> Q_REQUEUE_PI_LOCKED
    rcuwait_wait_event()
      if (atomic_read(&q->requeue_state) != Q_REQUEUE_PI_WAIT)
       break /* no schedule() */

 /* q.pi_state->owner == current */
 futex_private_hash_put()
 /* return from syscall */
                                              rcuwait_wake_up(&q->requeue_wait)
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

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 79823ad13683..b3f4a4bccb12 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -154,8 +154,16 @@ static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
 	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
 
 #ifdef CONFIG_PREEMPT_RT
-	/* If the waiter interleaved with the requeue let it know */
-	if (unlikely(old == Q_REQUEUE_PI_WAIT))
+	/*
+	 * The waiter in futex_requeue_pi_wakeup_sync() can interleave with the
+	 * wake below: It will assign Q_REQUEUE_PI_IN_PROGRESS and here it will
+	 * be updated to Q_REQUEUE_PI_LOCKED (locked = 1). The rcuwait_wait_event()
+	 * will already read Q_REQUEUE_PI_LOCKED and skip the schedule() invocation,
+	 * leading to an access of futex_q::requeue_wait after the waiter returned.
+	 * In this case only we skip the wake here and rely on following wake in
+	 * requeue_pi_wake_futex() to perform the wake if needed.
+	 */
+	if (unlikely(old == Q_REQUEUE_PI_WAIT) && new != Q_REQUEUE_PI_LOCKED)
 		rcuwait_wake_up(&q->requeue_wait);
 #endif
 }

