Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EF3B5F5D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586240; cv=none; b=rvmMZ5wgxmUzmF2TIBQxgE4fM4VbCGQKxFiSQlc55yuXAZl3FPZ7aox21YyM7JK8gUc3XXun8QNauN0vGnnPZfKUQ1KeUwDLU/foKtfAV3T72O4qFEY+M2DQz3f5S7E/n+G81ksffJUlECHldMDRxjzX1dgWOZhLXBhgm7ADStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586240; c=relaxed/simple;
	bh=Vd4QCF9IPhEV+4ZjtLUQqmPuKnOoO/Lmq6Epy+5P6Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoORpP8mGIYtvo/MzvqM+YEsy2DdGdcNnuyaF5yO5B/b1hz3j+y7AWFzP6DzQDg8r7+LHxpYlnZWG1J4L38TPYShXpN05Jfl8436UjEqk774lX7x1zMXEW1XT1YdQd5/OS9VIvIyXoXGnzCUsQGr/uFQkQ5Oi1oqHNMIbdXHmtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtTujZpM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtTujZpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B462A1F000FF;
	Wed, 16 Sep 2026 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586217;
	bh=pL6GqNWwTsXIUSQV6nBE/aQn6ejX0bA663be5vudCY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AtTujZpMD8kbQfn4zW0L73AK3aEux19sHUBo1US48PERn/N6PkTcE4IKUsTDwLYjI
	 F7tJa/e0QVHGJSRr/doI3UE2yQaWS++zo6U8rJB+Mlt/LMFz/hfuXro3218ToJhKbA
	 iDwQmi9in7hFqRiWmG8ajLw004BSgEOXgs/FPWicHi5538vVsAZkrxIiZZL4PBv1E3
	 ezapJpxQX1ni2Cn70m9hbD37sUA0WcNcaJYfl/VwsWuSCZM21TcMbYbQx61q98N1gT
	 LjohOqpLAxR+jxBaaiuxpL4gvwndEbrqwJhqB7m//1fsQF1MxXK48d5NKYrYJL4K1o
	 KQokB4JXuFPvQ==
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
Subject: [PATCH 5.10.y] reboot: fix cad_pid use-after-free race
Date: Wed, 16 Sep 2026 15:16:55 -0400
Message-ID: <20260916191655.2013594-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091657-festive-cultural-6f26@gregkh>
References: <2026091657-festive-cultural-6f26@gregkh>
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
[ adapted proc_do_cad_pid() changes to its existing implementation in kernel/sysctl.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h        |  2 +-
 include/linux/sched/signal.h |  5 +----
 init/main.c                  |  2 +-
 kernel/reboot.c              |  5 +++--
 kernel/signal.c              | 12 ++++++++++++
 kernel/sysctl.c              | 13 +++++++++++--
 6 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c5bd595f560c..814d4e6e1130e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1536,7 +1536,7 @@ static inline int is_global_init(struct task_struct *tsk)
 	return task_tgid_nr(tsk) == 1;
 }
 
-extern struct pid *cad_pid;
+extern struct pid __rcu *cad_pid;
 
 /*
  * Per process flags
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 5e4194e12a7db..3321fb12e9d28 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -534,10 +534,7 @@ static inline sigset_t *sigmask_to_save(void)
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
index d23d1a8d5393f..d979a5d80d4ca 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1467,7 +1467,7 @@ static noinline void __init kernel_init_freeable(void)
 	 */
 	set_mems_allowed(node_states[N_MEMORY]);
 
-	cad_pid = get_pid(task_pid(current));
+	rcu_assign_pointer(cad_pid, get_pid(task_pid(current)));
 
 	smp_prepare_cpus(setup_max_cpus);
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index e297b35fc6521..054847f20bd82 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -12,7 +12,9 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/rcupdate.h>
 #include <linux/reboot.h>
+#include <linux/sched/signal.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
@@ -23,8 +25,7 @@
  */
 
 int C_A_D = 1;
-struct pid *cad_pid;
-EXPORT_SYMBOL(cad_pid);
+struct pid __rcu *cad_pid;
 
 #if defined(CONFIG_ARM)
 #define DEFAULT_REBOOT_MODE		= REBOOT_HARD
diff --git a/kernel/signal.c b/kernel/signal.c
index d9f2f01db1038..709b5040c5a53 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1809,6 +1809,18 @@ int kill_pid(struct pid *pid, int sig, int priv)
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
 /*
  * These functions support sending signals using preallocated sigqueue
  * structures.  This is needed "because realtime applications cannot
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c2870c9cae14a..634aaa005a89e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1505,10 +1505,13 @@ static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct pid *new_pid;
+	struct pid *old_pid;
 	pid_t tmp;
 	int r;
 
-	tmp = pid_vnr(cad_pid);
+	rcu_read_lock();
+	tmp = pid_vnr(rcu_dereference(cad_pid));
+	rcu_read_unlock();
 
 	r = __do_proc_dointvec(&tmp, table, write, buffer,
 			       lenp, ppos, NULL, NULL);
@@ -1519,7 +1522,13 @@ static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
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
 
-- 
2.53.0

