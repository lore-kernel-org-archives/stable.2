Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201631;
	b=1+oLhSdetEHZdi1oNK48MagC14DA6cIXw8/pv/GOto2ZnHMmgxakQNEFtBW7mnTV1zXL
	 NqLQzWNcVgeB1wC5/m8KFZEoWDkpIeKVnwTsD1rs+n3Aub+dH0T7uEFF6/Rrhh8kf6zta
	 MMhY+JUDTpyHNiUErJtNSY1e+ngRuBcwOBzo3FHg8cIIpylrqt97l0luY/OOERFe6lCGL
	 pe56MuevG+TQRkjfMwcSzbRZeuwFP1b2ZvBYu9YzN0/xn46UCShc69ERFWLmrSmnHT3HG
	 YbdZJTk70YtJ3KoieoLTCKDAz/bNvLj9A51EX99NwLmoJ38CRQ7nSIXMcWiTKIAPY2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201631;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CRhXEqIPe1yrqE0G6SxuPwseknzIZkMpb2TchfbWJDQ=;
	b=gA491KbZGeBlAZOLsAJNIdwTHvnSNUa8slZvWEHyJhPxqIbW6ta/DlbR+HS4hYlVyfLW
	 TcsJXsR9+4ISrOq646ZAmQsS8oW/8MFEtCfX70QtTu83Ajk3+1CLeKYdadLkIFHDNsCB4
	 PXfVilUYye85doF8GU9OvuWYzH2IOr9Apd77H+SPSaYUx0eDZwK33ZhCXlueGo1n3UBmr
	 J47G6Y5p08IudNTA4LPuhUBzPA9CoLKpWfI4Rmw/35BEDx/nWWuubC7bm6iiG05j348XE
	 45CZJLvbppK7cX1yNpl7L4oqCycSNdZYH2KNPnANDtAxh4mZQFAyFU4SB+sVLVs+QKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TRsX5LHe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D4606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TRsX5LHe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF2E1F01825;
	Wed, 28 Oct 2026 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201630;
	bh=CRhXEqIPe1yrqE0G6SxuPwseknzIZkMpb2TchfbWJDQ=;
	h=Subject:To:Cc:From:Date;
	b=TRsX5LHeaadVxdX1sx58V9gGmXfERGiuUxpvd+XAe6H86tXD/kQSel45Gr0xJjcKV
	 PFLR0QuoHMKrwMDM0+OxmdPUt65v/+fZnF8IROj0NV/UaROFmCxqJhvyrJUawqd/0O
	 +PCR9FdZxIqbLsvTxcrNcmsG/d5KfHE8EXmQdejA=
Subject: FAILED: patch "[PATCH] fork: don't create io threads once PF_POSTCOREDUMP is set" failed to apply to 7.3-stable tree
To: brauner@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:33:48 +0100
Message-ID: <2026102848-foster-escapade-ec01@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 1f978881ce6c9ac4f4d4a7b6a6e52339eadcd350
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102848-foster-escapade-ec01@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f978881ce6c9ac4f4d4a7b6a6e52339eadcd350 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:45:03 +0200
Subject: [PATCH] fork: don't create io threads once PF_POSTCOREDUMP is set

zap_process() skips every thread that already has PF_POSTCOREDUMP set.
Such a thread is past synchronize_group_exit(), so a coredump can't
catch it anymore. It isn't counted in core_state->threads_remaining and
it isn't sent SIGKILL.

do_exit() sets PF_POSTCOREDUMP in synchronize_group_exit() and calls
io_uring_files_cancel() right after that. The cancellation runs task
work and a create_worker_cb() that io-wq queued before the exit creates
a new io-wq worker from there. If another thread started a coredump in
the meantime that worker joins a thread-group which is already being
dumped. zap_process() never saw it so it was never counted. But when it
exits it sees signal->core_state in synchronize_group_exit() and
decrements threads_remaining like any other thread.

So the count reaches zero one thread early and the dumper leaves
coredump_wait_inactive() while a thread it counted is still running.

The task has no fatal signal pending because zap_process() deliberately
didn't send it one, and it never went through get_signal() so it doesn't
have PF_SIGNALED either.

Refuse to create an io thread when the creator has PF_POSTCOREDUMP.
That costs nothing. io_uring_files_cancel() raises IO_WQ_BIT_EXIT
before it runs any task work, so a worker created from there only ever
gets to exit again, and io_should_retry_thread() doesn't retry -EINTR.

Clearing PF_POSTCOREDUMP for the new thread in copy_process() was the
other option. It makes the worker a thread like any other, but it only
helps while the dump hasn't started. A worker born after zap_process()
has run is invisible to it whatever its flags say and still decrements
threads_remaining on the way out. Refusing to create it covers both, and
then no task is ever born with the flag, so there is nothing to clear.

Moving io_uring_files_cancel() ahead of synchronize_group_exit() closes
the same window. It runs the cancellation, and whatever that can block
on, before the thread announces itself to the dumper. A thread that
blocks there never reaches coredump_task_exit() at all, so the dumper
ends up waiting for a thread that never parks. Refusing the creation
leaves the cancellation where it is. But it's very ugly to run io_uring
work even before we did all the generic exit work.

Fixes: 92307383082d ("coredump:  Don't perform any cleanups before dumping core")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-14-8e4adb1619e6@kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/kernel/fork.c b/kernel/fork.c
index 0489d11656d9..623eaead3747 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2700,8 +2700,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.user_worker	= 1,
 	};
 
-	/* A creator past its fatal signal gets no thread. */
-	if (current->flags & PF_SIGNALED)
+	/* A creator past its fatal signal or its coredump point gets no thread. */
+	if (current->flags & (PF_SIGNALED | PF_POSTCOREDUMP))
 		return ERR_PTR(-EINTR);
 
 	return copy_process(NULL, 0, node, &args);

