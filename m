Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4C2BE05E;
	Tue, 18 Aug 2026 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059723; cv=none; b=DCxh2lZ/5Tg34Q8DIaeUJh8DsSFXcnK8+Pe1NPsa1Z+5wr5e1pzRbr1Ouo+0Eue0An2ilSouln5E0avjj1oJ1HczORvQBbWaw79XxT0W+CUDoMHiDN7MwgydE0rNzbpCVReW7fnqdbbTq731vBftMLLuXZzMfyXFLV3okhmMPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059723; c=relaxed/simple;
	bh=gxyDXngT9cPy5aax/33wXUPsrJj9LJswLD+bH2CuFyk=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=lHmYvJnDZDlc2EH1GJmKx8Q7sv4Kn0WEnUyb4UoDF3K0RR9GnwDZfJzXc1jSF2gSyD42PS3pZ3eSFyqM3qn4XZWhGfH61513mpEqRHyVgiiuxoer+02C+3wfy6bh88Nrqq5uF3UFyafSSwfFBqVSY0yVSDQSYuZOq6/CYyCEIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b=dt7tJBfL; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b="dt7tJBfL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=xmission.com;
	 s=xmission; h=Subject:Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gxyDXngT9cPy5aax/33wXUPsrJj9LJswLD+bH2CuFyk=; b=dt7tJBfLS15fZTjqrlFWll+1xq
	qZpcUnZz9Is4af1poLHD8KN6WOO6zHdkOBrCPJgtC+s24ZFy9T+v+JO80HXpbkEPR0x95dEoj4BEf
	j2xTNooeweJs+nDodkdeahtc0fDmNrYfFINq62AjuFvGVYs1UqzIFN3V5/wDC71bWI3M=;
Received: from in02.mta.xmission.com ([166.70.13.52]:36954)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wwJJo-008tSU-F7; Tue, 18 Aug 2026 06:53:28 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:53222 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wwJJm-0035V7-Dy; Tue, 18 Aug 2026 06:53:28 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: joel.granados@kernel.org,  kees@kernel.org,  brauner@kernel.org,
  oleg@redhat.com,  mingo@redhat.com,  peterz@infradead.org,
  akpm@linux-foundation.org,  jack@suse.cz,  avagin@gmail.com,
  ptikhomirov@virtuozzo.com,  mjguzik@gmail.com,  include@grrlz.net,
  legion@kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  AutonomousCodeSecurity@microsoft.com,
  tgopinath@linux.microsoft.com,  kys@microsoft.com,
  stable@vger.kernel.org
In-Reply-To: <20260814040944.16561-1-blbllhy@gmail.com> (Cen Zhang's message
	of "Fri, 14 Aug 2026 00:09:44 -0400")
References: <20260814040944.16561-1-blbllhy@gmail.com>
Date: Tue, 18 Aug 2026 07:53:17 -0500
Message-ID: <87h5krk2te.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1wwJJm-0035V7-Dy;;;mid=<87h5krk2te.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;sPfnum=0;;;sPf=pass
X-XM-AID: U2FsdGVkX1+yMuRZZ0BH9ovp2EX3l4m2tVg/f3LoQvw=
X-Spam-Level: *
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;"Cen Zhang (Microsoft)" <blbllhy@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1572 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 4.5 (0.3%), b_tie_ro: 3.1 (0.2%), parse: 1.32
	(0.1%), extract_message_metadata: 20 (1.2%), get_uri_detail_list: 4.5
	(0.3%), tests_pri_-2000: 33 (2.1%), tests_pri_-1000: 2.4 (0.2%),
	tests_pri_-950: 1.16 (0.1%), tests_pri_-900: 0.87 (0.1%),
	tests_pri_-90: 97 (6.2%), check_bayes: 95 (6.0%), b_tokenize: 17
	(1.1%), b_tok_get_all: 15 (0.9%), b_comp_prob: 5 (0.3%),
	b_tok_touch_all: 52 (3.3%), b_finish: 1.01 (0.1%), tests_pri_0: 714
	(45.4%), check_dkim_signature: 0.61 (0.0%), check_dkim_adsp: 4.3
	(0.3%), poll_dns_idle: 674 (42.9%), tests_pri_10: 1.66 (0.1%),
	tests_pri_500: 692 (44.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4] reboot: fix cad_pid use-after-free race
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, kys@microsoft.com, tgopinath@linux.microsoft.com, AutonomousCodeSecurity@microsoft.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, legion@kernel.org, include@grrlz.net, mjguzik@gmail.com, ptikhomirov@virtuozzo.com, avagin@gmail.com, jack@suse.cz, akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com, oleg@redhat.com, brauner@kernel.org, kees@kernel.org, joel.granados@kernel.org, blbllhy@gmail.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

"Cen Zhang (Microsoft)" <blbllhy@gmail.com> writes:

> cad_pid is a single kernel-wide struct pid pointer. proc_do_cad_pid()
> reads it and passes it to pid_vnr() without protecting the lifetime of
> the referenced struct pid. A concurrent writer can replace cad_pid and
> drop the final reference to the old struct pid after the reader has
> loaded the pointer but before pid_vnr() has finished dereferencing it,
> causing a use-after-free.
>
> kill_cad_pid() has the same lifetime race when it passes cad_pid to
> kill_pid().
>
> At the time this issue was reported, an unprivileged user could reach the
> sysctl through user and PID namespaces because cad_pid was registered in
> pid_table[]. Moving cad_pid back to the global reboot sysctl table
> corrected that namespace and permission mismatch, but did not fix the
> underlying lifetime race.
>
> Fix this by treating cad_pid as an RCU-protected pointer at both read
> sites and by waiting for a grace period before dropping the old reference
> on the write side.
>
> call_rcu(&old_pid->rcu, ...) cannot be used here because free_pid()
> also queues pid->rcu; queueing the same rcu_head twice can corrupt the
> RCU callback list.

Dumb question why not a mutex to protect cad_pid?

All of the bare rcu_dereference and rcu_assign_pointer makes me go hmmm.

Especially when we are talking an interface that is expected to be
called maybe once.  RCU to protect it's data structures seems a bit
overkill.

Yes KASAN crashed but that was because someone was abusing it.
Oleg's change should have reduced the set of processes that can
abuse this.

Now it is just a matter of keeping root from doing something stupid.
AKA changing cad_pid while pressing "Ctrl-Alt-Del".
So why not a mutex?


I am still not convinced there are any users of changing CAD pid.
But I can see it being easier to write a patch to handle them,
then to figure out if they exist.  Still something tricky like
using RCU seems way way overkill.

Eric


> Original KASAN crash stack:
>   kernel/pid.c:545 pid_nr_ns()        # reads freed pid->level
>   kernel/pid.c:556 pid_vnr()          # calls pid_nr_ns()
>   kernel/pid.c:775 proc_do_cad_pid()  # calls pid_vnr(cad_pid)
>
> Fixes: 9ec52099e4b8 ("[PATCH] replace cad_pid by a struct pid")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Closes: https://lore.kernel.org/all/20260717210143.4734-1-blbllhy@gmail.com/
> Link: https://lore.kernel.org/all/alz5ZYLE4kaq_v2P@redhat.com/
> Link: https://lore.kernel.org/all/al4ICz9biJKtdZc4@redhat.com/
> Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> Suggested-by: Bradley Morgan <include@grrlz.net>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Suggested-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v4:
>  - Rebase on sysctl-next after Oleg's cad_pid sysctl placement change.
>  - Fold the two-patch v3 series into a single lifetime fix.
>  - Move kill_cad_pid() implementation to kernel/signal.c.
>  - Export kill_cad_pid() and stop exporting the raw cad_pid pointer.
>  - Update proc_do_cad_pid() in kernel/reboot.c.
>  - Add explicit includes for the RCU API and kill_cad_pid().
>  - Preserve the original unprivileged impact context while noting that
>    the namespace permission path has been fixed separately.
>
> v3:
>  - Keep kill_cad_pid() inside the RCU read-side critical section
>    instead of taking a pid reference, as suggested by Oleg.
>
> v2:
>  - Split out kill_cad_pid() deinline into a preparatory patch.
>  - Annotate cad_pid as __rcu and use rcu_dereference().
>  - Protect kill_cad_pid() by taking a pid reference under RCU.
>  - Add a comment explaining why synchronize_rcu() is used instead of
>    call_rcu().
>
>  include/linux/sched.h        |  2 +-
>  include/linux/sched/signal.h |  5 +----
>  init/main.c                  |  2 +-
>  kernel/reboot.c              | 19 +++++++++++++++----
>  kernel/signal.c              | 12 ++++++++++++
>  5 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 373bcc0598d1..31ce72b1233c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1767,7 +1767,7 @@ static inline bool is_lazy_mmu_mode_active(void)
>  }
>  #endif
>  
> -extern struct pid *cad_pid;
> +extern struct pid __rcu *cad_pid;
>  
>  /*
>   * Per process flags
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 584ae88b435e..d45a5476b97d 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -562,10 +562,7 @@ static inline sigset_t *sigmask_to_save(void)
>  	return res;
>  }
>  
> -static inline int kill_cad_pid(int sig, int priv)
> -{
> -	return kill_pid(cad_pid, sig, priv);
> -}
> +int kill_cad_pid(int sig, int priv);
>  
>  /* These can be the second arg to send_sig_info/send_group_sig_info.  */
>  #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
> diff --git a/init/main.c b/init/main.c
> index e363232b428b..19a10d0c2760 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1636,7 +1636,7 @@ static noinline void __init kernel_init_freeable(void)
>  	 */
>  	set_mems_allowed(node_states[N_MEMORY]);
>  
> -	cad_pid = get_pid(task_pid(current));
> +	rcu_assign_pointer(cad_pid, get_pid(task_pid(current)));
>  
>  	smp_prepare_cpus(setup_max_cpus);
>  
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index f070c5c1103a..d177d89fcc33 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -13,7 +13,9 @@
>  #include <linux/kexec.h>
>  #include <linux/kmod.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/rcupdate.h>
>  #include <linux/reboot.h>
> +#include <linux/sched/signal.h>
>  #include <linux/suspend.h>
>  #include <linux/syscalls.h>
>  #include <linux/syscore_ops.h>
> @@ -24,8 +26,7 @@
>   */
>  
>  static int C_A_D = 1;
> -struct pid *cad_pid;
> -EXPORT_SYMBOL(cad_pid);
> +struct pid __rcu *cad_pid;
>  
>  #if defined(CONFIG_ARM)
>  #define DEFAULT_REBOOT_MODE		= REBOOT_HARD
> @@ -1371,10 +1372,14 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
>  {
>  	struct ctl_table tmp_table = *table;
>  	struct pid *new_pid;
> +	struct pid *old_pid;
>  	pid_t tmp_pid;
>  	int r;
>  
> -	tmp_pid = pid_vnr(cad_pid);
> +	rcu_read_lock();
> +	tmp_pid = pid_vnr(rcu_dereference(cad_pid));
> +	rcu_read_unlock();
> +
>  	tmp_table.data = &tmp_pid;
>  
>  	r = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
> @@ -1385,7 +1390,13 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
>  	if (!new_pid)
>  		return -ESRCH;
>  
> -	put_pid(xchg(&cad_pid, new_pid));
> +	old_pid = unrcu_pointer(xchg(&cad_pid, RCU_INITIALIZER(new_pid)));
> +	/*
> +	 * Wait for cad_pid readers before put_pid().  We cannot use
> +	 * call_rcu() here because free_pid() already owns pid->rcu.
> +	 */
> +	synchronize_rcu();
> +	put_pid(old_pid);
>  	return 0;
>  }
>  
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9c2b32c4d755..464732c44554 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1891,6 +1891,18 @@ int kill_pid(struct pid *pid, int sig, int priv)
>  }
>  EXPORT_SYMBOL(kill_pid);
>  
> +int kill_cad_pid(int sig, int priv)
> +{
> +	int ret;
> +
> +	rcu_read_lock();
> +	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(kill_cad_pid);
> +
>  #ifdef CONFIG_POSIX_TIMERS
>  /*
>   * These functions handle POSIX timer signals. POSIX timers use
>
> base-commit: 8d75c338f0bcecaa6c9af67f86c176b67b6acf3e
