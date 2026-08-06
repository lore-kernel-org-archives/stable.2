Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945973DD854;
	Thu,  6 Aug 2026 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008843; cv=none; b=WUd66r088o/kATYd8DRbqgaWfrMomFz7yKm/TNSIvyE+stII+kI9tI4vUou4CRPmuUpw9+596GELqBMGlgQTP3FL8EbJoqNV45voXhXcHvcvs6YkYj5f/fRcmIZe9tZ8rJSSe3UExXkD+TbWjsTqwSTKcNdZw2IJoWOOfBDZ6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008843; c=relaxed/simple;
	bh=zFbSo5+cfeZ6fQN28cNK5NlbX7m1nCUPNznS0RjAeK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/M0IX9arBTmpU48SPHBhdYL8jm6wN9KnE/dPOOjP9LCB5PKF2yIV/PXxbWrWSZ2vPtxeny6V8GAsKRzFTMWzbhSWgWP3fbnBrs/APExWVBzzi9dQb9a3QB7Z+wTz/A4XJBnWyicAdxH8Z7vgcymBfn05e4zxJgi74/Xz7Iacp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=A2jDtbF+; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="A2jDtbF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1786008842; x=1817544842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MwvsO7wf1ortKCjyDe8oiLOSqiCPD1EV5AQqurfa1zY=;
  b=A2jDtbF+g6cefwLRsmGJhK8YXyTmhcrGnRv8Q78r88YUhfz2Tq+ulOF9
   Ap/7nFKlwmMEJLuNRWdvRgMqKKo3wI5HzejzyAhnuKE7y3otMbqblkgy7
   8ovRyuTzZzhTvDNjwMNdqQINXs3k9XyhbQ9nsQcCjgMOjgFzH543aOPfW
   BwEOjYOyUwkvTn7jyReLNBSa+dWyDN+tdSEZUtqBm9PULskCEc1XHWzfJ
   Dkf7TfqzOLsazgxtRhdEZktij/H4a/iN36Be8WURo1h1HNtHrlWedp3+U
   2aCeZxBN8eaF/c1KSNXCN50AbGdO/3FVSjwt51iz56ThLM+xq0sYWxYee
   g==;
X-CSE-ConnectionGUID: zyXLMOb0TUWUF3EYg56UxQ==
X-CSE-MsgGUID: atcm2zJdQ8yrmnkT78pOSA==
X-IronPort-AV: E=Sophos;i="6.25,208,1779148800"; 
   d="scan'208";a="25246332"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 09:33:59 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:25423]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.134:2525] with esmtp (Farcaster)
 id 319e3cdf-151c-4654-ac9d-c7a5c1952204; Thu, 6 Aug 2026 09:33:59 +0000 (UTC)
X-Farcaster-Flow-ID: 319e3cdf-151c-4654-ac9d-c7a5c1952204
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 6 Aug 2026 09:33:59 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Thu, 6 Aug 2026
 09:33:56 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?q?Andr=C3=A9=20Almeida?=
	<andrealmeid@igalia.com>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Simon Liebold
	<simonlie@amazon.de>, John Stultz <jstultz@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: Juri Lelli <juri.lelli@redhat.com>, Connor O'Brien <connoro@google.com>,
	Metin Kaya <metin.kaya@arm.com>, Valentin Schneider <vschneid@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH 6.12.y 1/2] locking/mutex: Make mutex::wait_lock irq safe
Date: Thu, 6 Aug 2026 09:32:58 +0000
Message-ID: <20260806093259.2778358-2-simonlie@amazon.de>
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

From: Juri Lelli <juri.lelli@redhat.com>

[ Upstream commit 5ec58525a1f1bd6ca8ea778e9df55cd82bc02e11 ]

With the proxy-execution series, we traverse the task->mutex->task
blocked_on/owner chain in the scheduler core. We do this while holding
the rq::lock to keep the structures in place while taking and
releasing the alternating lock types.

Since the mutex::wait_lock is one of the locks we will take in this
way under the rq::lock in the scheduler core, we need to make sure
that its usage elsewhere is irq safe.

[rebase & fix {un,}lock_wait_lock helpers in ww_mutex.h]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Link: https://lore.kernel.org/r/20241009235352.1614323-3-jstultz@google.com
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 kernel/locking/mutex.c    | 18 ++++++++++--------
 kernel/locking/ww_mutex.h | 21 +++++++++++----------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 6c94da061ec25..cd248d1767eb3 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -578,6 +578,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	DEFINE_WAKE_Q(wake_q);
 	struct mutex_waiter waiter;
 	struct ww_mutex *ww;
+	unsigned long flags;
 	int ret;
 
 	if (!use_ww_ctx)
@@ -620,7 +621,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		return 0;
 	}
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -681,7 +682,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		/* Make sure we do wakeups before calling schedule */
 		wake_up_q(&wake_q);
 		wake_q_init(&wake_q);
@@ -706,9 +707,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
 
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -734,7 +735,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 	return 0;
@@ -744,7 +745,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
 	wake_up_q(&wake_q);
@@ -915,6 +916,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	struct task_struct *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
+	unsigned long flags;
 
 	mutex_release(&lock->dep_map, ip);
 
@@ -941,7 +943,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		}
 	}
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
@@ -959,7 +961,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		__mutex_handoff(lock, next);
 
 	preempt_disable();
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 }
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index a54bd16d0f17d..37f025a096c9d 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -70,14 +70,14 @@ __ww_mutex_has_waiters(struct mutex *lock)
 	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
 }
 
-static inline void lock_wait_lock(struct mutex *lock)
+static inline void lock_wait_lock(struct mutex *lock, unsigned long *flags)
 {
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, *flags);
 }
 
-static inline void unlock_wait_lock(struct mutex *lock)
+static inline void unlock_wait_lock(struct mutex *lock, unsigned long *flags)
 {
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, *flags);
 }
 
 static inline void lockdep_assert_wait_lock_held(struct mutex *lock)
@@ -144,14 +144,14 @@ __ww_mutex_has_waiters(struct rt_mutex *lock)
 	return rt_mutex_has_waiters(&lock->rtmutex);
 }
 
-static inline void lock_wait_lock(struct rt_mutex *lock)
+static inline void lock_wait_lock(struct rt_mutex *lock, unsigned long *flags)
 {
-	raw_spin_lock(&lock->rtmutex.wait_lock);
+	raw_spin_lock_irqsave(&lock->rtmutex.wait_lock, *flags);
 }
 
-static inline void unlock_wait_lock(struct rt_mutex *lock)
+static inline void unlock_wait_lock(struct rt_mutex *lock, unsigned long *flags)
 {
-	raw_spin_unlock(&lock->rtmutex.wait_lock);
+	raw_spin_unlock_irqrestore(&lock->rtmutex.wait_lock, *flags);
 }
 
 static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
@@ -380,6 +380,7 @@ static __always_inline void
 ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
 	DEFINE_WAKE_Q(wake_q);
+	unsigned long flags;
 
 	ww_mutex_lock_acquired(lock, ctx);
 
@@ -408,10 +409,10 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
 	 * die or wound us.
 	 */
-	lock_wait_lock(&lock->base);
+	lock_wait_lock(&lock->base, &flags);
 	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
 	preempt_disable();
-	unlock_wait_lock(&lock->base);
+	unlock_wait_lock(&lock->base, &flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 }
-- 
2.50.1

