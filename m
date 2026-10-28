Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201840;
	b=P3b5DUP6oKjcy4i6J8cQElf28rEuq0+8ZHl8DRRbHrHaLYcTmdviX1zF2v4FQhT8MRzW
	 aCwz8nUbU76U1M7JrXCp4sI3Zeh+bRy/rpkqPF/VmzK9Yj3XD4uLMNGXZ86Ej9yzG32BB
	 vR8h0PeF5Lr5LJvXwM/SsjQwIrsvnOcQXNPtYGIcj9SGaolf69MDma6vf3aGhMqZF1RjS
	 hkHJ/4cYvZLll45XKW6TuCDEeIY2vJ7lgW0fXO+/j2NIryCUyFV2dSDRuGwXcjHBYRJKF
	 CBLowuw0NjmFYa4qvM1X7P7H7OmTXAuzCOrXQ0bPdGGBm1Y5tHKT4RkjNNVtrmag5bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201840;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UaxJsQxI6P+KN8QUBb/0zvjO+eAtP/4lyX44Lovc9B0=;
	b=ruGVh7xVsMI5zFo+9fJDJAgj7ko3XOcjCedb7/lmSifKMdYL3VYdZ9//PQuTMqsTP8T0
	 51tsfUMKZcPPR8Orip7289QMGGQUnGBfhNb2j03K+VAMGFNWOWJatqjADGzPyXgbi4VzF
	 Fa+5WJyakgAqtQPb1FTVXwxRJp+gn1O867xVnR7T7jl4gZOqIoz8+2U1PeUI04qiDZT/x
	 79in5AH7MGMfNZknqNcQafxGo5voEAx1pT2m2SBr+7C8NFpjWz8Pyp9NH96rxDoeJImoT
	 uBv6H7ExKVe/Qzf6uoNKXRNeM08gvO2ABsPNCRSjMPQfbZ063zN9G/uOHqxfRa/tqcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=scuNp4MV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98F606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=scuNp4MV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686441F01825;
	Wed, 28 Oct 2026 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201839;
	bh=UaxJsQxI6P+KN8QUBb/0zvjO+eAtP/4lyX44Lovc9B0=;
	h=Subject:To:Cc:From:Date;
	b=scuNp4MV/Q+KljYeGD34zbW04Lm4k77UEhS5LuSRUy2axKhZZkhG9dK0KkxnERoGp
	 9/oz3hMrmu1kPXXUOZ2iZ/A2kd0oTP5QktUn5NOlGCsxzVsD0kUJP9loKjaxziePn8
	 E1NyMmfzvVSyc81GRX56Z0Ui6YbhcXyOw/u9c/zI=
Subject: FAILED: patch "[PATCH] exec: cancel io_uring requests before de_thread()" failed to apply to 7.3-stable tree
To: brauner@kernel.org,axboe@kernel.dk,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:37:18 +0100
Message-ID: <2026102818-cauterize-secluded-dd6b@gregkh>
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
git cherry-pick -x b42c85c20d84ff3e4f0f027d6596c3b3b4a20657
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102818-cauterize-secluded-dd6b@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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

