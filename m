Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048142;
	b=VYHlZgK8SxBe+3DUdb5t9WGACzPURLCD3FoR0qNN83JiUcU7H7AoYKkRPd2i7gPeWTyJ
	 2/RbzoKM8l1d+GS0NyS4LQR8OYp2sJ9JVV7y0UbVPeWdPr5kPohuwY/9woSDIVXND+yM5
	 4R/10QJblL+eqaZdLHH+VpLDbb1JXG3GY455q/wajyDf2dyGA614s30QEZSWeE+Yd+3xX
	 csFJr6CHfXTTOUmuilHHBG+ijp2k2YxECKzoGU6qmr9Vt5aJ+YHyNez/b8CrGJqW3IiMY
	 j/i4xqDjGaTVJvBY9p5W/wFgNLtAMKQFuYJYT0DR7QpEoW8PC/0bxaeiA72uWCjsZ6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048142;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gfX42KCbVNUKUcQVW68AVDxp4zCOFW6y2XziQl/N2Yw=;
	b=0NYRqfZ2WZbtW+csT+F7D1EquZRGZ1xAmhmEw5ludhfeBEk8Qaf9bzC9T4DFoNpvM2r4
	 8P9BW6nv3wFTw3AQkSg3JjHcJVGDilSjcEFFfZu/npFozV66EQCEyD0JUa+fotDfJ8qYe
	 ajVideyjdhPg64xVYrepZiKFEp+VtF2Q+bBjB07Nj9at7A7CU93EbXocAarBr+OWw/QHT
	 WcgxUO8Rw8keu+iSzyMvROiEiQpg1bckl5QH2nLllUhpfly+Hd0J8OBx+2AaQnkHo413k
	 dQT4sxSjs7lRAJkjGB4En8qexR+m3rwm9YGdeiYtnI5KoJUl0qlu8qFA/tl+09AmsXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GuvuC/XU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuvuC/XU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA861F0089F;
	Sat,  7 Nov 2026 10:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048142;
	bh=gfX42KCbVNUKUcQVW68AVDxp4zCOFW6y2XziQl/N2Yw=;
	h=From:To:Cc:Subject:Date;
	b=GuvuC/XUSc2xLZAZDqlrapF7WMGN+xvU7nFJmSM5ofclqh6ZCT2IbdSAU0YilfGwk
	 qqdZBL7gYTlmBW+wo9o001F9iRMMKzs+awX3yzBJRF5wItBOIpUH2dR8JjjF9n4OCT
	 fIFjNeiT3jYENAtZ87CIQOETe19SLBuSJ2ufJaFeChAignnRz8+sOqKq3G4vnzKVK5
	 vFqW2b9kFI4/wULXOZzWLekIOXlCFvVWyW+RqfwFBA2cATgtPAtYFfYk9WX9QUEdk0
	 VIUnf2Gw9AZI7GBbIfFCQlDh0k0K9IIJqbgrxDFBW8qLpnFaqdRUAoX3+3BY0iTU7Y
	 n6hu3MZ0NbM/w==
From: Sasha Levin <sashal@kernel.org>
To: oleg@redhat.com,
	kusaram@devineni.in,
	kees@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] signalfd: don't dequeue the forced fatal signals" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:20 -0500
Message-ID: <20261107054220-failed-6.1-d72e0fb3b00c@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d72e0fb3b00c6a1146bcfd7186ad9f6f609ba236
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054220-failed-6.1-d72e0fb3b00c@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




