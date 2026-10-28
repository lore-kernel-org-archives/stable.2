Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197393;
	b=rVTOfSE9RriaZwvWvix/yS8cLtPpPuuuooozHxqm5VZ4EGmnK7Ok6wWqaDlrHT6LbDYB
	 Qu0YMh+PpBIuqiJ51mXaF4tVvKogWK6LYY6uiSDDHMomD0qc/eQGB92Vra+udWPOodCKr
	 ghvpvcxb8Y6NPk0pIgfGUsrwCTLuXKKfDMBJ+8aS/Q5OHbbOooRaUsn2dH5UCz6egVu64
	 mkGVEfxCLpxvmdzIdwv7O8KnPmaJxfKMKsiM8XLYarI1c5nGsUQS+bHV8M8/e1vjqGBlY
	 1Edtg4s1u2pgV3XOb+XWTpHRpJdvl1pTFTrLJNgcejuhMQQp4aJN9LZvyvI9EGyf23g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197393;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EJruIkh0G5UG3h4uiULc5zN04bhJb9yvs4o27ogEjsM=;
	b=JR5yR5qNZkrEeaa+Pp/27juotKwzl3NRbngjso2KyEH9J4AxSfb9E0FSuS10sDSxEKAs
	 GHX2PtfeJjjiK3swuDAZq5KCuO7SfObwXix9g08DRxFgHxYiWF0gbyrHxGsS4mdhZLvF7
	 Hu1c0zDU92qTNsM33JysBTsZQVcCpi4pIeKCW0uTMjyCZZNrWf2PAhAyp17QuhNmZC+kQ
	 3VZpuSCVCfx8Kjjhvf8e06fem0BKMAOcJKD6q3cxUdDx5G3f5gmx8Kt3+prlBmJHV+yoQ
	 0Dl8GjcOHr7n7hgB8xPgXxeGkBlCvGRNSgFciV0Fxd1KjhvAX+OP0w65sPknl41/rtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=D1qiqN6V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D09606A32A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=D1qiqN6V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E85B1F01825;
	Wed, 28 Oct 2026 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793197392;
	bh=EJruIkh0G5UG3h4uiULc5zN04bhJb9yvs4o27ogEjsM=;
	h=Subject:To:Cc:From:Date;
	b=D1qiqN6VoCqIl0FS4OLSDpJg4jLfucnpO6yymu63zeF8BRYqQTRXAn8bq1TR/ifdS
	 oSYIHweWmCdETOC2KpWDZHPUckNrmbx+9hoyN7JUO8Q6Mq06j9GFii+Ze5n/60gHUm
	 uuT62kKCnhnGqfEUoYHCs5X7W8eM+8ldHIqMx3Cw=
Subject: FAILED: patch "[PATCH] coredump: hold RCU while releasing parked threads" failed to apply to 5.10-stable tree
To: brauner@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 15:23:03 +0100
Message-ID: <2026102802-parasite-try-a089@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 61d58591aa0188bf2463e263962256316ff8b576
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102802-parasite-try-a089@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61d58591aa0188bf2463e263962256316ff8b576 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:44:50 +0200
Subject: [PATCH] coredump: hold RCU while releasing parked threads

coredump_finish() releases the parked threads by clearing ->task in
their core_thread entry and calling wake_up_process() on each of them.
It does that without holding a reference on the task and without being
inside rcu.

But calling wake_up_process(task) without rcu here isn't safe. A parked
thread doesn't need that wakeup to leave. A spurious wakeup or a
preemption after the store is enough for the task to go away.

So if the coredump client is preempted between the store and
wake_up_process() the thread can exit and be freed in the meantime and
try_to_wake_up() takes pi_lock in freed memory.

Hold rcu across the loop.

Fixes: a94e2d408eae ("coredump: kill mm->core_done")
Cc: stable@vger.kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-1-8e4adb1619e6@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/coredump.c b/fs/coredump.c
index 7c0f276c3e0d..d88a65e37ee1 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -562,6 +562,8 @@ static void coredump_finish(bool core_dumped)
 	current->signal->core_state = NULL;
 	spin_unlock_irq(&current->sighand->siglock);
 
+	/* A released thread may exit and be freed before it is woken. */
+	guard(rcu)();
 	while ((curr = next) != NULL) {
 		next = curr->next;
 		task = curr->task;
@@ -570,6 +572,7 @@ static void coredump_finish(bool core_dumped)
 		 * ->task == NULL before we read ->next.
 		 */
 		smp_mb();
+		/* Any wakeup now lets the thread exit, rcu keeps it alive. */
 		curr->task = NULL;
 		wake_up_process(task);
 	}

