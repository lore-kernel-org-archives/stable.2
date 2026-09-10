Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC0A4A091E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049184; cv=none; b=VbkAHho/eWOVuPu7CB3f9m0SA6v8erhDP+HQ2NrBVMMam9Lv7IfWzhjdJt5+DC5uMIr0f/57rK7kxIoNX5wbWT+S/6LYRIDwUo3tSUtbZHXb58ZDpEs0hyhn/rI08Q6lwQbYGz8FsCUkL8WlA4novYszhv3U6vx+w/pmJlOd6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049184; c=relaxed/simple;
	bh=1lIT8qI+W4dDH3RWncPxu9QAMG/B9sx91f1OmWdQrhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccRzYFhL+Ct30rEdmPQ+fKlLWeb5yUb2p8w4qi4/wruxKYfLI/GSChALZkkLWT1FXt6akMkU5l/dJYc6gaupiOQSXIGkGMKbyQkW6m0rEH54ZNaQTVijmIYh8NJNsv1Y9eXmreVosq0XWhsxW8MUQkRn6BPWJo3Z9GA36eAP/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbdmIxH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbdmIxH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713041F00898;
	Thu, 10 Sep 2026 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049183;
	bh=EmOw6tY9y9TQ3heCQ2Z3pMxGJB5bJX5MtNz+N3i70J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RbdmIxH6lB3/ZEY1NWRkDbo2hClLoaxuUknjZsBjzOC08s9jvzqf4Ri8YMk81Wv5H
	 v/URT8xD9+rVc0d9ADVTNa0s9v/GDKcOjAwmXT5nNnvpFGiVXbO+9pZ8CXdsLsRh6T
	 QkbklADE9Z2lcxFr0chQd+UWRJ1TOSrXcCyh5XDqutfnjjcTZ0T0WQCb4MrVzt9nsv
	 tb+VSNQaC9RLo2b3dblP/rKxolRe/XLGLIaqep7GZId2hrYnTSJE6pVBoDcfLs1fgz
	 ScW/iJpeT8EPi8+CzzGIJLPNuzFIaOWvSvj4srGCGx1KfqZ0wup77JEkkP4B4qMacW
	 84brR8XvaVlUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Kai <yaokai34@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] futex: Prevent rcuwait use-after-free during requeue PI
Date: Thu, 10 Sep 2026 10:06:17 -0400
Message-ID: <20260910140617.564852-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910140617.564852-1-sashal@kernel.org>
References: <2026090826-jeep-tassel-64cd@gregkh>
 <20260910140617.564852-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Kai <yaokai34@huawei.com>

[ Upstream commit a3b8d46fe401cba3a5c46dea610e6eb3dc15370e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/requeue.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 0378f603fb04f..6dac1abfed902 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -148,8 +148,16 @@ static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
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
-- 
2.53.0

