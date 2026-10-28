Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190082;
	b=HFvqiR7034rmMqqVUWqge9wnsXbYDUvGZbi5P619VLQcNwQtZtExRLDOZjnQgo4s5erV
	 yspw4BluNA/pW9VExHYDbVboMhKQBW3/SUDt/SStwODUT12Po/Nheb7xon6Wdn+FML9U5
	 Xj4+k3AJKzkLEsx3JQ+cJ452Jx/KxFTyIgQiQ5BluikfC8Aftc2KaFEGnCTDI2aKP9UVy
	 j6x7j/qOD5xWDAzp5AKyPUTOyarslbVTUbpqH6mopQoN/YwrMRqg4dq8nUB4g1MSkDxQW
	 VN8YSRQfFehUHc3XpLENFtBTcCScPCj0eyQYwv5uoA94n0U9c+XEjYbA9MtEYIlIehQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190082;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3bsaBJ8E6DSwrTTnrWjO3rWYrTilvI7ak2QL0ZcC0Mc=;
	b=1DjN3bKkJ3wk4XN7/rZB8ha8ApP3AzgT5U1z8fus/Z2Mm9AeZqXgfIygL8PXkzbBf3nl
	 mTQFRUxv1b5KbYX9C7PuIaIuxBLTonajKOuzblBk4uo6cG1TKtfbvTSxKWtXgsAGl3X3d
	 +xeoWJw/1oZN9Le/uJY90WGFNeoizS7D5rHR4UVP/O3kQV1OHFfaMsy/6j4ErQUQlJJVB
	 wRRBHyVeZD8OJw6d34SwpA4GNIq9FnpTKi4FxUmObk10tyaVMTRiBE7v3zvO02UhWu+HY
	 JLSa1vfgUMqM9k2sELidng6GN6ti7rC7Ilj/EQWxY/bu30Y0d9bC2LSigNv6AbNzy0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5M4rM4U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64242606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5M4rM4U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F521F01828;
	Wed, 28 Oct 2026 12:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793190082;
	bh=3bsaBJ8E6DSwrTTnrWjO3rWYrTilvI7ak2QL0ZcC0Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5M4rM4UADANAlyun70btYo8tO6dMGNGa3nQ9cYl3KaKzF+25VvQQ2bE4pOd0F5KA
	 jKlzRABBOdrX49yAt+sypYqNXcuXy8qvK0ON/mvQis+zIvWzD6Ohkl10mlAlRUtaDc
	 mw5VVZ1R/ojpZYleR4q3bimq0pvcBslvt7nCty5THeJ5XRM3NnvvjKgHKIaeoTvmZr
	 XVV5Fj9p0XwqMNh96idwkaT0YIk39fKy6+xpukKXbamkeyNt3wuP1Z116ZhSKnnmRj
	 UuzZZkucdNTjKWDBQ3Erj35a0MPRVywFvD6F73JqbLK/+SPpOV05sYEFqKe6l1sjUd
	 xm8lJ89aXp+5g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Kijo Park <red993688@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [STABLE v5.10] exec: Cleanup POSIX timers right after de_thread()
Date: Wed, 28 Oct 2026 12:21:18 +0000
Message-ID: <20261028122118.3429939-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <2026092225-humongous-ultimate-9930@gregkh>
References: <2026092225-humongous-ultimate-9930@gregkh>
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

From: Hyunwoo Kim <imv4bel@gmail.com>

commit acb03d3881818581052924a9bbbe92b8741ed448 upstream.

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
[Lee: Context conflict only - no functional change]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 fs/exec.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a2f72a503b7a..5980f577026d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1234,6 +1234,17 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 	perf_event_comm(tsk, exec);
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
@@ -1262,6 +1273,15 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
+	/*
+	 * This must be done here to ensure that POSIX CPU timers which were
+	 * armed on the current task are dequeued from me::posix_cputimers.
+	 * Otherwise in case of a TID switch the deletion of the related POSIX
+	 * timer would not remove an enqueued timer because the TID lookup
+	 * of the old TID fails.
+	 */
+	posixtimer_exec(me);
+
 	/* Ensure the files table is not shared. */
 	retval = unshare_files();
 	if (retval)
@@ -1303,14 +1323,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	bprm->mm = NULL;
 
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
-- 
2.56.0.313.g2479322e68-goog

