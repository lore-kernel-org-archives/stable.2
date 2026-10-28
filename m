Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220426;
	b=cLY5vheILmH0U4qOqv9F8XX9k5bmPan1TSAlvS5TKhC38I91wrahkCdPSPQ0NaBGlRlt
	 lOWpzH3Bn8JUZZSPT0ALgcIaRNHMozZ9CKBVy1dFwQ7fJYQH09ouTkaL8KzctaFJQCbnL
	 J0i+qMJmTziXx2grKFF03D9gshdqKxsq9nRkNOEIuVW3VqGKBSaKCioyiuFTGvOew+f/X
	 Wj0vdWutctBKMKHD29UQOE3L9neRn6xHFu3WzBCsKQM1pN9l/5pqwl4hsQFfAXtlT57wz
	 5gKzAb6OP4Mm6IkftPgOX1SAq75QPiau6TXBdri56dMLgaHVrM9oPpkDP7ArsV4NvXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220426;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DFZOzIv6KnBRepkjdYpsrLCsBCQNj0RpUPNU/HvMmTI=;
	b=QuhGCSwA0kytcTtEUD/3rQNtKQeTc41XPeyUR7P4VUhAcgwCPHCB77nQXDpZp1CSZBK/
	 39kJo8W2p8urFx8fbLD89cZ7TxGwoc+PbtmPRB2jmqhfch4Q+XEtr3pZi3zaXh4zm1yda
	 5FsqEODbTJy6nws8hi9f7co88JFzMiQdMQgTb9/8aBDWlfff0o87MdSMeWDR1PlUwnX7w
	 ugSzy+veWpfY0OX9DDGGwvh2foSiBnLAzM52AMA17V6l6tDsGjaWc4XcmRZjtclwY5zP/
	 n42pgDMK683QRXI2f4MgBL3TNUh3sLjzPNkricGzyhwyi+lbC4jZu6rWeBwMieuczwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGAdGRHQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576B606A320
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGAdGRHQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02CA1F01825;
	Wed, 28 Oct 2026 20:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793220425;
	bh=DFZOzIv6KnBRepkjdYpsrLCsBCQNj0RpUPNU/HvMmTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CGAdGRHQX9v/kI4SguZQ32DoEIEcMOmHyEzk1TPe7eAD7O2pzOTgW6OZJI0blIG3W
	 x2SZYDbFW/M3QepvyPqVfqakAQc+QuhEPODo3hFQM/PlPyYLtbMbztRK2noAWnTN9P
	 fTWSyt7zUIuuSPnte2ipGT3z4uWuC4jXPk3Ane/zJKfma6DIseZZSheU+1dQvMf7VD
	 ZXHkY6rlFJzf5XEa70hp6FlNdq9WWR7gpc9hq4I74tPlwlewkYdVec9kkr5dwEuqOC
	 UexRUVq0QNec+vrhWQ9bOm0cojRLQsat485pwnEbHlnqnaObDiWJ+n4mcJHP35y06L
	 //GoYvxdzDHkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] coredump: prevent TIF_NOTIFY_SIGNAL from interrupting coredumps
Date: Wed, 28 Oct 2026 16:47:03 -0400
Message-ID: <20261028204648.2126015-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102818-slander-stove-d034@gregkh>
References: <2026102818-slander-stove-d034@gregkh>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit a58d647acfdc62561f3570d114025b3bf38ae41b ]

TIF_NOTIFY_SIGNAL is used to kick a task in uninterruptible sleep to
return to userspace and run task work and then go back to sleep. This
mechanism works well but breaks coredumps. dump_interrupted() only
allows fatal signals to interrupt a coredump and the whole regular write
path going to actual filesystems is impervious to TIF_NOTIFY_SIGNAL as
well.

However, both the usermodehelper pipe and the coredump socket will bail
early on TIF_NOTIFY_SIGNAL. This affects the following codepaths:

- coredump_sock_recv() -> unix_stream_read_generic()
  The request/ack handshake is abandoned before any coredump data is
  sent.

- anon_pipe_write() returning -ERESTARTSYS
  Once the pipe is full this truncates the coredump.

- unix_stream_sendmsg() returning -ERESTARTSYS
  Once the send buffer is full this truncates the coredump.

- coredump_sock_wait() -> __kernel_read()
  This reports a failure that didn't happen.

- wait_for_dump_helpers() -> wait_event_interruptible()
  This stops waiting for the coredump helpers.

Such truncation is entirely invisible to userspace and all uapi bits
still indicate that a successful coredump happened. A crashing process
with a bunch of file backed mappings and io_uring thrown in loses most
of the coredump data. If the NT_FILE note goes past PAGE_SIZE mappings
it's gonzo.

TIF_NOTIFY_SIGNAL is sent by io_uring for the common case. And it uses
poll without sleeping so a completion callback runs task_work_add() from
interrupt context against the task that submitted the request. This is
the task that is running the coredump. Since that task hasn't set
work_exited (it hasn't exited yet after all) TIF_NOTIFY_SIGNAL keeps
reappearing.

A coredumping task doesn't return to userspace. The task work is run at
exit. So interrupting it doesn't buy anything and just loses the
coredump which is quite valuable.

Note that this isn't specific to io_uring. There's also
klp_send_signals(), bpf_task_work_schedule_signal(), landlock's tsync
and then  technically, kthread_stop() and the printk kunit test set the
bit raw.

Link: https://patch.msgid.link/20260824-work-tif_notify_signal-v2-2-6609e42b3157@kernel.org
Fixes: 12db8b690010 ("entry: Add support for TIF_NOTIFY_SIGNAL")
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: adjusted context for inline coredump handling with override_creds() instead of scoped_with_creds(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 3e927378bf5bf..b3cc7c0531ee1 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1131,6 +1131,8 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	if (coredump_wait(siginfo->si_signo, &core_state) < 0)
 		return;
 
+	/* Task work must not cut the dump short, see signal_pending(). */
+	guard(no_notify_signal)();
 	old_cred = override_creds(cred);
 
 	if (!coredump_parse(&cn, &cprm, &argv, &argc)) {
-- 
2.53.0

