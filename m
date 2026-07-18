Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E4E43F0A1;
	Sat, 18 Jul 2026 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784375690; cv=none; b=n5T35xDJYtcllx2yRMmX1zLfaweEvCugwV/av9+GMBUCHivRAGVzDbQbCE07pRIMprEk5yIbSWYDXa4clLaWWAO+7mZzKK8+bzjj++Je8ONgyRF0KWzQqJIJ2FF6+vijrkrHLE+LWl26JCohcytgxodEvpV9YEJ6D2Ux5SAr79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784375690; c=relaxed/simple;
	bh=Od5TMuPtg/dytALZicKtq64UBl+914lM7NBsil94AuI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=raPoAW3f2iYcKSN7woH5/Vt136csV8JKi0rGK+GbPMjn0CF3uQy/c+t/rM9pWEyn3zc/g94EUrLlEbGFo1rn3si0I6jr1adoFSfI5P1bgAZGWg5XoEkqyyONYTi1Tzm49b7OKSHzcBySlB6UCo5Nq86vn3wFl8ul1LJA1+22HBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=AozA5S0/; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="AozA5S0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784375677;
	bh=euB67fX2hzoA+rb1l4cjhCrMh2BKG3iJ7BkTvNiQ6Jk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=AozA5S0/hFtNxBsqvJZJ5jBZJ0Lfnh4W7c5cfi54vtE0zuvRBA1rOVeV3OgW6PEQ8
	 7Vmh3FNu0fumB74kJY+syJHmf/V8fcFN5H274xdoiSQU5Mlsy46ct2lz/eeNgxERRW
	 sFV6IU/jm4eWnahg8r9oSvl2SsoNdEdfV/hqEf6s=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4h2QDs621MzGpQy;
	Sat, 18 Jul 2026 11:54:37 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4h2QDs3Tj0zGpQg;
	Sat, 18 Jul 2026 11:54:37 +0000 (UTC)
Date: Sat, 18 Jul 2026 12:54:37 +0100
From: Bradley Morgan <include@grrlz.net>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, brauner@kernel.org
CC: oleg@redhat.com, akpm@linux-foundation.org, jack@suse.cz, avagin@gmail.com,
 ptikhomirov@virtuozzo.com, mjguzik@gmail.com, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com, blbllhy@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pid: fix cad_pid use-after-free race
In-Reply-To: <20260718032000.9184-2-blbllhy@gmail.com>
References: <20260718032000.9184-1-blbllhy@gmail.com> <20260718032000.9184-2-blbllhy@gmail.com>
Message-ID: <F5A46F56-F5A4-4EEA-B3E0-9FE04C398AAD@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 18, 2026 4:20:00 AM GMT+01:00, "Cen Zhang (Microsoft)"
<blbllhy@gmail.com> wrote:
>proc_do_cad_pid() reads the global cad_pid pointer and passes it to
>pid_vnr() without protecting the lifetime of the referenced struct pid.
>A concurrent writer can replace cad_pid and drop the final reference to
>the old struct pid after the reader has loaded the pointer but before
>pid_vnr() has finished dereferencing it, causing a use-after-free.
>
>The sysctl is mode 0600, but access is checked against the owning user
>namespace, so an unprivileged user can reach it via userns, pidns, and a
>proc mount.
>
>Fix this by treating cad_pid as an RCU-protected pointer at both read
>sites and by waiting for a grace period before dropping the old reference
>on the write side.
>
>KASAN crash stack:
>  kernel/pid.c:545 pid_nr_ns()        # reads freed pid->level
>  kernel/pid.c:556 pid_vnr()
>  kernel/pid.c:775 proc_do_cad_pid()
>  fs/proc/proc_sysctl.c proc_sys_call_handler()
>  fs/read_write.c vfs_read()
>  fs/read_write.c __x64_sys_pread64()
>
>Fixes: 9ec52099e4b8 ("[PATCH] replace cad_pid by a struct pid")
>Reported-by: AutonomousCodeSecurity@microsoft.com
>Closes: https://lore.kernel.org/all/20260717210143.4734-1-blbllhy@gmail.com/
>Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
>Reviewed-by: Bradley Morgan <include@grrlz.net>

This tag remains, no need to revoke.

Reviewed-by: Bradley Morgan <include@grrlz.net>


>Cc: stable@vger.kernel.org
>Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
>---
>v2:
>  - Split out kill_cad_pid() deinline into a preparatory patch.
>  - Annotate cad_pid as __rcu and use rcu_dereference().
>  - Protect kill_cad_pid() by taking a pid reference under RCU.
>  - Add a comment explaining why synchronize_rcu() is used instead of
>    call_rcu().
>
> include/linux/sched.h |  2 +-
> init/main.c           |  2 +-
> kernel/pid.c          | 26 +++++++++++++++++++++++---
> kernel/reboot.c       |  2 +-
> 4 files changed, 26 insertions(+), 6 deletions(-)
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
>diff --git a/kernel/pid.c b/kernel/pid.c
>index 234ebee29375..bffc5f765080 100644
>--- a/kernel/pid.c
>+++ b/kernel/pid.c
>@@ -559,7 +559,17 @@ EXPORT_SYMBOL_GPL(pid_vnr);
> 
> int kill_cad_pid(int sig, int priv)
> {
>-	return kill_pid(cad_pid, sig, priv);
>+	struct pid *pid;
>+	int ret;
>+
>+	rcu_read_lock();
>+	pid = get_pid(rcu_dereference(cad_pid));
>+	rcu_read_unlock();
>+
>+	ret = kill_pid(pid, sig, priv);
>+	put_pid(pid);
>+
>+	return ret;
> }
> 
> pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
>@@ -773,11 +783,15 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
> 		size_t *lenp, loff_t *ppos)
> {
> 	struct pid *new_pid;
>+	struct pid *old_pid;
> 	pid_t tmp_pid;
> 	int r;
> 	struct ctl_table tmp_table = *table;
> 
>-	tmp_pid = pid_vnr(cad_pid);
>+	rcu_read_lock();
>+	tmp_pid = pid_vnr(rcu_dereference(cad_pid));
>+	rcu_read_unlock();
>+
> 	tmp_table.data = &tmp_pid;
> 
> 	r = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
>@@ -788,7 +802,13 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
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
>diff --git a/kernel/reboot.c b/kernel/reboot.c
>index 695c33e75efd..fc191a48c0e9 100644
>--- a/kernel/reboot.c
>+++ b/kernel/reboot.c
>@@ -24,7 +24,7 @@
>  */
> 
> static int C_A_D = 1;
>-struct pid *cad_pid;
>+struct pid __rcu *cad_pid;
> EXPORT_SYMBOL(cad_pid);
> 
> #if defined(CONFIG_ARM)
>

Thanks!
