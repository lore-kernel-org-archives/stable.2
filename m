Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA44734CF;
	Fri,  4 Sep 2026 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520951; cv=none; b=fjm63Yq5Bdb8xWoBL7ma+7ywhNHIKRCzBhirOzDMITeDmc4w8gu7btiKo8uiUsCFg3sJ1b/fZocD0NxegtDcY2xPAxWpSalGXL9qgIL0E3V72xSEk2efx3eNGn6+tI4byPxb+U6iEOroV4L6BsO4vTkBvdfFMr1MhTzVRAeFPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520951; c=relaxed/simple;
	bh=c6LKdjCRtX9r7BkpBqhHl3YDIF7wMKwHPOCCdDBstSs=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hpPD3zvrFULw6lFUpUdTZ17cdnwXw8bSYdJp30AZ6n7iGwUZEtxDpQU2LFK4w9u3jwBEO3lobgQx1XPtnhpzKiHUFvGqm42c0DbM75qmYZlez7ediQRwKHHcOBOlQH0ibrgSbbosxRKM8oN5Vnmh6j57KBDoR4pvhXHQ+1Bf32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBnkU74I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBnkU74I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98361F00A3E;
	Fri,  4 Sep 2026 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520949;
	bh=/MjvIu2eMcDyB476Ez37rVlvnO35eZxH5+YssIQfLa8=;
	h=Date:From:To:Cc:Subject:References;
	b=hBnkU74I3TP8Z6ELqV8PmhBwn3sZ+74wmbRjNTGlhsCzAV9686nKBr2wqOa8wAbSr
	 5As/v5CNR1vokggX3aPjFYZRwNAL++foP23zxITyNuTDqmttVFGiT+F3pEt5f/feVz
	 izDRxechzOORanTN0YK6euKRx52zGjYIGnjyHcKo5Ri/QY1T3sUgWH07BV9VSdmDve
	 ucxXZSaVtQH/Lp6+datI+UCZVWdlP6Ye794dEhQWKOnRAlHWTRuTbnA3geeurDXt2u
	 cdtsVVg/bvdFK8dChV/Tw4zwgJao85UFhiBqwIjr/3C7Rhe7FirBGBFV0ZHoGpG0io
	 Qk6pAGlfC3dWw==
Date: Fri, 04 Sep 2026 13:22:26 +0200
Message-ID: <20260904112202.131242426@kernel.org>
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
 stable@vger.kernel.org
Subject: [patch 2/8] exec: Cleanup POSIX timers right after de_thread()
References: <20260904112100.683893401@kernel.org>
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
+	 * That ensures that in case of a TID switch the deletion of the related
+	 * POSIX timer will not free an enqueued timer because the TID lookup
+	 * failed as the original target TID was the old leader.
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

