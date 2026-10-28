Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201639;
	b=1TJjVaJuQwwKLouR8dfE2Eturdbaov4G2Nzz+qKfXJtp/8M7JsNSOLvO5969mfsVBFZu
	 /x0ID9IDGj84pa7sBe/JU1e7GI4x/Xorqnzj/oaWXxRQC1pyF1dsd1ixf6NyqLDQEtL87
	 eR4YKBZH2oh0TECzzMaqoJgR3jUTt8o1Er7X+KfD6/984DXT5X7aA6+sJX0YCk3UBHz4k
	 DmxjmJRzv6eEI1c6hHYIm41xJjVvwJM98HezSgjOc0nh7uwgxc1vsHt7SnWrEfZd2lXP3
	 QRSjyQLO78942R24DJYvJAd+fOs71fFg4eZTdv+esCPc65Oae7fhHCsd6S5H26EKHDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201639;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LOVUEyry4m8xuJjz3vnYyxNR0yzKTLdPrALqR8fEPf8=;
	b=3gapP9xqDYH1WeqeDWQg8rsYXLu41F3+ekux2n07gjx6Qh0IaUpSDl2qwJo273YZzlmP
	 CG0VbYESTW+GskWBo9sGB1Qj8xO8bwhsG/VS4kO1FZsCoOgiDB/UCCJG1cMgA3N7rQVX5
	 +mvOCgZQwnQhdVMxHUvisVt5I8s5uc2PVxzdCeLbAIGQNs1ckHwnCMk/yx5kExgdY7wC2
	 opnNpLNRbkHDZIKWHEsCpj+hEYHRjmKhGxm2sK5JXQ31HMRgX181N68itOM7U1cHI1GVt
	 G2wsnyW1CqiSVzC1JJeffnBoxaH6Rsgv8zjFf3UfpE3vAyja0OZa7JGCaJiatkUd07A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qcnJ3XPo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B10606A320
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qcnJ3XPo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE01F01825;
	Wed, 28 Oct 2026 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201639;
	bh=LOVUEyry4m8xuJjz3vnYyxNR0yzKTLdPrALqR8fEPf8=;
	h=Subject:To:Cc:From:Date;
	b=qcnJ3XPoXMaVS3Y2fEhv/qt2kf7sxm2kUvjFcmPxh2NOPTKnuB7RWSZUgHZh1ckA2
	 eOpG81NqZgnitHtM4VRvkwXEpLC/PmIxY5gnFggMr4NvvgQsJ4TUKM6Ak/ygkl9hEc
	 pFk3NWTsvOTPktjT0C40aEWInXZUmQVuY/xTInxI=
Subject: FAILED: patch "[PATCH] fork: don't create io threads once PF_POSTCOREDUMP is set" failed to apply to 6.18-stable tree
To: brauner@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:33:50 +0100
Message-ID: <2026102850-pulverize-satin-96a4@gregkh>
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
git cherry-pick -x 1f978881ce6c9ac4f4d4a7b6a6e52339eadcd350
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102850-pulverize-satin-96a4@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

