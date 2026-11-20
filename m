Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187775;
	b=yLCktI/ySvv0CVfJy4gpfrN9jteljY3oIt+iudsOyODpPKl7etMJidhB5sVnZHDJuvZg
	 OqYTvXZ1MvfA4et235hgT7ssE0nu8eIS6Hv+sNlMijDz33bF8QxKlv69NF/BG7cX4IE8l
	 mYuFlMzSF1qxJAm9c8iASCwWX1uYmTEvOunt5v6EYwqp8mWFLnLzUgmrzowEHWnmbXwRH
	 drrPv2kC2Bo28+sYk5uparCd8XlW5IiTnhgsCq1ECXGks8WdSJDYIhXHJwpwtwdD3DUJ1
	 IT0+eZE2uStujLhyzOKxEmWtlEhcvy49D07CQP0sNQ/av/mamHUGZfAJbRQpsutgZVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187775;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=VJY0pMaR2Hgf9iovNumsqArKUrBvWohEWSq9se+XYTE=;
	b=h4gVePz26I4A6MbuVj32zxSb9UrFWx6xP3pMQztgywiQEqwzrmqJv3VXmwDWNSMNeb9C
	 XGlfRhmzuBc0y7R7QgcLBzNfrJEBBkBCAQNgKWVraUNehwHI2ekzWnluIumryGTzrOduQ
	 /HXGrzGUFWkAI2crMCihumQQYQxVBqCaBZdXt6yVm2YjiDeaa+CZZZi0wXXb7Ug05FoMv
	 ZiuxlHqo2jVYkZMsz8haXSijn2Uklok5EBNPhd3A+4tviFbwEVfNMBYqy6HaamqtLxCaZ
	 EZoPaT30t87MZQQBkq4bJCXeZI9wTBli2V+KJsq8HNp3YbaOv4w/AiV0nH1yHuIarfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=DMxXhlY7;
	arc=none smtp.remote-ip=45.157.188.11
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B57606A331
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07B57606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=DMxXhlY7
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jWJnf64mdzFkj;
	Fri, 20 Nov 2026 16:16:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795187766;
	bh=VJY0pMaR2Hgf9iovNumsqArKUrBvWohEWSq9se+XYTE=;
	h=From:To:Cc:Subject:Date:From;
	b=DMxXhlY7b8WQ7iO3RoUeGpysJ7YKzXsiMxhIZJUnFatuUWXdqZGlfWb50jMlw+SP5
	 67adzrIb89Xrn+9QHD1uwQGdS++lQyx2F8vp4kUlVPlMSFCGE7q50yBMORlGiwcMxa
	 H9SMbddNEeE7KbmvXBq/eRrZedld4qfVmnF5O148=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jWJnZ5vbGz5M6;
	Fri, 20 Nov 2026 16:16:02 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bart Van Assche <bvanassche@acm.org>,
	Cen Zhang <blbllhy@gmail.com>,
	James Morris <jmorris@namei.org>,
	Lee Seong Hyeon <ihopenre@gmail.com>,
	Marco Elver <elver@google.com>,
	NeilBrown <neil@brown.name>,
	Nickolai Zeldovich <nickolai@csail.mit.edu>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Yihan Ding <dingyihan@uniontech.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] landlock: Do not hold exec_update_lock across the TSYNC wait
Date: Fri, 20 Nov 2026 16:15:52 +0100
Message-ID: <20261120151554.2651743-1-mic@digikod.net>
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
X-Infomaniak-Routing: alpha

landlock_restrict_sibling_threads() write-locks
current->signal->exec_update_lock to serialize TSYNC callers, and holds
it until every sibling thread has run its task_work.  This wait is
unbounded: TWA_SIGNAL does not wake a TASK_KILLABLE sleeper, so a
sibling blocked as a vfork() parent runs it only once its child execs or
exits.

Meanwhile, readers of this lock block, mostly in D state:
/proc/<pid>/stat, mm_access(), pidfd_getfd(), kcmp(), perf_event_open(),
etc.  An unprivileged process can thus stall tools run by other users,
including root, such as ps and top.

Only a per-process "TSYNC in progress" marker is needed.  Use an unused
signal_struct.flags bit, protected by sighand->siglock, which is held
only to set or clear the marker.  A second caller still restarts the
syscall, and a cleanup class releases the marker on every return.

Like de_thread(), treat a group exit or an ongoing exec as a held
marker: a group exit may overwrite the flags, and both kill the other
threads, which the restart lets the caller handle.

Add KUnit tests for taking a free marker and for rejecting a held one.
A concurrent TSYNC caller cannot be started deterministically from user
space, but a KUnit thread has no sibling and can hold the marker itself.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Yihan Ding <dingyihan@uniontech.com>
Cc: stable@vger.kernel.org
Reported-by: Lee Seong Hyeon <ihopenre@gmail.com>
Suggested-by: Lee Seong Hyeon <ihopenre@gmail.com>
Fixes: ff88df67dbf7 ("landlock: Serialize TSYNC thread restriction")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since the initial report from Lee Seong Hyeon:
- Rewrite the fix, storing the marker in an unused signal_struct.flags
  bit protected by sighand->siglock instead of adding a signal_struct
  field.
- Treat group exit and ongoing exec as a held marker, because group exit
  may overwrite the flags.
- Release the marker with a cleanup class.
- Clarify that not all readers wait in D state: perf_event_open() waits
  interruptibly.
- Add KUnit tests.
- Credit Lee Seong Hyeon with Reported-by and Suggested-by instead of
  authorship, because the implementation was rewritten.

Christian, Oleg, and Tejun, this patch reserves a signal_struct.flags
bit for Landlock and relies on group-exit paths overwriting these flags
under siglock.  Please check that this use of signal-core state is
acceptable.

Lee, this rewrites the patch you sent with your report, so it credits
you with Reported-by and Suggested-by.  Please tell me if you prefer a
different credit.
---
 include/linux/sched/signal.h |   1 +
 security/landlock/tsync.c    | 134 +++++++++++++++++++++++++++++++----
 2 files changed, 122 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0adb51ab1542..f68bbaa3527a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -262,6 +262,7 @@ struct signal_struct {
 #define SIGNAL_STOP_STOPPED	0x00000001 /* job control stop in effect */
 #define SIGNAL_STOP_CONTINUED	0x00000002 /* SIGCONT since WCONTINUED reap */
 #define SIGNAL_GROUP_EXIT	0x00000004 /* group exit in progress */
+#define SIGNAL_LANDLOCK_TSYNC	0x00000008 /* Landlock TSYNC in progress */
 /*
  * Pending notifications to parent.
  */
diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index cfa73a2a67ca..a6fa9ce0ac78 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -5,6 +5,7 @@
  * Copyright © 2025 Google LLC
  */
 
+#include <kunit/test.h>
 #include <linux/atomic.h>
 #include <linux/cleanup.h>
 #include <linux/completion.h>
@@ -479,6 +480,46 @@ static void cancel_tsync_works(const struct tsync_works *works,
 	}
 }
 
+/*
+ * try_set_current_tsync_marker - mark the current thread group as under TSYNC
+ *
+ * Returns false if another TSYNC operation, group exit, or exec is in progress.
+ */
+static bool try_set_current_tsync_marker(void)
+{
+	struct signal_struct *const signal = current->signal;
+
+	guard(spinlock_irq)(&current->sighand->siglock);
+
+	/*
+	 * Group-exit paths may replace all signal flags, including an active
+	 * marker.  Treat SIGNAL_GROUP_EXIT as a held marker to prevent another
+	 * TSYNC operation from starting during group teardown.
+	 *
+	 * Like de_thread(), also treat an ongoing exec as a group action in
+	 * progress.  de_thread() sets group_exec_task in the same siglock
+	 * critical section that sends SIGKILL to all other threads, including
+	 * current.  Instead of queuing task_work for exiting threads,
+	 * restart_syscall() lets current handle its pending SIGKILL.
+	 */
+	if ((signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_LANDLOCK_TSYNC)) ||
+	    signal->group_exec_task)
+		return false;
+
+	signal->flags |= SIGNAL_LANDLOCK_TSYNC;
+	return true;
+}
+
+static void clear_current_tsync_marker(void)
+{
+	guard(spinlock_irq)(&current->sighand->siglock);
+
+	current->signal->flags &= ~SIGNAL_LANDLOCK_TSYNC;
+}
+
+DEFINE_CLASS(current_tsync_marker, bool, if (_T) clear_current_tsync_marker(),
+	     try_set_current_tsync_marker(), void)
+
 /*
  * restrict_sibling_threads - enables a Landlock policy for all sibling threads
  */
@@ -492,6 +533,19 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 	size_t newly_discovered_threads;
 	bool found_more_threads;
 
+	/*
+	 * Serialize concurrent TSYNC operations to prevent deadlocks when
+	 * multiple threads call landlock_restrict_self() simultaneously.  If
+	 * another operation got there first, gracefully yield by restarting the
+	 * syscall.  This allows the current thread to process pending
+	 * task_works before retrying.
+	 *
+	 * sighand->siglock protects only the marker, not the wait below.
+	 */
+	CLASS(current_tsync_marker, marker)();
+	if (!marker)
+		return restart_syscall();
+
 	atomic_set(&shared_ctx.preparation_error, 0);
 	init_completion(&shared_ctx.all_prepared);
 	init_completion(&shared_ctx.ready_to_commit);
@@ -503,16 +557,6 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 		(restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) ||
 		task_no_new_privs(current);
 
-	/*
-	 * Serialize concurrent TSYNC operations to prevent deadlocks when
-	 * multiple threads call landlock_restrict_self() simultaneously.
-	 * If the lock is already held, we gracefully yield by restarting the
-	 * syscall. This allows the current thread to process pending
-	 * task_works before retrying.
-	 */
-	if (!down_write_trylock(&current->signal->exec_update_lock))
-		return restart_syscall();
-
 	/*
 	 * We schedule a pseudo-signal task_work for each of the calling task's
 	 * sibling threads.  In the task work, each thread:
@@ -536,8 +580,9 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 	 * 5) signals that it's done altogether (barrier synchronization
 	 *    "all_finished")
 	 *
-	 * Unlike seccomp, which modifies sibling tasks directly, we do not
-	 * need to acquire the cred_guard_mutex and sighand->siglock:
+	 * Unlike seccomp, which modifies sibling tasks directly, we do not need
+	 * to hold the cred_guard_mutex or sighand->siglock around the thread
+	 * walk:
 	 *
 	 * - As in our case, all threads are themselves exchanging their own
 	 *   struct cred through the credentials API, no locks are needed for
@@ -634,6 +679,69 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 		wait_for_completion(&shared_ctx.all_finished);
 
 	tsync_works_release(&works);
-	up_write(&current->signal->exec_update_lock);
 	return atomic_read(&shared_ctx.preparation_error);
 }
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static bool is_current_tsync_marker_set(void)
+{
+	return current->signal->flags & SIGNAL_LANDLOCK_TSYNC;
+}
+
+static void test_tsync_marker_free(struct kunit *const test)
+{
+	const struct cred *const cred = current_cred();
+
+	KUNIT_ASSERT_TRUE(test, thread_group_empty(current));
+	KUNIT_ASSERT_FALSE(test, is_current_tsync_marker_set());
+
+	KUNIT_EXPECT_TRUE(test, try_set_current_tsync_marker());
+	KUNIT_EXPECT_TRUE(test, is_current_tsync_marker_set());
+	clear_current_tsync_marker();
+	KUNIT_EXPECT_FALSE(test, is_current_tsync_marker_set());
+
+	/* Takes and releases the marker. */
+	KUNIT_EXPECT_EQ(test, 0,
+			landlock_restrict_sibling_threads(cred, cred, 0));
+	KUNIT_EXPECT_FALSE(test, is_current_tsync_marker_set());
+}
+
+static void test_tsync_marker_held(struct kunit *const test)
+{
+	const struct cred *const cred = current_cred();
+
+	KUNIT_ASSERT_TRUE(test, thread_group_empty(current));
+	KUNIT_ASSERT_TRUE(test, try_set_current_tsync_marker());
+
+	KUNIT_EXPECT_FALSE(test, try_set_current_tsync_marker());
+	KUNIT_EXPECT_TRUE(test, is_current_tsync_marker_set());
+
+	/* Restarts without releasing the marker held by another caller. */
+	KUNIT_EXPECT_EQ(test, -ERESTARTNOINTR,
+			landlock_restrict_sibling_threads(cred, cred, 0));
+	KUNIT_EXPECT_TRUE(test, is_current_tsync_marker_set());
+
+	/* Clears TIF_SIGPENDING set by restart_syscall(). */
+	scoped_guard(spinlock_irq, &current->sighand->siglock)
+		recalc_sigpending();
+
+	clear_current_tsync_marker();
+}
+
+static struct kunit_case test_cases[] = {
+	/* clang-format off */
+	KUNIT_CASE(test_tsync_marker_free),
+	KUNIT_CASE(test_tsync_marker_held),
+	{}
+	/* clang-format on */
+};
+
+static struct kunit_suite test_suite = {
+	.name = "landlock_tsync",
+	.test_cases = test_cases,
+};
+
+kunit_test_suite(test_suite);
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.0

