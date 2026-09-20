Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com [74.125.227.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506A3D7D94
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789930756; cv=none; b=bmKB94ZFlAWuGh91dDyeX4rIJbfTm2WpDjMBJ2bFpDjf3fBzPMSQmcB4raL0RKzbTDC1Lkg03k0PwCfbcEKqtrSVskS2hgMozVa0tGY32yaKtULSf24z73j50dBJI02RjMkBlhT/GpgWv+59B5ogtm6zjAxnFFYxwGSJZ7S8p2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789930756; c=relaxed/simple;
	bh=46uMN4lJrSmclQBpzEHuI1ksKCrff2Sc5bU/8mZe8KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haGYgv7CT53Zvw+Vat/9cuoOGu2KNrVyMOIegPjCdcstRw5MxWrwgP10MIfzIs7WkXWp/YbceA3c9YDUCyhtuPgQkAvExQxKgsiPhb7beIlFay8X0If2BOxYH3VX9XePNqCpjPyp/SzR3hdCeWVN1mKmP7FquRxerPF5MAsVaXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffgKgLAb; arc=none smtp.client-ip=74.125.227.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffgKgLAb"
Received: by mail-pj2-f21.google.com with SMTP id d9443c01a7336-2d747f0b25dso25251775ad.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789930752; x=1790535552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X3PDFqCazi4Kprb1qz6IGJP/J9CVmi8tfYOpx0/Dzzg=;
        b=ffgKgLAbQaZECqL+qKjbUDFWWeAUFMvS/DDrYuKOgqA1oeYQrAGDaCVwrkU+cHXF8I
         EvOM6nbWqsJzA3VlLfiPwedKqFK3ODReBpjWsLzwGtbtLMLoGS53KQJR///+DldmV7PV
         8sgvYGaUN8VajREmG3rIQCBAp69faeNmp4jffVcPvHNoL1a64Qu3zKazyvUecF1ia6qx
         3TtOMskVh3zdxCsRa8e4uSAocg1llJOvpQ5ViIC7o+1yLBpP2amMkRway2SQwnpBxq0d
         C9/EepQhhCTTApqtpxMlMVoPugxzopBCjQvtMel0h3DiRNtuFpRXCPhTU5MKVLxzHBK7
         tYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789930752; x=1790535552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X3PDFqCazi4Kprb1qz6IGJP/J9CVmi8tfYOpx0/Dzzg=;
        b=PYejdY8az8wrTokYySaTyxq/Ijlqbqq6Q/HZn4ZpGUdZ/hePUbZ+ObwRB/ODafhyOu
         V0umETKnm7pVWW9Jgke5GUUbtBWfA3eLVX/6N+kam5W4Hw8356CI6626JQQuMLQjk9wL
         PQVi8dvGXvu823aTZPvQaS4qUZQcRmXary4Xu9VginE5sx8cj7qd+ymFXiEvATko07GW
         3Dv5wGnz9xUE/1InXHIabJxkJequSle4gENFVW9nygn9DZz8mmIxNMhK2PiRVRklKxL9
         AGyFtuZp3FUpwA5AK394ueVgyie5QzbhKzJlHbTDJYHoWq9YJactFxlRcc326w7Cqk2N
         rBHA==
X-Forwarded-Encrypted: i=1; AKwUvBxASKngkSND+WdnZM6XJe2TFqC4HDIbYnCztsFI8iGrfOWP0tMbq8gElFLcb3zdTtKoQbhdJJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++mAl6YXdN7z4z6Ic5B83y5jneU5uxMxv76Wkre5rRYhEujtvz65
	e/auiXLECBOEc72qk9gMrVCdeq7Vgeb6RbstgFRRI30EA6/CU/U5pslb
X-Gm-Gg: AYBFou3jJeNqiJ1wWeTBPjN2JCnOtb4+EokynvNI7jmQQ83ACCK+ZWLoXSbeaISkOOS
	1MLU1I679U2ucZm2b57irbpZzMnUqVoj0n5WKJ6OZvKFiN08bTv7VRonpt0zFK7F0QU6GGYRtcO
	RWdNpQgC0/F3bkHoSeZFmVOFylz2E47M5aKHOikufBqn70VLK26uI7/zqsMaITukwYo7/5iUzr4
	CaqrxgdTjWi7yH6GCs+QaDqQi1e15SyESEOxY1NuQrcTu/k1bZitQIL1d+EkCKKudos/wStNbR6
	T+odRqOlVva+D4MuDIFxd3XjKr4NFAQcAB33dHmOg3JbC06RkRCe/ciiEyDZs7JTxbHVGFYLiFR
	xQxjaoMdubzNtYMat4U4z4mjUiB/Ct7DGV/+GVIAlTee1ts4aZST6pWWFcBv4DMAl8EOwFARDxG
	yltR9zrdZR+0vKDEYQ5Sl4K/Ya5EWaeL3Gw33y10yRoVt9mUXjQskZzebzjVN1XVybXJ6o8QO7F
	TpQV+VVRBa0/lKpctgdg8MYIeOYomxVm5qWBszYvGyvYKF2b36SA4bjS7RpusTpdLN+6LiGzVjA
	ZguQKjzmDw==
X-Received: by 2002:a17:902:eccb:b0:2dd:c100:3140 with SMTP id d9443c01a7336-2ddc100325fmr74778415ad.60.1789930752358;
        Sun, 20 Sep 2026 11:59:12 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df475fd2bcsm3912305ad.7.2026.09.20.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:59:11 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4] seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND is interrupted
Date: Sun, 20 Sep 2026 18:59:10 +0000
Message-ID: <20260920185910.3307638-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <A3F8F45D-3B9B-4E52-B076-7924FF3AF360@mainlining.org>
References: <A3F8F45D-3B9B-4E52-B076-7924FF3AF360@mainlining.org>
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

Tested in QEMU against Linux 7.3.0-rc3 by exercising kernel/seccomp.c
and verifying the fix with KASAN enabled.

Fixes: 0ae71c7720e3 ("seccomp: Support atomic "addfd + send reply"")
Cc: stable@vger.kernel.org
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
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

 kernel/seccomp.c                              |   2 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 161 ++++++++++++++++++
 2 files changed, 163 insertions(+)

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
index 0622bc2acad4..e565728f9eb2 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4368,6 +4368,173 @@ TEST(user_notification_addfd_rlimit)
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
+	pid_t pid, sig_pid, parent_pid = getpid();
+	long ret;
+	int status, listener, memfd;
+	struct seccomp_notif_addfd addfd = {};
+	struct seccomp_notif req = {};
+	struct sigaction sa = {};
+	struct sched_param sp_tracee_idle = { .sched_priority = 0 };
+	struct sched_param sp_supervisor_fifo = { .sched_priority = 99 };
+	struct sched_param sp_sig_helper_fifo = { .sched_priority = 50 };
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
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
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
+	sched_setscheduler(pid, SCHED_IDLE, &sp_tracee_idle);
+	if (sched_setscheduler(0, SCHED_FIFO, &sp_supervisor_fifo) != 0) {
+		close(listener);
+		close(memfd);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
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
+	ASSERT_GE(sig_pid, 0);
+	if (sig_pid == 0) {
+		sched_setscheduler(0, SCHED_FIFO, &sp_sig_helper_fifo);
+		kill(parent_pid, SIGUSR1);
+		_exit(0);
+	}
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EINTR);
+	EXPECT_EQ(waitpid(sig_pid, &status, 0), sig_pid);
+
+	/*
+	 * Restore normal scheduling and sleep briefly so the woken tracee
+	 * runs in do_user_notif(). With knotif->state restored to
+	 * SECCOMP_NOTIFY_SENT, the tracee must loop back to sleep waiting for
+	 * the notification reply rather than returning 0 from __NR_getppid.
+	 */
+	sched_setscheduler(0, SCHED_OTHER, &sp_tracee_idle);
+	sched_setscheduler(pid, SCHED_OTHER, &sp_tracee_idle);
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
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
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
