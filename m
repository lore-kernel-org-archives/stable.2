Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFA5427F8
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583838; cv=none; b=eDrpHgCK+QfjDR2MIbtn61lrgt3JjePtcFnDIHbdtvQvY9vFS7AVCAdJY8ZOFoyN+zgihAMV2CFAyEAmkjhrNQ/pV0tkjRuMGzQJkjVPvWaM/yukio4w/dY2b4V+UJazn4VGL72BcHrbKDrT1d3waZVoMGfpE+h6RnR9EqZwKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583838; c=relaxed/simple;
	bh=RvvnBvR4argft4F59MyUzyyqmaAJvmn2A65DpPjI3fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiSmpnkymBhyAxgB4vr/cAfVLQdGLOc9hoSxzshyAI7AHRYgxwB75N4LJNO/ceYES1m5RJlphPDOE4Nc55TArCxgMODbYqGlIVbPBJ1lbmLAHsUOP4HXmQmP8xDUhVT+RJKkcRhFj9J+qMR3BmV1M3ZUiHYn49ukxT4UfX8J5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVuEvp8u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVuEvp8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708C31F000FF;
	Wed, 16 Sep 2026 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583807;
	bh=Ms+6jOgkJ03a/8MzXevMj2vWaUIlijr8HV7BjwW8KW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XVuEvp8uHhxKi6oECsrsRJyzCZD3dIgLEYIQH1HfPOrnUsE7exgGAIFCt97rjsPte
	 eKd/3yqUa9ZTA38L9vvNg4Yh5jFTf8Pi3GvRaYNq3NBsryrQZuVJ4SiK/ojSl8Zgkr
	 2/i3sa1rYXmFRDQHycoTF8eoHQvoxFcbiuGYbaLTNjFPXZ3UHmWZvRitrsWqXGok5m
	 NlycpZ7YMhpw285dTtLmyxgooVHgsQJ3wk5tv/KQr5l0nGQil+PYtO+Zg0BjG9evIX
	 FR5xBhS7KSY3pa4JGCBoS5rqFbUaQaQ5OA24rip1T/8WJvR6I8hRyMV3xqjO9SzheT
	 xOG+MxmBDHSlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Alexey Gladkov <legion@kernel.org>,
	Bradley Morgan <include@grrlz.net>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Joel Granados <joel.granados@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] sysctl: move the "cad_pid" entry from pid_table[] to kern_reboot_table[]
Date: Wed, 16 Sep 2026 14:36:44 -0400
Message-ID: <20260916183645.1771278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091655-decent-swimsuit-d207@gregkh>
References: <2026091655-decent-swimsuit-d207@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 7170ca01623b399c97f2ae9d3e228badc1f25ea3 ]

cad_pid is global, and kill_cad_pid() is only used in the root namespace.

However, due to pid_table_root_permissions(), a non-root user can unshare
pid/user namespaces and modify it from the child namespace. This makes no
sense and is simply wrong.

Move it to kern_reboot_table[] where it logically belongs; this ensures
that only GLOBAL_ROOT_UID can read/modify this sysctl.

Note that this patch doesn't preserve "#ifdef CONFIG_PROC_SYSCTL" around
the "cad_pid"; CONFIG_PROC_SYSCTL selects CONFIG_SYSCTL, so it is always
set when kern_reboot_table[] is compiled.

Cc: stable@vger.kernel.org
Fixes: e054bcbe7e7a ("sysctl: move cad_pid into kernel/pid.c")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Alexey Gladkov <legion@kernel.org>
Reviewed-by: Bradley Morgan <include@grrlz.net>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Joel Granados <joel.granados@kernel.org>

Backport notes for Linux 6.1:

The cad_pid handler and sysctl entry still live in kernel/sysctl.c in
this tree. Move that existing handler and entry directly to reboot.c;
do not import the absent PID-namespace sysctl infrastructure. Use a
local ctl_table copy and proc_dointvec(), since __do_proc_dointvec()
is private to sysctl.c, while retaining the non-const 6.1 handler API
and the required table sentinel. No new functions are introduced.

Keep reboot sysctl registration independent of CONFIG_SYSFS by making
the existing kernel_reboot_sysctls_init() its own late initcall. This
preserves cad_pid availability with PROC_SYSCTL=y and SYSFS=n.

Relocate the existing TASK_SIZE_OF fallback, unchanged, before cad_pid
in sched.h. Its conditional boundary lets the target's declaration hunk
merge cleanly with Git's default merge algorithm despite the absence of
upstream's adjacent lazy-MMU helpers. Do not add those helpers or alter
the cad_pid declaration in this dependency.

Guard the existing POSIX-timer-only sigqueue helpers with
CONFIG_POSIX_TIMERS and align their introductory comment with upstream.
This supplies the context needed for 5a88f78df753 ("reboot: fix cad_pid
use-after-free race") to cherry-pick cleanly without pulling in timer
refactoring. Its RCU lifetime fix remains in the target commit.

[ sashal: Reduced backport -- upstream 7170ca01623b3 touches 2 file(s), this
  backport carries 4. Not backported here:
  kernel/pid.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 5a88f78df753 ("reboot: fix cad_pid use-after-free race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h |  8 ++++----
 kernel/reboot.c       | 40 +++++++++++++++++++++++++++++++++++-----
 kernel/signal.c       | 12 +++++-------
 kernel/sysctl.c       | 31 -------------------------------
 4 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5b415d3b653e3..71ecfae2aae94 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1724,6 +1724,10 @@ static inline int is_global_init(struct task_struct *tsk)
 	return task_tgid_nr(tsk) == 1;
 }
 
+#ifndef TASK_SIZE_OF
+#define TASK_SIZE_OF(tsk)	TASK_SIZE
+#endif
+
 extern struct pid *cad_pid;
 
 /*
@@ -2292,10 +2296,6 @@ static inline bool vcpu_is_preempted(int cpu)
 extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
 extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 
-#ifndef TASK_SIZE_OF
-#define TASK_SIZE_OF(tsk)	TASK_SIZE
-#endif
-
 #ifdef CONFIG_SMP
 static inline bool owner_on_cpu(struct task_struct *owner)
 {
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 6ebef11c88760..49b73674555e1 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1257,7 +1257,32 @@ static struct attribute *reboot_attrs[] = {
 	NULL,
 };
 
+#endif /* CONFIG_SYSFS */
+
 #ifdef CONFIG_SYSCTL
+static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
+			   size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp_table = *table;
+	struct pid *new_pid;
+	pid_t tmp_pid;
+	int r;
+
+	tmp_pid = pid_vnr(cad_pid);
+	tmp_table.data = &tmp_pid;
+
+	r = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
+	if (r || !write)
+		return r;
+
+	new_pid = find_get_pid(tmp_pid);
+	if (!new_pid)
+		return -ESRCH;
+
+	put_pid(xchg(&cad_pid, new_pid));
+	return 0;
+}
+
 static struct ctl_table kern_reboot_table[] = {
 	{
 		.procname       = "poweroff_cmd",
@@ -1273,17 +1298,24 @@ static struct ctl_table kern_reboot_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
 	},
+	{
+		.procname	= "cad_pid",
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_do_cad_pid,
+	},
 	{ }
 };
 
-static void __init kernel_reboot_sysctls_init(void)
+static int __init kernel_reboot_sysctls_init(void)
 {
 	register_sysctl_init("kernel", kern_reboot_table);
+	return 0;
 }
-#else
-#define kernel_reboot_sysctls_init() do { } while (0)
+late_initcall(kernel_reboot_sysctls_init);
 #endif /* CONFIG_SYSCTL */
 
+#ifdef CONFIG_SYSFS
 static const struct attribute_group reboot_attr_group = {
 	.attrs = reboot_attrs,
 };
@@ -1303,8 +1335,6 @@ static int __init reboot_ksysfs_init(void)
 		return ret;
 	}
 
-	kernel_reboot_sysctls_init();
-
 	return 0;
 }
 late_initcall(reboot_ksysfs_init);
diff --git a/kernel/signal.c b/kernel/signal.c
index efdd01ffdccd7..1c1bbf5abe9aa 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1937,14 +1937,10 @@ int kill_pid(struct pid *pid, int sig, int priv)
 }
 EXPORT_SYMBOL(kill_pid);
 
+#ifdef CONFIG_POSIX_TIMERS
 /*
- * These functions support sending signals using preallocated sigqueue
- * structures.  This is needed "because realtime applications cannot
- * afford to lose notifications of asynchronous events, like timer
- * expirations or I/O completions".  In the case of POSIX Timers
- * we allocate the sigqueue structure from the timer_create.  If this
- * allocation fails we are able to report the failure to the application
- * with an EAGAIN error.
+ * These functions handle POSIX timer signals. POSIX timers use
+ * preallocated sigqueue structs for sending signals.
  */
 struct sigqueue *sigqueue_alloc(void)
 {
@@ -2024,6 +2020,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
+#endif /* CONFIG_POSIX_TIMERS */
+
 static void do_notify_pidfd(struct task_struct *task)
 {
 	struct pid *pid;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index eaa2691caf492..83a1f65e1f893 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1344,28 +1344,6 @@ int proc_dointvec_ms_jiffies(struct ctl_table *table, int write, void *buffer,
 				do_proc_dointvec_ms_jiffies_conv, NULL);
 }
 
-static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
-{
-	struct pid *new_pid;
-	pid_t tmp;
-	int r;
-
-	tmp = pid_vnr(cad_pid);
-
-	r = __do_proc_dointvec(&tmp, table, write, buffer,
-			       lenp, ppos, NULL, NULL);
-	if (r || !write)
-		return r;
-
-	new_pid = find_get_pid(tmp);
-	if (!new_pid)
-		return -ESRCH;
-
-	put_pid(xchg(&cad_pid, new_pid));
-	return 0;
-}
-
 /**
  * proc_do_large_bitmap - read/write from/to a large bitmap
  * @table: the sysctl table
@@ -1801,15 +1779,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysrq_sysctl_handler,
 	},
-#endif
-#ifdef CONFIG_PROC_SYSCTL
-	{
-		.procname	= "cad_pid",
-		.data		= NULL,
-		.maxlen		= sizeof (int),
-		.mode		= 0600,
-		.proc_handler	= proc_do_cad_pid,
-	},
 #endif
 	{
 		.procname	= "threads-max",
-- 
2.53.0

