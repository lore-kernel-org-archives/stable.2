Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793230466;
	b=GnrZ/+OA91ZKvdluwB7qmk45tTFH7QsIEsngK5vvy2KtMs4YNjcK3vdzpD6MPuaJnGxl
	 gH+nPNaKeOXhpVIWP7ZKNQQWE9HKLfVu/FWEpwStsgODh43PVefObnyJXXwVukGSwew9a
	 ZnfXryre/OLQgV9zP/oLSf3EELFINl5k8+AiTjwkgz4dFPcgUpR5LYg693MQJ0Uw5a0lq
	 I5KjYAyh+8UqkRgkDlBvW+OecHVas4gQhd4vpJb+1XHTCm0vcqL0n7FWxsy6EWBShopJ7
	 YeJBzeG6YpfxKJR6F+Lxbd0T0JXpq7akCV4vrOw5zJmObs5nbrOEbeMSocxqRm2oheQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230466;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=z+33F51VHug5QneOMKSWWqKefuyMZ97ZR5M8c8brN0o=;
	b=yYvDrtOclKyRKsXnxICkFM56XoQ+90Mbe2WJQ8cilLSSfGntclOF9WpYUxJ6g/wPGP2a
	 8542JQTO1k5UBaOVk67DqSCby3yJZoDhi2YjV9OkXYkcKeB/MW2RlWNwmKhB/TM4GDG/e
	 JgEgJzc4UScQXXS8anAr1VMERnRn9lK/ftRTpVSn9tbUX9iXhMNJko5yNXWYrpPCU0fnc
	 QhlRFn4V2kJrFJDwrCplNQlJKRPqv9kvdVHo32eKdAaEsPdDel+Snfz2CZW7pxoIw9zB+
	 q7CxNOVYb3L9dv6FaguTiDqAmiqoplXg5ABdfWDdsEjy61esK0ysyv4aSBL+oTldS1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0l5eJHL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C7606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0l5eJHL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24141F01825;
	Wed, 28 Oct 2026 23:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793230465;
	bh=z+33F51VHug5QneOMKSWWqKefuyMZ97ZR5M8c8brN0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k0l5eJHLkL6fIjWm5su02e5y6iif8dSjTuwNpQLNupm9jmlWPgOhFoQIvcEmz2fkZ
	 QLR0/C7OmJp8zpKWErWnVndoHNfh+Fk0briOQ7jp6YjEOyHdt9Oz5mnz7TSVU9uhCq
	 S3uRKGfUnam3rBwiHlP5nS/xsM+X/rFO6U2bEwfmyuxQobW5xpBss8b6XPe/kGWRQF
	 11vOkjdg4n7+USVd/IKoHxzHmF5cmnsiCryA5WVlfOz/B3xb4zmRbhF4XgQ/LdEEPR
	 KJ9t4XJyIyKJJEJKOl5j6uzGCnRYxWudTX+wLjxX5JcucXO4XL0QdVPIO0Vptbz935
	 QP2ixRUc9CbXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] coredump: prevent TIF_NOTIFY_SIGNAL from interrupting coredumps
Date: Wed, 28 Oct 2026 19:34:23 -0400
Message-ID: <20261028233404.2437969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102820-lend-elastic-275c@gregkh>
References: <2026102820-lend-elastic-275c@gregkh>
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
[ sashal: Moved the guard from vfs_coredump() to do_coredump() before override_creds(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index f92376a45cd4f..2e97cda5f0fe4 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -632,6 +632,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	if (retval < 0)
 		goto fail_creds;
 
+	/* Task work must not cut the dump short, see signal_pending(). */
+	guard(no_notify_signal)();
 	old_cred = override_creds(cred);
 
 	ispipe = format_corename(&cn, &cprm, &argv, &argc);
-- 
2.53.0

