Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F047F2EB;
	Tue, 15 Sep 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467771; cv=none; b=nqGJHoRhpuvFbOUAO1vF2jhcjFPxCLgcz0fvWN+0kaW9rtZIcqJ9Vw5++ameBxMdK2PYTokNHGy96aD81h6wHfnO034miqTu9Z1MZi4tB8VBhRQhD0ND0FDiN8gQjhYnUEVwGvVZrwF/f1Y45IUDKR8lVXa6jKf/vo4bSjbEyC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467771; c=relaxed/simple;
	bh=wEE0usJXExKGpjCvpVt43sCmGWJShblWOIA/77PWrYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNTe1rs++IUKG+ZqgNUWwDJmI/n7oUS9qMyZl8tVvd3KLhhVegS4muZXEs0g7q/DZ/MtGZ97VW9C0e5wmWuDJD8jqlUJpXEJm92u7hKawgh1Wdhf5F5NI/aB7rBZFkLDhmxABiES0bOPX7b/w0uo1xDKfsxuoW0LeZmK33rtOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQTXkm7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQTXkm7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D131F000FF;
	Tue, 15 Sep 2026 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789467769;
	bh=+Lfwr6DOZEL712P9mk5S4cinKmJtaSPg9LGMOLkoIvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OQTXkm7POpmghchxaNkGvtcXtdXm76bpQ8ZxWm+B3QBzgU0ST2VFq5KqUnO4hhQRP
	 fFLpGL+t4GwnL4u8J1dRV1HsADNpYBrxbaQn5O6lg4LR4v6IZSM6C5eT89XNZsCk07
	 5H7bvxmABJ1ue7nBzDILxz3qRtSYNktF5IKea38meFXGwe9alGZgZj7Ii0DGfjg0Xf
	 lQrUu+J2PjKq+nNoM9m3AT2y+B2+Mgh3zMLmIs6imZ6P11jUEgQRbGHH96OmszAQhL
	 8oPNePv7lrOfCTeUVKYMkx15tkzRwhxQmeeLu/hdOMPpQqPX4gWIBxdIlauIHKSorL
	 Q1uFe/Ekp4dbQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 12:22:19 +0200
Subject: [PATCH 4/6] signal: only SIGKILL interrupts a coredumping task
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-coredump-fixes-v1-4-f354ca41780c@kernel.org>
References: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
In-Reply-To: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
 io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2928; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wEE0usJXExKGpjCvpVt43sCmGWJShblWOIA/77PWrYg=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGqpHGijRDk4mk14U0sKIqMGh9oPZ352zjxnb7ninkYbALDDp
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmqpHGgACgkQkcYbwGV43KJNmgD/VSH8
 FkLiZlfi+FXpjhT54oVKKQ1kqWXsAMvoIboEKrcA/RXFD5+8zc9AFxnf6PL1yZXmcQkyhk3fWXs
 2ENjyxkYO
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The coredump client only accepts SIGKILL. I've massaged away
TIF_NOTIFY_SIGNAL in another patch series but it seems that
TIF_SIGPENDING also has some warts and causes truncated coredumps:

(1) cgroup v2 freezer isn't built on freezing. Instead,
    cgroup_freeze_task() sets JOBCTL_TRAP_FREEZE and calls
    signal_wake_up() on every task in the cgroup. That includes the
    coredump client. The coredump client isn't able to act on the trap.

    So a freeze that lands in while a coredump is written will block.
    Moving a coredumping client into a frozen cgroup has the same
    problem.

(2) retarget_shared_pending() doesn't take a coredump into account too.
    So if a sibling thread is in the middle of changing the signal mask
    or it exists with a pending signal that helpers points the signals
    to other threads.

    While it skips exiting threads it will target it at the coredump
    client as the coredump client isn't yet exiting.

So it's related to PF_NO_NOTIFY_SIGNAL which I have sitting in
kernel-7.4.signal. We should be able to fix it this time by making
signal_pending() report only SIGKILL for a task
that has PF_DUMPCORE set.

A cgroup v2 freeze now waits for the dump to finish. The PM and cgroup
v1 freezers keep aborting it through dump_interrupted().

Basically, PM should be able to interrupt the dump. cgroup v1 freezers
are legacy crap we don't care about and cgroup 2 should wait(?).

Fixes: 403bad72b67d ("coredump: only SIGKILL should interrupt the coredumping task")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/sched/signal.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 70067ccfe2ba..3a7ff3416e57 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -386,6 +386,11 @@ static inline int task_sigpending(struct task_struct *p)
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }
 
+static inline int __fatal_signal_pending(struct task_struct *p)
+{
+	return unlikely(sigismember(&p->pending.signal, SIGKILL));
+}
+
 static inline int signal_pending(struct task_struct *p)
 {
 	/*
@@ -395,12 +400,12 @@ static inline int signal_pending(struct task_struct *p)
 	 */
 	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
 		return 1;
-	return task_sigpending(p);
-}
-
-static inline int __fatal_signal_pending(struct task_struct *p)
-{
-	return unlikely(sigismember(&p->pending.signal, SIGKILL));
+	if (!task_sigpending(p))
+		return 0;
+	/* A coredumping task only stops for SIGKILL, see dump_interrupted(). */
+	if (unlikely(READ_ONCE(p->flags) & PF_DUMPCORE))
+		return __fatal_signal_pending(p);
+	return 1;
 }
 
 static inline int fatal_signal_pending(struct task_struct *p)

-- 
2.53.0

