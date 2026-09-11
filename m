Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD3376A1E;
	Fri, 11 Sep 2026 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117761; cv=none; b=QafvhfMie1m1b9g4+PUUWlwnE6iaePl0kd7xgKAD0Cirqo0HIU4i4yxPdILxDP/TESNAv8UWEb59ZDPqotTUCWiRgSVNWz719ePoNDhilUIQqhA5SeS69ttXJFnuL51dBTH+fESyTUhq/9h3a9+rgP8OkQ6li1TKcCqXpKJDhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117761; c=relaxed/simple;
	bh=36kUj1xy90SJ/2U4I49r6/qBFpp1qMLSU6nHvh2fqEE=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Azy9ri6M315LO0hF3BKHoJDDdpGthdOcvddUhiA3KdCEoYCD0CK2ELmP7sjzhbb0VAEaVG+BVWMt40lmLcHeidJLm+SdslXXAk/QZkoPZzWbxocrvi+kzYTM8VEGNeyU8YyoLF9lhznyZWwCTeYQzfxPZFlw8jBSOiiTuOU0204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMfkJVrZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMfkJVrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8661F000FF;
	Fri, 11 Sep 2026 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117760;
	bh=Aq7mFGqwAOxE0CSoUnFid/xgjIH7t6qbhFnPRY2p+cw=;
	h=Date:From:To:Cc:Subject:References;
	b=DMfkJVrZnCl7XUW5ZWGc4Y9Bz56bcmLzR4eR9ddPOG4mRqqcl966lERSLlbFcwRcD
	 HN275jNjW6PJyByXDTYBqztVjalQpnYg24WkDzsLdITRkBCCD4dnkVflyRV2dSVk/F
	 9ppw7sLRWhkJ+Y3hkih42KVkBtGfl4LqLqhVlc4faRTxtck6VuEsKu1ElCZ9VlxUnk
	 CtSjmC3CVv8QHWoiC+CEJpgzOldd5ZF/7ArPruVmdgPz6UXDvkGVFNjDCUpgsW8lEe
	 Bnz1e4phfpILFJnc/XsAphnBtNewz6rbVoK6+wRDcezBRAwN8adgtR2EXTpFF4TyAA
	 hMW4LGX84c+HA==
Date: Fri, 11 Sep 2026 11:09:17 +0200
Message-ID: <20260911090541.627712075@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>,
 Ingo Molnar <mingo@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 stable@vger.kernel.org
Subject: [patch V3 2/8] exec: Cleanup POSIX timers right after de_thread()
References: <20260911090341.949101445@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Hyunwoo Kim <imv4bel@gmail.com>

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
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/ao7Q8miiuLAPVnWv@v4bel

---
Changes in v3:
  Move the cleanup right after de_thread() - Oleg
  Rework change log

Changes in v2:
- Add the trigger sequence and the KASAN log to the commit message.
- v1: https://lore.kernel.org/all/anfgrsPlUdwBhdrp@v4bel/
---
 fs/exec.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1115,6 +1115,17 @@ static struct file *bprm_identity_file(c
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
@@ -1152,6 +1163,16 @@ int begin_new_exec(struct linux_binprm *
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
@@ -1192,14 +1213,6 @@ int begin_new_exec(struct linux_binprm *
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



