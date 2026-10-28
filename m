Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201851;
	b=XfMiwwwoSeiSV+/ay2Z/unWZASXcVToIpcMS8oVlsMHp5dQYHEMhAeR7fOt0eykbtwxm
	 vJsiwl5pkIb9XEON2q1VhVLLFknvacq4oWU3HDb9GhwQ3FqBgY/wnwA9NTF1KkTEJPdwh
	 UAg4bzcn1VVN98vyXortbkAXb7DW3TAF8KNp3qf2Jx3yVnjsQ2QkWpAswp/swTscu/2+M
	 17f2wgzYtTCqkHTkVChrUB5UZLORoSPLNCszPmSbFTLvb+Iyt0buww3aIXRG6BvQbqmjV
	 nat5VqirT39DrWLWZxwME7V8rHXqMa/e5nm4IqmNpU8UqhsdusRr5GR0GHllcxGz3IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201851;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lWO32G06xC0N59DpoD4dIroR1qHDBa59DIbWbVrJjNM=;
	b=KYj7PAF9zOb/ZeH0w8ZpmA2XKuV5RbTr9VCna3UaDxhhMGlMXb51ewcg8eAJJMotek8m
	 7LoxIzz8AgZrE9mLjPdlIuD1TqVKUnZO/wqg0O5R97feN/mK/KeMn3xoTxH35AaduZVfX
	 naHu89r+4y6iN3pMmLbgtLU8U0bPWO2MHpGMuEfJEZgmsImGkAPdfvXlJvxtoxjh0o4WP
	 529+ak2exktjL8JBt00uYjljTAxBP4tjfhqDcNTvZ1qWVAglcqJyUGSNesL1sgM0tIYvB
	 MENObrXTpi1d/Xioxde1PqtjuJpYXShm0dH84DrYSrVujRxfO0xb4Ku3VDrc0gsA3Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lrfLnTaI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB0606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lrfLnTaI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49B31F01828;
	Wed, 28 Oct 2026 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201851;
	bh=lWO32G06xC0N59DpoD4dIroR1qHDBa59DIbWbVrJjNM=;
	h=Subject:To:Cc:From:Date;
	b=lrfLnTaIboHqAEsonmF9WQiTDquOpjtAmRJZmV8QGY8+o/hMK/J0iezkoiucjVG9L
	 UtPAEuGbaYs+jUtcyfdF7OQFtg4KF1vS/fXcJp288lBnUMxRuWSgYJ5zNcPde6q6WW
	 1gFphE0iEcH+H5sA9c4ZUPgSrKu/bg/ZqDKMaeKY=
Subject: FAILED: patch "[PATCH] exec: cancel io_uring requests before de_thread()" failed to apply to 6.1-stable tree
To: brauner@kernel.org,axboe@kernel.dk,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:37:20 +0100
Message-ID: <2026102820-emptier-goofiness-f4f7@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b42c85c20d84ff3e4f0f027d6596c3b3b4a20657
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102820-emptier-goofiness-f4f7@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b42c85c20d84ff3e4f0f027d6596c3b3b4a20657 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:45:01 +0200
Subject: [PATCH] exec: cancel io_uring requests before de_thread()

begin_new_exec() cancels the exec'ing thread's io_uring requests after
de_thread() made it the only thread in the thread-group. Now
io_uring_task_cancel() runs task work after. If it runs a
create_worker_cb() item then a io-wq queued on the thread before the
exec creates a new io-wq worker thread.

Said thread joins the thread-group which de_thread() just took down. The
io-iwq sticks around until it notices that its workqueue is dying. But
code after de_thread() relies on being single-threaded.

Move io_uring_task_cancel() before de_thread() but behind the point of
no return. Any worker created during task work run from
io_uring_task_cancel() is just a sibling thread that de_thread() will
take down and reap.

Once io_uring_task_cancel() returned the thread has neither a task
context nor a workqueue left so nothing can add a thread behind
de_thread()'s back anymore.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/aq0_lvHDViIpX_Mu@redhat.com
Fixes: 3bfe6106693b ("io-wq: fork worker threads from original task")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-12-8e4adb1619e6@kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/exec.c b/fs/exec.c
index 745f6eb5279e..bf143ee3acb1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1148,16 +1148,19 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	bprm->point_of_no_return = true;
 
+	/*
+	 * Cancel any io_uring activity across execve. This runs task work
+	 * that may still create an io-wq worker, so do it while de_thread()
+	 * can still zap it.
+	 */
+	io_uring_task_cancel();
+
 	/* Make this the only thread in the thread group */
 	retval = de_thread(me);
 	if (retval)
 		goto out;
 	/* see the comment in check_unsafe_exec() */
 	current->fs->in_exec = 0;
-	/*
-	 * Cancel any io_uring activity across execve
-	 */
-	io_uring_task_cancel();
 
 	/* Ensure the files table is not shared. */
 	retval = unshare_files();

