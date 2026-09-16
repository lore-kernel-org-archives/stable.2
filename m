Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC354AE122
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577338; cv=none; b=NU72c1sFinOVqelsJ0AcRyR/CyZF4PoBzMd4DpMH9m3QjvxJSSk0MFkwErtI2VRhZLWK+GywFv4Lvsyx2rx8NnCBPSDsVFh/Az4xEiW2e3Dpv9n+YJEmcHqsI9Pv3L8T/Vx8V/VfmKOQhLyqmgIqnUq6+xGbdiMwD4GFaXpdMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577338; c=relaxed/simple;
	bh=YvD7MHCJNc7+Krb4qNsF7tFVTrLkmuTTRaci3LWMKgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0Qd2pmrPtjBVuqWyoaRgp//7DR63F98jVSCaFV0k1yqUFQNs+Qqtt9+lrAphZbVf00OBBz/pKu9deUZItF4GAqykuoL3i9FhOK7bvk1Td497CvoEz5bogdtNAIsmoNpBSUzMp0FUSBemdZt0kNvvxOPPmAuyItuj63J5/5nM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEczKmxU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEczKmxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247A01F00898;
	Wed, 16 Sep 2026 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577330;
	bh=jksiaibzPLbzfk9dT5ZLh27n+xQrrBb+E/75Frp1KyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WEczKmxUILrtRu2nR1VmeT47RWZtGVyl4pNX58NSNZ9MjmtcRP59Ixu+wL+rNW04C
	 N/e/xtSKloLDb+vw/u+pKspZ/+3sTUHelJs8513KWJA1/MSxAAwJuQlTjslGSB3DhF
	 MRbufyweBpgA+nlbrGMIAtb8mEJwkEC7SSrjSP+IIfbYUOSXgxqq28ZjgWM9UvGg8M
	 TGodDGHAzJv8a+xUxWhq/Eyf1S56DhTnC77HGfLALABAzE+2zb8tMIDmq9Q7QRTWgd
	 L7KLIjUeLGIZJxSRl9UhDbR0qjYDwzUPABkMnV8lT+Mldl57vMbgm7muduJyzOglBq
	 E/qL803YdnOLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	AutonomousCodeSecurity@microsoft.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Bradley Morgan <include@grrlz.net>,
	Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] reboot: fix cad_pid use-after-free race
Date: Wed, 16 Sep 2026 12:48:42 -0400
Message-ID: <20260916164843.541311-3-sashal@kernel.org>
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

From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>

[ Upstream commit 5a88f78df753993469dab4d1831f8fb4256a9468 ]

cad_pid is a single kernel-wide struct pid pointer. proc_do_cad_pid()
reads it and passes it to pid_vnr() without protecting the lifetime of
the referenced struct pid. A concurrent writer can replace cad_pid and
drop the final reference to the old struct pid after the reader has
loaded the pointer but before pid_vnr() has finished dereferencing it,
causing a use-after-free.

kill_cad_pid() has the same lifetime race when it passes cad_pid to
kill_pid().

At the time this issue was reported, an unprivileged user could reach the
sysctl through user and PID namespaces because cad_pid was registered in
pid_table[]. Moving cad_pid back to the global reboot sysctl table
corrected that namespace and permission mismatch, but did not fix the
underlying lifetime race.

Fix this by treating cad_pid as an RCU-protected pointer at both read
sites and by waiting for a grace period before dropping the old reference
on the write side.

call_rcu(&old_pid->rcu, ...) cannot be used here because free_pid()
also queues pid->rcu; queueing the same rcu_head twice can corrupt the
RCU callback list.

Original KASAN crash stack:
  kernel/pid.c:545 pid_nr_ns()        # reads freed pid->level
  kernel/pid.c:556 pid_vnr()          # calls pid_nr_ns()
  kernel/pid.c:775 proc_do_cad_pid()  # calls pid_vnr(cad_pid)

Fixes: 9ec52099e4b8 ("[PATCH] replace cad_pid by a struct pid")
Reported-by: AutonomousCodeSecurity@microsoft.com
Closes: https://lore.kernel.org/all/20260717210143.4734-1-blbllhy@gmail.com/
Link: https://lore.kernel.org/all/alz5ZYLE4kaq_v2P@redhat.com/
Link: https://lore.kernel.org/all/al4ICz9biJKtdZc4@redhat.com/
Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Suggested-by: Bradley Morgan <include@grrlz.net>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Suggested-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Link: https://patch.msgid.link/20260814040944.16561-1-blbllhy@gmail.com
Reviewed-by: Bradley Morgan <include@grrlz.net>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h        |  2 +-
 include/linux/sched/signal.h |  5 +----
 init/main.c                  |  2 +-
 kernel/reboot.c              | 19 +++++++++++++++----
 kernel/signal.c              | 12 ++++++++++++
 5 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7a5239ae0ab2f..78221c691f469 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1741,7 +1741,7 @@ static inline int is_global_init(struct task_struct *tsk)
 
 /* PID to notify when Ctrl-Alt-Del sends a signal. */
 
-extern struct pid *cad_pid;
+extern struct pid __rcu *cad_pid;
 
 /*
  * Per process flags
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0014d3adaf846..daa95d3251891 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -568,10 +568,7 @@ static inline sigset_t *sigmask_to_save(void)
 	return res;
 }
 
-static inline int kill_cad_pid(int sig, int priv)
-{
-	return kill_pid(cad_pid, sig, priv);
-}
+int kill_cad_pid(int sig, int priv);
 
 /* These can be the second arg to send_sig_info/send_group_sig_info.  */
 #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
diff --git a/init/main.c b/init/main.c
index 62d8f7610e846..0baa79ed1aea0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1503,7 +1503,7 @@ static noinline void __init kernel_init_freeable(void)
 	 */
 	set_mems_allowed(node_states[N_MEMORY]);
 
-	cad_pid = get_pid(task_pid(current));
+	rcu_assign_pointer(cad_pid, get_pid(task_pid(current)));
 
 	smp_prepare_cpus(setup_max_cpus);
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index d432816245480..8ff9e6dc8ab69 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,7 +13,9 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/rcupdate.h>
 #include <linux/reboot.h>
+#include <linux/sched/signal.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
@@ -24,8 +26,7 @@
  */
 
 static int C_A_D = 1;
-struct pid *cad_pid;
-EXPORT_SYMBOL(cad_pid);
+struct pid __rcu *cad_pid;
 
 #if defined(CONFIG_ARM)
 #define DEFAULT_REBOOT_MODE		= REBOOT_HARD
@@ -1264,10 +1265,14 @@ static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
 {
 	struct ctl_table tmp_table = *table;
 	struct pid *new_pid;
+	struct pid *old_pid;
 	pid_t tmp_pid;
 	int r;
 
-	tmp_pid = pid_vnr(cad_pid);
+	rcu_read_lock();
+	tmp_pid = pid_vnr(rcu_dereference(cad_pid));
+	rcu_read_unlock();
+
 	tmp_table.data = &tmp_pid;
 
 	r = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
@@ -1278,7 +1283,13 @@ static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
 	if (!new_pid)
 		return -ESRCH;
 
-	put_pid(xchg(&cad_pid, new_pid));
+	old_pid = unrcu_pointer(xchg(&cad_pid, RCU_INITIALIZER(new_pid)));
+	/*
+	 * Wait for cad_pid readers before put_pid().  We cannot use
+	 * call_rcu() here because free_pid() already owns pid->rcu.
+	 */
+	synchronize_rcu();
+	put_pid(old_pid);
 	return 0;
 }
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 1ab5b5e1aad6b..58d6ccbc4343a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1950,6 +1950,18 @@ int kill_pid(struct pid *pid, int sig, int priv)
 }
 EXPORT_SYMBOL(kill_pid);
 
+int kill_cad_pid(int sig, int priv)
+{
+	int ret;
+
+	rcu_read_lock();
+	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL(kill_cad_pid);
+
 #ifdef CONFIG_POSIX_TIMERS
 /*
  * These functions handle POSIX timer signals. POSIX timers use
-- 
2.53.0

