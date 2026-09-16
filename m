Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCEE52E053
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572511; cv=none; b=kjTlEZvCMfaFTRMqKWnshduHvBGEQn3WGd1RUZ5KKlpkymgdjSFk1QQ/wB5Y1paWH+hSF5DIuijjSeoHcgjE+0qjkZEb/MxczRUGbXLylCwGDkTkkpwdPciRWe96hyeYT+EFjCGUEs18HYruPu0ocKBhOjRuQ95iwNOLAkNnSI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572511; c=relaxed/simple;
	bh=HVg5XnrKHJ6j2S/S+q+YVG+SvZggZgbzhU/Bfvq1UXk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WSAWdSP8O1rBViItsF9g5C/NVcEaJDWvmf6q9H0OrZq1oZSF8VtDIAAGoanwgk9SXzgQTYgroAh0u9Imkl+5nKU0VhtdRmDVgf+KGYXiJShlWr9uiI4hgXr6INeWkUaUK1CkJi6LSLHuaPL3ECNorVUxDlOLdyrF5cT5UkA1BAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JKzaPMAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JKzaPMAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221161F0089A;
	Wed, 16 Sep 2026 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572505;
	bh=l5EfZpLBagMxePdyN9UtB6usxfqB1GvJXpOBxVwfQ6g=;
	h=Subject:To:Cc:From:Date;
	b=JKzaPMAl4k7z528R5Hj6OenAJGZTZSoNcY5Z3HV/kxDODS06X/Ez/aaYQBYEQMjhY
	 lqos+76p7tYnnB1fhar/NsfVbDI75I0FpqG2hPIMn7vyhjmwck2AYSpagNXwYljaJD
	 8dtCAyM0tnttAPOrQ4Bv+VTszDxSsW3zOSAdCr4w=
Subject: FAILED: patch "[PATCH] exit: hold a reference to thread_pid across proc_flush_pid" failed to apply to 6.18-stable tree
To: 4ncienth@gmail.com,brads@mainlining.org,brauner@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:16:58 +0100
Message-ID: <2026091657-curry-myself-be92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x cdd812d0683dee14ead02c9eded568685e61b23f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091657-curry-myself-be92@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cdd812d0683dee14ead02c9eded568685e61b23f Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Mon, 31 Aug 2026 09:12:21 +0900
Subject: [PATCH] exit: hold a reference to thread_pid across proc_flush_pid

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

diff --git a/kernel/exit.c b/kernel/exit.c
index 182c06671c78..e12072f1507c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -261,8 +261,11 @@ void release_task(struct task_struct *p)
 	pidfs_exit(p);
 	cgroup_task_release(p);
 
-	/* Retrieve @thread_pid before __unhash_process() may set it to NULL. */
-	thread_pid = task_pid(p);
+	/*
+	 * Pin @thread_pid before __unhash_process() clears it. The last
+	 * PIDTYPE detach can otherwise free it before proc_flush_pid().
+	 */
+	thread_pid = get_pid(task_pid(p));
 
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
@@ -291,8 +294,8 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	/* @thread_pid can't go away until free_pids() below */
 	proc_flush_pid(thread_pid);
+	put_pid(thread_pid);
 	exit_cred_namespaces(p);
 	add_device_randomness(&p->se.sum_exec_runtime,
 			      sizeof(p->se.sum_exec_runtime));

