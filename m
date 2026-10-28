Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227825;
	b=ltSdluDFB7KFbYdQ+hyf4YIHPszig9qKLVHB93uy1Dftk5jehRl21aGPo1zsIbNO5lVX
	 5ZfGqBtUpjqxz3ebD6Meq8JIfPeYMTW98dVLe9R46cSnO7q0AN4IMvtsLgzQXsnH8IfDV
	 orUt8eSPZ0VFbMiacjqoc3b0ia2g0Gag1iiTBfkEQnQyJLGT/VzpikR6Sllfhm+PhRZpS
	 z5djpSmv7LqTrqvdHMv16T3gja3YfOuPjKFPnKyPNIFLKrCvh50aRnVDtyFqGrpfiBejQ
	 vabiywa/NdXe3gtEleolD9BjX1ppkSOCHFUMhYJkcCA187SWzZ4tSrxg1Vftg6TYefA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sLBkOKAo4Btus7+LZUplgPCWssAMm6YIDFeAEyJbIEU=;
	b=LK+NvoXuxFGC5WG8Bv4vXzaFrbaaOfSi9F1b89miKT3BwbKtfFtFaEu/wWP1DP3O9OvQ
	 4W9h9xJKZY7KS5wZcbpEX0QhugEYnDb6tPi7al+vvTuGPDzbANCDoPbJmvYzsQaKLwQzH
	 L5oXGnrISeteW+MdIdSKfRaftwIyLBWUza+20ZcUxrc8dlOAMY93OpDQVinwqPzvpPf2L
	 JuMSRsy4CoU/WARTYDQw80qRJsmhhyrMRTm/eYTQpIhjoC/bCUaSejIXi9CT/MjU7Cw60
	 UtKNHekRf+93x6tteVNh2+ux+BhtHp5G2/mVcw3mmwiLpDLvkHK162hjEDZZUX43YEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAIVXdEc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD6606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAIVXdEc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D7E1F01825;
	Wed, 28 Oct 2026 22:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793227825;
	bh=sLBkOKAo4Btus7+LZUplgPCWssAMm6YIDFeAEyJbIEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BAIVXdEcYlbG8vt8141nTgXlIWBqdP9jtnnhb5TyiDfMpn7ohEv49A4OrmIbfiftD
	 Y6K1IGXM3HvK+2SItzSkqwc04ZVUboAjHNUras42/ZU/rbuvrBFLJTBe7IYK8wHRDz
	 JH1qX+OlC7Lwx7rkm5tya5qM0N87XtUkXe33crG0CKzAUI5wKmUfwMjBFQGBgHgk7A
	 ltY+TC9oE9J3fftUDjGczjJl+OprqlglIO4V2jahvlvJlmd1RFivFYyCD8Yjkn5sX/
	 HGR4bhkO//mKIDCzn9rwP3XNllL4c8Sx8u7sjDS5FD1iaJ1SRsHTLQmdUjjFlkMAu8
	 8HGqTXYECkEyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] coredump: prevent TIF_NOTIFY_SIGNAL from interrupting coredumps
Date: Wed, 28 Oct 2026 18:50:23 -0400
Message-ID: <20261028225002.2428149-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102819-progress-massager-b75a@gregkh>
References: <2026102819-progress-massager-b75a@gregkh>
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
[ sashal: moved the guard from vfs_coredump() to do_coredump() before override_creds() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 326b30421eec3..cf0a41044d71f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -642,6 +642,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	if (retval < 0)
 		goto fail_creds;
 
+	/* Task work must not cut the dump short, see signal_pending(). */
+	guard(no_notify_signal)();
 	old_cred = override_creds(cred);
 
 	ispipe = format_corename(&cn, &cprm, &argv, &argc);
-- 
2.53.0

