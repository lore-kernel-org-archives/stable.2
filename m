Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FE54BA9F6;
	Sat,  5 Sep 2026 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634746; cv=none; b=TiW+Dk8/oU285Tu/GtbeZEy4+C0CEts566ruHFlAyObx1enEIhmJW3SdKgHy+tm/CbtVOyUj4Fwv2uwGXTvuAHGJSu66Othz/CHpejLWt5pc5jggieZYhnxJ/Fx4akLdzbrVW4Xdjc4BmjcXfAhO30gPMgVvhvJd8Z6nzTdVTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634746; c=relaxed/simple;
	bh=lCynVIs8aKJKMVWb3jXPUDUGT7cEenB0fKBdf2tYc2E=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EnjHtXu0ZcIb6winxgIt/kYk+hMSdmZ8dmKcxgCz1FL6oqNZunUbysPLChf6vKn+h9oTP3Ytt2qY4aPsN6965OtPUUzqbrviDpW5HJDBp6byRLJg7+6Cg7pbUmN66XbKZMuSlu1z/5yMlVdzp+SrSpARrxiy+/B2wXuP4fJGAqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2PmboTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2PmboTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35F71F00A3A;
	Sat,  5 Sep 2026 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788634744;
	bh=BTVGTOT+HOOx+x25pfx45Vo+L4C+P6jQofqpFcJJKto=;
	h=Date:From:To:Cc:Subject:References;
	b=o2PmboTWA0FWW5KJudocblmL30UuNwgUm20F/8a1I+norxwxvQ1JB34mPYo2k/CHi
	 8jaXKDAFzDGImptgWVLAv5z/GCMBr3GbhcUI6Y8tkgABRawkwGgtZgpQ9irbCrKEZE
	 pZIZ8Hl1FZhpJS6WmpFsHrqX7h20jlPFFofMhX4FpJydd3lzdEC/sKX2nhs9lChUam
	 64+NIMYI7EZQYp35QTXQJiKlblpIauNukd0jr/vs7C1d9PNKiURTtw4dDH32P3pykz
	 ngQf9U4T13NfGhbAxMpWihKTr25fYx+gNfTsZUEYgoN4/X5IVn0nMqsybJbl2TBYlT
	 7yVa7ogFXjaTQ==
Date: Sat, 05 Sep 2026 20:59:01 +0200
Message-ID: <20260905185839.667208455@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>,
 Ingo Molnar <mingo@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 stable@vger.kernel.org
Subject: [patch V2 1/8] signal: Prevent exec() race
References: <20260905181551.738186850@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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

Fixes: fb3bbcfe344e ("exit: change the release_task() paths to call flush_sigqueue() lockless")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Debugged-by: Hyunwoo Kim <imv4bel@gmail.com>
Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Closes: https://patch.msgid.link/aok1rdkBgZsynHZB@v4bel
---
V4: Prevent requeuing of signals which are unignored - Oleg, Eric

    Split out the decision into an inline which can be reused by the posix
    CPU timer follow up changes.

V3: Restructure code and fix the missing unlock - Oleg

V2: Don't flush w/o sighand lock held - Oleg
    Move the while pending list under the lock and free it lockless
---
 kernel/exit.c   |   11 +++--
 kernel/signal.c |  103 +++++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 78 insertions(+), 36 deletions(-)

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -299,12 +299,13 @@ void release_task(struct task_struct *p)
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
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -457,18 +457,28 @@ static void __sigqueue_free(struct sigqu
 	kmem_cache_free(sigqueue_cachep, q);
 }
 
-void flush_sigqueue(struct sigpending *queue)
+static void flush_sigqueue_list(struct list_head *head)
 {
-	struct sigqueue *q;
+	struct sigqueue *q, *tmp;
 
-	sigemptyset(&queue->signal);
-	while (!list_empty(&queue->list)) {
-		q = list_entry(queue->list.next, struct sigqueue , list);
+	list_for_each_entry_safe(q, tmp, head, list) {
 		list_del_init(&q->list);
 		__sigqueue_free(q);
 	}
 }
 
+void flush_sigqueue(struct sigpending *queue)
+{
+	sigemptyset(&queue->signal);
+	flush_sigqueue_list(&queue->list);
+}
+
+static void sigqueue_dequeue_pending(struct sigpending *queue, struct list_head *head)
+{
+	sigemptyset(&queue->signal);
+	list_splice_init(&queue->list, head);
+}
+
 /*
  * Flush all pending signals for this kthread.
  */
@@ -1019,6 +1029,21 @@ static inline bool legacy_queue(struct s
 	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
 }
 
+/*
+ * When PF_EXITING is set the task is on the way out and has t::pending
+ * flushed already. Prevent queueing of PIDTYPE_PID signals as they would
+ * be leaked.
+ */
+static inline bool task_can_queue_signal(struct task_struct *t, enum pid_type type)
+{
+	lockdep_assert_held(&t->sighand->siglock);
+
+	if (!(t->flags & PF_EXITING))
+		return true;
+
+	return type != PIDTYPE_PID;
+}
+
 static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 				struct task_struct *t, enum pid_type type, bool force)
 {
@@ -1030,6 +1055,10 @@ static int __send_signal_locked(int sig,
 	lockdep_assert_held(&t->sighand->siglock);
 
 	result = TRACE_SIGNAL_IGNORED;
+
+	if (!task_can_queue_signal(t, type))
+		goto ret;
+
 	if (!prepare_signal(sig, t, force))
 		goto ret;
 
@@ -1968,11 +1997,25 @@ static inline struct task_struct *posixt
 	struct task_struct *t = pid_task(tmr->it_pid, tmr->it_pid_type);
 
 	if (t && tmr->it_pid_type != PIDTYPE_PID &&
-	    same_thread_group(t, current) && !current->exit_state)
+	    same_thread_group(t, current) && !(current->flags & PF_EXITING))
 		t = current;
 	return t;
 }
 
+/*
+ * Find the target task for the POSIX timer signal and prevent that a
+ * PIDTYPE_PID signal is queued on a task which has PF_EXITING set.
+ */
+static inline struct task_struct *posixtimer_get_unignore_target(struct k_itimer *tmr)
+{
+	struct task_struct *t = posixtimer_get_target(tmr);
+
+	if (t && task_can_queue_signal(t, tmr->it_pid_type))
+		return t;
+
+	return NULL;
+}
+
 void posixtimer_send_sigqueue(struct k_itimer *tmr)
 {
 	struct sigqueue *q = &tmr->sigq;
@@ -1990,6 +2033,9 @@ void posixtimer_send_sigqueue(struct k_i
 	if (!likely(lock_task_sighand(t, &flags)))
 		return;
 
+	if (!task_can_queue_signal(t, tmr->it_pid_type))
+		goto unlock;
+
 	/*
 	 * Update @tmr::sigqueue_seq for posix timer signals with sighand
 	 * locked to prevent a race against dequeue_signal().
@@ -2081,6 +2127,7 @@ void posixtimer_send_sigqueue(struct k_i
 	result = TRACE_SIGNAL_DELIVERED;
 out:
 	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type != PIDTYPE_PID, result);
+unlock:
 	unlock_task_sighand(t, &flags);
 }
 
@@ -2136,7 +2183,7 @@ static void posixtimer_sig_unignore(stru
 		 * has exited by now, drop the reference count.
 		 */
 		guard(rcu)();
-		target = posixtimer_get_target(tmr);
+		target = posixtimer_get_unignore_target(tmr);
 		if (target)
 			posixtimer_queue_sigqueue(&tmr->sigq, target, tmr->it_pid_type);
 		else
@@ -3120,42 +3167,36 @@ static void retarget_shared_pending(stru
 
 void exit_signals(struct task_struct *tsk)
 {
+	LIST_HEAD(sigq_list);
 	int group_stop = 0;
-	sigset_t unblocked;
 
 	/*
 	 * @tsk is about to have PF_EXITING set - lock out users which
-	 * expect stable threadgroup.
+	 * expect a stable threadgroup.
 	 */
 	cgroup_threadgroup_change_begin(tsk);
 
-	if (thread_group_empty(tsk) || (tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
+	scoped_guard(spinlock_irq, &tsk->sighand->siglock) {
 		tsk->flags |= PF_EXITING;
-		cgroup_threadgroup_change_end(tsk);
-		return;
-	}
 
-	spin_lock_irq(&tsk->sighand->siglock);
-	/*
-	 * From now this task is not visible for group-wide signals,
-	 * see wants_signal(), do_signal_stop().
-	 */
-	tsk->flags |= PF_EXITING;
+		sigqueue_dequeue_pending(&tsk->pending, &sigq_list);
 
-	cgroup_threadgroup_change_end(tsk);
+		if (task_sigpending(tsk) && !thread_group_empty(tsk) &&
+		    !(tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
+			sigset_t unblocked = tsk->blocked;
+
+			signotset(&unblocked);
+			retarget_shared_pending(tsk, &unblocked);
+
+			if (unlikely(tsk->jobctl & JOBCTL_STOP_PENDING) &&
+			    task_participate_group_stop(tsk))
+				group_stop = CLD_STOPPED;
+		}
+	}
 
-	if (!task_sigpending(tsk))
-		goto out;
+	cgroup_threadgroup_change_end(tsk);
 
-	unblocked = tsk->blocked;
-	signotset(&unblocked);
-	retarget_shared_pending(tsk, &unblocked);
-
-	if (unlikely(tsk->jobctl & JOBCTL_STOP_PENDING) &&
-	    task_participate_group_stop(tsk))
-		group_stop = CLD_STOPPED;
-out:
-	spin_unlock_irq(&tsk->sighand->siglock);
+	flush_sigqueue_list(&sigq_list);
 
 	/*
 	 * If group stop has completed, deliver the notification.  This

