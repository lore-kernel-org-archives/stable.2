Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37448FF90
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577339; cv=none; b=harWSiEaQsxr5rShyAg5TuBQ7KhmfNdwwt854WtqdoowelfBXC8EKo5kjDQVMP1k/W+uvPs2eilifVXqrpMSew4xSUnliDQCJFCju6T06OtK6AMaGIMlWzWClmUo9wZMKVupE6q905nyUHNfKaAoKO3QVCbg5eSXkO16WkS/guo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577339; c=relaxed/simple;
	bh=eWBw/jURzgwpGSNLHWlKB8pzUqgwnJzh6qaGURat4Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1lXuc90IT/JY1XT/0E+KnwwketPCj8wL/NDA8kujr0LWOTAxwhWt9GOngRR1LgpF+4O/3x6CxkozhmBPKUPcjm9T8Nf4BKT7Rt4lW5DiW6LGC3yb4UwW7tzfZMR2eUGx1M8vWGvNVvR/qJZDUsEZgkOK1IfhXA+cX+3KrLz+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxIwscHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxIwscHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2160A1F0089B;
	Wed, 16 Sep 2026 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577328;
	bh=e3T08W23ja6va1/bSANfSdwt/3bf7a54Wc4hmM8e64c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hxIwscHwXGYrnYmxqNTvJjLuyxwJeKmb7blDAGDfeCFcfGd6dYlunGy7A7MdV1j8b
	 udf+plMOt1hj0eawsB21Dy7sj1uM0ZacwLt573QXs5Ae/1DfwPcDtTKeVBKcuDXn1L
	 zRbVxc5/EXs9SCAgXbZ4SV4yJxqxeA8bVElunayUnIF3TRDgq/sm/MO3vcAh4tIdhQ
	 bK4TLfZrIS7gVAlaahzEkJjbGOvdbyV7d4gV/MPV0y6ka0Iyyuzts3vzclZKncdGHj
	 l8nvIDu71KVTNgWXsiKGQpMPP1wVwiiYi+ZjKQpnFnR5zL89As8CVm00wyIMddNPdd
	 RAG60E1AZXSCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Alexey Gladkov <legion@kernel.org>,
	Bradley Morgan <include@grrlz.net>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Joel Granados <joel.granados@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] sysctl: move the "cad_pid" entry from pid_table[] to kern_reboot_table[]
Date: Wed, 16 Sep 2026 12:48:41 -0400
Message-ID: <20260916164843.541311-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916164843.541311-1-sashal@kernel.org>
References: <2026091654-satiable-demanding-819a@gregkh>
 <20260916164843.541311-1-sashal@kernel.org>
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

Stable dependency adaptation for 6.6:

The cad_pid handler and entry still live in kernel/sysctl.c here, and the
namespaced pid_table does not exist. Move the existing handler and entry
directly into kernel/reboot.c, leaving kernel/pid.c unchanged. The namespace
permission bug described above is absent in this tree; this relocation
prepares the cad_pid lifetime fix in 5a88f78df753.

Use a temporary ctl_table and proc_dointvec() instead of the private
__do_proc_dointvec(), retaining the non-const handler signature, mutable
table and sentinel required by 6.6. Register the reboot sysctls from their
existing initializer as an independent late initcall so cad_pid remains
available with CONFIG_SYSFS disabled.

Guard the existing POSIX timer sigqueue helpers with CONFIG_POSIX_TIMERS
and align their introductory comment with the target's insertion context.
Separate the cad_pid declaration from is_global_init() with a descriptive
comment and a blank line so the target's declaration change merges without
importing the newer lazy-MMU helpers. No new functions are introduced.

[ sashal: Reduced backport -- upstream 7170ca01623b3 touches 2 file(s), this
  backport carries 4. Not backported here:
  kernel/pid.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 5a88f78df753 ("reboot: fix cad_pid use-after-free race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h |  2 ++
 kernel/reboot.c       | 39 ++++++++++++++++++++++++++++++++++-----
 kernel/signal.c       | 12 ++++++++----
 kernel/sysctl.c       | 31 -------------------------------
 4 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4be7af82f813c..7a5239ae0ab2f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1739,6 +1739,8 @@ static inline int is_global_init(struct task_struct *tsk)
 	return task_tgid_nr(tsk) == 1;
 }
 
+/* PID to notify when Ctrl-Alt-Del sends a signal. */
+
 extern struct pid *cad_pid;
 
 /*
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 6ebef11c88760..d432816245480 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1256,8 +1256,32 @@ static struct attribute *reboot_attrs[] = {
 #endif
 	NULL,
 };
+#endif /* CONFIG_SYSFS */
 
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
@@ -1273,17 +1297,24 @@ static struct ctl_table kern_reboot_table[] = {
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
@@ -1303,8 +1334,6 @@ static int __init reboot_ksysfs_init(void)
 		return ret;
 	}
 
-	kernel_reboot_sysctls_init();
-
 	return 0;
 }
 late_initcall(reboot_ksysfs_init);
diff --git a/kernel/signal.c b/kernel/signal.c
index 6a51bd690092f..1ab5b5e1aad6b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1950,11 +1950,13 @@ int kill_pid(struct pid *pid, int sig, int priv)
 }
 EXPORT_SYMBOL(kill_pid);
 
+#ifdef CONFIG_POSIX_TIMERS
 /*
- * These functions support sending signals using preallocated sigqueue
- * structures.  This is needed "because realtime applications cannot
- * afford to lose notifications of asynchronous events, like timer
- * expirations or I/O completions".  In the case of POSIX Timers
+ * These functions handle POSIX timer signals. POSIX timers use
+ * preallocated sigqueue structs for sending signals. This is needed
+ * "because realtime applications cannot afford to lose notifications of
+ * asynchronous events, like timer expirations or I/O completions".
+ * In the case of POSIX Timers
  * we allocate the sigqueue structure from the timer_create.  If this
  * allocation fails we are able to report the failure to the application
  * with an EAGAIN error.
@@ -2054,6 +2056,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
+#endif /* CONFIG_POSIX_TIMERS */
+
 static void do_notify_pidfd(struct task_struct *task)
 {
 	struct pid *pid;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f8f07c0492388..132b768768168 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1327,28 +1327,6 @@ int proc_dointvec_ms_jiffies(struct ctl_table *table, int write, void *buffer,
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
@@ -1765,15 +1743,6 @@ static struct ctl_table kern_table[] = {
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

