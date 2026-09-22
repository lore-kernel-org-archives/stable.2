Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4962339CCF8
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044329; cv=none; b=Bipkbzui1g+3lso2jqxeu4prV/4h5qkF/Cly7jz/z/momHr2qyAb08fS86F1lgrsLNdxKt040cDQlKy9tZ6AIN7ICf91obHfckEKUcVT6acoDJsdJ+0aY7+x6R7zQAEoL9UTskmuh2ZCleuZH4aM0XjK0B4fVYALkrbz7qBoiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044329; c=relaxed/simple;
	bh=OWrmlEyHyg7cYKICRi9qQd8KLeurdcnjIE3fpyU+tBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feu7plgOGOb5LlFt+MW3MhhWkhuJ66VHZwP9fSQM9pyN+38FBMXJZD6KA2JvmZMcUAOwwDaGBiHZI5T7wzNcnOktjQhWiFGEmczremGRb5hnwVdJ3jRwGZJkR1B7HuOjf+/Jt2+i9an33u+cv2RvrvXVTlP4l5928a8FzOx5BHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV4Od/BD; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV4Od/BD"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so3521492a91.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790044326; x=1790649126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4mFagjV1SEq8DGpthdMn6xHW8xleMxzMDlgFzTrE6fc=;
        b=LV4Od/BDzUoepFUMNBt085ZRwbw7pJjHyQ1iahJAwdMY0UrFoabckigEwMJuaotToV
         Fx1cyiOJeo/GLViQPjpr016MsIeFRU1M+Nje8+KZGLKaWj8nhp8pVuH7yYzLNBvLat7P
         Bgvt43ETMKH68H2UNa029p7uNMbhfeyGHNIouuB4Oex2uNCj0pAcKGASJLTdIBY/hYI3
         CuOD66LhweOoNcHdyLlNagX0ylSTck7YStHFBiBp3OhlRxa5yEVnFcsSewzxZDxmAR3B
         nQ/MwVJ5Q++5UktJ+kaKcgn15pYGJ1/b+uEO3N1s6rcQwkdjmLtO+PTBx9HTRAkvoZOm
         Drkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044326; x=1790649126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4mFagjV1SEq8DGpthdMn6xHW8xleMxzMDlgFzTrE6fc=;
        b=nbzWl9EqseC8Wt+/T/WqCbTL2w3ZnOaEqCnAbbVne/9tHAO71YM3EvDyl3L72TNs52
         uKmdZdJMM+AOyadTDbBQTLH/vAEVWggDoPXRiC65YwKg4jEr88nQEJnkE94H/SpwEROm
         1kiB6Il79ByMZ+59Nqzm+8HKO3Bwry0Ms6YyvS28MH1YBAC3WuMAwp9eAmKCgr35I8+y
         gxfG7LKRxVHiDjSIdW1YOC2eWM/bT1E6PTTYdJqPv2XQ5RM5CRvYx04rZNJpKI8yfynp
         nfAGRDGdvOgO8C86tXNBXVIrSP4gIaiwsuKhLMvI0hcmSUGdy2JBlGfhWXks+9/rJYQg
         8e2Q==
X-Forwarded-Encrypted: i=1; AKwUvBx0Y4tJVkl0Vz8hc8z0b8FBQ/oKcOM74kwJfnglkFsyxlOyPNsGJLevvdsywoyor0N24jj7ulM=@vger.kernel.org
X-Gm-Message-State: AFuF++lzq0nPQLpOatOgP3bGVTEejn32xt3zfe+r/z52jV5I3ihCfaOS
	3d+vaVrIKb3Q7oBnqQAUTyWEmm+fcVDlCng/DrRjuxpCoRFQ9mMUhnwUS7ks70yk
X-Gm-Gg: AYBFou0MDhTkprU+klK9nysPhyDASB0G6WxUmXVLNhVHdEun8Sv1NTYQuBdlVxzMSlb
	kS6MORD4dhy17F3mNKES53Xb41aQDpa0UsiCErZWvNMSDzACX3kVRSAcxTl1N6Z2AsRBuP6Q+If
	rC+ygvRqkn7mkCAXa9Z3aGfRAbpf5ZLi35hVImdmTYIp5e4wceYAPZi2f1GfRo4l3ki9Mo2V0d7
	Md0k5HYoiu3UgHWahHvM7o2GfZikhruuT6Ge7zCB8M6GsCr+nFXF39sYLxk7Je+nLVs35A3nng9
	Y0VFCApiI7xYI+EWOudk8y2NLDqwGwsWzjI4tLMadsX/P0gszNpwjPykz9OT3CDFwgNo1GUVMs8
	DNwlNYwKuSHU10hJV8ytB+XV1VS1Qthd/cToxzLI1qTq2prwNwt4jv8VJe++Z87LhZzkgFYXRoS
	lcsBMN79anm0trbfBvTloLh3rfG3zSG6advW1Sfb/dhZe2WppYSDYTNlLChzE1zacq9YIpLr253
	96+6SWQjrKh+CTFAekrv4AEOYQqXJ1W94v+QlI+1IRspTqQ6BtJSpjE7okEtNleUMU6wOD50yUL
	9z38slmSTA==
X-Received: by 2002:a17:90b:2d44:b0:39d:8794:5564 with SMTP id 98e67ed59e1d1-39e54ce36fdmr19680388a91.12.1790044326199;
        Mon, 21 Sep 2026 19:32:06 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5a5eb4sm501764a91.14.2026.09.21.19.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:32:05 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5] seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND is interrupted
Date: Tue, 22 Sep 2026 02:32:04 +0000
Message-ID: <20260922023204.2504832-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <202609210158.F3D96F157@keescook>
References: <202609210158.F3D96F157@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In seccomp_notify_addfd(), when SECCOMP_ADDFD_FLAG_SEND is set in
addfd.flags, knotif->state is optimistically transitioned from
SECCOMP_NOTIFY_SENT to SECCOMP_NOTIFY_REPLIED before waking the tracee
and waiting on kaddfd.completion:

	if (addfd.flags & SECCOMP_ADDFD_FLAG_SEND) {
		knotif->state = SECCOMP_NOTIFY_REPLIED;
		...
	}

If wait_for_completion_interruptible(&kaddfd.completion) is interrupted
by a signal before the tracee dequeues the kaddfd request
(!list_empty(&kaddfd.list)), seccomp_notify_addfd() removes kaddfd from
knotif->addfd and returns -EINTR to the supervisor without having
installed the file descriptor.

However, knotif->state is left as SECCOMP_NOTIFY_REPLIED (with
knotif->error == 0 and knotif->val == 0). This causes two problems:

1. When the tracee runs in do_user_notif(), it checks
   if (knotif.state != SECCOMP_NOTIFY_REPLIED) after calling
   seccomp_handle_addfd(). Because knotif->state is already
   SECCOMP_NOTIFY_REPLIED, the tracee exits the notification wait loop
   prematurely and returns 0 from the trapped syscall without the file
   descriptor ever having been installed.

2. If the supervisor retries SECCOMP_IOCTL_NOTIF_ADDFD or
   SECCOMP_IOCTL_NOTIF_SEND before the tracee runs, it fails with
   -EINPROGRESS because knotif->state is no longer SECCOMP_NOTIFY_SENT.

Fix this by restoring knotif->state back to SECCOMP_NOTIFY_SENT if
SECCOMP_ADDFD_FLAG_SEND was set and kaddfd was not consumed before the
interrupted wait. Also add a seccomp_bpf selftest
(user_notification_addfd_send_interrupted) covering this race.

Tested in QEMU against Linux 7.3.0-rc3 using the
user_notification_addfd_send_interrupted selftest added in this patch
(./seccomp_bpf -t user_notification_addfd_send_interrupted): on the
unfixed kernel the test fails because the retry ioctl(listener,
SECCOMP_IOCTL_NOTIF_ADDFD, &addfd) returns -EINPROGRESS (-1) and the
tracee prematurely exits do_user_notif() with return value 0 instead of
FD 42, whereas with this patch applied the test passes.

Fixes: 0ae71c7720e3 ("seccomp: Support atomic "addfd + send reply"")
Cc: stable@vger.kernel.org
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v5:
- Check the return values of all sched_setscheduler() calls in
  user_notification_addfd_send_interrupted, as requested by Kees Cook.
- Restore SCHED_OTHER on the supervisor and tracee immediately after
  ioctl(SECCOMP_IOCTL_NOTIF_ADDFD) returns (and on fork() failure) so
  the test cannot remain SCHED_FIFO on a single-CPU VM/CI runner, as
  suggested by Kees Cook.
- Rename pid and struct sched_param variables (tracee_pid, sp_zero,
  sp_fifo_high, sp_fifo_mid) for clarity.

Changes in v4:
- Restore Reviewed-by: Bradley Morgan <brads@mainlining.org> and Cc:
  stable@vger.kernel.org tags from v1 (and restore Bradley Morgan to Cc),
  and add Assisted-by: LLM tag.
- Fix Fixes: tag SHA and subject (0ae71c7720e3 ("seccomp: Support atomic
  "addfd + send reply"")).
- Fix truncated word "interrupted" in the Subject line.

Changes in v3:
- Actually include the tools/testing/selftests/seccomp/seccomp_bpf.c
  regression test in the patch diff (v2 accidentally omitted the selftest
  hunk), with detailed comments explaining the race and test setup.

Changes in v2:
- Add user_notification_addfd_send_interrupted regression test to
  tools/testing/selftests/seccomp/seccomp_bpf.c as requested by Kees Cook.

 kernel/seccomp.c                              |   5 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 184 ++++++++++++++++++
 2 files changed, 187 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 86cf4460d69e..94c7ba80a8f7 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1808,10 +1808,13 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 	 * We need to check again if the addfd request has been handled,
 	 * and if not, we will remove it from the queue.
 	 */
-	if (list_empty(&kaddfd.list))
+	if (list_empty(&kaddfd.list)) {
 		ret = kaddfd.ret;
-	else
+	} else {
 		list_del(&kaddfd.list);
+		if (addfd.flags & SECCOMP_ADDFD_FLAG_SEND)
+			knotif->state = SECCOMP_NOTIFY_SENT;
+	}
 
 out_unlock:
 	mutex_unlock(&filter->notify_lock);
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 0622bc2acad4..8cafac59ec7b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4368,6 +4368,184 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
 
+static void sigusr1_handler(int signo)
+{
+}
+
+/*
+ * Verify that when SECCOMP_IOCTL_NOTIF_ADDFD with SECCOMP_ADDFD_FLAG_SEND is
+ * interrupted by a signal before the tracee dequeues the addfd request,
+ * knotif->state is restored from SECCOMP_NOTIFY_REPLIED back to
+ * SECCOMP_NOTIFY_SENT so that:
+ *   1. The woken tracee sees knotif->state == SECCOMP_NOTIFY_SENT in
+ *      do_user_notif() and goes back to sleep instead of prematurely
+ *      returning 0 from the trapped syscall without the FD installed.
+ *   2. The supervisor can retry SECCOMP_IOCTL_NOTIF_ADDFD (or
+ *      SECCOMP_IOCTL_NOTIF_SEND) instead of failing with -EINPROGRESS.
+ *
+ * To deterministically hit the race window where the supervisor sleeps in
+ * wait_for_completion_interruptible(&kaddfd.completion) after waking the
+ * tracee (complete(&knotif->ready)) but before the tracee runs
+ * seccomp_handle_addfd(), pin all processes to a single CPU and enforce a
+ * strict 3-tier scheduling priority hierarchy on that CPU:
+ *   - Supervisor:            SCHED_FIFO priority 99 (highest)
+ *   - Signal helper (sig_pid): SCHED_FIFO priority 50 (middle)
+ *   - Tracee (pid):          SCHED_IDLE             (lowest)
+ */
+TEST(user_notification_addfd_send_interrupted)
+{
+	/*
+	 * Save parent_pid before user_notif_syscall(__NR_getppid, ...) installs
+	 * the seccomp filter on the calling process; children inherit that
+	 * filter, so sig_pid must not call getppid().
+	 */
+	pid_t tracee_pid, sig_pid, parent_pid = getpid();
+	long ret;
+	int status, listener, memfd, err;
+	struct seccomp_notif_addfd addfd = {};
+	struct seccomp_notif req = {};
+	struct sigaction sa = {};
+	struct sched_param sp_zero = { .sched_priority = 0 };
+	struct sched_param sp_fifo_high = { .sched_priority = 99 };
+	struct sched_param sp_fifo_mid = { .sched_priority = 50 };
+	struct timespec delay = { .tv_nsec = 15000000 };
+	cpu_set_t cpuset;
+	int cpu;
+
+	/* Pin the supervisor (and its future child processes) to one CPU. */
+	cpu = sched_getcpu();
+	if (cpu >= 0) {
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu, &cpuset);
+		sched_setaffinity(0, sizeof(cpuset), &cpuset);
+	}
+
+	sa.sa_handler = sigusr1_handler;
+	ASSERT_EQ(sigaction(SIGUSR1, &sa, NULL), 0);
+
+	memfd = memfd_create("test", 0);
+	ASSERT_GE(memfd, 0);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/*
+	 * Follow the convention of other user_notification_* tests in this
+	 * file by trapping __NR_getppid: because the filter is installed on
+	 * the supervisor before fork(), the trapped syscall must be a
+	 * side-effect-free syscall that the supervisor itself never invokes.
+	 * Even though getppid() does not normally return an FD,
+	 * SECCOMP_ADDFD_FLAG_SEND replaces the trapped syscall's return value
+	 * with the newly installed FD number (42).
+	 */
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	tracee_pid = fork();
+	ASSERT_GE(tracee_pid, 0);
+
+	if (tracee_pid == 0) {
+		/*
+		 * Tracee: invoke __NR_getppid as a dummy trigger syscall to
+		 * trap into do_user_notif(). Verify that the syscall returns
+		 * the injected FD number (42) and that FD 42 is open.
+		 */
+		ret = syscall(__NR_getppid);
+		exit(ret != 42 || fcntl(42, F_GETFD) < 0);
+	}
+
+	/* Wait for the tracee to trap in do_user_notif(). */
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+	/*
+	 * Demote the tracee to SCHED_IDLE and promote the supervisor to
+	 * SCHED_FIFO(99) on the same CPU.
+	 */
+	ASSERT_EQ(sched_setscheduler(tracee_pid, SCHED_IDLE, &sp_zero), 0);
+	if (sched_setscheduler(0, SCHED_FIFO, &sp_fifo_high) != 0) {
+		kill(tracee_pid, SIGKILL);
+		waitpid(tracee_pid, NULL, 0);
+		SKIP(return, "SCHED_FIFO requires CAP_SYS_NICE");
+	}
+
+	addfd.srcfd = memfd;
+	addfd.newfd_flags = O_CLOEXEC;
+	addfd.newfd = 42;
+	addfd.id = req.id;
+	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD | SECCOMP_ADDFD_FLAG_SEND;
+
+	/*
+	 * Fork a signal helper on the same CPU and set it to SCHED_FIFO(50).
+	 * Because the supervisor is currently running at SCHED_FIFO(99) on
+	 * this CPU, sig_pid is queued on the runqueue but cannot run until the
+	 * supervisor blocks inside the kernel.
+	 *
+	 * When the supervisor invokes ioctl(SECCOMP_IOCTL_NOTIF_ADDFD) below:
+	 *   1. seccomp_notify_addfd() sets knotif->state = SECCOMP_NOTIFY_REPLIED,
+	 *      wakes the tracee (SCHED_IDLE), and blocks in
+	 *      wait_for_completion_interruptible(&kaddfd.completion).
+	 *   2. The CPU scheduler immediately runs sig_pid (SCHED_FIFO 50)
+	 *      ahead of the woken tracee (SCHED_IDLE).
+	 *   3. sig_pid sends SIGUSR1 to parent_pid, waking the supervisor
+	 *      (SCHED_FIFO 99), which immediately preempts sig_pid, aborts the
+	 *      wait with -ERESTARTSYS (-EINTR), removes kaddfd from
+	 *      knotif->addfd, and restores knotif->state = SECCOMP_NOTIFY_SENT
+	 *      before the tracee has executed a single instruction.
+	 */
+	sig_pid = fork();
+	if (sig_pid < 0) {
+		sched_setscheduler(0, SCHED_OTHER, &sp_zero);
+		kill(tracee_pid, SIGKILL);
+		waitpid(tracee_pid, NULL, 0);
+	}
+	ASSERT_GE(sig_pid, 0);
+	if (sig_pid == 0) {
+		if (sched_setscheduler(0, SCHED_FIFO, &sp_fifo_mid) != 0)
+			_exit(1);
+		kill(parent_pid, SIGUSR1);
+		_exit(0);
+	}
+
+	ret = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
+	err = errno;
+
+	/*
+	 * Restore normal scheduling ASAP so the supervisor does not remain
+	 * SCHED_FIFO on a single-CPU machine/VM/CI, then sleep briefly so the
+	 * woken tracee runs in do_user_notif(). With knotif->state restored to
+	 * SECCOMP_NOTIFY_SENT, the tracee must loop back to sleep waiting for
+	 * the notification reply rather than returning 0 from __NR_getppid.
+	 */
+	ASSERT_EQ(sched_setscheduler(0, SCHED_OTHER, &sp_zero), 0);
+	ASSERT_EQ(sched_setscheduler(tracee_pid, SCHED_OTHER, &sp_zero), 0);
+
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(err, EINTR);
+	EXPECT_EQ(waitpid(sig_pid, &status, 0), sig_pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	nanosleep(&delay, NULL);
+
+	/*
+	 * Retry SECCOMP_IOCTL_NOTIF_ADDFD. Because knotif->state is
+	 * SECCOMP_NOTIFY_SENT, the retry succeeds (returns 42) instead of
+	 * failing with -EINPROGRESS, installs FD 42 into the tracee, and wakes
+	 * the tracee to complete the syscall with return value 42.
+	 */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), 42);
+
+	EXPECT_EQ(waitpid(tracee_pid, &status, 0), tracee_pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(listener);
+	close(memfd);
+}
+
 #ifndef SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP
 #define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
 #define SECCOMP_IOCTL_NOTIF_SET_FLAGS  SECCOMP_IOW(4, __u64)
-- 
2.49.0
