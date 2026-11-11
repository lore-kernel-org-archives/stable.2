Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407172;
	b=SsAW38YrxwT0WtMZSqZ25bRJnuF8Nd5UuYln+ZxHJHSQfU2l5gZtrtZd9XFL6yltRH14
	 wBGb65tN6zbFtoLp3U7B7NhuhGQ8sVuVEvS7mcSJ00otCgtZFQHnTGttNyHb2J8rZNM6L
	 nXmjaG/09dkAtBuvuNn5HzfYJLiI4T6l4TUA/DGzIyYKrofBlx9hmMdo37uY7YQyVKKr2
	 ugNSyjKRnwMAH+d7DxG0Ca0oDaT0Yq52Pam1MsRG7TVYBU+yvF+spjkywj6iA/ta297Ja
	 Cxvzl8bNn+ROXXlI6jG3Xvt8en1SomPfTTcHeiQ8t5XzbXVL4+mBeHTwrkHP4N2FXbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407172;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RvfahGfHqHL+AYuZu/usoC7u3JN93uuveW8lViR1oO4=;
	b=hoB2KdGSr90QGXlvqEfZbRHHHrilUkCIqomxdycZV4swn7eEpKmZHqpXovC8Yqkk2Un9
	 K78Vm/YG8tGrfwARTLQ+Pnr4jcUXCSVtOFeTIYvTrkt0Zy4R+ui4n2mIUDa6Q8pyZKMBg
	 tbB4XIGMoIEfJiMpcFBRCMDc4XAiuSvZ2SVD7VzxjhoHald53wJAYitVod+99q1MMYWaJ
	 f//T/L2goyGGHhXuG5po7WsKvkutOiFsYY7U5/bQM+uGKEsW2+OOb4dymGop+jPu8BLmp
	 Eyt0Sg8CUL2399HFHMkAqJdvu0dh/szGPLIuVSww35fLaWcMRZ15zga91xOp9VWBxzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X3bQy/Yp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F1606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3bQy/Yp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E861F00A07;
	Wed, 11 Nov 2026 14:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407172;
	bh=RvfahGfHqHL+AYuZu/usoC7u3JN93uuveW8lViR1oO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X3bQy/Yp16/a6jBLtpEW/law10r07kUlX7jFBDibpSqj7DlT4j/XM0MC+jj9usVTI
	 ucZsF7JcxH8j9YxzYwnY3LHMg42JYBMY/O9uwyN2AsHAOd2F491zJp9tIKzDGxjQeb
	 YOPO9NGypN3YFboCrEqw8ZIHQbVUG3x52Xxi0WBhco/Z1Ctp6Ga3KBQVTqTadfWsH0
	 UB2zVpbJarWdSFdvyqvujvMq4tZxLlJNHhVHcVyGLN/RnL/S1X1c5W/9ZSGxQ04EXy
	 fSOzrN9zjJ284Xo7pBl/T6DGBT9SV189v9G0WXyn7AxeA6tfl2CZ9Cf3V/FgLqKoNf
	 KNeyWxbDclV5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] signal: Requeue signals in the appropriate queue
Date: Wed, 11 Nov 2026 09:26:08 -0500
Message-ID: <20261111142411.2273665-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055921-failed-5.15-d72e0fb3b00c@kernel.org>
References: <20261107055921-failed-5.15-d72e0fb3b00c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit 5768d8906bc23d512b1a736c1e198aa833a6daa4 ]

In the event that a tracer changes which signal needs to be delivered
and that signal is currently blocked then the signal needs to be
requeued for later delivery.

With the advent of CLONE_THREAD the kernel has 2 signal queues per
task.  The per process queue and the per task queue.  Update the code
so that if the signal is removed from the per process queue it is
requeued on the per process queue.  This is necessary to make it
appear the signal was never dequeued.

The rr debugger reasonably believes that the state of the process from
the last ptrace_stop it observed until PTRACE_EVENT_EXIT can be recreated
by simply letting a process run.  If a SIGKILL interrupts a ptrace_stop
this is not true today.

So return signals to their original queue in ptrace_signal so that
signals that are not delivered appear like they were never dequeued.

Fixes: 794aa320b79d ("[PATCH] sigfix-2.5.40-D6")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.gi
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/87zgq4d5r4.fsf_-_@email.froward.int.ebiederm.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Stable-dep-of: d72e0fb3b00c ("signalfd: don't dequeue the forced fatal signals")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/signalfd.c                |  5 +++--
 include/linux/sched/signal.h |  7 ++++---
 kernel/signal.c              | 21 ++++++++++++++-------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 65ce0e72e7b95..e20d1484c6633 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -155,11 +155,12 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info,
 				int nonblock)
 {
+	enum pid_type type;
 	ssize_t ret;
 	DECLARE_WAITQUEUE(wait, current);
 
 	spin_lock_irq(&current->sighand->siglock);
-	ret = dequeue_signal(current, &ctx->sigmask, info);
+	ret = dequeue_signal(current, &ctx->sigmask, info, &type);
 	switch (ret) {
 	case 0:
 		if (!nonblock)
@@ -174,7 +175,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ret = dequeue_signal(current, &ctx->sigmask, info);
+		ret = dequeue_signal(current, &ctx->sigmask, info, &type);
 		if (ret != 0)
 			break;
 		if (signal_pending(current)) {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 324a3fd0f3c3e..d71dc9a933d44 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -274,17 +274,18 @@ static inline int signal_group_exit(const struct signal_struct *sig)
 extern void flush_signals(struct task_struct *);
 extern void ignore_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
-extern int dequeue_signal(struct task_struct *task,
-			  sigset_t *mask, kernel_siginfo_t *info);
+extern int dequeue_signal(struct task_struct *task, sigset_t *mask,
+			  kernel_siginfo_t *info, enum pid_type *type);
 
 static inline int kernel_dequeue_signal(void)
 {
 	struct task_struct *task = current;
 	kernel_siginfo_t __info;
+	enum pid_type __type;
 	int ret;
 
 	spin_lock_irq(&task->sighand->siglock);
-	ret = dequeue_signal(task, &task->blocked, &__info);
+	ret = dequeue_signal(task, &task->blocked, &__info, &__type);
 	spin_unlock_irq(&task->sighand->siglock);
 
 	return ret;
diff --git a/kernel/signal.c b/kernel/signal.c
index c4091812ea89b..8f2a050d3b24c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -626,7 +626,8 @@ static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
  *
  * All callers have to hold the siglock.
  */
-int dequeue_signal(struct task_struct *tsk, sigset_t *mask, kernel_siginfo_t *info)
+int dequeue_signal(struct task_struct *tsk, sigset_t *mask,
+		   kernel_siginfo_t *info, enum pid_type *type)
 {
 	bool resched_timer = false;
 	int signr;
@@ -634,8 +635,10 @@ int dequeue_signal(struct task_struct *tsk, sigset_t *mask, kernel_siginfo_t *in
 	/* We only dequeue private signals from ourselves, we don't let
 	 * signalfd steal them
 	 */
+	*type = PIDTYPE_PID;
 	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
 	if (!signr) {
+		*type = PIDTYPE_TGID;
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
 					 mask, info, &resched_timer);
 #ifdef CONFIG_POSIX_TIMERS
@@ -2609,7 +2612,7 @@ static void do_freezer_trap(void)
 		task_work_run();
 }
 
-static int ptrace_signal(int signr, kernel_siginfo_t *info)
+static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
 {
 	/*
 	 * We do not check sig_kernel_stop(signr) but set this marker
@@ -2650,7 +2653,7 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
 
 	/* If the (new) signal is now blocked, requeue it.  */
 	if (sigismember(&current->blocked, signr)) {
-		send_signal(signr, info, current, PIDTYPE_PID);
+		send_signal(signr, info, current, type);
 		signr = 0;
 	}
 
@@ -2751,6 +2754,7 @@ bool get_signal(struct ksignal *ksig)
 
 	for (;;) {
 		struct k_sigaction *ka;
+		enum pid_type type;
 
 		/* Has this task already been marked for death? */
 		if (signal_group_exit(signal)) {
@@ -2793,16 +2797,18 @@ bool get_signal(struct ksignal *ksig)
 		 * so that the instruction pointer in the signal stack
 		 * frame points to the faulting instruction.
 		 */
+		type = PIDTYPE_PID;
 		signr = dequeue_synchronous_signal(&ksig->info);
 		if (!signr)
-			signr = dequeue_signal(current, &current->blocked, &ksig->info);
+			signr = dequeue_signal(current, &current->blocked,
+					       &ksig->info, &type);
 
 		if (!signr)
 			break; /* will return 0 */
 
 		if (unlikely(current->ptrace) && (signr != SIGKILL) &&
 		    !(sighand->action[signr -1].sa.sa_flags & SA_IMMUTABLE)) {
-			signr = ptrace_signal(signr, &ksig->info);
+			signr = ptrace_signal(signr, &ksig->info, type);
 			if (!signr)
 				continue;
 		}
@@ -3633,6 +3639,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 	ktime_t *to = NULL, timeout = KTIME_MAX;
 	struct task_struct *tsk = current;
 	sigset_t mask = *which;
+	enum pid_type type;
 	int sig, ret = 0;
 
 	if (ts) {
@@ -3649,7 +3656,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 	signotset(&mask);
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	sig = dequeue_signal(tsk, &mask, info);
+	sig = dequeue_signal(tsk, &mask, info, &type);
 	if (!sig && timeout) {
 		/*
 		 * None ready, temporarily unblock those we're interested
@@ -3668,7 +3675,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
 		sigemptyset(&tsk->real_blocked);
-		sig = dequeue_signal(tsk, &mask, info);
+		sig = dequeue_signal(tsk, &mask, info, &type);
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 
-- 
2.53.0

