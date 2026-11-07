Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049176;
	b=PM7nyUQPIvV0xIHZo1z9wnkAbDTZpB46QMd4Q1/ui4clumiZ9WweKHkxuYtrXAILcXGq
	 gr7Y9nXJD6wB2NS/BMQM56gfrhJ3sxwoEu7HQGATizA0hof93IHxsASK1BAVdm62pWu/L
	 jHJePI2aVafNBj+jYtAtiFzUOZLOmefrbT2rZS1sF60wG6xxcgkIEw4aUkTc5E8QPDwle
	 oaXb4wWMh6EDnQnC+iXzEZk1BdttXFTfLU4MkXLB+S2tKLZ+6EZIAR//ow6fdOjZVbB5z
	 24+jlk4AOWmR2LTRhqCSFgrmNrUyGo6evDjVpzVLGXaQDlLEB4CGLsxhMGUMiKj0fvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049176;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FI2w6ZFgLYad93OFyKkpBTljGwkS2XmSVzlRlj33edQ=;
	b=0tWxMRCwaBZYu088OCiTYCRWS9dk4zcLwg+78gtHVuAe3rwVEDuTTBLK2V/22XD7B62S
	 D++UN/EGvz75CCBGAzyaPR6oLOkTpRGY+SjffLu7fu/q7vST1QT7P7kigLLjMyDNs2ZHJ
	 fWl8Uc9d9WLHltcgzYPhDamMI46JFjSMEX0p4HL7nbDMFhZ9rmKpaoB9y2X+UfVA9VaOQ
	 EaWQ86mjMWX/pGC345GUZ6xOdJHZerq/d2ZzLvoaex9N1rP6IsQLgiwRGVjTQaqRG4orf
	 viDYihkw5Cws3WPqpt4S7RDgw5K8IQuBb4LuTUcQ1ktJ/aWqgX10MjqNlXssSk+264Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzlgU5Z4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89E606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzlgU5Z4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255321F0089F;
	Sat,  7 Nov 2026 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049175;
	bh=FI2w6ZFgLYad93OFyKkpBTljGwkS2XmSVzlRlj33edQ=;
	h=From:To:Cc:Subject:Date;
	b=WzlgU5Z4+TBUPiFERvLbaQWaKd9YIw4CRc1dFnqWdP/UvaUFm2etyiO/rCiElicnK
	 txcFLyjvcPCueIEawmyqgNvEvIy3VH9YSCa66t2fwcoo/V/h/ihU3nn1FiV4s+t4Xh
	 soKHF7ZAHXLpY7ylt8pAV/hWGELcLWvzzWSqDmPx9jlnObazo08NZ8RfLEhLEKdOqN
	 5tx7ARDcCNeHd4qWKBqYxs7sv2scsTiPtWWaDLmTugfnzZu9fVvjqp1BlNI/iRTOqL
	 bNDJWo7nkaid2qL4atVavMPSZJ2UL0Tg11gtAp2iPtdv9ognHRNjdckVEKew9RwUPg
	 NK/1xbph7eQtQ==
From: Sasha Levin <sashal@kernel.org>
To: benquike@gmail.com,
	brads@mainlining.org,
	kees@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND is interrupted" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:33 -0500
Message-ID: <20261107055933-failed-5.15-832b9b176be0@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 832b9b176be06a20747a267db6bc0010a24b74f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055933-failed-5.15-832b9b176be0@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 832b9b176be06a20747a267db6bc0010a24b74f4 Mon Sep 17 00:00:00 2001
From: Hui Peng <benquike@gmail.com>
Date: Tue, 22 Sep 2026 02:32:04 +0000
Subject: [PATCH] seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND
 is interrupted

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
Link: https://patch.msgid.link/20260922023204.2504832-1-benquike@gmail.com
Signed-off-by: Kees Cook <kees@kernel.org>
---
 kernel/seccomp.c                              |   7 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 179 ++++++++++++++++++
 2 files changed, 184 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 86cf4460d69ea..94c7ba80a8f74 100644
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
index 0622bc2acad40..891383a161d0b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4368,6 +4368,185 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
 
+/* Just take a signal and do nothing else. */
+static void empty_handler(int signo)
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
+	sa.sa_handler = empty_handler;
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
2.53.0




