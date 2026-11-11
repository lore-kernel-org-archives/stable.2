Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405683;
	b=YL7P4wc4d4r4eiyq2f+pUA9DSQ//7IfRWJlAI+NB8+QlRIVB3cIK0/48tjpsNKGmekD/
	 01zWVR4LNjbzOW52ju93OKqa1bksUiri/LjtsW3iyxmVYDnyJAiqOKU6smornpSWucfSG
	 NZOcgRqnKelUCaaDAwTabVmMrYRYSMsWNyEHVlkxdGPvBhQW75aW+9PQulYSQH2EOX8ev
	 mfzYsLD+mpMBOHk4yZ7wgo4Y6gCH2aBJwVyZIehjrYucZ+TWj54Cuk7uaeUGICOZ+dDLJ
	 Lb+IIq2bWta55hd3C60n8l690DgT1dUR7vwnljda7VQiB8FxJaYV9S6BXxsPgulZvJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405683;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uRckgGNHpPxYPMgMHsCjaBLUkYha09vt+id7WN5jCvw=;
	b=cidL5Pv+vYUuPrNjOk6P9Wjdt0cSF9Vv/9skREDO4+p0xutm1d/YKe9gMC7gACRRu49t
	 tAlN90zqrtClv63AZSjyLbpyo51aWfVG6Z+E6fkb1AAIvLWIRNIUbKK+EmaQ7wi5CjBd8
	 /b8DCZv05n2p++kNjSKzYViNIY53fUQfTRDxMP/WHBs2dM+yECBIoX0GBYpLSV67/pNs1
	 gLhFD6W5mAWt09vHzVLfivDq2W3qAqF6Qtc02c93+UMIXxw7aUgSi+fVY4byn330zZu7O
	 Wec0w+cc60pdD7LUjmoxHz3Eo/sgI2D26rBtJyRbMh9rnrdkN9KL2JOC8+/eHQqgnog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0JcLcRB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C7606A880
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0JcLcRB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBB61F00A07;
	Wed, 11 Nov 2026 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405682;
	bh=uRckgGNHpPxYPMgMHsCjaBLUkYha09vt+id7WN5jCvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N0JcLcRBTfedw1dNVmHNLvQETa2wzbauzv59IwTa2pdEE0322KpPeWDSp4y89G6za
	 2T05f8dHCdKUUoBGpUwCLwQN1EyH1+AsxGaZb1ncxxPg53kFS6Th3pUnUCzsRww6OH
	 5x/ThknqTczbwiQKkIDVWm+UeWZsmxn5hvs9DRaDSxFKlNlEdIzFmwCDobQey0BaRB
	 P+jGhT4Mn7MhhIKO7EEEn5yWfhi9EOoomKqFTj6Pbw5JUyikZeLzpWutx3Qii63JH7
	 9xBlRqzazsri/zLmFMeAiR/nkkbP0wMGDQ+R7huAbuVd5lyBT6Xri1il+4+yI3Ggkr
	 aERaQhODuBmhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	stable@kernel.org,
	syzbot+0a4c46806941297fecb9@syzkaller.appspotmail.com,
	Kusaram Devineni <kusaram@devineni.in>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] signalfd: don't dequeue the forced fatal signals
Date: Wed, 11 Nov 2026 09:01:20 -0500
Message-ID: <20261111140003.2190636-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054220-failed-6.1-d72e0fb3b00c@kernel.org>
References: <20261107054220-failed-6.1-d72e0fb3b00c@kernel.org>
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
[ sashal: adapted dequeue_signal() calls to retain the explicit current argument ]
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

