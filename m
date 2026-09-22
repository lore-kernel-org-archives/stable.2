Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E267A5505D0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090577; cv=none; b=kxf6lDAvvV7pNVrB28s0K0e5UvX0E1MmUEvfPu+g31fZ2ndAikZaL0k/uj0Nuy4Xoeay8TkfY2folhc8aqcJvH60ou9Szb2kID6do/F8dODyAPqHron+3PfX2E7pZraZFcEucRKh3e+SaT/F0H0VUJ7DewXw2ED6sLYY19JV8VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090577; c=relaxed/simple;
	bh=0zeXwD9zlx+gVGzZNs0rIeo/BYmpYoI7OcleeUXzwSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEzFP7ozzC7WWDhuLZzAxCAqnBnX95tPdevJqrpf3OG4PDGe3COWY8Brhkp151vWYG1pvfUXazgdFGMS9PvjeqqoIdtzZPzo/acrgisQG4W34RsnqkNyLrmk/0hQwNNEJ6sI2nTMOX4yH6VFZtZbMtEVTvwJH3Ow1AaBpEZQBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOjAbYWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOjAbYWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1395E1F000FF;
	Tue, 22 Sep 2026 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090575;
	bh=cp4pvIg9n6ozNzoNEmJ9ZjmLHZ5bWE3Aqq+ZBAFY/0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bOjAbYWwOaXgfduMQMwuKHtj3VyLjsaN0lfUmhdlNWfbFipcgFk0bp0UjLqv+iWWc
	 jPHbElN8Vg+ZY6KqzRzyoJ48sG7mRm76t1kXwhkxxDwzswM2S02Z7vcKibf2Lgi/3w
	 sHTm5M7umb3QgqOr+MPoYAuhOVAG3WOEuo2OxFJrFMpHlQtrEm23ErVH63lcPNVsp3
	 hbbBLewY2om3/NVcTjPW9d7sk8qQA2Zw+KVeMvnRlPYUFxa733gL0jZG3qsTi0Luou
	 psw2mTvm+Y2QvOSOWOVF2xLhtBGag+K4aCQTn5zjncSw9FOgBMb0yfNtrMPpuxvDBX
	 uasMGuibZuZCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Kijo Park <red993688@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] exec: Cleanup POSIX timers right after de_thread()
Date: Tue, 22 Sep 2026 11:22:53 -0400
Message-ID: <20260922152253.2800305-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092225-humongous-ultimate-9930@gregkh>
References: <2026092225-humongous-ultimate-9930@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit acb03d3881818581052924a9bbbe92b8741ed448 ]

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
[ kept timer cleanup inline instead of introducing upstream’s posixtimer_exec() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e4dd402aa4ce6..8e91240a71e17 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1268,6 +1268,21 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
+	/*
+	 * This must be done here to ensure that POSIX CPU timers which were
+	 * armed on the current task are dequeued from me::posix_cputimers.
+	 * Otherwise in case of a TID switch the deletion of the related POSIX
+	 * timer would not remove an enqueued timer because the TID lookup
+	 * of the old TID fails.
+	 */
+#ifdef CONFIG_POSIX_TIMERS
+	spin_lock_irq(&me->sighand->siglock);
+	posix_cpu_timers_exit(me);
+	spin_unlock_irq(&me->sighand->siglock);
+	exit_itimers(me);
+	flush_itimer_signals();
+#endif
+
 	/*
 	 * Cancel any io_uring activity across execve
 	 */
@@ -1302,14 +1317,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
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
2.53.0

