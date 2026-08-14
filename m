Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D941DDE5;
	Fri, 14 Aug 2026 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699389; cv=none; b=ghQJ4rAqIpPpOe7sadXBOjpgCncbPp4vgH9yN2RlHlLK1J0tCINy0al+tDtjKq58mJ2NKWImQMo0+U6+/cutd6EwXzQx/1Lf42ymCHRfcJElV2Y2eupAn6LOuGGRzaPPVHY/we4Ve8ZafbJrZTAm/cN/H7mM78IWVXeW2WxDXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699389; c=relaxed/simple;
	bh=QDcRRRnmDqASITyOBcNjC/qWmLNWXfp7D7bUKvv3n8Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ejzbsAHeR5MGhMZOe0NoYsDGMbJIJ70s07TyNywVRBTj6QLd2f1m6K5gXQKHbGodon41iiJS0Ujd/iwIffo+0UC6tuSgxyVmrD9ikBRt0gRwNqFNcxAGQgY12nvXmfaitZmOQoXWdC8ke8Zm3E5/6wnEwsly37LTkToFYVyEhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=erHeTF5L; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="erHeTF5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786699377;
	bh=QDp5D1LZfeKZbkcHL5uKVsiNgaiuoNVnkMl1uYlLU5k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=erHeTF5LFQ3YJM30CuziJQCZ0P7IS7u4IKtNu4CpkY5bcTtP5KvOvhyibhYGCDTiM
	 pI07vVcc5hYGWMta+68gXe0/R6HiWpuIKPwhYycniUnTotRIoZwv3OPM+Z3hvLNFmM
	 RN0e4y/YOduWhgV7cSw1gOsH5I5VG31S42k4NuYs=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hLxbP1vy4z6vJm;
	Fri, 14 Aug 2026 09:22:57 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hLxbN53hBz4y6W;
	Fri, 14 Aug 2026 09:22:56 +0000 (UTC)
Date: Fri, 14 Aug 2026 10:22:57 +0100
From: Bradley Morgan <include@grrlz.net>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, joel.granados@kernel.org,
 kees@kernel.org
CC: brauner@kernel.org, oleg@redhat.com, mingo@redhat.com, peterz@infradead.org,
 akpm@linux-foundation.org, jack@suse.cz, avagin@gmail.com,
 ptikhomirov@virtuozzo.com, mjguzik@gmail.com, ebiederm@xmission.com,
 legion@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, kys@microsoft.com, blbllhy@gmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v4] reboot: fix cad_pid use-after-free race
In-Reply-To: <20260814040944.16561-1-blbllhy@gmail.com>
References: <20260814040944.16561-1-blbllhy@gmail.com>
Message-ID: <CD4DC929-7746-4284-A160-1A9B58110228@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 14 August 2026 05:09:44 BST, "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
wrote:
>cad_pid is a single kernel-wide struct pid pointer. proc_do_cad_pid()
>reads it and passes it to pid_vnr() without protecting the lifetime of
>the referenced struct pid. A concurrent writer can replace cad_pid and
>drop the final reference to the old struct pid after the reader has
>loaded the pointer but before pid_vnr() has finished dereferencing it,
>causing a use-after-free.
>
>kill_cad_pid() has the same lifetime race when it passes cad_pid to
>kill_pid().
>
>At the time this issue was reported, an unprivileged user could reach the
>sysctl through user and PID namespaces because cad_pid was registered in
>pid_table[]. Moving cad_pid back to the global reboot sysctl table
>corrected that namespace and permission mismatch, but did not fix the
>underlying lifetime race.
>
>Fix this by treating cad_pid as an RCU-protected pointer at both read
>sites and by waiting for a grace period before dropping the old reference
>on the write side.
>
>call_rcu(&old_pid->rcu, ...) cannot be used here because free_pid()
>also queues pid->rcu; queueing the same rcu_head twice can corrupt the
>RCU callback list.
>
>Original KASAN crash stack:
>  kernel/pid.c:545 pid_nr_ns()        # reads freed pid->level
>  kernel/pid.c:556 pid_vnr()          # calls pid_nr_ns()
>  kernel/pid.c:775 proc_do_cad_pid()  # calls pid_vnr(cad_pid)
>
>Fixes: 9ec52099e4b8 ("[PATCH] replace cad_pid by a struct pid")
>Reported-by: AutonomousCodeSecurity@microsoft.com
>Closes: https://lore.kernel.org/all/20260717210143.4734-1-blbllhy@gmail.com/
>Link: https://lore.kernel.org/all/alz5ZYLE4kaq_v2P@redhat.com/
>Link: https://lore.kernel.org/all/al4ICz9biJKtdZc4@redhat.com/
>Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
>Suggested-by: Bradley Morgan <include@grrlz.net>

Yk what I'm gonna do...

Reviewed-by: Bradley Morgan <include@grrlz.net>


It kinda of makes sense in reboot code

>Suggested-by: Oleg Nesterov <oleg@redhat.com>
>Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
>Suggested-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>Cc: stable@vger.kernel.org
>Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
>---
>v4:
> - Rebase on sysctl-next after Oleg's cad_pid sysctl placement change.
> - Fold the two-patch v3 series into a single lifetime fix.
> - Move kill_cad_pid() implementation to kernel/signal.c.
> - Export kill_cad_pid() and stop exporting the raw cad_pid pointer.
> - Update proc_do_cad_pid() in kernel/reboot.c.
> - Add explicit includes for the RCU API and kill_cad_pid().
> - Preserve the original unprivileged impact context while noting that
>   the namespace permission path has been fixed separately.
>
>v3:
> - Keep kill_cad_pid() inside the RCU read-side critical section
>   instead of taking a pid reference, as suggested by Oleg.
>
>v2:
> - Split out kill_cad_pid() deinline into a preparatory patch.
> - Annotate cad_pid as __rcu and use rcu_dereference().
> - Protect kill_cad_pid() by taking a pid reference under RCU.
> - Add a comment explaining why synchronize_rcu() is used instead of
>   call_rcu().
>
> include/linux/sched.h        |  2 +-
> include/linux/sched/signal.h |  5 +----
> init/main.c                  |  2 +-
> kernel/reboot.c              | 19 +++++++++++++++----
> kernel/signal.c              | 12 ++++++++++++
> 5 files changed, 30 insertions(+), 10 deletions(-)
>
>diff --git a/include/linux/sched.h b/include/linux/sched.h
>index 373bcc0598d1..31ce72b1233c 100644
>--- a/include/linux/sched.h
>+++ b/include/linux/sched.h
>@@ -1767,7 +1767,7 @@ static inline bool is_lazy_mmu_mode_active(void)
> }
> #endif
> 
>-extern struct pid *cad_pid;
>+extern struct pid __rcu *cad_pid;
> 
> /*
>  * Per process flags
>diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
>index 584ae88b435e..d45a5476b97d 100644
>--- a/include/linux/sched/signal.h
>+++ b/include/linux/sched/signal.h
>@@ -562,10 +562,7 @@ static inline sigset_t *sigmask_to_save(void)
> 	return res;
> }
> 
>-static inline int kill_cad_pid(int sig, int priv)
>-{
>-	return kill_pid(cad_pid, sig, priv);
>-}
>+int kill_cad_pid(int sig, int priv);
> 
> /* These can be the second arg to send_sig_info/send_group_sig_info.  */
> #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
>diff --git a/init/main.c b/init/main.c
>index e363232b428b..19a10d0c2760 100644
>--- a/init/main.c
>+++ b/init/main.c
>@@ -1636,7 +1636,7 @@ static noinline void __init kernel_init_freeable(void)
> 	 */
> 	set_mems_allowed(node_states[N_MEMORY]);
> 
>-	cad_pid = get_pid(task_pid(current));
>+	rcu_assign_pointer(cad_pid, get_pid(task_pid(current)));
> 
> 	smp_prepare_cpus(setup_max_cpus);
> 
>diff --git a/kernel/reboot.c b/kernel/reboot.c
>index f070c5c1103a..d177d89fcc33 100644
>--- a/kernel/reboot.c
>+++ b/kernel/reboot.c
>@@ -13,7 +13,9 @@
> #include <linux/kexec.h>
> #include <linux/kmod.h>
> #include <linux/kmsg_dump.h>
>+#include <linux/rcupdate.h>
> #include <linux/reboot.h>
>+#include <linux/sched/signal.h>
> #include <linux/suspend.h>
> #include <linux/syscalls.h>
> #include <linux/syscore_ops.h>
>@@ -24,8 +26,7 @@
>  */
> 
> static int C_A_D = 1;
>-struct pid *cad_pid;
>-EXPORT_SYMBOL(cad_pid);
>+struct pid __rcu *cad_pid;
> 
> #if defined(CONFIG_ARM)
> #define DEFAULT_REBOOT_MODE		= REBOOT_HARD
>@@ -1371,10 +1372,14 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
> {
> 	struct ctl_table tmp_table = *table;
> 	struct pid *new_pid;
>+	struct pid *old_pid;
> 	pid_t tmp_pid;
> 	int r;
> 
>-	tmp_pid = pid_vnr(cad_pid);
>+	rcu_read_lock();
>+	tmp_pid = pid_vnr(rcu_dereference(cad_pid));
>+	rcu_read_unlock();
>+
> 	tmp_table.data = &tmp_pid;
> 
> 	r = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
>@@ -1385,7 +1390,13 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
> 	if (!new_pid)
> 		return -ESRCH;
> 
>-	put_pid(xchg(&cad_pid, new_pid));
>+	old_pid = unrcu_pointer(xchg(&cad_pid, RCU_INITIALIZER(new_pid)));
>+	/*
>+	 * Wait for cad_pid readers before put_pid().  We cannot use
>+	 * call_rcu() here because free_pid() already owns pid->rcu.
>+	 */
>+	synchronize_rcu();
>+	put_pid(old_pid);
> 	return 0;
> }
> 
>diff --git a/kernel/signal.c b/kernel/signal.c
>index 9c2b32c4d755..464732c44554 100644
>--- a/kernel/signal.c
>+++ b/kernel/signal.c
>@@ -1891,6 +1891,18 @@ int kill_pid(struct pid *pid, int sig, int priv)
> }
> EXPORT_SYMBOL(kill_pid);
> 
>+int kill_cad_pid(int sig, int priv)
>+{
>+	int ret;
>+
>+	rcu_read_lock();
>+	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
>+	rcu_read_unlock();
>+
>+	return ret;
>+}
>+EXPORT_SYMBOL(kill_cad_pid);
>+
> #ifdef CONFIG_POSIX_TIMERS
> /*
>  * These functions handle POSIX timer signals. POSIX timers use
>
>base-commit: 8d75c338f0bcecaa6c9af67f86c176b67b6acf3e
>

Thanks!
