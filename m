Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426630;
	b=csuIgo4YfkXfFr3S1/ULaqa1HI0zDWPfHoIHMMD1LT8Lppue/ztJm5jA95tlO11gE3p4
	 W1EbqttcjbVuA8xjF0Ety9HWSi5kP86HLnp8uNDQmjhBff2P+aVAfmVo7V3U/pvZFfASX
	 kxv6IlaKnLLKuwnE7347ZUuao74J83pUn079TItpNB1hzlgNOPfPby93UshzVRpkUU33q
	 0vKwOmT8eqtjVpGnoHgo2gMte9FOpi57/PFqG2YVI9lg2IFLY2hmusSAHyd/iiMdVP5ZL
	 60wnef68kmcywsB15I3ZyghpxWykkByrRoZ13UAwS7i7wTdsnzQVASdEujd7yv/8SJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3stIAhWeLpkAK+Xdt9fISn39S98OsH/dTo/owyjfuZI=;
	b=lkbbfVWOliQYWy0EZtW6bVaromNH1ehxtmA6Vh3QXTP7H4MXTTl9XxaAp0tcK3wNvbJ5
	 /cU0WTMv8XPQZVUf+pcRgP9L43M5dREpyll9XKuo9aSB1KBE8mee877Y2To7CC8lelIiM
	 kzK7fNMnXMx6EC6rpe9CYUlUbZiYpDEp0Mr3AJqSPZzi8UmXWP3e3EpfeNy8tO184TKk9
	 8VjXZKmsFw3XRyail5WKd4z0tLHVmyuXNAcg1kvjxsEEKw8djELj1gGIq84yHK37RQNNU
	 HvNW6i8vXaHgwpAPIUi/jDqYU97h5HpbiVA1fg3K1FTebasD61FM82VcVJFLnSyUwhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Orf2ltdI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEA1606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Orf2ltdI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CF01F00A08;
	Wed, 11 Nov 2026 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426630;
	bh=3stIAhWeLpkAK+Xdt9fISn39S98OsH/dTo/owyjfuZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Orf2ltdIqFtVeSjch63psOZBYNVFTDE8R3AEsTZ7tQReByPPdFIS+x11yqKrZEOut
	 sjjJtmt0/DVs/JF88yRE7SMoundPga8vgYFmAOjUYsoSpunw51vAbOOru3BKP4iWSw
	 PnaEYaKnU5BxGHEQunYrrIzIbQPN15/4Y/+Z5Eb0y0DiEyvnai55YAlkyYOE7Jygvk
	 4+yLKqnAS5gshE/XvaU+dOB6rkiEmzecSJf28MsN3/C7Td5cFTAyqeZZXWjUoCQ7Bx
	 WnGMMbYr/4T9uU70biWyMkuLRNQXq7kBlSQxi3jS6/Ln9TUXk9u5Z0T6kmawe5eXTF
	 oTdH9Sy+0dfmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] pidfs: don't let PIDFD_GET_INFO miss a reaped task
Date: Wed, 11 Nov 2026 14:50:27 -0500
Message-ID: <20261111194945.4005899-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111194945.4005899-1-sashal@kernel.org>
References: <20261107051552-failed-6.18-172658cf6009@kernel.org>
 <20261111194945.4005899-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 172658cf600904ff6121e240f69a0ccb36e65d6b ]

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
[ sashal: inlined the RCU-protected ownership check in pidfd_info() instead of adding pidfs_task_owns_pid() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pidfs.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index d2afc85b9df37..a014db891aaa8 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -309,6 +309,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	struct user_namespace *user_ns;
 	struct pidfs_attr *attr;
 	const struct cred *c;
+	bool task_owns_pid;
 	__u64 mask;
 
 	BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER1);
@@ -329,6 +330,17 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		return -EREMOTE;
 
 	attr = READ_ONCE(pid->attr);
+	exit_info = &attr->__pei;
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
@@ -346,7 +358,6 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		kinfo.coredump_mask = READ_ONCE(attr->__pei.coredump_mask);
 	}
 
-	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task) {
 		/*
 		 * If the task has already been reaped, only exit
@@ -404,16 +415,29 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	 * task might return as soon as the copy_to_user finishes, but that's ok
 	 * and userspace expects that might happen and can act accordingly, so
 	 * this is just best-effort. What we can do however is checking that all
-	 * the fields are set correctly, or return ESRCH to avoid providing
-	 * incomplete information. */
+	 * the fields are set correctly, to avoid providing incomplete
+	 * information.
+	 */
 
 	kinfo.ppid = task_ppid_nr_ns(task, NULL);
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
+	scoped_guard(rcu)
+		task_owns_pid = pid_task(pid, PIDTYPE_PID) == task;
+	if (!task_owns_pid || kinfo.tgid == 0) {
+		put_task_struct(task);
+		task = NULL;
+		memset(&kinfo, 0, sizeof(kinfo));
+		goto again;
+	}
 
 copy_out:
 	/*
@@ -688,6 +712,11 @@ void pidfs_exit(struct task_struct *tsk)
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

