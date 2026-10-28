Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201854;
	b=uZfZY0cwCb2UopSKyOpDU/T5EV5c09b4fXX1CkhCF0WVQfepXNP5uExDdw7LDs5KKXvj
	 SIzhz5verG0vAlhmDCIc6YbqVz7dERsJBr5+AifUajtU7p7vO/TwY6461BRUiGkLeRmnG
	 mPSD3NFH3wvjfoqipVrJMc+M5cq8Y7xgC+V9A5n1kVEc8FILr4eegZMpNVSgOaadRrckh
	 pAI48fCJ+0xA0mwD6VqZhvweeX6AQjglwkDNrf5BGG1xW2WJbi79pbDDKUYxT+qBriajr
	 2dShxlsXYf/gS1sYzSXctI/rAPzGOjmsbIIvE1+UNSL8VkZKy9YZTlrfxKtvm8gPJmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201854;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Voc8yJK355seTjg1M4WQ9lGN4cvzEqE8tRF5yYzAR/8=;
	b=j/CsAwNzstNXGeh/qn9YzEIA+M4sfd3jhOUIyz+57b7yEcJg/2myRa5R7XyNPJiyAnnt
	 mPCOmyeS/p1HgxrkeH1818l1euaoiSThjEZpmpnm5RABWPjKM8GQMDwBnjjxP3Xb7iAKa
	 EsHRwdjbr15/hCH/fA+dZkSUfuVqydmDbMr7ZHn5Vp3binTgoW7PXVWgYF6rlQFcavEGr
	 r+vyz0/NwzI2wdJdTr9y7h0OIh6PS+Jc8J5mt3uZ4e8bUcpTgc6IHVNrWVPjtEQB0urEQ
	 qxusP43l+iZfR2J9Cy3njSg/+oeD4kWN1VRH5AeUaBkicsqqft71ZRhkDEHJbHL0q5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cB7axu4D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E52606A327
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cB7axu4D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2501F031E8;
	Wed, 28 Oct 2026 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201854;
	bh=Voc8yJK355seTjg1M4WQ9lGN4cvzEqE8tRF5yYzAR/8=;
	h=Subject:To:Cc:From:Date;
	b=cB7axu4DUEIh/L1VElgKmKEXx3TaMfpCu3Feb0pXqeUoA1HwrOWvZe2VJxyzwMfhF
	 nxWz3NKfGgjghpF1lUOLgsSUUxmgqbIbDOwHLmrFlM/WT7ZodgvCgwFoRoErnnhdrd
	 T/2G3M/BBJ9Kgp74K5iMAZgdge7ept3DJQBYKpt0=
Subject: FAILED: patch "[PATCH] exec: cancel io_uring requests before de_thread()" failed to apply to 6.6-stable tree
To: brauner@kernel.org,axboe@kernel.dk,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:37:20 +0100
Message-ID: <2026102820-majorette-entwine-2e07@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b42c85c20d84ff3e4f0f027d6596c3b3b4a20657
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102820-majorette-entwine-2e07@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

