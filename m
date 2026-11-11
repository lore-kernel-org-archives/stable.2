Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404635;
	b=h+IKSQ+8LQcOedCWnPQz+9kdYnRkXpud2F7af/QQJv5l/zW9JpttVhWiwuVvveIRrSob
	 jJEj4OxlaJttjVtta8BptQAGPx2ITbO9JC9ftEsiGzYNrNVx+I5rI60al9HkHTCWylkwq
	 hs7veIdkDZ+sRvNnTfAaG1Lh8fL2EkP3CnOXKG+/uaqYbpCX8o9b+1k4i05g8bh5CO/p8
	 ePy+JdNkenuhqZ+/S53fP3OC/J4O4r7qT0g6RXSzA7MZ/BLUpTwwLPSFRMgGo15091oWL
	 YmEl653xRDHWaE0FHI0OzpsJ3yBYHZEyYT0NZc9cwR4IkOpqmXaKxvbWdTSeWs4Nn0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=F21HXehkhHOJ2Hcvkr+Y1EVk7iSfQoJREPt1VKE3m9I=;
	b=2xyWqcM1MRb2qamkP/xpSCUN/LKMIqMSSsaUvG6HbAzFfvAaRftDsnu/NuvpO0QTOd5n
	 J+/iA/x777kMDUHsXvwz0Qhlh2HofYm8fGbHyNTv9/FlPDrHVQPGA5ZtiyTHdnbI44S/g
	 ehBfWwdo//BVH54nKa24MytpmUsBqBu3ZZvTdpVoOdxWliSeB8cru+5WDzG3CiPv6z/lT
	 9iBdZfOUsRdr4/Q0E78esu7n01xbqyVmI+oupEhvXC4+dtci6G9XKWWzcgbp6kQDisjxI
	 fiDN6VcIwnAsyD5xKsc0KZDsK+ZnWPNutD54wP6wkK6Z3NbpelRWGKPlcINIJLMhe+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAqse8ef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8A606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAqse8ef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351D71F00A05;
	Wed, 11 Nov 2026 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404635;
	bh=F21HXehkhHOJ2Hcvkr+Y1EVk7iSfQoJREPt1VKE3m9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAqse8ef9sE588ha03+UPpRxfY+8N4FSCj00v38AvDX9hKkpmz07G/8v1NhE9dwIF
	 WXhM8zhR17mq+7jWWEmJHVb3NqNIFfe8LHaRjSCQdlg8xNUAHpmJTdeH8xcUSGkc0c
	 voJxG9panXqSFsE526H4gzhduFK+mMy+jTnUaeu0vyTVy5pep4EK9nkWdNnkBujx+F
	 sf+FBlKdtc1KuP41fuJ5Ri1kolFPRYDzfO/5eipeN4W34dMKxgm2ww0oQhrbz4Fx0S
	 uOP4XXSDM0TPwBmyyIntSKR/3dHm9e2pIJtNCP82cDqzPcjxjO0u2uwUqhvEnpurPF
	 3hI58yDKnveMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	stable@kernel.org,
	syzbot+0a4c46806941297fecb9@syzkaller.appspotmail.com,
	Kusaram Devineni <kusaram@devineni.in>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] signalfd: don't dequeue the forced fatal signals
Date: Wed, 11 Nov 2026 08:43:52 -0500
Message-ID: <20261111134326.1683124-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052941-failed-6.6-d72e0fb3b00c@kernel.org>
References: <20261107052941-failed-6.6-d72e0fb3b00c@kernel.org>
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

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit d72e0fb3b00c6a1146bcfd7186ad9f6f609ba236 ]

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
[ sashal: Retained current as the first argument to both dequeue_signal() calls to match the existing API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/signalfd.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index e20d1484c6633..797c906bb5de1 100644
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
 
@@ -156,11 +169,13 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 				int nonblock)
 {
 	enum pid_type type;
-	ssize_t ret;
 	DECLARE_WAITQUEUE(wait, current);
+	sigset_t sigmask;
+	ssize_t ret;
 
 	spin_lock_irq(&current->sighand->siglock);
-	ret = dequeue_signal(current, &ctx->sigmask, info, &type);
+	refine_sigmask(ctx, &sigmask);
+	ret = dequeue_signal(current, &sigmask, info, &type);
 	switch (ret) {
 	case 0:
 		if (!nonblock)
@@ -175,7 +190,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ret = dequeue_signal(current, &ctx->sigmask, info, &type);
+		ret = dequeue_signal(current, &sigmask, info, &type);
 		if (ret != 0)
 			break;
 		if (signal_pending(current)) {
@@ -185,6 +200,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 		spin_unlock_irq(&current->sighand->siglock);
 		schedule();
 		spin_lock_irq(&current->sighand->siglock);
+		refine_sigmask(ctx, &sigmask);
 	}
 	spin_unlock_irq(&current->sighand->siglock);
 
-- 
2.53.0

