Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D305476C5
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583837; cv=none; b=fUzpgclVCFjK/PZq6uUiqPuZXJPeQAOoCWPPjVLJpWO0yWQOstHrXO0OUG4Zt+ZTgOFVzTcetznyMuJpgVsiATNM36DD49xCz2w5XMXZH1D0cYyKfcVNBkx1xohdJDaY1wPWhxl2WDLB9KMifEMwx7c2Nbt8JiJahLhoL4cRNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583837; c=relaxed/simple;
	bh=rW5xCIY1RGuVWG12WZKWwLyLUQKmrwlms9pKtcHOl30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvJ1L4GHgjPAEICgsfBm1lNNFFmMKlDV+9PgyrZWJ2GIx5XX3RGLYo1ge85e1Otdqa8kfD7Pd9YqaJY8fK6n6LeWMh4+Vj8WtDgzxBNqa5CtK2eVHoq/BkrkHPP65a8fix+IkSvIfKhTMYEMND7RsinLjuG70LH2I4XK10Mqjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFCqwWDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFCqwWDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738C21F008A1;
	Wed, 16 Sep 2026 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583808;
	bh=II9M0dRhstvSA0pCilnyVK6rTHtlCgYzLamcT2hyrB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CFCqwWDeDsGTLzdyK/V4I8XLmkt0JsCf7Tpkg2zCGfDl8qkKxnNkqRS5/7dfFJ/QU
	 nPks5dCxvH7BdPbFwGP7AgyC7Rdc/aeNRgorYyLkDt1io09kO/X+PTqus3Ps0woHCO
	 T6Rnck3aFuHAhTORzvUKBKKJZbdjjuAGoMsjTmJAPKxgT1Pb9/ZmaQaJ+z3YSQ1doH
	 3lJP/jr9mNhFBky+/Oj401GH6mamH/nOcdHvEaVN4zL9PumLJKzqke3q7ize2P9E9z
	 eRHXUMZVn7C/GP9erCd6e20Qd8YTknE+RkQIQ+Ys5zle8rBHbQP5M5QSwvGNAV4+/m
	 A/UG/JRvw9tpg==
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
Subject: [PATCH 6.1.y 2/2] reboot: fix cad_pid use-after-free race
Date: Wed, 16 Sep 2026 14:36:45 -0400
Message-ID: <20260916183645.1771278-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916183645.1771278-1-sashal@kernel.org>
References: <2026091655-decent-swimsuit-d207@gregkh>
 <20260916183645.1771278-1-sashal@kernel.org>
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
index 71ecfae2aae94..783e82e037de2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1728,7 +1728,7 @@ static inline int is_global_init(struct task_struct *tsk)
 #define TASK_SIZE_OF(tsk)	TASK_SIZE
 #endif
 
-extern struct pid *cad_pid;
+extern struct pid __rcu *cad_pid;
 
 /*
  * Per process flags
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 669e8cff40c74..c3a4a58135c09 100644
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
index 50b84f1f9ff38..c8f27ccb1b443 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1574,7 +1574,7 @@ static noinline void __init kernel_init_freeable(void)
 	 */
 	set_mems_allowed(node_states[N_MEMORY]);
 
-	cad_pid = get_pid(task_pid(current));
+	rcu_assign_pointer(cad_pid, get_pid(task_pid(current)));
 
 	smp_prepare_cpus(setup_max_cpus);
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 49b73674555e1..5772f146afcdb 100644
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
@@ -1265,10 +1266,14 @@ static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
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
@@ -1279,7 +1284,13 @@ static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
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
index 1c1bbf5abe9aa..bd5fb55470cf2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1937,6 +1937,18 @@ int kill_pid(struct pid *pid, int sig, int priv)
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

