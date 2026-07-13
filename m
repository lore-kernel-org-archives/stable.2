Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6C369990
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979861; cv=none; b=MsKWpLLvzL9hdbyJweZqfGoc1BQt83ObIx+QXkmnG93k9zcvFYDwdmmP2n7X5UFBQmc2Z78hk5qVLFgzkEfRWR1EFNOAM/bdej8MfntXXiIvxj+gAkGZe215QS/RH3ThBbLbFXPoc4zZgVjKJjmEQNoYzut8SvfzJygaBYfZDWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979861; c=relaxed/simple;
	bh=vHIGMrHCfIJ09tTBAGjepytCCJwH8sNL3ynlXlivTck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XghY3qyJvtJ2RFhz2pFeYar8HW7qT/9HnWfPDZBh6dtgzZRK73yYsH+V06UvZmbKVkfpAIFlxItqhFTMKvBNm68DT4pVPx+Tyu/S5B/NXm9qJbGLPBHQuVM0c6ElKMw10MMkCGZmmeNvJrJp2nRf3+HcxPChz4UObmJZ9Zc5NfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cstl0BK/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cstl0BK/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c19bad03so33070945e9.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783979858; x=1784584658; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAtaFSLWhee1znLKaJsm7x7QIdSwkUq4LXsxy026Pys=;
        b=cstl0BK/BaIAvEamCI6Xurzu4vVy/juJcgUTEI8BSZYM4nPrNdjxhA3LvE6Cj8LLUj
         curD5KDDphQdGPoeqkX0+bM/wHvkfp6wfHvwGBAx4SCJh0G+gJN+PHpUh59C7ueN5ICR
         1cm4Yz9/EJYDHHpOHy1fypeC+YiIKepfae8RmPG2jN+FdJJdrlwTU001ZalCIaxfHsgL
         n8Oh3X2g/JNDzuHmvlrJfFrVdPshlkFhDvHCjpGPS8tM0noaamO8ZM7ktYj395t/lU9A
         8CEk6YsztnTEM/kbo5ZR0gdk85+GkqcaYaSR0nrPxdDyq5OFXtpOeZUwRj4az/C5c4fo
         Tsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979858; x=1784584658;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OAtaFSLWhee1znLKaJsm7x7QIdSwkUq4LXsxy026Pys=;
        b=deCqbJ1XzohrJHz+WCXr31KUtAGLGoAJkhvh+GZrLYo7wQOkpORg9ua4exni/RnxKG
         SvzJGOnBHHgyI9n7C8fhl1g3oT2mskOcKkAg9zAHOsgAKWpVOm1chQHpg8jeHaZajsS0
         fNQjJ0NLVQKr+6g4a/PVVQ6Qff1sYy3rjsKCtGJuXOg3icBKuoSEsp2YK2v6Zqdx2riP
         svHiOl1J8Gte+rImkMkGZr8/VbDvPJqn6BftoSKIvBljK1UqpL9lDtUIdpU8W/vSiirc
         UiiPLZOwL0VWvGoML5EwoUxu+6SdYqbA4tSoEuwuidpN/eaRC98bA25bF5LDcXV7TLsL
         PxFg==
X-Gm-Message-State: AOJu0YzzBh44OZfLl20GzkZiOede66Z8jZTj2YUJ2m8vivd5nDu4ua7T
	70JtNtuABx6dsN9fygwMujbMXnRSqOfeS/OvUN2Pvh0J/dozFwm1hlJA
X-Gm-Gg: AfdE7clWxTdFG92d9GBig4Fx6PHSOqt44FDJ+hL7qN1t77iY9/xRwrzepLVZHDB/QE4
	Nr5193bgJLUimF5M0YCT/xjN4bwfoXNZo87shFvHa7EFspr6113MXZCgNioemCYqd7dSmx2PpeW
	dt0uUG7QvzWdkYo6sLvhWJ9cFQ7TOhtmziUhNYKpv8sXZWczXKJ/klC3facL/16G8M2CHc1pD1f
	SOZFXBns6LVvdXhVecq6gkzFPkwPLtrnNfFY9y/aHdodS6+I69XVXohrro0qEjZR178U4cSAAOo
	Krb3PWUjpOxDyafutd9ruwNRlWVniP+4kDP77NStMdAGNPn7UzoBClI4RZDN54FcoptRGqKOXUa
	AtX4gpOjhJbKwG7D/pMNoxJJIf1dLZMc5ksTDKiCyHxSwadcnbYdSw5NFzC+qu9C8
X-Received: by 2002:a05:600c:468e:b0:493:de89:61b with SMTP id 5b1f17b1804b1-493f882d74cmr122883555e9.26.1783979857429;
        Mon, 13 Jul 2026 14:57:37 -0700 (PDT)
Received: from eldamar.lan ([213.55.221.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871e830sm25781585e9.2.2026.07.13.14.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:57:31 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 3BC67BE2EE7; Mon, 13 Jul 2026 23:57:27 +0200 (CEST)
Date: Mon, 13 Jul 2026 23:57:27 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Wongi Lee <qw3rtyp0@gmail.com>, Jungwoo Lee <jwlee2217@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: RFC: How to backport 920f893f735e ("posix-cpu-timers: Prevent UAF
 caused by non-leader exec() race") down to 5.15.y?
Message-ID: <alVfR78eqdaRbOIy@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ckgJj4bMTvPj4kyO"
Content-Disposition: inline

--ckgJj4bMTvPj4kyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

920f893f735e ("posix-cpu-timers: Prevent UAF caused by non-leader
exec() race") talks about a UAF, and the commit was CC'ed for stable.
While checking it I noticed the commit though won't apply cleanly. I
was thinking of needing to pick 6fdb2677a594 ("posix-timers: Expand
timer_[re]arm() callbacks with a boolean return value") beforehand as
preparatory change, and then 920f893f735e ("posix-cpu-timers: Prevent
UAF caused by non-leader exec() race"). Would that be sound/sensible?

At least that would apply cleanly (though not yet even compile tested)
to 7.1.y and 6.18.y but then already not anymore to 6.12.y, which will
need more adjustments.

Thomas, would you intend to provide backports from you directly?

The two patches reflect this RFC.

Regards,
Salvatore

--ckgJj4bMTvPj4kyO
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-posix-timers-Expand-timer_-re-arm-callbacks-with-a-b.patch

From 484d452c7a831d9d37dfa7589d203e05a835e369 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@kernel.org>
Date: Wed, 8 Apr 2026 13:53:56 +0200
Subject: [PATCH 1/2] posix-timers: Expand timer_[re]arm() callbacks with a
 boolean return value

commit 6fdb2677a594ab38eade927919bbd4d9688bfa1c upstream.

In order to catch expiry times which are already in the past the
timer_arm() and timer_rearm() callbacks need to be able to report back to
the caller whether the timer has been queued or not.

Change the function signature and let all implementations return true for
now. While at it simplify posix_cpu_timer_rearm().

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: John Stultz <jstultz@google.com>
Link: https://patch.msgid.link/20260408114952.130222296@kernel.org
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 kernel/time/alarmtimer.c       |  6 ++++--
 kernel/time/posix-cpu-timers.c | 18 ++++++++++--------
 kernel/time/posix-timers.c     |  6 ++++--
 kernel/time/posix-timers.h     |  4 ++--
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 6e173d70d825..e10021be190f 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -527,12 +527,13 @@ static void alarm_handle_timer(struct alarm *alarm, ktime_t now)
  * alarm_timer_rearm - Posix timer callback for rearming timer
  * @timr:	Pointer to the posixtimer data struct
  */
-static void alarm_timer_rearm(struct k_itimer *timr)
+static bool alarm_timer_rearm(struct k_itimer *timr)
 {
 	struct alarm *alarm = &timr->it.alarm.alarmtimer;
 
 	timr->it_overrun += alarm_forward_now(alarm, timr->it_interval);
 	alarm_start(alarm, alarm->node.expires);
+	return true;
 }
 
 /**
@@ -588,7 +589,7 @@ static void alarm_timer_wait_running(struct k_itimer *timr)
  * @absolute:	Expiry value is absolute time
  * @sigev_none:	Posix timer does not deliver signals
  */
-static void alarm_timer_arm(struct k_itimer *timr, ktime_t expires,
+static bool alarm_timer_arm(struct k_itimer *timr, ktime_t expires,
 			    bool absolute, bool sigev_none)
 {
 	struct alarm *alarm = &timr->it.alarm.alarmtimer;
@@ -600,6 +601,7 @@ static void alarm_timer_arm(struct k_itimer *timr, ktime_t expires,
 		alarm->node.expires = expires;
 	else
 		alarm_start(&timr->it.alarm.alarmtimer, expires);
+	return true;
 }
 
 /**
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0de2bb7cbec0..395e297093f8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -19,7 +19,7 @@
 
 #include "posix-timers.h"
 
-static void posix_cpu_timer_rearm(struct k_itimer *timer);
+static bool posix_cpu_timer_rearm(struct k_itimer *timer);
 
 void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit)
 {
@@ -1011,24 +1011,27 @@ static void check_process_timers(struct task_struct *tsk,
 /*
  * This is called from the signal code (via posixtimer_rearm)
  * when the last timer signal was delivered and we have to reload the timer.
+ *
+ * Return true unconditionally so the core code assumes the timer to be
+ * armed. Otherwise it would requeue the signal.
  */
-static void posix_cpu_timer_rearm(struct k_itimer *timer)
+static bool posix_cpu_timer_rearm(struct k_itimer *timer)
 {
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	struct task_struct *p;
 	struct sighand_struct *sighand;
+	struct task_struct *p;
 	unsigned long flags;
 	u64 now;
 
-	rcu_read_lock();
+	guard(rcu)();
 	p = cpu_timer_task_rcu(timer);
 	if (!p)
-		goto out;
+		return true;
 
 	/* Protect timer list r/w in arm_timer() */
 	sighand = lock_task_sighand(p, &flags);
 	if (unlikely(sighand == NULL))
-		goto out;
+		return true;
 
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
@@ -1045,8 +1048,7 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	 */
 	arm_timer(timer, p);
 	unlock_task_sighand(p, &flags);
-out:
-	rcu_read_unlock();
+	return true;
 }
 
 /**
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 9331e1614124..da04ed42bf82 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -288,12 +288,13 @@ static inline int timer_overrun_to_int(struct k_itimer *timr)
 	return (int)timr->it_overrun_last;
 }
 
-static void common_hrtimer_rearm(struct k_itimer *timr)
+static bool common_hrtimer_rearm(struct k_itimer *timr)
 {
 	struct hrtimer *timer = &timr->it.real.timer;
 
 	timr->it_overrun += hrtimer_forward_now(timer, timr->it_interval);
 	hrtimer_restart(timer);
+	return true;
 }
 
 static bool __posixtimer_deliver_signal(struct kernel_siginfo *info, struct k_itimer *timr)
@@ -795,7 +796,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 		return timer_overrun_to_int(scoped_timer);
 }
 
-static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
+static bool common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 			       bool absolute, bool sigev_none)
 {
 	struct hrtimer *timer = &timr->it.real.timer;
@@ -822,6 +823,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 
 	if (!sigev_none)
 		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
+	return true;
 }
 
 static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 7f259e845d24..4ea9611dd716 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -27,11 +27,11 @@ struct k_clock {
 	int	(*timer_del)(struct k_itimer *timr);
 	void	(*timer_get)(struct k_itimer *timr,
 			     struct itimerspec64 *cur_setting);
-	void	(*timer_rearm)(struct k_itimer *timr);
+	bool	(*timer_rearm)(struct k_itimer *timr);
 	s64	(*timer_forward)(struct k_itimer *timr, ktime_t now);
 	ktime_t	(*timer_remaining)(struct k_itimer *timr, ktime_t now);
 	int	(*timer_try_to_cancel)(struct k_itimer *timr);
-	void	(*timer_arm)(struct k_itimer *timr, ktime_t expires,
+	bool	(*timer_arm)(struct k_itimer *timr, ktime_t expires,
 			     bool absolute, bool sigev_none);
 	void	(*timer_wait_running)(struct k_itimer *timr);
 };
-- 
2.53.0


--ckgJj4bMTvPj4kyO
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0002-posix-cpu-timers-Prevent-UAF-caused-by-non-leader-ex.patch

From 798a9d582522eb528daf68b629de8707482e563b Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@kernel.org>
Date: Fri, 3 Jul 2026 12:02:38 +0200
Subject: [PATCH 2/2] posix-cpu-timers: Prevent UAF caused by non-leader exec()
 race

commit 920f893f735e92ba3a1cd9256899a186b161928d upstream.

Wongi and Jungwoo decoded and reported a non-leader exec() related race
which can result in an UAF:

 sys_timer_delete()			exec()
   posix_cpu_timer_del()
   // Observes old leader
   p = pid_task(pid, pid_type);		de_thread()
   					  switch_leader();
					  release_task(old_leader)
					    __exit_signal(old_leader)
					      sighand = lock(old_leader, sighand);
					      posix_cpu_timers*_exit();
   sighand = lock_task_sighand(p)	      unhash_task(old_leader);
     sh = lock(p, sighand)	    	      old_leader->sighand = NULL;
					      unlock(sighand);
     (p->sighand == NULL)
	unlock(sh)
	return NULL;

   // Returns without action
   if(!sighand)
      return 0;
   free_posix_timer();

This is "harmless" unless the deleted timer was armed and enqueued in
p->signal because on exec() a TGID targeted timer is inherited.

As sys_timer_delete() freed the underlying posix timer object
run_posix_cpu_timers() or any timerqueue related add/delete operations on
other timers will access the freed object's timerqueue node, which results
in an UAF.

There is a similar problem vs. posix_cpu_timer_set(). For regular posix
timers it just transiently returns -ESRCH to user space, but for the use
case in do_cpu_nanosleep() it's the same UAF just that the k_itimer is
allocated on the stack.

Also posix_cpu_timer_rearm() fails to rearm the timer, which means it stops
to expire.

While debating solutions Frederic pointed out another problem:

   posix_cpu_timer_del(tmr)
					__exit_signal(p)
					  posix_cpu_timers*_exit(p);
					  unhash_task(p);
					  p->sighand = NULL;
     sh = lock_task_sighand(p)
        sighand = p->sighand;
	if (!sighand)
	    return NULL;
	lock(sighand);

     if (!sh)
	WARN_ON_ONCE(timer_queued(tmr));

On weakly ordered architectures it is not guaranteed that
posix_cpu_timer_del() will observe the stores in posix_cpu_timers*_exit()
when p->sighand is observed as NULL, which means the WARN() can be a false
positive.

Solve these issues by:

  1) Changing the store in __exit_signal() to smp_store_release().

  2) Adding a smp_acquire__after_ctrl_dep() into the !sighand path
     of lock_task_sighand().

  3) Creating a helper function for looking up the task and locking sighand
     which does not return when sighand == NULL. Instead it retries the
     task lookup and only if that fails it gives up.

  4) Using that helper in the three affected functions.

observes all preceeding stores, i.e. the stores in posix_cpu_timers*_exit()
and the ones in unhash_task().

gracefully. When the task lookup returns the old leader, but sighand ==
NULL then it retries. In the non-leader exec() case the subsequent task
lookup will observe the new leader due to #1/#2. In normal exit() scenarios
the subsequent lookup fails.

When the task lookup fails, the function also checks whether the timer is
still enqueued and issues a warning if that's the case. Unfortunately there
is nothing which can be done about it, but as the task is already not
longer visible the timer should not be accessed anymore. This check also
requires memory ordering, which is not provided when the first lookup
fails. To achieve that the check is preceeded by a smp_rmb() which pairs
with the smp_wmb() in write_seqlock() in __exit_signal(). That ensures that
the stores in posix_cpu_timers*_exit() are visible.

The history of the non-leader exec() issue goes back to the early days of
posix CPU timers, which stored a pointer to the group leader task in the
timer. That obviously fails when a non-leader exec() switches the leader.
commit e0a70217107e ("posix-cpu-timers: workaround to suppress the problems
with mt exec") added a temporary workaround for that in 2010 which survived
about 10 years. The fix for the workaround changed the task pointer to a
pid pointer, but failed to see the subtle race described above. So the
Fixes tag picks that commit, which seems to be halfways accurate.

Thanks to Frederic Weissbecker, Oleg Nesterov and Peter Zijlstra for
review, feedback and suggestions and to Wongi and Jungwoo for the excellent
bug report and analysis!

Fixes: 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")
Reported-by: Wongi Lee <qw3rtyp0@gmail.com>
Reported-by: Jungwoo Lee <jwlee2217@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 kernel/exit.c                  |   7 +-
 kernel/signal.c                |  10 +-
 kernel/time/posix-cpu-timers.c | 173 ++++++++++++++++++++++-----------
 3 files changed, 130 insertions(+), 60 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f50d73c272d6..7ba7966a23b9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -212,7 +212,12 @@ static void __exit_signal(struct release_task_post *post, struct task_struct *ts
 	__unhash_process(post, tsk, group_dead);
 	write_sequnlock(&sig->stats_lock);
 
-	tsk->sighand = NULL;
+	/*
+	 * Ensure that all preceeding state is visible. Pairs with
+	 * the smp_acquire__after_ctrl_dep() in the sighand == NULL
+	 * path of lock_task_sighand().
+	 */
+	smp_store_release(&tsk->sighand, NULL);
 	spin_unlock(&sighand->siglock);
 
 	__cleanup_sighand(sighand);
diff --git a/kernel/signal.c b/kernel/signal.c
index 9c2b32c4d755..bbc0fd4cc4d7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1362,8 +1362,16 @@ struct sighand_struct *lock_task_sighand(struct task_struct *tsk,
 	rcu_read_lock();
 	for (;;) {
 		sighand = rcu_dereference(tsk->sighand);
-		if (unlikely(sighand == NULL))
+		if (unlikely(sighand == NULL)) {
+			/*
+			 * Pairs with the smp_store_release() in
+			 * __exit_signal().  It ensures that all state
+			 * modifications to the task preceeding the store are
+			 * visible to the callers of lock_task_sighand().
+			 */
+			smp_acquire__after_ctrl_dep();
 			break;
+		}
 
 		/*
 		 * This sighand can be already freed and even reused, but
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 395e297093f8..7e6d19c81652 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -461,6 +461,109 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
 		trigger_base_recalc_expires(timer, p);
 }
 
+/*
+ * Lookup the task via timer->it.cpu.pid and attempt to lock the task's sighand.
+ *
+ * This can race with the reaping of the task:
+ *
+ * CPU0					CPU1
+ *
+ * // Finds task
+ * p = pid_task(pid, pid_type);		__exit_signal(p)
+ *					  lock(p, sighand);
+ *					  posix_cpu_timers*_exit();
+ * sighand = lock_task_sighand(p);	  unhash_task(p);
+ *					  p->sighand = NULL;
+ *					  unlock(sighand);
+ *
+ * In this case sighand is NULL, which means the task and the associated timer
+ * queue cannot be longer accessed safely.
+ *
+ * __exit_signal() invokes posix_cpu_timers_exit() and if the thread group is
+ * dead it also invokes posix_cpu_timers_group_exit(). These functions delete
+ * all pending timers from the related timer queues. The POSIX timers (k_itimer)
+ * themself are still accessible, but not longer connected to the task.
+ *
+ * exec() works slightly differently. The task which exec()'s terminates all
+ * other threads in the thread group and runs __exit_signal() on them. As the
+ * thread group is not dead they only clean up the per task timers via
+ * posix_cpu_timers_exit().
+ *
+ * As the TGID on exec() stays the same per process timers stay queued, if they
+ * are armed. This works without a problem when exec() is done by the thread
+ * group leader. If a non-leader thread exec()'s this can end up in the
+ * following scenario:
+ *
+ * CPU0					CPU1
+ * // Returns old leader
+ * p = pid_task(pid, pid_type);		de_thread()
+ *					switch_leader()
+ *					release_task(old leader)
+ *					  __exit_signal()
+ *					  old_leader->sighand = NULL;
+ * // Returns NULL
+ * sighand = lock_task_sighand(p)
+ *
+ * That's problematic for several functions:
+ *
+ *  - posix_cpu_timer_del(): If the timer is still enqueued on the task the
+ *    underlying k_itimer will be freed which results in a UAF in
+ *    run_posix_cpu_timers() or on timerqueue related add/delete operations.
+ *    If the timer is not enqueued, the failure is harmless
+ *
+ *  - posix_cpu_timer_set(): Independent of the enqueued state that results in a
+ *    transient failure which is user space visible (-ESRCH) for regular posix
+ *    timers. But for the use case in do_cpu_nanosleep() it's the same UAF
+ *    problem just that the timer is allocated on the stack.
+ *
+ *  - posix_cpu_timer_rearm(): Timer is not enqueued at that point, but this
+ *    silently ignores the rearm request, which is a functional problem as the
+ *    timer wont expire anymore.
+ */
+static struct task_struct *timer_lock_sighand(struct k_itimer *timer, unsigned long *flags)
+{
+	enum pid_type type = clock_pid_type(timer->it_clock);
+	struct cpu_timer *ctmr = &timer->it.cpu;
+
+	guard(rcu)();
+
+	for (;;) {
+		struct task_struct *t = pid_task(timer->it.cpu.pid, type);
+
+		/* Fail if the task cannot be found. */
+		if (!t)
+			break;
+
+		/* Try to lock the task's sighand */
+		if (lock_task_sighand(t, flags))
+			return t;
+
+		/*
+		 * The next PID lookup might either fail or return the new
+		 * leader. This is correct for both exit() and exec().
+		 */
+	}
+
+	/*
+	 * If the timer is still enqueued, warn. There is nothing safe to do
+	 * here as there might be two timers in there which are removed in
+	 * parallel and that will cause more damage than good. This should never
+	 * happen!
+	 *
+	 * Ensure that the stores to the timer and timerqueue are visible:
+	 *
+	 * __exit_signal()
+	 *   posix_cpu_timers*_exit()
+	 *   write_seqlock(seqlock)
+	 *	smp_wmb(); <-------
+	 *   __unhash_process()	  |	!pid_task()
+	 *			  ---->	smp_rmb();
+	 *				WARN_ON_ONCE(...)
+	 */
+	smp_rmb();
+	WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
+	return NULL;
+}
 
 /*
  * Clean up a CPU-clock timer that is about to be destroyed.
@@ -470,29 +573,13 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
  */
 static int posix_cpu_timer_del(struct k_itimer *timer)
 {
-	struct cpu_timer *ctmr = &timer->it.cpu;
-	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
 	int ret = 0;
 
-	rcu_read_lock();
-	p = cpu_timer_task_rcu(timer);
-	if (!p)
-		goto out;
+	p = timer_lock_sighand(timer, &flags);
 
-	/*
-	 * Protect against sighand release/switch in exit/exec and process/
-	 * thread timer list entry concurrent read/writes.
-	 */
-	sighand = lock_task_sighand(p, &flags);
-	if (unlikely(sighand == NULL)) {
-		/*
-		 * This raced with the reaping of the task. The exit cleanup
-		 * should have removed this timer from the timer queue.
-		 */
-		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
-	} else {
+	if (likely(p)) {
 		if (timer->it.cpu.firing) {
 			/*
 			 * Prevent signal delivery. The timer cannot be dequeued
@@ -508,11 +595,8 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		unlock_task_sighand(p, &flags);
 	}
 
-out:
-	rcu_read_unlock();
-
 	if (!ret) {
-		put_pid(ctmr->pid);
+		put_pid(timer->it.cpu.pid);
 		timer->it_status = POSIX_TIMER_DISARMED;
 	}
 	return ret;
@@ -626,21 +710,17 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 old_expires, new_expires, now;
-	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
 	int ret = 0;
 
-	rcu_read_lock();
-	p = cpu_timer_task_rcu(timer);
-	if (!p) {
-		/*
-		 * If p has just been reaped, we can no
-		 * longer get any information about it at all.
-		 */
-		rcu_read_unlock();
+	p = timer_lock_sighand(timer, &flags);
+	/*
+	 * If p has just been reaped, we can no longer get any information about
+	 * it at all.
+	 */
+	if (!p)
 		return -ESRCH;
-	}
 
 	/*
 	 * Use the to_ktime conversion because that clamps the maximum
@@ -648,20 +728,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 */
 	new_expires = ktime_to_ns(timespec64_to_ktime(new->it_value));
 
-	/*
-	 * Protect against sighand release/switch in exit/exec and p->cpu_timers
-	 * and p->signal->cpu_timers read/write in arm_timer()
-	 */
-	sighand = lock_task_sighand(p, &flags);
-	/*
-	 * If p has just been reaped, we can no
-	 * longer get any information about it at all.
-	 */
-	if (unlikely(sighand == NULL)) {
-		rcu_read_unlock();
-		return -ESRCH;
-	}
-
 	/* Retrieve the current expiry time before disarming the timer */
 	old_expires = cpu_timer_getexpires(ctmr);
 
@@ -698,7 +764,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	/* Retry if the timer expiry is running concurrently */
 	if (unlikely(ret)) {
 		unlock_task_sighand(p, &flags);
-		goto out;
+		return ret;
 	}
 
 	/* Convert relative expiry time to absolute */
@@ -733,8 +799,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 */
 	if (!sigev_none && new_expires && now >= new_expires)
 		cpu_timer_fire(timer);
-out:
-	rcu_read_unlock();
 	return ret;
 }
 
@@ -1018,19 +1082,12 @@ static void check_process_timers(struct task_struct *tsk,
 static bool posix_cpu_timer_rearm(struct k_itimer *timer)
 {
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
 	u64 now;
 
-	guard(rcu)();
-	p = cpu_timer_task_rcu(timer);
-	if (!p)
-		return true;
-
-	/* Protect timer list r/w in arm_timer() */
-	sighand = lock_task_sighand(p, &flags);
-	if (unlikely(sighand == NULL))
+	p = timer_lock_sighand(timer, &flags);
+	if (unlikely(!p))
 		return true;
 
 	/*
-- 
2.53.0


--ckgJj4bMTvPj4kyO--
