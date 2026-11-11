Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407173;
	b=vuyLcR2qxmN3qp9VxTGBL/vdci07OBFr6w4Avsws0Fd5rTtor0X0LZzoO8MUUrurw6ms
	 3iQGQNmtJh/thAqrD6rfuUA7zv7tc/ADANf2SWsduhK+bRNVIEIxQrxzN8WgHx7Uv9T5q
	 MckPotYaKIYsPPivebGIFVd1S5+hBygqB2AlS+FLVoSA2+fZXRksaQx4HVQ46sfTIHjko
	 GhiU2fXr9vhaSNY00bE/2LUY/165eXjK6G/qd+0O5NTDglsvDn6zTi4z1QuWmeMvCr/EI
	 xe+CF0vfkquzRNDWDOy9Bf2AQBK2LNskD40ROZ/diK8Z5sZnRAbbWgHNOMc93E15jMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q7PFIXnzXn/20f2MIp9SUp3wRfETWXkHDWJKIM8FF+o=;
	b=dJgA0Ri5PxfbJUh+p7Rz9v3mGdaznSewbOeuDIRQtrnU4VEc6oxc/lmfrMPpU1LxkUZ4
	 a18XCuD6BGRkZ3nzHChs9u/d+XTqQMEMbZgmYjptsuqaAcI1McQ3UyBh9fTzU0xwJL/0Z
	 vsEv3esOppgYDLbE5rWONiOvWQFSqXxiHV1jQr2Hblq3a1YA9SMNzKAVncGIlI8cITIx+
	 fTUfw8HMwurXXqNGwPFTfuCP9e68WKYs9i4BDNuQtUc8fcqku7oRGi2128INUWe8K59lA
	 C3DevCZ5a/BjfVqkLWIkikA1RfT6IMaO7yIbmFgfTjuA+CTC+DD1hGLx2V9lWlbUSgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SFoGYW/v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9E606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFoGYW/v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5FD1F00A05;
	Wed, 11 Nov 2026 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407173;
	bh=q7PFIXnzXn/20f2MIp9SUp3wRfETWXkHDWJKIM8FF+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFoGYW/v08Mb34O9gcEfpVD87rY/ncOr/IB9+owWz+STslamD6Srk/42LA0S1nvL8
	 zaLBQTfQG97IVtwYVjPD3B5uVShipcYhRhi1k0aDhN7ufl7KmBHql0cL2570SOcWBg
	 js0aUflOVX4TJ6jbHTqS/CY6okpibz566RvdynA/BsKFoxCjVZir9D1tEcwjxUQtOn
	 ucSXkFu1RG+1fNUbRgjU4nQMTApITprVldNqK+h06QGo5xvX0kz3SYhGnNaC/sZzbc
	 8VDcqILeI4rc3k9LkFbuZ80k3GaJ6A4hgNEb7p1V8dBJNx9O5fXitN6CMWRIJoIetK
	 4vRBwE6kpqYTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] signal: Remove task argument from dequeue_signal()
Date: Wed, 11 Nov 2026 09:26:09 -0500
Message-ID: <20261111142411.2273665-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111142411.2273665-1-sashal@kernel.org>
References: <20261107055921-failed-5.15-d72e0fb3b00c@kernel.org>
 <20261111142411.2273665-1-sashal@kernel.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit a2b80ce87a87fc18c594e74d13031d5e347b69cb ]

The task pointer which is handed to dequeue_signal() is always current. The
argument along with the first comment about signalfd in that function is
confusing at best. Remove it and use current internally.

Update the stale comment for dequeue_signal() while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Stable-dep-of: d72e0fb3b00c ("signalfd: don't dequeue the forced fatal signals")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/signalfd.c                |  4 ++--
 include/linux/sched/signal.h |  5 ++---
 kernel/signal.c              | 23 ++++++++++-------------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index e20d1484c6633..07cc5f6d3483a 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -160,7 +160,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 	DECLARE_WAITQUEUE(wait, current);
 
 	spin_lock_irq(&current->sighand->siglock);
-	ret = dequeue_signal(current, &ctx->sigmask, info, &type);
+	ret = dequeue_signal(&ctx->sigmask, info, &type);
 	switch (ret) {
 	case 0:
 		if (!nonblock)
@@ -175,7 +175,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ret = dequeue_signal(current, &ctx->sigmask, info, &type);
+		ret = dequeue_signal(&ctx->sigmask, info, &type);
 		if (ret != 0)
 			break;
 		if (signal_pending(current)) {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index d71dc9a933d44..6f105308ab5f0 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -274,8 +274,7 @@ static inline int signal_group_exit(const struct signal_struct *sig)
 extern void flush_signals(struct task_struct *);
 extern void ignore_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
-extern int dequeue_signal(struct task_struct *task, sigset_t *mask,
-			  kernel_siginfo_t *info, enum pid_type *type);
+extern int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type);
 
 static inline int kernel_dequeue_signal(void)
 {
@@ -285,7 +284,7 @@ static inline int kernel_dequeue_signal(void)
 	int ret;
 
 	spin_lock_irq(&task->sighand->siglock);
-	ret = dequeue_signal(task, &task->blocked, &__info, &__type);
+	ret = dequeue_signal(&task->blocked, &__info, &__type);
 	spin_unlock_irq(&task->sighand->siglock);
 
 	return ret;
diff --git a/kernel/signal.c b/kernel/signal.c
index 8f2a050d3b24c..858b340c09b5d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -621,20 +621,18 @@ static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
 }
 
 /*
- * Dequeue a signal and return the element to the caller, which is
- * expected to free it.
- *
- * All callers have to hold the siglock.
+ * Try to dequeue a signal. If a deliverable signal is found fill in the
+ * caller provided siginfo and return the signal number. Otherwise return
+ * 0.
  */
-int dequeue_signal(struct task_struct *tsk, sigset_t *mask,
-		   kernel_siginfo_t *info, enum pid_type *type)
+int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 {
+	struct task_struct *tsk = current;
 	bool resched_timer = false;
 	int signr;
 
-	/* We only dequeue private signals from ourselves, we don't let
-	 * signalfd steal them
-	 */
+	lockdep_assert_held(&tsk->sighand->siglock);
+
 	*type = PIDTYPE_PID;
 	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
 	if (!signr) {
@@ -2800,8 +2798,7 @@ bool get_signal(struct ksignal *ksig)
 		type = PIDTYPE_PID;
 		signr = dequeue_synchronous_signal(&ksig->info);
 		if (!signr)
-			signr = dequeue_signal(current, &current->blocked,
-					       &ksig->info, &type);
+			signr = dequeue_signal(&current->blocked, &ksig->info, &type);
 
 		if (!signr)
 			break; /* will return 0 */
@@ -3656,7 +3653,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 	signotset(&mask);
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	sig = dequeue_signal(tsk, &mask, info, &type);
+	sig = dequeue_signal(&mask, info, &type);
 	if (!sig && timeout) {
 		/*
 		 * None ready, temporarily unblock those we're interested
@@ -3675,7 +3672,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
 		sigemptyset(&tsk->real_blocked);
-		sig = dequeue_signal(tsk, &mask, info, &type);
+		sig = dequeue_signal(&mask, info, &type);
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 
-- 
2.53.0

