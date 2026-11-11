Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407174;
	b=ir+5EQAkQ+3ROX5NMMZ2Ooapa2ky0C34U7hl/VXQrqNeeJ+YvodUt9RiH6/63oiQjZ6W
	 WaLfzC1UnxLq6oTdZ9P+s/ORyzxTbmcaEEOq61qBZFNwHu8n4/jNji529OoWEDrW+xB5K
	 aYxv3eB7TRXiZLnI18HqYHpMTd2YgNXnOt/u2PNPZX9+7VZo90Km9Bd17l/2rF4UdP6HB
	 QvURBMOvAHzhWap6RIKV5zU9iVArVLq9EwG8Rw8KtB2yrphsZLpTqULKI22B4ZLJXMowW
	 KoZ+KoU+lh5pYQt7fnoLx0UDr11DwWjthKEmPpAasnytGkgNHPN/IZ3b74t1XyhrZUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407174;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NBHhxEiD+7g+UWuU1hCpfvT96JAxx93nksH81ZHIN6I=;
	b=da7yjPCYbncPVP+3mmGx3VHcAUmTc2TL4xHeQ4/ulG9mUYiNce4r3T/24tpiOlbaZaD3
	 VUDaIYc0/RYoOzGYiyUamxQb/ySwkRLtSErJfu/PZEnWifyrtwpVbBFOsm9cRbgiSyZ70
	 2JfNwVNwkSpYxVpDMeKAeGKwAFA+d20YkF7pbu/iAU2K5y/UT7mGFfxMxLnRQO3YVO4Jp
	 dei3HWvUTMQZ2+HW7CcUI4Ag6FOCpy6hdCXW+tWE1RF5BNFjEG3IaOIK69fZNWByczDuW
	 wjBXAoyKpTXY68GJZ2xc0u35/L3fGwXdmhjz10gdWlrViENZwkPJ8QWXZ6b2DmGlkdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SK9BGTux;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B18606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SK9BGTux
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6301F00A07;
	Wed, 11 Nov 2026 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407174;
	bh=NBHhxEiD+7g+UWuU1hCpfvT96JAxx93nksH81ZHIN6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SK9BGTuxxNaD1R60WyKXIf0JqMbVjRe7vhEBuEVEnkRfa9en+QT/2oobSfjMdbHFI
	 8Ah+sOaz28F2kvVRmPb7BsMQxPPs3tJ7PSi2YUHMYxOMbpcMrs5rYzxIMHcAFE1ABY
	 pShAZn+fTKOgdedUFtnz0nDelrsF/5x8ouEb6nUyO+tE4xliNjuhh28gY6ISZzyBD9
	 X6I5W6yO1IKoBKwoM5bcbOTR62KYdJhycmTGwskLP08HtINzEamKDaP0AMalkyosSj
	 YrKhRQutstRgWj5Iww2jIYr+NT/abN12ije7cvuo8mqe+4vhxEKZJMgECUWRRctERI
	 8FTm2xUMTc90g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	stable@kernel.org,
	syzbot+0a4c46806941297fecb9@syzkaller.appspotmail.com,
	Kusaram Devineni <kusaram@devineni.in>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] signalfd: don't dequeue the forced fatal signals
Date: Wed, 11 Nov 2026 09:26:10 -0500
Message-ID: <20261111142411.2273665-3-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/signalfd.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 07cc5f6d3483a..96b0913a8da4d 100644
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
-	ret = dequeue_signal(&ctx->sigmask, info, &type);
+	refine_sigmask(ctx, &sigmask);
+	ret = dequeue_signal(&sigmask, info, &type);
 	switch (ret) {
 	case 0:
 		if (!nonblock)
@@ -175,7 +190,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ret = dequeue_signal(&ctx->sigmask, info, &type);
+		ret = dequeue_signal(&sigmask, info, &type);
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

