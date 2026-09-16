Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFC4B0E32;
	Wed, 16 Sep 2026 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577316; cv=none; b=bVWMIzzaY16nCYmJA/YaPEwOPbzyLOUfJhURUzyMceEFCS7B8LIIhtoPnfmn4Y7Tx37nN0kQsCOYD23HM2epcUJPcjsewF3OAxoazxeMUfeCq/oOrzh4Cw4d1Vm/vsHtpNgrjp6Z8mq6EUF1qYRj40cdiUhyiMHFQq9VhOEyBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577316; c=relaxed/simple;
	bh=D6XNuArynAAqq+r8UmwLP63vpOPqiyhjQ5oFLk/GCNg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I3kcy49E8udF6IPakSrQoo79dDPCA74fdSU4YBTNRlbKPpbrbjHG58alOCtRXnAM+0t3lCZvhCVgFnpqQdgHgsO+wzRts//wP00/sCWC9a93D9DQqlDhU/jfkQTc4KjXPvJP1ys3VmeuHZmdMMqw7lGeY7GbnkmGAdQ5lLGjcCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+9+HpF5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y6iBHWi+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+9+HpF5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y6iBHWi+"
Date: Wed, 16 Sep 2026 16:48:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789577294;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWlxcUI3j+V+gq2qKLl/djp00G/F+7fBVR6GK5j07o8=;
	b=U+9+HpF5iw5Qm6L5z2rvWIxmVZ9BYpmZ7V5gQeQDFZsT6QDNV9LwCjI+tUrSzYSMkOrBgq
	wozoXMMQTHTcCZ5RIe35Vu5otfkD9QBNKcG9trXMPx6RXeSqUm4jp7EF8qAFTSaRZMajOB
	5tRPPsubrddLzM/etOJXnwSZIjilRtqB/Ccd0NnU7+XFb4DNFUB/8k62tjEHRaWgu4gTB2
	vQgjmnud0q5w0NYG0W1bzNJaBFKZhIuEMWC5sZrY+bYyADyVvAdFlQJfBs1G7XHjhZFmrg
	Ym1ixBOCQSW5o/CHhqBkzeTCKTo/A34KNgyY17XrLsNJAaqZASxxnoqgzJyrwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789577294;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWlxcUI3j+V+gq2qKLl/djp00G/F+7fBVR6GK5j07o8=;
	b=y6iBHWi+a6LQF2kJ4gg4ePBuYH1Ze0nxeXabafDDXX2aUjS2pFZ0PJQVGX7wWR4gSwOUD5
	kZErglz9A7eRHvDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Prevent exec() race
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@kernel.org>, Kijo Park <red993688@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Frederic Weisbecker <frederic@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260911090541.572536604@kernel.org>
References: <20260911090541.572536604@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178957729287.1720534.9013303736117008292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d2710c8d938ae6a825a6463158e6e6f31eac792a
Gitweb:        https://git.kernel.org/tip/d2710c8d938ae6a825a6463158e6e6f31ea=
c792a
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Fri, 11 Sep 2026 11:09:12 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 16 Sep 2026 18:44:03 +02:00

signal: Prevent exec() race

Hyunwoo debugged the following KASAN UAF splat:

  BUG: KASAN: slab-use-after-free in __send_signal_locked+0xb27/0xba0
  Write of size 8 at addr ffff888007ed80c8 by task poc/79
  ...
  Call Trace:
   __send_signal_locked+0xb27/0xba0
   do_send_sig_info+0xa7/0x160
   do_send_specific+0x76/0xa0
   __x64_sys_tgkill+0x193/0x270
  ...
  Allocated by task 80:
   do_timer_create+0x1a4/0x1030
   __x64_sys_timer_create+0x145/0x190
  ...
  Freed by task 12:
   kmem_cache_free_bulk+0x1f8/0x4a0
   kvfree_rcu_bulk+0x14f/0x1c0
   kfree_rcu_work+0x128/0x1a0
  ...
  Last potentially related work creation:
   kvfree_call_rcu+0x39/0x390
   __flush_itimer_signals+0x211/0x320
   flush_itimer_signals+0x47/0x90
   begin_new_exec+0xa6b/0x28c0

It turned out that this happens with a non-leader exec() as Hyunwoo
explained:

de_thread() calls exchange_tids() before release_task(leader), so the
struct pid held by a SIGEV_THREAD_ID timer created against the leader's tid
now points to the thread which called execve(). pid_task() returns that
thread and lock_task_sighand() on it succeeds.

If the timer signal is blocked, its sigqueue stays queued on the leader's
task::pending. The next expiry of that timer can then run while
release_task() flushes the queue.

posixtimer_send_sigqueue() checks whether the sigqueue is already queued
with a plain list_empty(), which only reads list_head::next.
list_del_init() is not atomic and INIT_LIST_HEAD() stores list_head::next
before list_head::prev, so the check can pass in between. list_add_tail()
queues the entry on the task::pending of the live thread, and the
list_head::prev store from the flush then overwrites the list_head::prev
link that list_add_tail() has just set.

__flush_itimer_signals() does not undo that either. With list_head::prev
pointing at the entry itself, its list_del_init() only stores the same
values again, so the entry is not removed from the list. It is still there
after the last reference is dropped and the timer is freed by RCU, and the
list_add_tail() of a later tgkill() follows that list_head::prev into the
freed timer.

This problem surfaced with the recent commit which moved the sigqueue flush
out of the sighand lock held region.

Hyonwoo proposed to fix this by using list_del_init_careful(), but that
just papers over the problem. After some disucssions and various attempts
to solve it, Eric pointed out that there is no reason to flush
task::pending late in release_task() and it should be done in
exit_signals() already.

As nothing can collect and deliver signals which are queued in a dying
task's pending queue, there is no reason to delay it further.

But it has to be ensured that no signals can be queued into it after that
point. exit_signals() sets PF_EXITING in task::flags, which can be used as
an indicator for this.

Cure it by:

  - Preventing signal queueing for task private signals (PIDTYPE_PID) when
    the task has PF_EXITING set in __send_signal_locked() and in
    posixtimer_send_sigqueue().

  - Protecting the unlocked setting of PF_EXITING in exit_signals() for the
    task group empty and the group exit case with sighand lock

  - Flushing task::pending signals right there.

    Optimize that by moving the whole pending list to an on-stack list head
    under sighand lock and free the signals without the lock held.

There has been quite some discussion about the lockless flush and the
non-leader exec case on weakly ordered systems. The problem is that a third
party which tries to send a posix timer signal relies on the PID lookup to
find the target task and that lookup might result in the new leader when
the signal was originaly directed to the old leader. In case that the
signal was queued on the old leader then the lockless flush raised a
concern over the following situation:

   old_leader		new_leader              third party

A: flush_list()	// list_del_init() stores to sigqueue

   LOCK (tasklist)
   old_leader->exit_state =3D EXIT_ZOMBIE;
B: UNLOCK (tasklist)

C:			LOCK (tasklist)
			if (old_leader->exit_state)
			   transfer_tids()
D:			     store PID
						posix_timer_send_sigqueue()
						// Observes #D so t =3D new_leader
E:						t =3D get_target()

F:						LOCK (sighand)

G:						   if (list_empty(sigqueue))
							list_add(sigqueue)

The concern was that the third party might observe #D but not observe #A
and therefore would proceed to #G while the list_del() stores (#A) in
flush_list() are not visible yet, which could result in list corruption.

That would be possible if looking at it solely from a RELEASE+ACQUIRE
ordering point of view, but B-C is a UNLOCK+LOCK hand-over, which is not
the same as RELEASE+ACQUIRE:

  RELEASE+ACQUIRE: RCpc,  only the CPUs involved agree on the ordering
  UNLOCK+LOCK:     RCtso, the hand-over is store-ordering

As B-C is UNLOCK+LOCK, which is RCtso and that does impose store order,
A stores must happen before the D store.

Combine with E-F, which has a data dependency from the LOAD to the LOCK and
thereby constraints later LOADs, those sigqueue loads in G that come after
F must in fact observe the A stores.

Fixes: fb3bbcfe344e ("exit: change the release_task() paths to call flush_sig=
queue() lockless")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Debugged-by: Hyunwoo Kim <imv4bel@gmail.com>
Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Kijo Park <red993688@gmail.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260911090541.572536604@kernel.org
Closes: https://patch.msgid.link/aok1rdkBgZsynHZB@v4bel
---
 kernel/exit.c   |  11 ++--
 kernel/signal.c | 115 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 91 insertions(+), 35 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 4e028f1..424c44a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -302,12 +302,13 @@ repeat:
 	free_pids(post.pids);
 	release_thread(p);
 	/*
-	 * This task was already removed from the process/thread/pid lists
-	 * and lock_task_sighand(p) can't succeed. Nobody else can touch
-	 * ->pending or, if group dead, signal->shared_pending. We can call
-	 * flush_sigqueue() lockless.
+	 * This task was already removed from the process/thread/pid lists and
+	 * lock_task_sighand(p) can't succeed. If it's the group leader then
+	 * flush tsk->signal->shared_pending. tsk->pending has been flushed
+	 * already in exit_signals(). Nothing else can touch
+	 * signal->shared_pending anymore, so flush_sigqueue() can be invoked
+	 * lockless.
 	 */
-	flush_sigqueue(&p->pending);
 	if (thread_group_leader(p))
 		flush_sigqueue(&p->signal->shared_pending);
=20
diff --git a/kernel/signal.c b/kernel/signal.c
index ec30550..d31ebcb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -457,18 +457,42 @@ static void __sigqueue_free(struct sigqueue *q)
 	kmem_cache_free(sigqueue_cachep, q);
 }
=20
-void flush_sigqueue(struct sigpending *queue)
+/*
+ * flush_sigqueue_list() can only be invoked without holding sighand::sigloc=
k in
+ * the following cases:
+ *
+ *  1) When flushing task::pending _after_ setting task::flags PF_EXITING
+ *
+ *     All functions which try to send a signal to @task will observe PF_EXI=
TING
+ *     and drop the signal.
+ *
+ *  2) When flushing task::signal::shared_pending _after_ the last task in a
+ *     thread group was unhashed and task::sighand is NULL.
+ *
+ *     Nothing can queue a signal anymore because sighand is NULL.
+ */
+static void flush_sigqueue_list(struct list_head *head)
 {
-	struct sigqueue *q;
+	struct sigqueue *q, *tmp;
=20
-	sigemptyset(&queue->signal);
-	while (!list_empty(&queue->list)) {
-		q =3D list_entry(queue->list.next, struct sigqueue , list);
+	list_for_each_entry_safe(q, tmp, head, list) {
 		list_del_init(&q->list);
 		__sigqueue_free(q);
 	}
 }
=20
+void flush_sigqueue(struct sigpending *queue)
+{
+	sigemptyset(&queue->signal);
+	flush_sigqueue_list(&queue->list);
+}
+
+static void sigqueue_dequeue_pending(struct sigpending *queue, struct list_h=
ead *head)
+{
+	sigemptyset(&queue->signal);
+	list_splice_init(&queue->list, head);
+}
+
 /*
  * Flush all pending signals for this kthread.
  */
@@ -1019,6 +1043,21 @@ static inline bool legacy_queue(struct sigpending *sig=
nals, int sig)
 	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
 }
=20
+/*
+ * When PF_EXITING is set the task is on the way out and has t::pending
+ * flushed already. Prevent queueing of PIDTYPE_PID signals as they would
+ * be leaked.
+ */
+static inline bool task_can_queue_signal(struct task_struct *t, enum pid_typ=
e type)
+{
+	lockdep_assert_held(&t->sighand->siglock);
+
+	if (!(t->flags & PF_EXITING))
+		return true;
+
+	return type !=3D PIDTYPE_PID;
+}
+
 static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 				struct task_struct *t, enum pid_type type, bool force)
 {
@@ -1030,6 +1069,10 @@ static int __send_signal_locked(int sig, struct kernel=
_siginfo *info,
 	lockdep_assert_held(&t->sighand->siglock);
=20
 	result =3D TRACE_SIGNAL_IGNORED;
+
+	if (!task_can_queue_signal(t, type))
+		goto ret;
+
 	if (!prepare_signal(sig, t, force))
 		goto ret;
=20
@@ -1980,11 +2023,25 @@ static inline struct task_struct *posixtimer_get_targ=
et(struct k_itimer *tmr)
 	struct task_struct *t =3D pid_task(tmr->it_pid, tmr->it_pid_type);
=20
 	if (t && tmr->it_pid_type !=3D PIDTYPE_PID &&
-	    same_thread_group(t, current) && !current->exit_state)
+	    same_thread_group(t, current) && !(current->flags & PF_EXITING))
 		t =3D current;
 	return t;
 }
=20
+/*
+ * Find the target task for the POSIX timer signal and prevent that a
+ * PIDTYPE_PID signal is queued on a task which has PF_EXITING set.
+ */
+static inline struct task_struct *posixtimer_get_unignore_target(struct k_it=
imer *tmr)
+{
+	struct task_struct *t =3D posixtimer_get_target(tmr);
+
+	if (t && task_can_queue_signal(t, tmr->it_pid_type))
+		return t;
+
+	return NULL;
+}
+
 void posixtimer_send_sigqueue(struct k_itimer *tmr)
 {
 	struct sigqueue *q =3D &tmr->sigq;
@@ -2002,6 +2059,9 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
 	if (!likely(lock_task_sighand(t, &flags)))
 		return;
=20
+	if (!task_can_queue_signal(t, tmr->it_pid_type))
+		goto unlock;
+
 	/*
 	 * Update @tmr::sigqueue_seq for posix timer signals with sighand
 	 * locked to prevent a race against dequeue_signal().
@@ -2093,6 +2153,7 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
 	result =3D TRACE_SIGNAL_DELIVERED;
 out:
 	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type !=3D PIDTYPE_PID, =
result);
+unlock:
 	unlock_task_sighand(t, &flags);
 }
=20
@@ -2148,7 +2209,7 @@ static void posixtimer_sig_unignore(struct task_struct =
*tsk, int sig)
 		 * has exited by now, drop the reference count.
 		 */
 		guard(rcu)();
-		target =3D posixtimer_get_target(tmr);
+		target =3D posixtimer_get_unignore_target(tmr);
 		if (target)
 			posixtimer_queue_sigqueue(&tmr->sigq, target, tmr->it_pid_type);
 		else
@@ -3132,42 +3193,36 @@ static void retarget_shared_pending(struct task_struc=
t *tsk, sigset_t *which)
=20
 void exit_signals(struct task_struct *tsk)
 {
+	LIST_HEAD(sigq_list);
 	int group_stop =3D 0;
-	sigset_t unblocked;
=20
 	/*
 	 * @tsk is about to have PF_EXITING set - lock out users which
-	 * expect stable threadgroup.
+	 * expect a stable threadgroup.
 	 */
 	cgroup_threadgroup_change_begin(tsk);
=20
-	if (thread_group_empty(tsk) || (tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
+	scoped_guard(spinlock_irq, &tsk->sighand->siglock) {
 		tsk->flags |=3D PF_EXITING;
-		cgroup_threadgroup_change_end(tsk);
-		return;
-	}
=20
-	spin_lock_irq(&tsk->sighand->siglock);
-	/*
-	 * From now this task is not visible for group-wide signals,
-	 * see wants_signal(), do_signal_stop().
-	 */
-	tsk->flags |=3D PF_EXITING;
+		sigqueue_dequeue_pending(&tsk->pending, &sigq_list);
=20
-	cgroup_threadgroup_change_end(tsk);
+		if (task_sigpending(tsk) && !thread_group_empty(tsk) &&
+		    !(tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
+			sigset_t unblocked =3D tsk->blocked;
=20
-	if (!task_sigpending(tsk))
-		goto out;
+			signotset(&unblocked);
+			retarget_shared_pending(tsk, &unblocked);
=20
-	unblocked =3D tsk->blocked;
-	signotset(&unblocked);
-	retarget_shared_pending(tsk, &unblocked);
+			if (unlikely(tsk->jobctl & JOBCTL_STOP_PENDING) &&
+			    task_participate_group_stop(tsk))
+				group_stop =3D CLD_STOPPED;
+		}
+	}
=20
-	if (unlikely(tsk->jobctl & JOBCTL_STOP_PENDING) &&
-	    task_participate_group_stop(tsk))
-		group_stop =3D CLD_STOPPED;
-out:
-	spin_unlock_irq(&tsk->sighand->siglock);
+	cgroup_threadgroup_change_end(tsk);
+
+	flush_sigqueue_list(&sigq_list);
=20
 	/*
 	 * If group stop has completed, deliver the notification.  This
