Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479846E011
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591041; cv=none; b=oBzqASIPsNbXI5pxDdhhzMDH493Ah9qOf+uGTFvWIHMTdKnwTOdlCmZIPS3dPtk+zLHuGgl1Eyi0NY9eAZ03TFk/AA8NMl8MCvzlrHJ7Z5+L6S3Gnr4hAFtuuga7/3rlsIfsRShlRdMRgkkn7WJ22uf0nBl0LGzjQhtcS/ObNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591041; c=relaxed/simple;
	bh=vGUq/mq6pjETsh6rrtpLcBUOl3E68jLaOnnA0gs0QQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyJ1y2FNLxtq8qIrpo7TYG+pQ4ZlZg9aQJQyIsO7Lp4NNHcNppm5bNmncwEGFoieZ2WhAzHfSNVqG18AS+HkSkABigxBKnEbSMIB2NLcfkkX+ro4voLDR4yYt2YPLyrjVReLoJQQtMB1Owx1VVLqHhAIZUkVDq2pvbplGnMQlQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCkOLaSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCkOLaSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4E21F00898;
	Wed, 16 Sep 2026 20:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591020;
	bh=D9NqxqYkWaoLVyJo16XIoac/mxONFnR1Sy3SgThOHw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PCkOLaSC6gb7gz6y03bf7jjJL1H3w+Jy8wQ6xMgKbTwgXZBVB4JhCxYZwGrX+ZkxW
	 wtFIhldIWpfHozmfEhzzkG0YsrDI/aBzWulyKlyLclxmT91t7BZsUZyEUYGNoho7ss
	 5Q4WKcoPNf9ciViGerH8p/eLZm734X4rd+g+UeDrSV4HWtpbZbbEGbXRuRJydhEMTC
	 /FMwerwdvrzLDkIempGt7zzsWgrOpA6dulFwgtmn7iD5FLSmEJNzk9fvk7dZZxqPxe
	 BEZIOXqr/8i3DZVIJCmWhN6jnDgEqW3posFmPsO7UgN/f+bGbhye8jmtYRQxTayWHg
	 GFt9Txv6tL6vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com,
	syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com,
	Oleg Nesterov <oleg@redhat.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] exit: hold a reference to thread_pid across proc_flush_pid
Date: Wed, 16 Sep 2026 16:36:56 -0400
Message-ID: <20260916203656.2689289-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203656.2689289-1-sashal@kernel.org>
References: <2026091657-curry-myself-be92@gregkh>
 <20260916203656.2689289-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit cdd812d0683dee14ead02c9eded568685e61b23f ]

Commit 0a36bad01731 ("release_task: kill the no longer needed
get/put_pid(thread_pid)") removed the reference around proc_flush_pid().
It assumed that free_pids(post.pids) at the end of release_task() would
keep thread_pid alive until then.

That assumption is wrong.  __change_pid() only records a detached PID in
post.pids when pid_has_task() is false for every PIDTYPE.  If another task
still uses the exiting task's PID as its process group or session ID,
__unhash_process() removes the exiting task's PIDTYPE_PID link but leaves
the PID out of post.pids.  release_task() therefore holds no reference to
it after dropping tasklist_lock.

The other task can then remove the remaining PIDTYPE links.  Its
free_pids() call schedules delayed_put_pid(), and the RCU callback can free
the PID before the first release_task() reaches proc_flush_pid().

An unprivileged reproducer races wait4(-1) against setsid() to trigger this
ordering.  Three of three fresh v7.2 KASAN boots reported:

    BUG: KASAN: slab-use-after-free in
    proc_invalidate_siblings_dcache+0x3e2/0x3f0
    Read of size 8 by task h7_pid_reaper/1921

    Call Trace:
     proc_invalidate_siblings_dcache
     release_task
     wait_consider_task
     __do_wait
     do_wait
     kernel_wait4

    Freed by task 0:
     kmem_cache_free
     put_pid
     delayed_put_pid
     rcu_core

    Last potentially related work creation:
     __call_rcu_common
     free_pids
     ksys_setsid

KASAN identified a 144-byte object from the pid cache and located the bad
read 80 bytes into the freed object, matching pid->inodes.  With an
explicit reference, three of three fresh boots completed without a KASAN
report.  The concurrent RCU callback dropped its reference while
proc_flush_pid() was protected, and the balancing put_pid() performed the
final free afterward.

Take a reference before __unhash_process() clears p->thread_pid and release
it after proc_flush_pid() completes.

A tested source reproducer is available privately on request.  No
controlled read or write, information leak, or privilege escalation is
claimed.  The mainline patch applies directly to v6.19.y and newer;
v6.16.y through v6.18.y need a context-adjusted backport.

Fixes: 0a36bad01731 ("release_task: kill the no longer needed get/put_pid(thread_pid)")
Reported-by: syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0aee5e8066eddbbe7397
Reported-by: syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=e8b3520b53e78e90034e
Cc: stable@vger.kernel.org # see patch description, needs adjustments for 6.16.y-6.18.y
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Link: https://patch.msgid.link/20260831001221.3755948-1-4ncienth@gmail.com
Acked-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ Adjusted context for cgroup_release() and the missing exit_cred_namespaces() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index b22ede84c0ec9..d60c1241923a9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -264,8 +264,11 @@ void release_task(struct task_struct *p)
 	pidfs_exit(p);
 	cgroup_release(p);
 
-	/* Retrieve @thread_pid before __unhash_process() may set it to NULL. */
-	thread_pid = task_pid(p);
+	/*
+	 * Pin @thread_pid before __unhash_process() clears it. The last
+	 * PIDTYPE detach can otherwise free it before proc_flush_pid().
+	 */
+	thread_pid = get_pid(task_pid(p));
 
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
@@ -294,8 +297,8 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	/* @thread_pid can't go away until free_pids() below */
 	proc_flush_pid(thread_pid);
+	put_pid(thread_pid);
 	add_device_randomness(&p->se.sum_exec_runtime,
 			      sizeof(p->se.sum_exec_runtime));
 	free_pids(post.pids);
-- 
2.53.0

