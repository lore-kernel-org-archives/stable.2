Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766C3876DF
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065589; cv=none; b=VSEJYLoNDNheehT+/FlTUtN1A0Aw8rmjq2AV4fI4mWCYnP7jvMmczDF6p4/WlyVpE4nYDlHZI5akQnu8twBjyaNwDqArT7okkSCyjjo1PJWg/DpZyIb11pXcV8Vou9D3fabehUwR9ntnNbPfwh/T3xkTbz84alc4r0Q+t9AkVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065589; c=relaxed/simple;
	bh=39+EvjHzU1mev2QspyA70DOedywuHcgjckECouAnhbs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TcpzL7DI1l2mfRRudKUT484x4X9i1O63cwiEid528l5LV4dcgFDNUBJAb7wUoKW/Erv94Q98S8cHq5I1Km6hUK+k73Vm3VVJ8Q2HwUWZra4U1P4WTGL9n3Ai5/f967z9DfXvA6dxAHNXGAkWPB6hmJBswJrRu8520PrlibSawuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=stZvO/66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="stZvO/66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C081F1F000FF;
	Tue, 22 Sep 2026 08:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790065588;
	bh=Q1FwEZa+HqxujyVmFSAJhSKpY2p9ESjED7NQ1+MhDkg=;
	h=Subject:To:Cc:From:Date;
	b=stZvO/66ZBZ/6GUcWVaPH4XH+PVhRSUk24ddwk8misZXdYKFWw5/EWDsvLgRShm/m
	 wZmEfMtz6g/0C/5LMr1GzgGVuackeAlqPzIoRGhIH+x9rtzC8Jnvgb8S5f3KkQvpbW
	 mcscl8NivSdNkTGQzUF5QpozPHJmUkf8fBFM/R6Y=
Subject: FAILED: patch "[PATCH] exec: Cleanup POSIX timers right after de_thread()" failed to apply to 6.1-stable tree
To: imv4bel@gmail.com,frederic@kernel.org,oleg@redhat.com,red993688@gmail.com,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 10:26:25 +0200
Message-ID: <2026092225-humongous-ultimate-9930@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x acb03d3881818581052924a9bbbe92b8741ed448
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092225-humongous-ultimate-9930@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From acb03d3881818581052924a9bbbe92b8741ed448 Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Fri, 11 Sep 2026 11:09:17 +0200
Subject: [PATCH] exec: Cleanup POSIX timers right after de_thread()

A per-thread CPU timer holds a reference to the PID of the thread it is
attached to and, while it is armed, its node is queued in that thread's
posix_cputimers. The task is looked up by that PID.

When a non-leader thread exec()s, de_thread() changes which task owns
that PID. pid_task(timer->it.cpu.pid, PIDTYPE_PID) then returns NULL,
but the node is still queued on tsk, which is alive. timer_lock_sighand()
takes a failed lookup to mean that the node is already dequeued, so it
has nothing to undo.

begin_new_exec() calls posix_cpu_timers_exit(me) right after
exec_task_namespaces() and that removes the leftover node, so the state
normally stays invisible. But bprm->point_of_no_return is set before
de_thread(), so if unshare_files(), set_mm_exe_file(), exec_mmap() or
exec_task_namespaces() fails, the task dies before it gets there.
exit_itimers() then frees the k_itimer while its node is still queued,
and reaping tsk later erases that freed node from the rbtree.

In short:

      the non-leader thread B           the parent

  timer_create(CLOCK_THREAD_CPUTIME_ID)
  timer_settime()
    arm_timer()            // the node is queued on B
  execve()
    de_thread(B)
      exchange_tids(B, leader)  // B's PID now belongs to the leader
      release_task(leader)
        __exit_signal(leader)
          posix_cpu_timers_exit(leader)  // cleans leader's queue, not B's
          __unhash_process(leader)  // that PID has no task anymore
    exec_mmap()
      mmap_read_lock_killable(old_mm)
                                kill(B, SIGKILL)
      // -EINTR
  get_signal()
    do_exit()
      exit_itimers()
        posix_timer_delete()
          posix_cpu_timer_del()
        posix_timer_unhash_and_free()  // freed while still queued
                                wait4()
                                  release_task(B)
                                    posix_cpu_timers_exit(B)
                                      cleanup_timerqueue()
                                        timerqueue_del()  // use-after-free

Move the POSIX timer cleanup right after de_thread() before any of the
later failure conditions brings the task into do_exit().

[ tglx: Move the cleanup right after de_thread() ]

Fixes: 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Kijo Park <red993688@gmail.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/ao7Q8miiuLAPVnWv@v4bel
Link: https://patch.msgid.link/20260911090541.627712075@kernel.org

diff --git a/fs/exec.c b/fs/exec.c
index d3081c8f7c10..819643408e6d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1115,6 +1115,17 @@ static struct file *bprm_identity_file(const struct linux_binprm *bprm)
 	return bprm->file;
 }
 
+static void posixtimer_exec(struct task_struct *me)
+{
+#ifdef CONFIG_POSIX_TIMERS
+	spin_lock_irq(&me->sighand->siglock);
+	posix_cpu_timers_exit(me);
+	spin_unlock_irq(&me->sighand->siglock);
+	exit_itimers(me);
+	flush_itimer_signals();
+#endif
+}
+
 /*
  * Calling this is the point of no return. None of the failures will be
  * seen by userspace since either the process is already taking a fatal
@@ -1152,6 +1163,16 @@ int begin_new_exec(struct linux_binprm * bprm)
 	retval = de_thread(me);
 	if (retval)
 		goto out;
+
+	/*
+	 * This must be done here to ensure that POSIX CPU timers which were
+	 * armed on the current task are dequeued from me::posix_cputimers.
+	 * Otherwise in case of a TID switch the deletion of the related POSIX
+	 * timer would not remove an enqueued timer because the TID lookup
+	 * of the old TID fails.
+	 */
+	posixtimer_exec(me);
+
 	/* see the comment in check_unsafe_exec() */
 	current->fs->in_exec = 0;
 	/*
@@ -1206,14 +1227,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out_unlock;
 
-#ifdef CONFIG_POSIX_TIMERS
-	spin_lock_irq(&me->sighand->siglock);
-	posix_cpu_timers_exit(me);
-	spin_unlock_irq(&me->sighand->siglock);
-	exit_itimers(me);
-	flush_itimer_signals();
-#endif
-
 	/*
 	 * Make the signal table private.
 	 */

