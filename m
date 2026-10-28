Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201988;
	b=gvotz/smeEoqDwF7y2/sUUNXfkO0D+/XcOrKZsbjKIIyWmVLXUTqc5eimhsplYLEZmC/
	 lBowtyRRbRswFZIh2EIJ1vihCagXSndIcE+2evYyZTr7tgR2DFURkaLK/FwjF9i0AOC5O
	 F8S4HzWnXASr1DfPLwDCSwrnA2C1NIULhHFuW6+h8zjtRpBjI6oyiDzdQ9TDcqDP0AhVL
	 Pg/TyaO8WCLrLJ2uvPczuB6TSxpWWpaqO2ClzWVQQPaQUMh3AFeGKsVVzM03+EO3oOc/9
	 kDQ8QPFzWfiqlxwi+lXtaI+EFkrYHI52+AwiCnscHnUsvIm5x7MpJMSK1GgURi70dqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201988;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2iKcK+l7u13R2XKq63G1o5YBL0j7uUm2eO8hCG+5el8=;
	b=xOy9BMTXl2c43JdZ2m4ri1wmxPLRvUb0rJoNmja7IUR0Vilrfz92gmcKkD1dLjL92o13
	 8WsKzowqlD0rx8fTZHbH8/062ovleZve6/CZbZAZ1A87NNhpOqvSrGAWB+qUoO6PFyJfR
	 +vIII6a/HFtCgWi666TjYQ18A85A3jfxRerljuH3jZlLJlVTbNaR0cSkgXkAn14W/UNz6
	 QtCfRfNwC1vhEoyCRK/P/3ZjjeI6jBWkw5w+XdM/xcA2oQAzS2KlLd9ZNVY2ikP3wi2V8
	 9438hKA4zVNQGYT4tPcPuQsKMtznpU1fB0ZHZBR5dVCIpt6bsYYLTQVkvdqDBOvDcYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CUQdCa6k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC0606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CUQdCa6k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E0F1F01825;
	Wed, 28 Oct 2026 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201987;
	bh=2iKcK+l7u13R2XKq63G1o5YBL0j7uUm2eO8hCG+5el8=;
	h=Subject:To:Cc:From:Date;
	b=CUQdCa6kPscyu7vYLWhFhQpB0ZdZhzZ5vov7gsfLVkVp7+zmU+jApQzJuhDcFUQKQ
	 rIwgAKJUeYci8ZV6lz/iOzV3DdKt4Tbe38jL/E9Gagf2eArtQ0dbttT8LSVIGhi4Hz
	 NOBSy6b1VKNkTZ7WJ0d3QUtcQ6tR+TWLIrVWDoVQ=
Subject: FAILED: patch "[PATCH] signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL" failed to apply to 5.10-stable tree
To: brauner@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:39:38 +0100
Message-ID: <2026102838-repayment-hyphen-7ccb@gregkh>
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
git cherry-pick -x 22b7f491be8f93ff72de0a3fe02b8ee9e64d3f21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102838-repayment-hyphen-7ccb@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 22b7f491be8f93ff72de0a3fe02b8ee9e64d3f21 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 24 Aug 2026 14:08:16 +0200
Subject: [PATCH] signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL

TIF_NOTIFY_SIGNAL is used to kick a task in uninterruptible sleep to
return to userspace and run task work and then go back to sleep. This
mechanism works well but breaks e.g., coredumps. dump_interrupted() only
allows fatal signals to interrupt a coredump and the whole regular write
path going to actual filesystems is impervious to TIF_NOTIFY_SIGNAL as
well.

Add PF_NO_NOTIFY_SIGNAL and helpers to raise and restore it. This is the
same approach as memalloc_nofs_save(). signal_pending() will not report
a fake pending signal via TIF_NOTIFY_SIGNAL if inside a
PF_NO_NOTIFY_SIGNAL section.

No functional changes.

Link: https://patch.msgid.link/20260824-work-tif_notify_signal-v2-1-6609e42b3157@kernel.org
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8b3d47a325cc..e431c4195bf0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1816,7 +1816,7 @@ extern struct pid *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF__HOLE__00800000	0x00800000
+#define PF_NO_NOTIFY_SIGNAL	0x00800000	/* see no_notify_signal_save() */
 #define PF__HOLE__01000000	0x01000000
 #define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 584ae88b435e..6164995da980 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCHED_SIGNAL_H
 #define _LINUX_SCHED_SIGNAL_H
 
+#include <linux/cleanup.h>
 #include <linux/rculist.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -384,14 +385,36 @@ static inline int task_sigpending(struct task_struct *p)
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }
 
+/* Prevent TIF_NOTIFY_SIGNAL from interrupting this task. */
+static inline unsigned int no_notify_signal_save(void)
+{
+	unsigned int flags = current->flags;
+
+	current->flags |= PF_NO_NOTIFY_SIGNAL;
+	return flags;
+}
+
+/* Restore the previous PF_NO_NOTIFY_SIGNAL state. */
+static inline void no_notify_signal_restore(unsigned int flags)
+{
+	current_restore_flags(flags, PF_NO_NOTIFY_SIGNAL);
+}
+
+DEFINE_LOCK_GUARD_0(no_notify_signal,
+		    _T->flags = no_notify_signal_save(),
+		    no_notify_signal_restore(_T->flags),
+		    unsigned int flags)
+
 static inline int signal_pending(struct task_struct *p)
 {
 	/*
 	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
 	 * behavior in terms of ensuring that we break out of wait loops
-	 * so that notify signal callbacks can be processed.
+	 * so that notify signal callbacks can be processed. Not for a task
+	 * that asked not to be interrupted by it, see no_notify_signal_save().
 	 */
-	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
+	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)) &&
+	    likely(!(READ_ONCE(p->flags) & PF_NO_NOTIFY_SIGNAL)))
 		return 1;
 	return task_sigpending(p);
 }

