Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AA3F39E5;
	Thu,  6 Aug 2026 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008851; cv=none; b=lTg3QU8EobgMVuZOD5tP5nGTuMia3k1cXKmeF8PlPVXZycaLgPMgb5D9oSBVDInq2loHHLqrfoToyS6P4QelLU2RrkB16hm91PC/TyrD2FLIZwdHqkIOvnR9ECicZJbVRWy+4FTBLd6p08I+j+ig9E84ydpsCHqnuj3QMcHetG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008851; c=relaxed/simple;
	bh=ZDBwYTjlyxmY7RpXCHrVUb73xjconMigWKqjr2ml9OY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spsCTzKkG7sXdttUItvm6xk//w1vfdyM3tUuxIm+DRsN/YWoIEfVFNWfkLyopMox0jvcEN33AnVnBus4qn/OrpKgYPTOErL3kaXRYf2Okkap3zLQRY4YkoksEHUlJOCIpyKeRfQ76tFCkkRKux4pX7WQ2bUf8zmgMTGI763Oajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=qvjD1pgk; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="qvjD1pgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1786008849; x=1817544849;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RLwxQRqqoDZQEQzWK3xwTQMWElFQrfBnO6M7fiGzS/w=;
  b=qvjD1pgk5FsdNNlv7lMB96NtDbNf1Et8ysuuofDHXAB3Mz0HVfHzNrvK
   CRo5PBcKSYAsyjI4lP75/TQ8IHqi+MeuCUohy21wtvWbiBa2uDx2ZH3A8
   yw5BBzdJDTD97mzefwfzH2P7vxW32y6ju8+IxSo2cIGs5MN9JZ53ulJmi
   VkYYzI4UudGOyIcKoC6fQ7vkCMVlPNfWsWZUNfxtQtDXfM5s3okJA9NNp
   MpK1kHDwAHnGBcu2CjnXK4Sq/i2F/TPCZTPmnQLPRTBdwn59xr4Qcn5Rp
   RyXbLRvp+ko3wPfk/a53QrpOtsFiFV9xITKx+94LytLedko3RHcrer13m
   A==;
X-CSE-ConnectionGUID: OjgBAD7PTuSJPGdFRs5J7Q==
X-CSE-MsgGUID: M5QIGrhPR6KGmKnllr1/8w==
X-IronPort-AV: E=Sophos;i="6.25,208,1779148800"; 
   d="scan'208";a="25025866"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 09:34:06 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:23946]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.129:2525] with esmtp (Farcaster)
 id 829aeb35-e6ba-4b0b-9c17-20f6dac570df; Thu, 6 Aug 2026 09:34:05 +0000 (UTC)
X-Farcaster-Flow-ID: 829aeb35-e6ba-4b0b-9c17-20f6dac570df
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 6 Aug 2026 09:34:05 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Thu, 6 Aug 2026
 09:34:03 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?q?Andr=C3=A9=20Almeida?=
	<andrealmeid@igalia.com>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Simon Liebold
	<simonlie@amazon.de>, John Stultz <jstultz@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.12.y 2/2] sched/wake_q: Add helper to call wake_up_q after unlock with preemption disabled
Date: Thu, 6 Aug 2026 09:32:59 +0000
Message-ID: <20260806093259.2778358-3-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260806093259.2778358-1-simonlie@amazon.de>
References: <20260806093259.2778358-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: John Stultz <jstultz@google.com>

[ Upstream commit abfdccd6af2b071951633e57d6322c46a1ea791f ]

A common pattern seen when wake_qs are used to defer a wakeup
until after a lock is released is something like:
  preempt_disable();
  raw_spin_unlock(lock);
  wake_up_q(wake_q);
  preempt_enable();

So create some raw_spin_unlock*_wake() helper functions to clean
this up.

Applies on top of the fix I submitted here:
 https://lore.kernel.org/lkml/20241212222138.2400498-1-jstultz@google.com/

NOTE: I recognise the unlock()/unlock_irq()/unlock_irqrestore()
variants creates its own duplication, which we could use a macro
to generate the similar functions, but I often dislike how those
generation macros making finding the actual implementation
harder, so I left the three functions as is. If folks would
prefer otherwise, let me know and I'll switch it.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241217040803.243420-1-jstultz@google.com
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 include/linux/sched/wake_q.h | 34 ++++++++++++++++++++++++++++++++++
 kernel/futex/pi.c            |  5 +----
 kernel/locking/mutex.c       | 16 ++++------------
 kernel/locking/rtmutex.c     | 32 +++++---------------------------
 4 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 06cd8fb2f4098..0f28b4623ad45 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -63,4 +63,38 @@ extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
 extern void wake_up_q(struct wake_q_head *head);
 
+/* Spin unlock helpers to unlock and call wake_up_q with preempt disabled */
+static inline
+void raw_spin_unlock_wake(raw_spinlock_t *lock, struct wake_q_head *wake_q)
+{
+	guard(preempt)();
+	raw_spin_unlock(lock);
+	if (wake_q) {
+		wake_up_q(wake_q);
+		wake_q_init(wake_q);
+	}
+}
+
+static inline
+void raw_spin_unlock_irq_wake(raw_spinlock_t *lock, struct wake_q_head *wake_q)
+{
+	guard(preempt)();
+	raw_spin_unlock_irq(lock);
+	if (wake_q) {
+		wake_up_q(wake_q);
+		wake_q_init(wake_q);
+	}
+}
+
+static inline
+void raw_spin_unlock_irqrestore_wake(raw_spinlock_t *lock, unsigned long flags,
+				     struct wake_q_head *wake_q)
+{
+	guard(preempt)();
+	raw_spin_unlock_irqrestore(lock, flags);
+	if (wake_q) {
+		wake_up_q(wake_q);
+		wake_q_init(wake_q);
+	}
+}
 #endif /* _LINUX_SCHED_WAKE_Q_H */
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index ccd5d19dea68a..3888d4c26962b 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1021,10 +1021,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	 * it sees the futex_q::pi_state.
 	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current, &wake_q);
-	preempt_disable();
-	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irq_wake(&q.pi_state->pi_mutex.wait_lock, &wake_q);
 
 	if (ret) {
 		if (ret == 1)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cd248d1767eb3..c042e97e617ff 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -682,10 +682,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
-		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-		/* Make sure we do wakeups before calling schedule */
-		wake_up_q(&wake_q);
-		wake_q_init(&wake_q);
+		raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 
 		schedule_preempt_disabled();
 
@@ -735,8 +732,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	preempt_enable();
 	return 0;
 
@@ -745,10 +741,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
-	wake_up_q(&wake_q);
 	preempt_enable();
 	return ret;
 }
@@ -960,10 +955,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
-	preempt_disable();
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 }
 
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 9e99b9548e0a6..5de6f8ba5e4ac 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1292,13 +1292,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	 */
 	get_task_struct(owner);
 
-	preempt_disable();
-	raw_spin_unlock_irq(&lock->wait_lock);
-	/* wake up any tasks on the wake_q before calling rt_mutex_adjust_prio_chain */
-	wake_up_q(wake_q);
-	wake_q_init(wake_q);
-	preempt_enable();
-
+	raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
 	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
@@ -1647,13 +1641,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 			owner = rt_mutex_owner(lock);
 		else
 			owner = NULL;
-		preempt_disable();
-		raw_spin_unlock_irq(&lock->wait_lock);
-		if (wake_q) {
-			wake_up_q(wake_q);
-			wake_q_init(wake_q);
-		}
-		preempt_enable();
+		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
 			rt_mutex_schedule();
@@ -1804,10 +1792,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 	 */
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
-	preempt_disable();
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	rt_mutex_post_schedule();
 
 	return ret;
@@ -1864,11 +1849,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 			owner = rt_mutex_owner(lock);
 		else
 			owner = NULL;
-		preempt_disable();
-		raw_spin_unlock_irq(&lock->wait_lock);
-		wake_up_q(wake_q);
-		wake_q_init(wake_q);
-		preempt_enable();
+		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
 		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
 			schedule_rtlock();
@@ -1897,10 +1878,7 @@ static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	rtlock_slowlock_locked(lock, &wake_q);
-	preempt_disable();
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 }
 
 #endif /* RT_MUTEX_BUILD_SPINLOCKS */
-- 
2.50.1

