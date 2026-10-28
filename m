Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224991;
	b=qfexD8MB+Ff9pf/Lo355aBUy0OW4WLe1NhCbdLjhbpQBBAlCFNHf/e4LP8hned/EzBD1
	 RxEKEeQ9wkOHOMlwzLp/ByKgOhDBOQxiY3+3SwniW3bjwAosi42qztuxPc+j+nQjClsIf
	 J9/dxCU62pBGXl/iODgGyiMdJ3hnV5OqE6/GljowSjwVcA/3n9IGF0ln+sFdYZ4AgDXDR
	 XQcytYSC8zVO65A2ZqNEh/hs7f3udVcOzHWEYr+ck5TC5Ypv5r8xxmAGMr7SOFsz+T2uU
	 HJAgXiylvWd/zQ1Ec+c2Q5UthVv1jj11ZuPOmK7nu9c6irSQrJ+tzelIZYOOS/w+kUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224991;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vu1CDYa2AZZDg2qn5u+xXfq/PiA9saJn2/0cY4wqbL0=;
	b=O7JI24MtvLMXzHVeHlGAK4YbOfS5AwyU9Gz8511rKOTkzna+t/yW1snU7hXi/k2g1/dq
	 0J/uWBucuL6uZ9fyKxTLYtYohTzDC0T+vN/JMJSFRgs3aUgVz0RfB64P8c/UGrb1vO83S
	 xcTCqU163Tod5CgVkVzX90vggaXHivVBNSdr6BJ15bVtVpc+JV7T4vjEdACSTHM7hp/x0
	 lgf7Y8qf6s8C2ARwUvMkFmm1Ksq10Fwl2DwbE5kUI19hdGwS/b5B28HK7dEOLIKZywk4O
	 dnACfMuqBpok8/VWeFokFTqfWwsa3h8kPwMsi7vzzziFZcIhSbX4iAnJgGtmFHMn7pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNwJrUZQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E14606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNwJrUZQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214AD1F01825;
	Wed, 28 Oct 2026 22:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793224990;
	bh=vu1CDYa2AZZDg2qn5u+xXfq/PiA9saJn2/0cY4wqbL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dNwJrUZQqF+XD3ul4fEtzeuqXD7/zmN+Y0gegFHCK6ouvcaauYQyudLjUgjDTv6fG
	 QTvEjO7UbdYLSzrt0ebteHy3yu/U1BnB5tR9ZyAFevTuLR0FYcOGqXSKCI7qYcXjdg
	 yCttR73Vwp9o0BRWbNzDqWVdAj2rm+ETC+H/F3gRtUlX1ip1dVVTFP46DOWrbkQ+lx
	 b591a60vzyZd5XNSUVz5Z9A+j7nmSdfPF+l6E+5aZSqY+9uEieWsFOuTd+InAyMNvB
	 wsHZWqa6zvgFeXNUcuFzYbtpWy5Vlo/nGKdK+JXQKsP+6qjnemiqqXbAzRpFrZwpXj
	 YyjIuZZ06grxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] coredump: prevent TIF_NOTIFY_SIGNAL from interrupting coredumps
Date: Wed, 28 Oct 2026 18:03:08 -0400
Message-ID: <20261028220250.2366334-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102818-graded-prancing-5aef@gregkh>
References: <2026102818-graded-prancing-5aef@gregkh>
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
index d23c57eb2e058..6418f3eeeae7e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -630,6 +630,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	if (retval < 0)
 		goto fail_creds;
 
+	/* Task work must not cut the dump short, see signal_pending(). */
+	guard(no_notify_signal)();
 	old_cred = override_creds(cred);
 
 	ispipe = format_corename(&cn, &cprm, &argv, &argc);
-- 
2.53.0

