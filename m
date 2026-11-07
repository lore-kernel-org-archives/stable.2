Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046555;
	b=a1wahfU3+2zpgALwvXkRv7OyJleixDCsldCw95u0cc4ppU+Vbcp8T+eErLcc/AmDto7h
	 X2SEVb52gLZXHMt3CC6T3Pu1hCffiLsC9ROh9DJU11UhcC2RGZ9llRhK64H+MxA95CkfA
	 1cEhTRd4T6yIZDHywcz3ioM6onxHbduCrSpGOJdK6MmMFUoSHoiYNzCjTp77XuMUPpX/+
	 /l9whHED1GXV6u8h7tfsRDtFFSmpPO4BnHo8bsJ9B4Unt3vmPjOS2Fh21cAPAhG766JRq
	 3H9HMUbFMcOFTB2BhxOQSsqh6vzOhjMSg/69tAIKfaO8SdhE9v3CcvkF7c/Xev+3G0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046555;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MvKWAmq1byDN6Gc8r062YVHpv4UxIQGY4L9e/RGG6sM=;
	b=iZ1ijr9jS/+oKP5eQZfoofrrt7SrDg/7P+uk6FCuubYhXM872EcOHD4f5X57CH0QHXah
	 GSjUccAu8PmowGXeeaQHeQIUEGjxuYMUBLLG0PAg7sX+16uBwAiQI2dmyhbKBYJFqzfEw
	 ncArjdQ8EV6kcqUbqbUBmKRyZEAyu8RhK+VkzYgX8HLNrLboYfN+Ow7sTVOh18vk7aUn6
	 BvYyeMFTfQQOW+jWBxL1rzP5+4LFE0EOpIAc8x9e+/T8O8lVfDMD1PaXGWYpCplZLmtje
	 J0mTDnW9Hv8OpmM3OC1tA1GdOaNFqkxEV4XtzdCOYD4YZzfYR4tGRK2HteSfnEVbVag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0lVZe3S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FC9606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0lVZe3S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6EF1F008A1;
	Sat,  7 Nov 2026 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046554;
	bh=MvKWAmq1byDN6Gc8r062YVHpv4UxIQGY4L9e/RGG6sM=;
	h=From:To:Cc:Subject:Date;
	b=o0lVZe3StXS0PL0GIaB25ZV0ypWdSfKOw7p/Sx9tEJynQpgotxyShZvX1Q2oxkjJN
	 XYoRwA/BMHcms+84Kfa2d4GpA5H25qNlX4yf6cubIRam9U9W63/x27dePNVeH2tKBz
	 GMcVG6GmJcdfkhhJqhO+aQ2X50+APXkW8hzFR5BNMeIa0VsjVcNAyNn6aUcUXf84kc
	 XmJZdAGE6gvz9jMczLLhH1hmObccJtElKu1v5E+TUpURs+AZqfyD8Tih1I854QTFhk
	 S5VBZ/o6AOQj5XxOYfyx7zZDyxdXS/j+UFlaxOYxs6z6LSBO4fO5boVWpWASRTYpmo
	 MzKGbN8K09l8g==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] pidfs: don't let PIDFD_GET_INFO miss a reaped task" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:52 -0500
Message-ID: <20261107051552-failed-6.18-172658cf6009@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 172658cf600904ff6121e240f69a0ccb36e65d6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051552-failed-6.18-172658cf6009@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 172658cf600904ff6121e240f69a0ccb36e65d6b Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 4 Oct 2026 15:00:12 +0000
Subject: [PATCH] pidfs: don't let PIDFD_GET_INFO miss a reaped task

PIDFD_GET_INFO describes the task while there is one, and with
PIDFD_INFO_EXIT its exit status once it has been reaped.  pidfd_info()
looks at the two in the wrong order and can miss both:

  pidfd_info()                          release_task()
    PIDFS_ATTR_BIT_EXIT is not set
                                          pidfs_exit()
                                          __unhash_process()
    get_pid_task() == NULL
    goto copy_out

The ioctl succeeds with neither PIDFD_INFO_PID nor PIDFD_INFO_EXIT in the
mask.  If the task is unhashed a little later, after get_pid_task(), its
pid reads as 0 and the ioctl fails with -ESRCH, although the caller asked
for the exit information and it is available by now.

The second case does not even need an exit.  When a sub-thread execs,
de_thread() hands the leader's pid over to it and releases the old leader.
A caller that got hold of the old leader reports the tid of the sub-thread
as the pid, or -ESRCH for a process that is alive.

Look up the task first.  pidfs_exit() runs before the task is unhashed, so
a caller that finds no task finds the exit information; this needs a
barrier on both sides because taking tasklist_lock does not order the
store in pidfs_exit() against the one in detach_pid().  And start over if
the task no longer owns the pid when all the fields have been read: then
there is either exit information or another task.

Go by the pid for that check and for the pid we report, not by
->thread_pid of the task.  exchange_tids() moves the pid to the exec'ing
thread before it updates ->thread_pid of either task.  A caller that
finds the new leader in between would read the old tid of the sub-thread
from ->thread_pid, and a check of ->thread_pid would restart until the
exec'ing thread gets to its store.  On PREEMPT_RT that thread can be
preempted with tasklist_lock held and can't move to another CPU.  If the
RT task that preempted it calls PIDFD_GET_INFO, the ioctl spins until
the exec'ing thread gets the CPU back, and that never happens if the
exec'ing thread is an RT task of lower priority.

Christian Brauner <brauner@kernel.org> says:

Go by @pid instead of ->thread_pid of the task for the reported pid and
for the restart check.

Fixes: 7477d7dce48a ("pidfs: allow to retrieve exit information")
Fixes: cdda1f26e74b ("pidfd: add ioctl to retrieve pid info")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/pidfs.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7f8c323ce6cb8..66c1046e29290 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -362,6 +362,12 @@ static __u32 pidfs_coredump_mask(enum task_dumpable dumpable)
 			      PIDFD_INFO_COREDUMP_SIGNAL | \
 			      PIDFD_INFO_COREDUMP_CODE)
 
+static bool pidfs_task_owns_pid(struct task_struct *task, struct pid *pid)
+{
+	guard(rcu)();
+	return pid_task(pid, PIDTYPE_PID) == task;
+}
+
 static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
@@ -392,6 +398,16 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		return -EREMOTE;
 
 	attr = READ_ONCE(pid->attr);
+again:
+	/*
+	 * Look for the task first. pidfs_exit() records the exit information
+	 * before the task is unhashed, so if the task is gone the information
+	 * is there.
+	 */
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task)
+		smp_rmb(); /* pairs with smp_mb__after_atomic() in pidfs_exit() */
+
 	if (mask & PIDFD_INFO_EXIT) {
 		if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask)) {
 			smp_rmb();
@@ -414,7 +430,6 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 	}
 
-	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task) {
 		/*
 		 * If the task has already been reaped, only exit
@@ -468,16 +483,27 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	 * task might return as soon as the copy_to_user finishes, but that's ok
 	 * and userspace expects that might happen and can act accordingly, so
 	 * this is just best-effort. What we can do however is checking that all
-	 * the fields are set correctly, or return ESRCH to avoid providing
-	 * incomplete information. */
+	 * the fields are set correctly, to avoid providing incomplete
+	 * information.
+	 */
 
 	kinfo.ppid = task_ppid_vnr(task);
 	kinfo.tgid = task_tgid_vnr(task);
-	kinfo.pid = task_pid_vnr(task);
+	kinfo.pid = pid_vnr(pid);
 	kinfo.mask |= PIDFD_INFO_PID;
 
-	if (kinfo.pid == 0 || kinfo.tgid == 0)
-		return -ESRCH;
+	/*
+	 * The task was reaped, or lost @pid to a sub-thread that called exec,
+	 * while we were looking at it. Start over: there is exit information
+	 * now, or a new task. Don't go by ->thread_pid, exchange_tids()
+	 * updates it only after it has moved @pid.
+	 */
+	if (!pidfs_task_owns_pid(task, pid) || kinfo.tgid == 0) {
+		put_task_struct(task);
+		task = NULL;
+		memset(&kinfo, 0, sizeof(kinfo));
+		goto again;
+	}
 
 copy_out:
 	if (mask & PIDFD_INFO_SUPPORTED_MASK) {
@@ -790,6 +816,11 @@ void pidfs_exit(struct task_struct *tsk)
 	/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
 	smp_wmb();
 	set_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask);
+	/*
+	 * Whoever sees that the task is unhashed must see the bit, see
+	 * pidfd_info(). Taking tasklist_lock does not order the two stores.
+	 */
+	smp_mb__after_atomic();
 }
 
 #ifdef CONFIG_COREDUMP
-- 
2.53.0




