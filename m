Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190079;
	b=NFMun2mDYIT8GNnIhxZ3EEq+BY5BhKsO+PAFnvp2KolsHeT95dOmEKOvjSNGnXL16UPF
	 an7QWJQNh7VT84PSkOsI7MrXbIwr+2PACgoFZGFChIh1nxAmS0PsiuLkG6Wd7t6fGfSNM
	 3+v0xIq6j2TPxBC5sJuQXzLyxq40MMUCsHyJN26EnqaWCDwZFza05ORDN9QpXuR4hUiLu
	 rEIuFaiRbu1y1VhEdj123SFmpBScTaP30vJIaMbNHn6mj6/7sVB/EvJZCwiB+J6ICyGQh
	 rV8hVw6wt3Jzavs+Si+w10KNdFWTArw8ejICNVUVXSOrdahGdvnFSTcVAyXC/kh8Q0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190079;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=POFTP/JURJS04WunI6m5dVp5z76P4GfyBi0I7yizAPs=;
	b=1thVWEUGcjf6ZafGXcZjax8lw1kSn8OVvoIY5lVoaSKxhiGMBTDaNW1bKCkeHVFS7anW
	 D/MbZu6cRFcve79fu6aaSxsRRVg1o+GgPopsVzsYdPeP3bmpF+J2siyifjpEqWAQPmvky
	 h4cbW+q9WIvaM/ISXsSh9qyAa1FX4g3shD9cUBLp4gYXX4wOQN/dxjsQs1+dNM25HxmTy
	 AwfUd5wiOmdhTlAzDrJ4RNl/CJNJtfB7GokWKHK620ttR9IIEhhLkV5hXJaTmidxr6H5c
	 6a/pYXxJOE8W0oRHdaNwYKFDiCpSSaFGb2f66bOjUk/rdmD646FDWjZd6kfKHiaGdfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3qbEVXJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA137606A32E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3qbEVXJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBE61F031E0;
	Wed, 28 Oct 2026 12:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793190078;
	bh=POFTP/JURJS04WunI6m5dVp5z76P4GfyBi0I7yizAPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A3qbEVXJJO5UIg7L39bzJccddR77Y+nMKUXdF3/gu8AAkQSpudmzNLaGYXCDxwMFF
	 SZpjAqiiagSuPixfncCWBf5yEfZXgnPam0VBFLn8duScNw5hTXwFQZNox7olJT+O+3
	 pyEbDsCn0IctCAsdfJNET/wg624tpYUbj+TawfPzniAXOerSTkluJih/niH/BdIIJ+
	 2N4dj1Yavpl3elDkOR/2N+7tEa7uEDFZQJ6Q16mcASBWFTtbYm0nUCFnN/t4JGjDzs
	 xgefUK7dX7MNzTrVgR/rVc2gcdUomQ/KmZDIMIWZ4h5BOIiQl/ng7vvX9it6ub2vWj
	 GHSLEaufWdpFw==
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
Subject: [STABLE v5.15] exec: Cleanup POSIX timers right after de_thread()
Date: Wed, 28 Oct 2026 12:21:14 +0000
Message-ID: <20261028122114.3429846-1-lee@kernel.org>
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
index 6797c8cf88f4..5efe7ae6f968 100644
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
 	/*
 	 * Cancel any io_uring activity across execve
 	 */
@@ -1310,14 +1330,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
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

