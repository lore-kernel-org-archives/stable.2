Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DFE4A263F
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567917; cv=none; b=ZsbZUfwX/i9lxEGDGmeiMHRYGvR4gNGIFr0a/uhbPiZvT3FNfi3eR0/NUb47q+cVhbo//sc+YMXA5iRLJ/DfGAtEpVq2K9FoM0V3p60rryUrLU+c0N8+N+8WcGd2Iqjlpw3PMYeRIjAK1xk6Sy4/MIUqBU5MYzcpO8n6yYJecDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567917; c=relaxed/simple;
	bh=Cg25EPtJDCmacp8Ln8U5KFemy3Z4iH0v9owqRg8/vJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb+MF3b0xEXyEmfqfSYx4NeOOukQmeUBVqa0EcpYv1AF3/emosK98i3xW0zKzxhmZYMXwGMa+v7rfdTbxifKPcAfLDl2MeGjQmIqqNu8MNwExf70shusKgp7Nr6y8uJ/jzznkkurXBTP1KqpM2SGl21pQB9GWtclANCX9mpRtCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN2ttm3M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN2ttm3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2831F000FF;
	Wed, 16 Sep 2026 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567913;
	bh=rgCm7b6/4R+4AjOiToYWGtNx2WmSRjMnSJwLNyzNcgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JN2ttm3MQ2HZX+IllgKBtd98a7faNubbLXuFYKm6FL0x1hE2WrX8Pf/KeG8dgYJtF
	 Lxauu2NtpPySIwlkgwhzv+Lw4aKVmZ+tO/iEEwgF327QM52CtM77sUpoIr0PVRJtd0
	 tQEPMVsrnK+5TM8LiOks5+hJixQnNg4TIpzUfG5SdXn/tRwqCnf2iDg/Tpd7arX6g9
	 roEIpjDcl4MusskRlAfCWZ+9t9e8OiUIG5O0vHETk+wS5JsaNM9tH/jPsN7Sa2sQW/
	 m9xBs3BnTJaSD32XGkAyvThhtot2z3MB83lbY9pLeASogj8HxGyX4CC2RXoX3KNY84
	 NuAMd1gBAC6iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Alexey Gladkov <legion@kernel.org>,
	Bradley Morgan <include@grrlz.net>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Joel Granados <joel.granados@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] sysctl: move the "cad_pid" entry from pid_table[] to kern_reboot_table[]
Date: Wed, 16 Sep 2026 10:11:50 -0400
Message-ID: <20260916141151.2995957-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091653-fester-trodden-026e@gregkh>
References: <2026091653-fester-trodden-026e@gregkh>
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

[6.12 dependency adaptation]
The stable tree still keeps cad_pid in the global kernel/sysctl.c table;
it does not have the upstream per-PID-namespace table. Move the existing
handler and entry directly from kernel/sysctl.c to kernel/reboot.c, using
proc_dointvec() with a local table copy because __do_proc_dointvec() is
private to sysctl.c. Leave kernel/pid.c unchanged and retain the mutable
ctl_table required by the stable registration API.

Make the existing kernel_reboot_sysctls_init() an independent late initcall
outside CONFIG_SYSFS so cad_pid remains available with PROC_SYSCTL=y and
SYSFS=n, and does not depend on sysfs object allocation succeeding.

Prepare context for 5a88f78df753 without importing newer scheduler or timer
implementations: move the existing kick_process() declaration/stub before
cad_pid and expand the empty stub, and guard the existing POSIX-only
sigqueue helpers with CONFIG_POSIX_TIMERS using the upstream comment.
No new functions are introduced, and the target's RCU fix is left for the
target commit.

[ sashal: Reduced backport -- upstream 7170ca01623b3 touches 2 file(s), this
  backport carries 4. Not backported here:
  kernel/pid.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 5a88f78df753 ("reboot: fix cad_pid use-after-free race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h | 14 ++++++++------
 kernel/reboot.c       | 40 +++++++++++++++++++++++++++++++++++-----
 kernel/signal.c       | 12 +++++-------
 kernel/sysctl.c       | 31 -------------------------------
 4 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7b97f1ec1bc0a..c7d475b0f3b47 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1675,6 +1675,14 @@ static inline char task_state_to_char(struct task_struct *tsk)
 	return task_index_to_char(task_state_index(tsk));
 }
 
+#ifdef CONFIG_SMP
+extern void kick_process(struct task_struct *tsk);
+#else
+static inline void kick_process(struct task_struct *tsk)
+{
+}
+#endif
+
 extern struct pid *cad_pid;
 
 /*
@@ -1953,12 +1961,6 @@ extern int wake_up_state(struct task_struct *tsk, unsigned int state);
 extern int wake_up_process(struct task_struct *tsk);
 extern void wake_up_new_task(struct task_struct *tsk);
 
-#ifdef CONFIG_SMP
-extern void kick_process(struct task_struct *tsk);
-#else
-static inline void kick_process(struct task_struct *tsk) { }
-#endif
-
 extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
 
 static inline void set_task_comm(struct task_struct *tsk, const char *from)
diff --git a/kernel/reboot.c b/kernel/reboot.c
index d6ee090eda943..8ca5590a6d601 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1280,7 +1280,32 @@ static struct attribute *reboot_attrs[] = {
 	NULL,
 };
 
+#endif /* CONFIG_SYSFS */
+
 #ifdef CONFIG_SYSCTL
+static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffer,
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
@@ -1296,16 +1321,23 @@ static struct ctl_table kern_reboot_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
 	},
+	{
+		.procname	= "cad_pid",
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_do_cad_pid,
+	},
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
@@ -1325,8 +1357,6 @@ static int __init reboot_ksysfs_init(void)
 		return ret;
 	}
 
-	kernel_reboot_sysctls_init();
-
 	return 0;
 }
 late_initcall(reboot_ksysfs_init);
diff --git a/kernel/signal.c b/kernel/signal.c
index a11c3c9afd2b4..a665afdccecdd 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1936,14 +1936,10 @@ int kill_pid(struct pid *pid, int sig, int priv)
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
@@ -2043,6 +2039,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
+#endif /* CONFIG_POSIX_TIMERS */
+
 void do_notify_pidfd(struct task_struct *task)
 {
 	struct pid *pid = task_pid(task);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index de58128fa5212..6a9040fdefe51 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1322,28 +1322,6 @@ int proc_dointvec_ms_jiffies(const struct ctl_table *table, int write, void *buf
 				do_proc_dointvec_ms_jiffies_conv, NULL);
 }
 
-static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffer,
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
@@ -1760,15 +1738,6 @@ static struct ctl_table kern_table[] = {
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

