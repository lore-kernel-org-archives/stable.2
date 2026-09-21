Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C84A0924;
	Mon, 21 Sep 2026 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998316; cv=none; b=aKKDNPCcCCNhS8IhW5n38EQ4cV5qnXNM83N1V1IDBx+oidyE8tXQCZZMC+TM1ILFPip8jb4Btk6ItAqgMh0w+j0T/0Na62aU1CwLGP8IxZUuxV9MXb6CfbkfShPAoY3HOE01K/sMyS4LWXfc1kDFCMo3dfdZfn+1E7qi0iE9W/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998316; c=relaxed/simple;
	bh=n9hqLTkr1UKDpZ1DUBe7OO3QGqWNQ/aVSUNWWIZ+U44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BtWNdOVXUfzX7do9WSAyF1jMhaOottETVq+DEBVnyCBs6eO8CCE+xRZ+FfLjlJTPleCCUaOPzkPl263llj4K0T3faXgS+9OOE5NfNnKGFifCbpt9lPv4zs7ggoBAfWe50PGHeBvC0vOrI49KXrQN+YpW+3fNeB/QwOpxMDxI/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQaykdOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQaykdOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FD21F000FF;
	Mon, 21 Sep 2026 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998314;
	bh=Tj3627/NuZDLjqO8cCUQuxO6pF+QtBI46eNLi+WZiXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LQaykdOC7cc03wXUxrEHY3T5hMqaVe96MJ74zXFagPQtrJvZeCaChDs/+C1uTjBV5
	 KCesZfy7e2qtnvumDKhICwnZjA1cS4levVHc/8gxqH5knI+KuyHia2ii4tI8nF9w9x
	 i6+8qIHo8PGHXDskCam3ux+1ntN2X39BacD2ZcBjktmk5zI8tg5RlkEqQFUZHdp+42
	 z5flDyW1l8M1XCR+Xo/wEIIcHq29PbnS3dDNJ/rpMIsVnoqlAGBXpjfGg72C67+mNt
	 CMuu9a4bXs7jMWNgdpN1LxrFIxvaSCNKGgvDN/m9nSovLzqjU3fET2/y7jabA7Z8fL
	 nt7DiSKnOz4+Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:44:51 +0200
Subject: [PATCH v3 02/17] signal: only SIGKILL and the freezers interrupt a
 coredumping task
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-2-8e4adb1619e6@kernel.org>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
In-Reply-To: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Chris Mason <mason@kernel.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-mm@kvack.org, io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4764; i=brauner@kernel.org;
 h=from:subject:message-id; bh=n9hqLTkr1UKDpZ1DUBe7OO3QGqWNQ/aVSUNWWIZ+U44=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLnz8VRB43O3Ym2WRX81HGfG/VEz2HZAYWMZc6p0/
 DvR+E/6HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxN2ZkWNI+taQ3sIxzLduR
 qxK2MgpXzpU8jzxqenHT8/b7VTwz9jD80zjdnyNl4cd/aotl8sa9E/KKsl8Wcx1L2+Ziqr1PiPU
 JBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

For quite a while now coredump has allowed either SIGKILL or freezing to
interrupt an ongoing coredump. Since we seem to like it complicated
"freezing" can mean a lot of things:

(1) Power Management induced freezing
(2) cgroup v1 freezer controller induced freezing
(3) cgroup v2 freezer controller induced freezing

So (1) and (2) are handled by checking freezing() but (3) isn't.
(3) uses cgroup_freeze_task() which sets JOBCTL_TRAP_FREEZE and calls
signal_wake_up() on every task in the cgroup. The trap isn't handled by
the coredump code.

Which means the current logic is inconsistent. Power and cgroup v1
freeze and abort the coredump. With cgroup v2 it depends on where the
core goes. A dump to a file completes and the cgroup v2 freeze has to
wait for it to finish. When dumping to a pipe or socket the dump is
interrupted at the next write because of trap's TIF_SIGPENDING. Which is
it? Let's be consistent and align (1)-(3): freezing interrupts an
ongoing coredump and doesn't make it wait until the dump is done.

So make signal_pending() report only SIGKILL, freezing() and the cgroup
v2 freezer trap for a task that has PF_DUMPCORE set. freezing() lives in
linux/freezer.h and is a static branch. So keep that check a separate
helper instead of in signal_pending() itself.

Make dump_interrupted() check for JOBCTL_TRAP_FREEZE as well so a cgroup
v2 freeze keeps aborting the dump like PM and cgroup v1 do.

Fixes: 403bad72b67d ("coredump: only SIGKILL should interrupt the coredumping task")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                | 11 ++++++-----
 include/linux/sched/signal.h | 19 +++++++++++++------
 kernel/signal.c              |  8 ++++++++
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 6c0c597ec324..40eca2b85b81 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -580,12 +580,13 @@ static void coredump_finish(enum coredump_state state)
 static bool dump_interrupted(void)
 {
 	/*
-	 * SIGKILL or freezing() interrupt the coredumping. Perhaps we
-	 * can do try_to_freeze() and check __fatal_signal_pending(),
-	 * but then we need to teach dump_write() to restart and clear
-	 * TIF_SIGPENDING.
+	 * SIGKILL, freezing() or the cgroup v2 freezer trap interrupt the
+	 * coredumping. Perhaps we can do try_to_freeze() and check
+	 * __fatal_signal_pending(), but then we need to teach dump_write()
+	 * to restart and clear TIF_SIGPENDING.
 	 */
-	return fatal_signal_pending(current) || freezing(current);
+	return fatal_signal_pending(current) || freezing(current) ||
+	       (READ_ONCE(current->jobctl) & JOBCTL_TRAP_FREEZE);
 }
 
 static void wait_for_dump_helpers(struct file *file)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index e039e29cd8c5..3835fbf7d80f 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -384,6 +384,13 @@ static inline int task_sigpending(struct task_struct *p)
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }
 
+static inline int __fatal_signal_pending(struct task_struct *p)
+{
+	return unlikely(sigismember(&p->pending.signal, SIGKILL));
+}
+
+bool coredump_signal_pending(struct task_struct *p);
+
 static inline int signal_pending(struct task_struct *p)
 {
 	/*
@@ -393,12 +400,12 @@ static inline int signal_pending(struct task_struct *p)
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
+	/* A coredumping task only stops for SIGKILL or the freezer. */
+	if (unlikely(READ_ONCE(p->flags) & PF_DUMPCORE))
+		return coredump_signal_pending(p);
+	return 1;
 }
 
 static inline int fatal_signal_pending(struct task_struct *p)
diff --git a/kernel/signal.c b/kernel/signal.c
index ec30550951ec..d8bb1f168055 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -717,6 +717,14 @@ void signal_wake_up_state(struct task_struct *t, unsigned int state)
 		kick_process(t);
 }
 
+/* Only SIGKILL or a freezer interrupt a coredump, see dump_interrupted(). */
+bool coredump_signal_pending(struct task_struct *p)
+{
+	return __fatal_signal_pending(p) || freezing(p) ||
+	       (READ_ONCE(p->jobctl) & JOBCTL_TRAP_FREEZE);
+}
+EXPORT_SYMBOL(coredump_signal_pending);
+
 static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q);
 
 static void sigqueue_free_ignored(struct task_struct *tsk, struct sigqueue *q)

-- 
2.53.0

