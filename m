Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561178;
	b=i3ycpFk1LvLcISJFqM3xxhPF7lVQi0YrzC12fCB9HrV0Lqwt1FwJBUjrWUpuFapdFKnb
	 MbW8jZS+9QUaiNiqRTeICCAzIYDGIVIIyzllpFGmJl1p0BmkPo1d1zlqrabrFMyslxwVQ
	 +wxAtHfQRLSg5yzA/x8iRiaa87d6JQwkqlHlSm72YVU2l0dm5wF+DVc4Y4P9Afl5k1Z8B
	 xAPMLTieNJUlm3L2TA4Rw5mU3kq36qtQpvRiS5npHdInPEd0kJjgx5DW4PzcpjyymVb+G
	 Ra8tve7BsfN7meclY8+pVN1c0LhghlE0TqDw55+CvvgCQZRR5GqTFdRGf9tA0KdV/9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561178;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7dhdMAikSNSHWYSj5gXK3zToTZetL3KpIeQO1xIoCkw=;
	b=yw0wCRK8BJBGQORF1XqHfioCpI0csSKtuJy3z4pBVj7yNThiK3J7TDNIK5oYc99UjRBi
	 gAm0uJc5ppmQvcXpalMjQhSCh0qBabS/RWwxxO8v/CiJqgBtIgiAlPoPLVxQpfXYJSo0z
	 /KnXCWahkE226ZTG9IwQum6IzLs8uddEryF2DmQ0ziLagU/ZPMnJ8ZeVsEOGlGGjNkso+
	 7cn1JForOp6hX8gt1YcdEOhNrraLkChJNcyI0KAenYCYWErl9U1TOTYCrJqh7nUylUf41
	 WgGdGHblpZsfOrxqyGJi3VV72xU1Yrm/CgCsJXGn/BtFVFGVWuOouN9P1uxju5ygduw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDqwfhH8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D3606A321;
	Tue, 24 Nov 2026 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDqwfhH8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA151F000E6;
	Tue, 24 Nov 2026 22:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561177;
	bh=7dhdMAikSNSHWYSj5gXK3zToTZetL3KpIeQO1xIoCkw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BDqwfhH8VAYrOQskOqhCbYxoxwoaFIke6MbxBeO39QiygukfmZCNNiURz6oN87aAq
	 Z+bImWA9N15x2Pc5N+pWDM/e3l902aU2T5UAz1p91pu4cYBaGYoVzYLPY1VeQNLbz3
	 dUyPtA60dTnzRv5dNFbfnHpyEk6D4RErJ3axJ4vmeAVJG/BP/fe1lFhm/DTWiQoks2
	 4uCr5sVqgY7Zq+YspnVhwtO3CGTd6zXtnqpMvid134R5e13kOQJEv/Gg0WXcznoifC
	 3uMHQsrqdsFtspCc+eUZXzALA3/Wi4No5RHfcX2Ucxyltgtzt9ALOqhNTJTZic73wR
	 GzRBNJhGSW+UA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:25 +0100
Subject: [PATCH RFC 02/19] kcmp: look up epoll target without
 exec_update_lock held
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-work-exec-update_lock-v1-2-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 selinux@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=6236; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yRIldja6dQ5xpXwyVGOr9K78g5q5kSFyqhkHsrppIv8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziW2/1f126/VXj1dLGkyf+tH+n1DMVBuZlEg3nw031
 3T0rtna2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARR1VGhlNTggs23LLe67n1
 NXf+2eVnzsyc1F34v8HHX1SSzzoioo2R4Qar99pvCoKS9ouuvtNlrWts/vvU+80DNoE09qVzCyw
 c2QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

kcmp(KCMP_EPOLL_TFD) holds exec_update_lock and two things both of which
are susceptible to page fault induced, userspace controlled delays:

(1) cpy struct kcmp_epoll_slot from userspace

   locks held by kcmp-reader/233:
    #0: (&sig->exec_update_lock){++++}-{4:4}, at: __do_sys_kcmp+0x2ec/0xb10
    #1: (&sig->exec_update_lock/1){.+.+}-{4:4}, at: __do_sys_kcmp+0x210/0xb10

(2) takes the mutex of the epoll file to look up the target file.

   locks held by epoll-waiter/236:
    #0: (&ep->mtx){+.+.}-{4:4}, at: ep_send_events+0x10a/0x9f0
   locks held by kcmp-caller/237:
    #0: (&sig->exec_update_lock){++++}-{4:4}, at: __do_sys_kcmp+0x2ec/0xb10
    #1: (&sig->exec_update_lock/1){.+.+}-{4:4}, at: __do_sys_kcmp+0x210/0xb10
    #2: (&ep->mtx){+.+.}-{4:4}, at: get_epoll_tfile_raw_ptr+0xa5/0x190

In the meantime an exec of either task waits for exec_update_lock past
the point of no return. And everyone else who needs the exec_update_lock
of that task queues up behind the exec. So a read of /proc/<pid>/stat
hangs as well:

  task:exec-task       state:D pid:235
  Call Trace:
   __schedule+0x1691/0x4b00
   schedule+0xe0/0x2e0
   schedule_preempt_disabled+0x11/0x20
   rwsem_down_write_slowpath+0x472/0x1820
   down_write_killable+0x1ba/0x240
   begin_new_exec+0xa4b/0x2df0
   load_elf_binary+0x340/0x4af0
   bprm_execve+0x772/0x1400
   do_execveat_common.isra.0+0x3d9/0x540
   __x64_sys_execve+0x8c/0xc0
   do_syscall_64+0x110/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  task:stat-reader     state:D pid:238
  Call Trace:
   __schedule+0x1691/0x4b00
   schedule+0xe0/0x2e0
   schedule_preempt_disabled+0x11/0x20
   rwsem_down_read_slowpath+0x5cc/0x10c0
   down_read_killable+0xf1/0x5f0
   do_task_stat+0x13b/0x2870
   proc_single_show+0x110/0x1d0
   seq_read_iter+0x2e4/0x1280
   seq_read+0x29b/0x550
   vfs_read+0x171/0xb20
   ksys_read+0x111/0x250
   do_syscall_64+0x110/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

All it takes is being allowed to kcmp() the two tasks.

Stop that and copy the before the locks are taken. With the locks held
only take a reference to the epoll file and look up the target after
they have been dropped. The epoll file is still taken from the task
after the access check and with exec_update_lock held.

Note that the target is now looked up a moment later. So if the task
execs in between and keeps the epoll file the caller may get to compare
a target that only the new image registered. The caller still only gets
at the epoll file while it's allowed to look at the task and all it
learns is how two files compare.

Fixes: 0791e3644e5e ("kcmp: add KCMP_EPOLL_TFD mode to compare epoll target files")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/kcmp.c | 72 +++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 22 deletions(-)

diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 76476aeee067b..8102e5825efc5 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -94,6 +94,34 @@ static int kcmp_lock(struct rw_semaphore *l1, struct rw_semaphore *l2)
 	return err;
 }
 
+static void kcmp_unlock_tasks(struct task_struct *task1,
+			      struct task_struct *task2)
+{
+	kcmp_unlock(&task1->signal->exec_update_lock,
+		    &task2->signal->exec_update_lock);
+}
+
+static int kcmp_lock_tasks(struct task_struct *task1,
+			   struct task_struct *task2)
+{
+	int ret;
+
+	ret = kcmp_lock(&task1->signal->exec_update_lock,
+			&task2->signal->exec_update_lock);
+	if (ret)
+		return ret;
+
+	/*
+	 * One should have enough rights to inspect task details.
+	 */
+	if (ptrace_may_access(task1, PTRACE_MODE_READ_REALCREDS) &&
+	    ptrace_may_access(task2, PTRACE_MODE_READ_REALCREDS))
+		return 0;
+
+	kcmp_unlock_tasks(task1, task2);
+	return -EPERM;
+}
+
 #ifdef CONFIG_EPOLL
 static int kcmp_epoll_target(struct task_struct *task1,
 			     struct task_struct *task2,
@@ -102,18 +130,26 @@ static int kcmp_epoll_target(struct task_struct *task1,
 {
 	struct file *filp, *filp_epoll, *filp_tgt;
 	struct kcmp_epoll_slot slot;
+	int ret;
 
+	/* This may fault so do it before exec_update_lock is taken. */
 	if (copy_from_user(&slot, uslot, sizeof(slot)))
 		return -EFAULT;
 
-	filp = get_file_raw_ptr(task1, idx1);
-	if (!filp)
-		return -EBADF;
+	ret = kcmp_lock_tasks(task1, task2);
+	if (ret)
+		return ret;
 
-	filp_epoll = fget_task(task2, slot.efd);
+	filp = get_file_raw_ptr(task1, idx1);
+	filp_epoll = filp ? fget_task(task2, slot.efd) : NULL;
+	kcmp_unlock_tasks(task1, task2);
 	if (!filp_epoll)
 		return -EBADF;
 
+	/*
+	 * This takes the epoll mutex which is held across page faults. So
+	 * do it after exec_update_lock has been dropped.
+	 */
 	filp_tgt = get_epoll_tfile_raw_ptr(filp_epoll, slot.tfd, slot.toff);
 	fput(filp_epoll);
 
@@ -153,19 +189,16 @@ SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
 
 	rcu_read_unlock();
 
-	/*
-	 * One should have enough rights to inspect task details.
-	 */
-	ret = kcmp_lock(&task1->signal->exec_update_lock,
-			&task2->signal->exec_update_lock);
-	if (ret)
-		goto err;
-	if (!ptrace_may_access(task1, PTRACE_MODE_READ_REALCREDS) ||
-	    !ptrace_may_access(task2, PTRACE_MODE_READ_REALCREDS)) {
-		ret = -EPERM;
-		goto err_unlock;
+	/* Takes and drops exec_update_lock itself. */
+	if (type == KCMP_EPOLL_TFD) {
+		ret = kcmp_epoll_target(task1, task2, idx1, (void __user *)idx2);
+		goto out;
 	}
 
+	ret = kcmp_lock_tasks(task1, task2);
+	if (ret)
+		goto out;
+
 	switch (type) {
 	case KCMP_FILE: {
 		struct file *filp1, *filp2;
@@ -203,18 +236,13 @@ SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
 		ret = -EOPNOTSUPP;
 #endif
 		break;
-	case KCMP_EPOLL_TFD:
-		ret = kcmp_epoll_target(task1, task2, idx1, (void *)idx2);
-		break;
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
-err_unlock:
-	kcmp_unlock(&task1->signal->exec_update_lock,
-		    &task2->signal->exec_update_lock);
-err:
+	kcmp_unlock_tasks(task1, task2);
+out:
 	put_task_struct(task1);
 	put_task_struct(task2);
 

-- 
2.53.0

