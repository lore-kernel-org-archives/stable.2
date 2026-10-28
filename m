Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201909;
	b=wFTL0PRWLQHs5Hlgk5JacjDy+pWqRbeEWgkvEgk/Q22gR6sePmuCfdK86MNLAtkN3WCZ
	 9/O7AjyJXwaGYjKl0shcIBRPbIOqmp9HFHibecAM38FNKefwQnRy2k8xgo59PVSL4D+dI
	 Df9sCOdGmWnX4pOs+tlYIk0z8RvpmV6iSVBJegKqMytBPi7443ZlLxQ2/Z9HuoQ5IicFg
	 IuyRDqweKdS0sB1eq6RQZCcp407SnVNAqDdVLr//E3AG7wjrMyFbKTMtv+e6xwq3kZSeb
	 /Zn6IqV/mX3AtHb2AcK1zyNR9TpZ4wvTG4g/vmBV7VHQqIL0c+FymcOYPpAYQGOFe3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201909;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=k45//KOxpZv1bM5GQBKpLXN3FLfd25+T7jmxTcf/50o=;
	b=id+V5yfVMGx2KzoYm1o/adV+uSOqst7l3aPTtEgf2+30OljOSNlMcoOK80AMirqUZL8Q
	 bp3z+TROMbTOfBcF021NNdiMYwP3gKGwtE9IfG+UuauoRIlvifcKPrQ5usk9XkVsoD7WK
	 mkq4EWTRV6pEEsLQBgf6xtJO/i9tPJDb3Usc09bOiZxqcorGt87SpzHD8wUQUbAKwIgh3
	 1vJvIparyLuhMTF64I6Cr6nTDmMQZJmort1W8oVqJqlq/o7dBdqOmStk/riPQyp5JcyQ8
	 MToQBupWRampP3nUfhOw+u2WV/S1VnyIKnFnW3lwimUoBQmjlOC5SMWlTTze8KzqZTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I4VpGTHJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D860606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I4VpGTHJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C931F01825;
	Wed, 28 Oct 2026 15:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201908;
	bh=k45//KOxpZv1bM5GQBKpLXN3FLfd25+T7jmxTcf/50o=;
	h=Subject:To:Cc:From:Date;
	b=I4VpGTHJdqc7dr6IHmljBTO4QSCGthhStXf1CNoByp6Oy9JdoHx3BValGWYDGb7Le
	 vTQsxLlOtQIsfomWOpCTyUXVHK2hkgIb2LIf1oCDWANnZPVFloEPSZMqMXpV1Ljcx3
	 Pk+DVdVTsQEwCevbnaNngqAKRWlRJPhPPJqsVCxE=
Subject: FAILED: patch "[PATCH] coredump: prevent TIF_NOTIFY_SIGNAL from interrupting" failed to apply to 5.15-stable tree
To: brauner@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:38:20 +0100
Message-ID: <2026102820-eldercare-grip-ee53@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a58d647acfdc62561f3570d114025b3bf38ae41b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102820-eldercare-grip-ee53@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

