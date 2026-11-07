Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049164;
	b=02Z/xNbxPy9UaSMlP4zZrXUhJyrXtqrdR3KdJgPngDrgI0Bv7IQJacvq17lJFvphLQ+3
	 EaH5ntgZZJ/THgotGJxCBbUhuwOf4zi3ryLXzG9JxFax1WSUJXDx8W2O9hnWC7WD3tUpq
	 cnKzvPGMKhGdYZnSX+itU1V9rhmjG7xVzH47qxB3tpSl96QVrcoxXT0/FD6plPBNyOed2
	 kZtYHMPNc4mkeU29Am1GKKD3cuzDDzqZKeJsfYryGX27y7WBiETaJ/cVrmiM3tdaldF10
	 Fhbp5ciBewJQ1xy+7Cr3NLYM1Aox4V/M/+NTGBZhrG/fxWWpiIdaoKQPfuzkw4g5hPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049164;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jVAGDxjxZFUaujA2O/JK5dFkRvK+biBXWgj6HlnnWio=;
	b=CO6aZrAwKFADldJ5EEZOn3ypiExjSshLlmFlqrqqteLak30G+Fwvu356WMd3KnUNI4mw
	 dZ796zmgiW3rh2iKo5/wEaqA5rsjSq/0QB5hoM7z8DmZl4zxt/WfSPOzx3jrNnoaBRI8o
	 0XUIR7BJYqyTVIpCvVKUHvL5nY7KpT9wD54nVMv0XFS68aRAf2tLL8Ks15NK8CqXI1BrY
	 3Hz/nWNiqKSKfVZF8PaYDchIosXj3a0n27cvj/qt/v0rPKR4cRYrr9539mpXmSzhUrlPi
	 IxH5U0u1Ad/h9pSBKNUCxVsV8Y/D6rESq4XUMKnMHM7PbPbAE6GuAYFj3ErvFhe7Spg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zsg+7tIG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA5606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zsg+7tIG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC101F0089F;
	Sat,  7 Nov 2026 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049163;
	bh=jVAGDxjxZFUaujA2O/JK5dFkRvK+biBXWgj6HlnnWio=;
	h=From:To:Cc:Subject:Date;
	b=Zsg+7tIG3Ai1gMTE0Z7mea+sa8t1usWW0UI+ZNmyHY/rs1EwvF4hO5HI8YjtkDoYF
	 DH3szobS/1AHtzXvs8ImUY2a4NQJM68P0WPR78F6XoGSRBFrj3nQ7RJvDRgW3q9Pok
	 CDNB5dsqKdo7kr6zJxHZlRaG2bCu5TtGyrEkL8tOrrITDfZbDdsDSWj4QIxITs/v7n
	 swqetOnhHCoAO6xI1QG9/tmkNQeW6ikaLjH35L0OGWjXBMr+XmcA9aHOhRju6wM0v1
	 npm+u9v+bQ9QYrEqd2w8Xzh8rln5kpAsc281QvGcIZldiu2Tzfhqc39CUSX+/cmhgc
	 kFf7AWTT0lSqQ==
From: Sasha Levin <sashal@kernel.org>
To: oleg@redhat.com,
	kusaram@devineni.in,
	kees@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] signalfd: don't dequeue the forced fatal signals" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:21 -0500
Message-ID: <20261107055921-failed-5.15-d72e0fb3b00c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d72e0fb3b00c6a1146bcfd7186ad9f6f609ba236
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055921-failed-5.15-d72e0fb3b00c@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d72e0fb3b00c6a1146bcfd7186ad9f6f609ba236 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Mon, 6 Apr 2026 15:37:32 +0200
Subject: [PATCH] signalfd: don't dequeue the forced fatal signals

These signals should act like SIGKILL, in that userspace must never dequeue
them. But as Kusaram explains, io_uring-driven signalfd_read_iter() called
from get_signal() -> task_work_run() paths can do this before get_signal()
has a chance to dequeue such a signal and notice SA_IMMUTABLE.

Change signalfd_poll() and signalfd_dequeue() to add pending SA_IMMUTABLE
signals to ctx->sigmask.

TODO: we should probably change force_sig_info_to_task(HANDLER_EXIT) to
make fatal_signal_pending() true, or add a fatal_or_forced_signal_pending()
helper. Then signalfd_dequeue() could just return -EINTR in this case.
This also makes sense for get_signal(), which could prioritize a fatal
signal sent by (say) force_sig_seccomp(force_coredump => true), just like
it already prioritizes SIGKILL.

Cc: stable@kernel.org
Reported-by: syzbot+0a4c46806941297fecb9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0a4c46806941297fecb9
Tested-by: syzbot+0a4c46806941297fecb9@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/69d122fd.050a0220.2dbe29.001c.GAE@google.com/
Suggested-by: Kusaram Devineni <kusaram@devineni.in>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://patch.msgid.link/adO3HG8bvwRPcmte@redhat.com
Signed-off-by: Kees Cook <kees@kernel.org>
---
 fs/signalfd.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index dff53745e3524..22bc0870a824d 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -48,17 +48,30 @@ static int signalfd_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static void refine_sigmask(struct signalfd_ctx *ctx, sigset_t *sigmask)
+{
+	struct k_sigaction *k = current->sighand->action;
+	int n;
+
+	*sigmask = ctx->sigmask;
+	for (n = 1; n <= _NSIG; ++n, ++k) {
+		if (k->sa.sa_flags & SA_IMMUTABLE)
+			sigaddset(sigmask, n);
+	}
+}
+
 static __poll_t signalfd_poll(struct file *file, poll_table *wait)
 {
 	struct signalfd_ctx *ctx = file->private_data;
 	__poll_t events = 0;
+	sigset_t sigmask;
 
 	poll_wait(file, &current->sighand->signalfd_wqh, wait);
 
 	spin_lock_irq(&current->sighand->siglock);
-	if (next_signal(&current->pending, &ctx->sigmask) ||
-	    next_signal(&current->signal->shared_pending,
-			&ctx->sigmask))
+	refine_sigmask(ctx, &sigmask);
+	if (next_signal(&current->pending, &sigmask) ||
+	    next_signal(&current->signal->shared_pending, &sigmask))
 		events |= EPOLLIN;
 	spin_unlock_irq(&current->sighand->siglock);
 
@@ -155,11 +168,13 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 				int nonblock)
 {
 	enum pid_type type;
-	ssize_t ret;
 	DECLARE_WAITQUEUE(wait, current);
+	sigset_t sigmask;
+	ssize_t ret;
 
 	spin_lock_irq(&current->sighand->siglock);
-	ret = dequeue_signal(&ctx->sigmask, info, &type);
+	refine_sigmask(ctx, &sigmask);
+	ret = dequeue_signal(&sigmask, info, &type);
 	switch (ret) {
 	case 0:
 		if (!nonblock)
@@ -174,7 +189,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ret = dequeue_signal(&ctx->sigmask, info, &type);
+		ret = dequeue_signal(&sigmask, info, &type);
 		if (ret != 0)
 			break;
 		if (signal_pending(current)) {
@@ -184,6 +199,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 		spin_unlock_irq(&current->sighand->siglock);
 		schedule();
 		spin_lock_irq(&current->sighand->siglock);
+		refine_sigmask(ctx, &sigmask);
 	}
 	spin_unlock_irq(&current->sighand->siglock);
 
-- 
2.53.0




