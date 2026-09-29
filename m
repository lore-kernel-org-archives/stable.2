Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327E3B101C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790719566; cv=none; b=OpNmq2FnZdSYbSSWmCntBDPnW6to7yB9xykFiL5wr/Li7arPG7pdooo0xE2oLCemy+8zpqNz+WSl3L+jleXnVAo3Eu5Ob1Ek4nADoislZApVPmM1yPVx9K7I5ryD/canQbVgb9HFE0296dlF3DR9icA4YywYbHGuAoyFdCSJHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790719566; c=relaxed/simple;
	bh=ihU837LXDhUGDBMT18eXfgJxrvty44ucZO2MNtt0m+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qu1XuSUkxukovZvEbfjiaJRqAdq8JYA3+c+Pj9+yORT068gjeyJIO3oqe/enL1t5j/n8tz+uxLO3Rwap+JYnmlEkH5/rsCgfvgBBWjcdnbUD0mq4/JcfhN0PhMGqi1TG9wvpkTJBsBmVI1IX55twMUO6pYpdo8UYpIwgoh6sn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9h4QVjo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9h4QVjo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790719563; x=1822255563;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ihU837LXDhUGDBMT18eXfgJxrvty44ucZO2MNtt0m+4=;
  b=O9h4QVjorTQWzro2mXfd63vQ5t4to9NXeMjZRJw6MFhsEE2z0wh3mrhc
   kMeNxbMJfyLaj5Tr/fi91ZJ3GLtuL/XKdApBEBdjb/H1qmNdkyfEDjf6H
   KOT1tCKNJIzKcop69OYMGzBUVZ4+gLFnaIAZSfKmzs3fMfyITCNzoIz92
   tIUeiPu7sm0nhfFvM8PfMt/u2m49kFInw3sjV0pam9oQekRt4xXAMDBBA
   y+n9yJX8J5YbJGNohNoD16OjFx+ccTKnXtVBm258HXyKHewLr20lHeO1n
   KaoEDb9iSGSDiKdFB26WzhOaVVd90dVXis0oWuDJvQEktAoAWDUsxrJbQ
   g==;
X-CSE-ConnectionGUID: WJ+qcQfrQAOGGV3gm6XD2Q==
X-CSE-MsgGUID: e4y0o3szThewXfcKKWTAWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="101612740"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="101612740"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:06:02 -0700
X-CSE-ConnectionGUID: M1Ou4h6ATFqrQN8od9EMJw==
X-CSE-MsgGUID: T6jK7AqCRXOtdmiNmaOYow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="275530432"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.111.124]) ([10.125.111.124])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:06:02 -0700
Message-ID: <c7d8a3ec020497a7b15ae3080b8de4f7363ebe0a.camel@linux.intel.com>
Subject: Re: FAILED: patch "[PATCH] sched/cache: Introduce
 task_struct->sched_cache_grp to fix" failed to apply to 7.2-stable tree
From: Tim Chen <tim.c.chen@linux.intel.com>
To: gregkh@linuxfoundation.org, imv4bel@gmail.com, mingo@kernel.org, 
	peterz@infradead.org, stable@kernel.org, yu.c.chen@intel.com,
 zenghui.yu@linux.dev
Cc: stable@vger.kernel.org
Date: Tue, 29 Sep 2026 15:06:00 -0700
In-Reply-To: <2026092927-ageless-staple-093f@gregkh>
References: <2026092927-ageless-staple-093f@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-29 at 13:43 +0200, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 7.2-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-7.2.y
> git checkout FETCH_HEAD
> git cherry-pick -x b636fef85bda7d1bab9c0a45067ab1508d79d946
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092927-=
ageless-staple-093f@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'
>=20
> Possible dependencies:
>=20

These patches in upstream needs to be applied first before this patch:
f0d243a96f268 sched/fair: Avoid creating misfits during cache-aware balanci=
ng (should be included in stable)
28f9c0e0a0b94 sched/cache: Decouple sched_cache_group from mm to fix UAF  (=
just merged in stable)

Thanks.

Tim

>=20
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------------ original commit in Linus's tree ------------------
>=20
> From b636fef85bda7d1bab9c0a45067ab1508d79d946 Mon Sep 17 00:00:00 2001
> From: Tim Chen <tim.c.chen@linux.intel.com>
> Date: Mon, 21 Sep 2026 17:37:25 -0700
> Subject: [PATCH] sched/cache: Introduce task_struct->sched_cache_grp to f=
ix
>  UAF
>=20
> Add a sched_cache_grp pointer to task_struct so that scheduler code
> can access the cache group directly via the task, without going
> through mm->sched_cache_grp.  This decouples the scheduler's hot-path
> accesses from the mm_struct.
>=20
> Each task holds its own refcount on the sched_cache_group, separate
> from the reference held by its mm_struct.  The reference is acquired
> in copy_mm() (fork) and exec_mmap() (exec), and released in exit_mm().
> This fixes the use-after-free when account_mm_sched() reaches the group
> through a task whose mm is being switched, as reported by Hyunwoo:
>=20
>   https://lore.kernel.org/lkml/apPb-Dr4nPYuHQOK@v4bel/
>=20
> Convert all scheduler code in fair.c and exit.c to use
> p->sched_cache_grp instead of p->mm->sched_cache_grp.
>=20
> Keep the fork/exec/exit reference management out of the generic mm
> paths: add sched_cache_fork(), sched_cache_fork_cleanup(),
> sched_cache_exec_mmap() and sched_cache_exit_mm() in
> kernel/sched/cache_sched.c (with empty stubs for !CONFIG_SCHED_CACHE),
> so fs/exec.c, kernel/fork.c and kernel/exit.c each call one helper
> instead of open-coding the refcounting under #ifdef.  Also add
> sched_cache_group_get() and task_cache_group_get().
>=20
> Fixes: df0d98475954 ("sched/cache: Introduce infrastructure for cache-awa=
re load balancing")
> Closes: https://lore.kernel.org/lkml/apPb-Dr4nPYuHQOK@v4bel/
> Closes: https://lore.kernel.org/all/343a7e07-7fad-4979-9c9b-82ec038c293c@=
linux.dev/
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Reported-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: <stable@kernel.org> #7.2.x
> Link: https://patch.msgid.link/ae7081dc54736bf115215f9867abb2711a7403fb.1=
790035273.git.tim.c.chen@linux.intel.com
>=20
> diff --git a/fs/exec.c b/fs/exec.c
> index 819643408e6d..a5269b5e00df 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -882,6 +882,7 @@ static int exec_mmap(struct linux_binprm *bprm)
>  	active_mm =3D tsk->active_mm;
>  	tsk->active_mm =3D mm;
>  	tsk->mm =3D mm;
> +	sched_cache_exec_mmap(tsk, mm);
>  	mm_init_cid(mm, tsk);
>  	exec_state =3D task_exec_state_replace(tsk, exec_state);
>  	/*
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e14ad43522c8..d35ae49a991f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1433,6 +1433,7 @@ struct task_struct {
> =20
>  #ifdef CONFIG_SCHED_CACHE
>  	struct callback_head		cache_work;
> +	struct sched_cache_group __rcu	*sched_cache_grp;
>  	int				preferred_llc;
>  	/* 1: task was enqueued to its preferred LLC, 0 otherwise */
>  	int				pref_llc_queued;
> @@ -2417,10 +2418,23 @@ struct sched_cache_group {
>  	struct rcu_head rcu;
>  } ____cacheline_aligned_in_smp;
> =20
> +struct sched_cache_group *sched_cache_group_get(struct sched_cache_group=
 *grp);
> +struct sched_cache_group *task_cache_group_get(struct task_struct *p);
> +
> +void sched_cache_fork(struct task_struct *p);
> +void sched_cache_fork_cleanup(struct task_struct *p);
> +void sched_cache_exec_mmap(struct task_struct *p, struct mm_struct *mm);
> +void sched_cache_exit_mm(struct task_struct *p);
> +
>  #else
> =20
>  struct sched_cache_group { };
> =20
> +static inline void sched_cache_fork(struct task_struct *p) { }
> +static inline void sched_cache_fork_cleanup(struct task_struct *p) { }
> +static inline void sched_cache_exec_mmap(struct task_struct *p, struct m=
m_struct *mm) { }
> +static inline void sched_cache_exit_mm(struct task_struct *p) { }
> +
>  #endif
> =20
>  #ifndef MODULE
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 024350e9b48c..282328d2b4cf 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -551,37 +551,6 @@ void mm_update_next_owner(struct mm_struct *mm)
>  }
>  #endif /* CONFIG_MEMCG */
> =20
> -#if defined(CONFIG_SCHED_CACHE) && defined(CONFIG_NUMA_BALANCING)
> -/*
> - * Subtract the memory footprint of the current task from
> - * mm.
> - */
> -static void exit_mm_sched_cache(struct mm_struct *mm)
> -{
> -	struct sched_cache_group *grp;
> -	unsigned long fp, sub;
> -
> -	if (!current->total_numa_faults)
> -		return;
> -	/*
> -	 * No lock protection due to performance considerations.
> -	 * Make sure the group footprint does not become
> -	 * negative.
> -	 */
> -	grp =3D READ_ONCE(mm->sched_cache_grp);
> -	if (!grp)
> -		return;
> -
> -	fp =3D READ_ONCE(grp->footprint);
> -	sub =3D min(fp, current->total_numa_faults);
> -	WRITE_ONCE(grp->footprint, fp - sub);
> -}
> -#else
> -static inline void exit_mm_sched_cache(struct mm_struct *mm)
> -{
> -}
> -#endif /* CONFIG_SCHED_CACHE CONFIG_NUMA_BALANCING */
> -
>  /*
>   * Turn us into a lazy TLB process if we
>   * aren't already..
> @@ -594,7 +563,7 @@ static void exit_mm(void)
>  	if (!mm)
>  		return;
> =20
> -	exit_mm_sched_cache(mm);
> +	sched_cache_exit_mm(current);
> =20
>  	mmap_read_lock(mm);
>  	mmgrab_lazy_tlb(mm);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5ef413368912..10f2d05d816a 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1599,6 +1599,7 @@ static int copy_mm(u64 clone_flags, struct task_str=
uct *tsk)
> =20
>  	tsk->mm =3D mm;
>  	tsk->active_mm =3D mm;
> +	sched_cache_fork(tsk);
>  	return 0;
>  }
> =20
> @@ -2602,6 +2603,7 @@ bad_fork_cleanup_io:
>  bad_fork_cleanup_namespaces:
>  	exit_nsproxy_namespaces(p);
>  bad_fork_cleanup_mm:
> +	sched_cache_fork_cleanup(p);
>  	if (p->mm) {
>  		mm_clear_owner(p->mm, p);
>  		mmput(p->mm);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f0a9586332fd..974a7dfe3215 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1478,7 +1478,7 @@ static inline int get_sched_cache_scale(int mul)
>  	return (1 + (tol - 1) * mul);
>  }
> =20
> -static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
> +static bool exceed_llc_capacity(struct sched_cache_group *grp, int cpu)
>  {
>  #ifdef CONFIG_NUMA_BALANCING
>  	unsigned long llc, footprint;
> @@ -1492,11 +1492,6 @@ static bool exceed_llc_capacity(struct mm_struct *=
mm, int cpu)
>  		return true;
> =20
>  	if (static_branch_likely(&sched_numa_balancing)) {
> -		struct sched_cache_group *grp =3D READ_ONCE(mm->sched_cache_grp);
> -
> -		if (!grp)
> -			return true;
> -
>  		/*
>  		 * TBD: RDT exclusive LLC ways reserved should be
>  		 * excluded.
> @@ -1531,10 +1526,9 @@ static bool exceed_llc_capacity(struct mm_struct *=
mm, int cpu)
>  	return false;
>  }
> =20
> -static bool invalid_llc_nr(struct mm_struct *mm, struct task_struct *p,
> +static bool invalid_llc_nr(struct sched_cache_group *grp, struct task_st=
ruct *p,
>  			   int cpu)
>  {
> -	struct sched_cache_group *grp;
>  	int scale;
> =20
>  	if (get_nr_threads(p) <=3D 1)
> @@ -1548,10 +1542,6 @@ static bool invalid_llc_nr(struct mm_struct *mm, s=
truct task_struct *p,
>  	if (scale =3D=3D INT_MAX)
>  		return false;
> =20
> -	grp =3D READ_ONCE(mm->sched_cache_grp);
> -	if (!grp)
> -		return true;
> -
>  	return !fits_capacity((READ_ONCE(grp->nr_running_avg) * cpu_smt_num_thr=
eads),
>  			(scale * per_cpu(sd_llc_size, cpu)));
>  }
> @@ -1723,6 +1713,96 @@ static void sched_cache_group_put(struct sched_cac=
he_group *grp)
>  	call_rcu(&grp->rcu, sched_cache_group_free_rcu);
>  }
> =20
> +DEFINE_FREE(sched_cache_group_put, struct sched_cache_group *,
> +	    sched_cache_group_put(_T));
> +
> +#define rcu_deref_sched_cache_grp(tsk) \
> +	rcu_dereference_check((tsk)->sched_cache_grp, (tsk) =3D=3D current)
> +
> +static struct sched_cache_group *sched_cache_replace_grp(struct task_str=
uct *p,
> +							 struct sched_cache_group *new)
> +{
> +	struct sched_cache_group *old;
> +
> +	old =3D rcu_deref_sched_cache_grp(p);
> +	rcu_assign_pointer(p->sched_cache_grp, new);
> +
> +	return old;
> +}
> +
> +struct sched_cache_group *sched_cache_group_get(struct sched_cache_group=
 *grp)
> +{
> +	/*
> +	 * refcount_inc_not_zero() is the acquire primitive for lockless
> +	 * (RCU) lookups; plain refcount_inc() would scribble the count if
> +	 * it already reached zero. Return NULL in that case.
> +	 */
> +	if (grp && !refcount_inc_not_zero(&grp->refcnt))
> +		grp =3D NULL;
> +
> +	return grp;
> +}
> +
> +struct sched_cache_group *task_cache_group_get(struct task_struct *p)
> +{
> +	guard(rcu)();
> +	return sched_cache_group_get(rcu_dereference(p->sched_cache_grp));
> +}
> +
> +void sched_cache_fork(struct task_struct *p)
> +{
> +	/*
> +	 * The child takes its own reference on the mm's cache group, separate
> +	 * from the reference held by the mm. @p is not yet visible to readers,
> +	 * so a plain initializing store is enough.
> +	 */
> +	RCU_INIT_POINTER(p->sched_cache_grp,
> +			 sched_cache_group_get(p->mm->sched_cache_grp));
> +}
> +
> +void sched_cache_fork_cleanup(struct task_struct *p)
> +{
> +	/*
> +	 * A fork that fails after sched_cache_fork() never reaches exit_mm(),
> +	 * so drop the reference here. @p never became visible, so there are no
> +	 * concurrent readers and the reference we hold keeps the group alive.
> +	 */
> +	sched_cache_group_put(rcu_access_pointer(p->sched_cache_grp));
> +	RCU_INIT_POINTER(p->sched_cache_grp, NULL);
> +}
> +
> +void sched_cache_exec_mmap(struct task_struct *p, struct mm_struct *mm)
> +{
> +	struct sched_cache_group *old;
> +
> +	/*
> +	 * Acquire the new reference before publishing the pointer, then drop
> +	 * the old one. @p is current and the only writer of its own pointer.
> +	 */
> +	old =3D sched_cache_replace_grp(p, sched_cache_group_get(mm->sched_cach=
e_grp));
> +	sched_cache_group_put(old);
> +}
> +
> +void sched_cache_exit_mm(struct task_struct *p)
> +{
> +	struct sched_cache_group *grp =3D sched_cache_replace_grp(p, NULL);
> +
> +#ifdef CONFIG_NUMA_BALANCING
> +	/*
> +	 * Subtract this task's footprint from the group before dropping the
> +	 * reference, so the group footprint converges as its threads exit.
> +	 * Unlocked for performance; clamp to avoid underflow.
> +	 */
> +	if (grp && p->total_numa_faults) {
> +		unsigned long fp =3D READ_ONCE(grp->footprint);
> +		unsigned long sub =3D min(fp, p->total_numa_faults);
> +
> +		WRITE_ONCE(grp->footprint, fp - sub);
> +	}
> +#endif
> +	sched_cache_group_put(grp);
> +}
> +
>  void mm_destroy_sched(struct mm_struct *mm)
>  {
>  	sched_cache_group_put(mm->sched_cache_grp);
> @@ -1777,15 +1857,10 @@ static unsigned long fraction_mm_sched(struct rq =
*rq,
>  	return div64_u64(NICE_0_LOAD * pcpu_sched->runtime, rq->cpu_runtime + 1=
);
>  }
> =20
> -static int get_pref_llc(struct task_struct *p, struct mm_struct *mm)
> +static int get_pref_llc(struct task_struct *p, struct sched_cache_group =
*grp)
>  {
>  	int mm_sched_llc =3D -1, mm_sched_cpu;
> -	struct sched_cache_group *grp;
> =20
> -	if (!mm)
> -		return -1;
> -
> -	grp =3D READ_ONCE(mm->sched_cache_grp);
>  	if (!grp)
>  		return -1;
> =20
> @@ -1819,9 +1894,8 @@ static unsigned int task_running_on_cpu(int cpu, st=
ruct task_struct *p);
>  static inline
>  void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_ex=
ec)
>  {
> +	struct sched_cache_group *grp =3D rcu_dereference_all(p->sched_cache_gr=
p);
>  	struct sched_cache_time *pcpu_sched;
> -	struct sched_cache_group *grp;
> -	struct mm_struct *mm =3D p->mm;
>  	int mm_sched_llc =3D -1;
>  	unsigned long epoch;
> =20
> @@ -1832,12 +1906,8 @@ void account_mm_sched(struct rq *rq, struct task_s=
truct *p, s64 delta_exec)
>  		return;
>  	/*
>  	 * init_task, kthreads and user thread created
> -	 * by user_mode_thread() don't have mm.
> +	 * by user_mode_thread() don't have a cache group.
>  	 */
> -	if (!mm)
> -		return;
> -
> -	grp =3D READ_ONCE(mm->sched_cache_grp);
>  	if (!grp || !grp->pcpu_sched)
>  		return;
> =20
> @@ -1855,13 +1925,13 @@ void account_mm_sched(struct rq *rq, struct task_=
struct *p, s64 delta_exec)
>  	 * its preferred state.
>  	 */
>  	if ((long)(epoch - READ_ONCE(grp->epoch)) > llc_epoch_affinity_timeout =
||
> -	    invalid_llc_nr(mm, p, cpu_of(rq)) ||
> -	    exceed_llc_capacity(mm, cpu_of(rq))) {
> +	    invalid_llc_nr(grp, p, cpu_of(rq)) ||
> +	    exceed_llc_capacity(grp, cpu_of(rq))) {
>  		if (READ_ONCE(grp->cpu) !=3D -1)
>  			WRITE_ONCE(grp->cpu, -1);
>  	}
> =20
> -	mm_sched_llc =3D get_pref_llc(p, mm);
> +	mm_sched_llc =3D get_pref_llc(p, grp);
> =20
>  	/* task not on rq accounted later in account_entity_enqueue() */
>  	if (task_running_on_cpu(rq->cpu, p) &&
> @@ -1874,19 +1944,15 @@ void account_mm_sched(struct rq *rq, struct task_=
struct *p, s64 delta_exec)
> =20
>  static void task_tick_cache(struct rq *rq, struct task_struct *p)
>  {
> +	struct sched_cache_group *grp =3D rcu_dereference_all(p->sched_cache_gr=
p);
>  	struct callback_head *work =3D &p->cache_work;
> -	struct sched_cache_group *grp;
> -	struct mm_struct *mm =3D p->mm;
>  	unsigned long epoch;
> =20
>  	if (!sched_cache_enabled())
>  		return;
> =20
> -	if (!mm || p->flags & PF_KTHREAD)
> -		return;
> -
> -	grp =3D READ_ONCE(mm->sched_cache_grp);
> -	if (!grp || !grp->pcpu_sched)
> +	if (!grp || p->flags & PF_KTHREAD ||
> +	    !grp->pcpu_sched)
>  		return;
> =20
>  	epoch =3D rq->cpu_epoch;
> @@ -1968,14 +2034,13 @@ static inline void update_avg_scale(u64 *avg, u64=
 sample)
> =20
>  static void task_cache_work(struct callback_head *work)
>  {
> +	struct sched_cache_group *grp __free(sched_cache_group_put) =3D NULL;
> +	cpumask_var_t cpus __free(free_cpumask_var) =3D CPUMASK_VAR_NULL;
>  	int cpu, m_a_cpu =3D -1, nr_running =3D 0, curr_cpu;
>  	unsigned long next_scan, now =3D jiffies;
>  	struct task_struct *p =3D current, *cur;
>  	unsigned long curr_m_a_occ =3D 0;
> -	struct sched_cache_group *grp;
> -	struct mm_struct *mm =3D p->mm;
>  	unsigned long m_a_occ =3D 0;
> -	cpumask_var_t cpus;
> =20
>  	WARN_ON_ONCE(work !=3D &p->cache_work);
> =20
> @@ -1984,7 +2049,12 @@ static void task_cache_work(struct callback_head *=
work)
>  	if (p->flags & PF_EXITING)
>  		return;
> =20
> -	grp =3D READ_ONCE(mm->sched_cache_grp);
> +	/*
> +	 * A reference makes sure grp is not released by others. The rcu
> +	 * lock can not be held till after zalloc_cpumask_var() below,
> +	 * because the latter might sleep.
> +	 */
> +	grp =3D task_cache_group_get(p);
>  	if (!grp)
>  		return;
> =20
> @@ -1999,8 +2069,8 @@ static void task_cache_work(struct callback_head *w=
ork)
>  		return;
> =20
>  	curr_cpu =3D task_cpu(p);
> -	if (invalid_llc_nr(mm, p, curr_cpu) ||
> -	    exceed_llc_capacity(mm, curr_cpu)) {
> +	if (invalid_llc_nr(grp, p, curr_cpu) ||
> +	    exceed_llc_capacity(grp, curr_cpu)) {
>  		if (READ_ONCE(grp->cpu) !=3D -1)
>  			WRITE_ONCE(grp->cpu, -1);
> =20
> @@ -2033,9 +2103,13 @@ static void task_cache_work(struct callback_head *=
work)
>  					m_cpu =3D i;
>  				}
> =20
> +				/*
> +				 * rcu_access_pointer() is used because the
> +				 * pointer is only compared, never dereferenced.
> +				 */
>  				cur =3D rcu_dereference_all(cpu_rq(i)->curr);
>  				if (cur && !(cur->flags & (PF_EXITING | PF_KTHREAD)) &&
> -				    cur->mm =3D=3D mm)
> +				    rcu_access_pointer(cur->sched_cache_grp) =3D=3D grp)
>  					nr_running++;
>  			}
> =20
> @@ -2081,7 +2155,6 @@ static void task_cache_work(struct callback_head *w=
ork)
>  	}
> =20
>  	update_avg_scale(&grp->nr_running_avg, nr_running);
> -	free_cpumask_var(cpus);
>  }
> =20
>  void init_sched_mm(struct task_struct *p)
> @@ -2090,6 +2163,13 @@ void init_sched_mm(struct task_struct *p)
> =20
>  	init_task_work(work, task_cache_work);
>  	work->next =3D work;
> +	/*
> +	 * dup_task_struct() copies the parent's task_struct, including its
> +	 * sched_cache_grp, for which the child holds no reference.  Clear it
> +	 * here - before copy_mm() runs - so the child never carries a
> +	 * borrowed pointer that the fork error path would put.
> +	 */
> +	RCU_INIT_POINTER(p->sched_cache_grp, NULL);
>  	/*
>  	 * Reset new task's preference to avoid
>  	 * polluting account_llc_enqueue().
> @@ -3890,10 +3970,9 @@ static void task_numa_placement(struct task_struct=
 *p)
>  			 * heuristic and occasional lost updates are tolerable.
>  			 *
>  			 * If a task exits, its corresponding footprint must
> -			 * be subtracted from the mm->sched_cache_grp->footprint,
> -			 * otherwise the mm->sched_cache_grp->footprint will not
> -			 * converge: the exiting thread's footprint remains
> -			 * unchanged/undecayed in mm->sched_cache_grp->footprint.
> +			 * be subtracted from p->sched_cache_grp->footprint,
> +			 * otherwise the footprint will not converge: the
> +			 * exiting thread's footprint remains unchanged/undecayed.
>  			 * See exit_mm().
>  			 *
>  			 * Lost updates and unsynchronized subtraction
> @@ -3901,12 +3980,14 @@ static void task_numa_placement(struct task_struc=
t *p)
>  			 * go negative. Clamp to zero to prevent the
>  			 * unsigned footprint from wrapping.
>  			 */
> -			grp =3D READ_ONCE(p->mm->sched_cache_grp);
> -			if (!grp)
> -				continue;
> +			scoped_guard(rcu) {
> +				grp =3D rcu_dereference(p->sched_cache_grp);
> =20
> -			new_fp =3D (long)READ_ONCE(grp->footprint) + diff;
> -			WRITE_ONCE(grp->footprint, max(new_fp, 0L));
> +				if (grp) {
> +					new_fp =3D (long)READ_ONCE(grp->footprint) + diff;
> +					WRITE_ONCE(grp->footprint, max(new_fp, 0L));
> +				}
> +			}
>  #endif
>  		}
> =20
> @@ -10855,7 +10936,6 @@ static enum llc_mig can_migrate_llc_task(struct l=
b_env *env,
>  					 struct task_struct *p)
>  {
>  	struct sched_cache_group *grp;
> -	struct mm_struct *mm;
>  	bool to_pref;
>  	int cpu, src_cpu, dst_cpu;
> =20
> @@ -10864,11 +10944,7 @@ static enum llc_mig can_migrate_llc_task(struct =
lb_env *env,
> =20
>  	src_cpu =3D env->src_cpu;
>  	dst_cpu =3D env->dst_cpu;
> -	mm =3D p->mm;
> -	if (!mm)
> -		return mig_unrestricted;
> -
> -	grp =3D READ_ONCE(mm->sched_cache_grp);
> +	grp =3D rcu_dereference_all(p->sched_cache_grp);
>  	if (!grp)
>  		return mig_unrestricted;
> =20
> @@ -10877,8 +10953,8 @@ static enum llc_mig can_migrate_llc_task(struct l=
b_env *env,
>  		return mig_unrestricted;
> =20
>  	/* skip cache aware load balance for too many threads */
> -	if (invalid_llc_nr(mm, p, dst_cpu) ||
> -	    exceed_llc_capacity(mm, dst_cpu)) {
> +	if (invalid_llc_nr(grp, p, dst_cpu) ||
> +	    exceed_llc_capacity(grp, dst_cpu)) {
>  		if (READ_ONCE(grp->cpu) !=3D -1)
>  			WRITE_ONCE(grp->cpu, -1);
>  		return mig_unrestricted;
