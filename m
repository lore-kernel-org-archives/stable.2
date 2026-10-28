Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201857;
	b=eywgP5GFWWy6/5u82nB7eLd6MVmc3vrp2BNpRXDxkIYWMLSg1/eIhBqduzPDytPC36VP
	 rzGvKzCIK+HWkZ5IqOZyC+siNcCIma67Nu6ofazr5Er8F5WMUuYAA8BbI1X9by1C+TNIc
	 i6+pY8sQfJ0ThwznXQ5v29+Sft/B/oxZs5vwY1biokqxFdn5iDDP1BD5oFluQ0fcqP89d
	 mrcv4hKEiGUCUJVwZUpBM67PzaUkJWNOaUd06EZPCAQLvzGBvg+T3J8BO2xW+EwoMp4v4
	 ZQ/l4qWylnN8RMsgG14AsrukSCRYrCtNaxS+vAaXBlTWiSwFOu+RMlbygRTa75x16WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201857;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SiW4B/Bly/gkxkXkOO4F3D6Ws9SnXckzMrJ/um4jy7Y=;
	b=kVUgOh8bOG+MFd+plGgKaqdmA6jpvJkPL1FUriuBvIyH780i+5M9ShjE1o37JknkbcLo
	 iq4qkJv43900eMo7HXjdCiao2XzBI/rJAN0m9r9/cL8UlkpfGlbmdzuQThby7B/ZQcn0L
	 23LGjjj+WMAt7IA+OT/jdsqP/BJDIIROe2W2ky1GRdRS1/H4UePwI+VRoYmMCsXfVk3WZ
	 mlYMS7OwcOuGkZv4b0FiFjtMLjLpFISETC0HTne5m/2vSYnUPBUkeVlBFYw2/54Fe5JTN
	 3cPzJCvfgqjeiBJCjPizvw4TQlgYiBPsM5NRXQg5GNrDqJv5tdAmaoDh/ErZkkVnp2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aCuIduu3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ECB60A2604
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aCuIduu3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869D71F031E2;
	Wed, 28 Oct 2026 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201857;
	bh=SiW4B/Bly/gkxkXkOO4F3D6Ws9SnXckzMrJ/um4jy7Y=;
	h=Subject:To:Cc:From:Date;
	b=aCuIduu36QBMYGKH5vn3fYpxuiqLdCG3M/Jh2rGn5LzvkEhnTcOHBqHCfXrAtBatX
	 F0PDSRzs+ywoHdF7DTZoTX+46tImiDL1QJ/KzeSAYyofmdtGmCtpa7IViexcnL1QcY
	 8/6NFDuZyWWEa8Y/5EMAuI8BNn3ITFDv3/XxY7AA=
Subject: FAILED: patch "[PATCH] exec: cancel io_uring requests before de_thread()" failed to apply to 5.15-stable tree
To: brauner@kernel.org,axboe@kernel.dk,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:37:21 +0100
Message-ID: <2026102821-deluge-generic-8319@gregkh>
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
git cherry-pick -x b42c85c20d84ff3e4f0f027d6596c3b3b4a20657
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102821-deluge-generic-8319@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

