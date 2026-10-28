Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201900;
	b=XjTSkzwBaL0C8GrydmKyi1Y/7NUebmGVFg8DSc8dW9ElIJl9MuWgyj1ovVzWzb8fOdgG
	 7WSKA8HV87IjIMfwERITYsvIKSwZCEAYklKfWOOslvy7hnNNsKlEuK4I0XDt2Y5No20cm
	 zEmeaoj1PZseA4T+5pzdq/5YzAvHsZVCinmxNSnz/4cydQ/AFtGA9fB6t3hczrRylPRLe
	 nQAOH5DSizqkQZOy7HcfaUlUudzXSDHOp2B/2QYBYAR0IlVkTOlqNmZzMrNaGOAEOZr+J
	 Z9sXHUxY0bfe55qpKgr8w5ylPZFpSkmswQJsfvdVuazAstAd64uXbSf/Y8qP7Sh9w4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201900;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zVUJDbgqlqC1O90xK21cuYfa+YewgFyS45fWDAHH8To=;
	b=K4RcIlfs+fsVeujENLxK4Kl/mnbuHX9tAwflO/XtroOaAvRtkriIA7parpWl6x8Ph/A+
	 22VZJ++rt1RhMovjxc9Ke4hCFOa28jIUsY3Wh+CkAfcooRJzTCLg62/LJ9VPUXScsf8zk
	 AQYjJxZ+SD3ClqLbRyDHhjz6M+r3yulCRtLZdbtkYlfjGb0hCwJKH5qgWOjWiPkmY1w31
	 jEEC70G6/Ozj+yE+LRMB63LY7GTCkEc4taJ6pU7drritsZzc5rSYO3hzJ9pIJTNdMLkn8
	 AGKZmIigmfCj203ALcZ819X2/WnYqpnY9QLj36t2k/r0FDoQ02qrsAFILypCBqCKA3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZKEKtdHw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D8606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZKEKtdHw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407AD1F01829;
	Wed, 28 Oct 2026 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201899;
	bh=zVUJDbgqlqC1O90xK21cuYfa+YewgFyS45fWDAHH8To=;
	h=Subject:To:Cc:From:Date;
	b=ZKEKtdHwg0gXRNak23kc4KPdQOHkHcIYKUAgzbofuzuzFaLMLt65BUpB/MXmL/iLJ
	 LaVB/51tQVxfCKxXJLr6Hjq6a61KpBOFKJpK50m93WXneUKTgddsapB8/1pBxHjajk
	 S7pqqyW1l+H6jZ2oKzv8wwW2Aa8zP8/eYNJstKXE=
Subject: FAILED: patch "[PATCH] coredump: prevent TIF_NOTIFY_SIGNAL from interrupting" failed to apply to 6.18-stable tree
To: brauner@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:38:18 +0100
Message-ID: <2026102818-slander-stove-d034@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a58d647acfdc62561f3570d114025b3bf38ae41b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102818-slander-stove-d034@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a58d647acfdc62561f3570d114025b3bf38ae41b Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 24 Aug 2026 14:08:17 +0200
Subject: [PATCH] coredump: prevent TIF_NOTIFY_SIGNAL from interrupting
 coredumps

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

diff --git a/fs/coredump.c b/fs/coredump.c
index ac3cd74808c6..7c0f276c3e0d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1191,6 +1191,8 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	if (coredump_wait(siginfo->si_signo, &core_state) < 0)
 		return;
 
+	/* Task work must not cut the dump short, see signal_pending(). */
+	guard(no_notify_signal)();
 	scoped_with_creds(cred)
 		do_coredump(&cn, &cprm, &argv, &argc, binfmt);
 	coredump_cleanup(&cn, &cprm);

