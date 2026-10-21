Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594150;
	b=P7qa2H2pYPdv5Qexpbc9rmoBETtMUNusZlOGmGSw4jE0SJBN8PWYlFFCsTT5udMMGbxf
	 q8qG8svvJc6nqsuHJHrgpfHz3VgXCZZiglbuYanjXouZf5SG4muSDMRAD5PYHqke61b9g
	 Tuh0nu7tsvPH5ZJfyMC78w42EqIWjcclImrFqZb+w4F2vzG9i1jgCcJF1dRPd9hdmlRRI
	 1uinqhBVuGR3ZmTkYwvyeJHudIsswWPAgt2G7gCncp472MkjY9bdJYeaoilVElm/upTwF
	 eWC2z8d1jCnQBGjGqnvAULxAxO9ArbITNjR4ezNCMc+4QyiK3HAPxKoey2rOT5jaitg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594150;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kMg45BOjMLYWMhfx1TKvb07bTgv3vsYeVoYQLLHbfMY=;
	b=QOJkEgJ/MNj9kkyCsRa/puE75mK4xLo6wK4q+Cv84pcvP+E8VR+lU4Niv+YU/jpvEXaU
	 dAlN5tXkw1IflGMrD6/LnbLERnWWZUPTlQ3z+I/SwWICRfAYra7XDFDjx8vNanAtgAIXd
	 iEIZT142KDDR13NjK98XJELEvb3lbCxy71Cr5hDgyur1uClVJvSMp9aUOXAWPanYUMRzO
	 loXoeECx5x2AcqL1iLFCkHhu5DWvWIKoxMce3RxrtZiBpV8r4sqlBZho4TxbHzbuen+yc
	 TXvKNGY0bR7G9St8un4wvzN1zxvKYfYHGAdbboDdRJ3dbR6rqylGu8s/IkdtcmpRBKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IzSEkvMw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FE606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IzSEkvMw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A31F1F000C4;
	Wed, 21 Oct 2026 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594150;
	bh=kMg45BOjMLYWMhfx1TKvb07bTgv3vsYeVoYQLLHbfMY=;
	h=Subject:To:Cc:From:Date;
	b=IzSEkvMwayfxkJYHW1ID5NQHrAgTPSeweiLiIw8hbcFYjt4tste+Lfcomcee2svef
	 PGZuxIAitZfEICIjdHYgeoVwOCt20vTnJISxefSyDUVsQTVOh3wMaCaPM1Chnpu5hl
	 KvrG9rg0ZMzg2YceXzILFJWW3xUWxMgTk+SXHj8k=
Subject: FAILED: patch "[PATCH] pid_namespace: make zap_pid_ns_processes() freezable" failed to apply to 6.6-stable tree
To: vaknins33@gmail.com,brads@mainlining.org,brauner@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:36:59 +0200
Message-ID: <2026102159-hunchback-poppy-cf49@gregkh>
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
git cherry-pick -x 81933038f5e273d17ed22792f906889393b204c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102159-hunchback-poppy-cf49@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81933038f5e273d17ed22792f906889393b204c5 Mon Sep 17 00:00:00 2001
From: Aviv Vaknin <vaknins33@gmail.com>
Date: Fri, 2 Oct 2026 23:28:20 +0300
Subject: [PATCH] pid_namespace: make zap_pid_ns_processes() freezable

When the init of a pid namespace exits, zap_pid_ns_processes() waits
until all other pids in the namespace are freed. A tracer outside the
namespace that does not reap its traced zombies keeps those pids
allocated, so this wait has no upper bound, and while it lasts every
suspend attempt fails:

  Freezing user space processes failed after 20.006 seconds (2 tasks refusing to freeze, wq_busy=0):

Neither wait is freezable. The first loop sleeps in do_wait(), which
returns -ERESTARTSYS on the freezer's fake signal; the loop then clears
TIF_SIGPENDING and waits again without ever freezing. The final loop
sleeps in TASK_INTERRUPTIBLE, and since nothing clears TIF_SIGPENDING
there, schedule() returns immediately after the first freeze attempt
and the task spins until the wait ends.

Sleep in TASK_INTERRUPTIBLE | TASK_FREEZABLE in do_wait(), so that the
freezer can freeze tasks waiting there directly, and in TASK_IDLE |
TASK_FREEZABLE in the final loop, like coredump_task_exit() does.

This was hit with Chromium-based browsers: crashpad ptrace-attaches the
threads of a crashed renderer, which is a pid namespace init, and does
not reap those killed during the dump.

Fixes: 3eb07c8c8adb ("pid namespaces: destroy pid namespace on init's death")
Fixes: b9a985db9896 ("pid_ns: Sleep in TASK_INTERRUPTIBLE in zap_pid_ns_processes")
Cc: stable@vger.kernel.org # 6.1+
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Aviv Vaknin <vaknins33@gmail.com>
Link: https://patch.msgid.link/20261002202820.3433318-1-vaknins33@gmail.com
Acked-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/kernel/exit.c b/kernel/exit.c
index 282328d2b4cf..ba1469bea8fb 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1729,7 +1729,7 @@ static long do_wait(struct wait_opts *wo)
 	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
 
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 		retval = __do_wait(wo);
 		if (retval != -ERESTARTSYS)
 			break;
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index d36afc58ee1d..4ade0f37ed54 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -268,7 +268,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * free_pid() will awaken this task.
 	 */
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		if (pid_ns->pid_allocated == init_pids)
 			break;
 		schedule();

