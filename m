Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E01466B08
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546437; cv=none; b=XWTCj80V9zrQiMcvhDkYmk3XJOMcI3rejcPDgUlLHtrrfe+thAJPCJIuPBLKRp5H+BxSISV9K2qHCu40SNJU9RZIjz/k1xBMFYF28QfuXBaMP1WEClhrEXaCuYSsB09D4lvhl4sXNAqQ9y5nzs7pzaZan7JHpYqxsYUWwbYkrjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546437; c=relaxed/simple;
	bh=OcLgie09noWlqX6eAiIAbPQyeETschOprZ0omBzmSRI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LK1KQTuFq4AbqtbSdm8MXLc5xWBh6TFTl7R6H8OG1ihadHkME7C803bcjvrnZXwndsexJC4xADONIdY5MdL31YItrhEjRczUyLR8tJWbiE87qc3huepqvkRTGtegDGMkz8U5X2De3GOfL1BIC5eZMjv29kThBF9WSanllJhMeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M8mKm4Wi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M8mKm4Wi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4C81F000FF;
	Wed, 16 Sep 2026 08:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789546426;
	bh=xw88qoee+bs1+7KmpxL1S4BHFYvEDSN10EsBwvvAFJ0=;
	h=Subject:To:Cc:From:Date;
	b=M8mKm4WioBILAzgh4MO6HUP+4yRJu/Sl0MjND0VcjnAme2TXL6BiG9xhm5ImgOIup
	 ZNO46TumCZyDZSQT/msEowF06qxHyAw/EjfXfv0wfEa4b24iIM6M/cWX5XlWHb/74U
	 ULAZpzt1qy5zwJfBnAAAiin0eTiQoK81YjaXW3BA=
Subject: FAILED: patch "[PATCH] reboot: fix cad_pid use-after-free race" failed to apply to 6.12-stable tree
To: blbllhy@gmail.com,brauner@kernel.org,ebiederm@xmission.com,include@grrlz.net,mjguzik@gmail.com,oleg@redhat.com,ptikhomirov@virtuozzo.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 09:11:53 +0100
Message-ID: <2026091653-fester-trodden-026e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5a88f78df753993469dab4d1831f8fb4256a9468
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091653-fester-trodden-026e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a88f78df753993469dab4d1831f8fb4256a9468 Mon Sep 17 00:00:00 2001
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Date: Fri, 14 Aug 2026 00:09:44 -0400
Subject: [PATCH] reboot: fix cad_pid use-after-free race

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

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3f100d69b053..fdafd164a42d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1778,7 +1778,7 @@ static inline bool is_lazy_mmu_mode_active(void)
 }
 #endif
 
-extern struct pid *cad_pid;
+extern struct pid __rcu *cad_pid;
 
 /*
  * Per process flags
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 584ae88b435e..d45a5476b97d 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -562,10 +562,7 @@ static inline sigset_t *sigmask_to_save(void)
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
index 92d34e496a33..f46f3a8b3efd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1644,7 +1644,7 @@ static noinline void __init kernel_init_freeable(void)
 	 */
 	set_mems_allowed(node_states[N_MEMORY]);
 
-	cad_pid = get_pid(task_pid(current));
+	rcu_assign_pointer(cad_pid, get_pid(task_pid(current)));
 
 	smp_prepare_cpus(setup_max_cpus);
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f070c5c1103a..d177d89fcc33 100644
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
@@ -1371,10 +1372,14 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
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
@@ -1385,7 +1390,13 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
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
index bbc0fd4cc4d7..2162fad7b940 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1899,6 +1899,18 @@ int kill_pid(struct pid *pid, int sig, int priv)
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

