Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318CD3D1A97
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790719936; cv=none; b=j+Go6Ck0UKKLXR4y3jawVMuKkKwGinuk3wTR3FZu5o0mSzusd7ahhk7Q4JecxOrh8UKLHIp3dRxxM3ybL+9ZjHeQQRtjvxi0+Y0keeUm3xfqpJvkne+80sFZr53bHjdy/vRtgtUVWuWL67ZR+mrY9Fif0cdn9cU4YiSuktYXhAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790719936; c=relaxed/simple;
	bh=yzggJ5BPKh8xZEgi3qRHYu+LGs5SYZ5e1/lEB1PfyuQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=brd4cXeNC99wx9zySvrLrfcmVeeMZ9nCOrJttKq81IDOhlBKq/VlrcsDbauNMLWb8jbGBsoeHWE8ofGsuP8Pe/DdmxUdKZYVI4fgaPVoXdGPnfXl1dGBANuui7CUgyWLvKa82wCr+TQC2wKGpE7aNQ5rgX8QLsnAkXgU2akO3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WicGRm4z; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WicGRm4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790719926; x=1822255926;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yzggJ5BPKh8xZEgi3qRHYu+LGs5SYZ5e1/lEB1PfyuQ=;
  b=WicGRm4zAek4xieNFJwf3A9L37dOOTYDsQdov6LS17JAFJTOONHbrKKm
   pqPsQrof+e78MNa+2tdiuMy2iqz9tgGlBb9DH94MfeR+aAvO0WjBBTtSz
   p5apWtmq/W3xVimitXDW5ybjbx9DzoBMIlyyqpiGmZv0vK2uWOm7Dqh76
   ImxmaqBVSxB0fzhbN1k2eHjTuMkCRkdjVgUrDPMFs0sM2+7j861Rjmts+
   m1R3MlUQIaPvAa4TEJbTCYFqCoUEVNyL6HcNwAITtfVxfq/bvBb4uYYXj
   9BJ9LirdG6K2INkgI3VW4HccjouPDcB2gO1tdazgMDyKT9EcLTS/IhGmB
   A==;
X-CSE-ConnectionGUID: IFPIAMGVQHOuKfj1WKu0Gg==
X-CSE-MsgGUID: DoVXMjyPRReVCuYQPuFa2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="101613363"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="101613363"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:12:05 -0700
X-CSE-ConnectionGUID: RewIumTlSwKS1I3JmN0cMw==
X-CSE-MsgGUID: KBRrdmleTZGw3J1vHDfvXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274613388"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.111.124]) ([10.125.111.124])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:12:03 -0700
Message-ID: <f74faef913c4d49cdede9c43581e979317c00829.camel@linux.intel.com>
Subject: Re: FAILED: patch "[PATCH] sched/cache: Keep nr_pref_llc_running in
 the runnable domain," failed to apply to 7.2-stable tree
From: Tim Chen <tim.c.chen@linux.intel.com>
To: gregkh@linuxfoundation.org, kayracizmeci@gmail.com, mingo@kernel.org, 
	peterz@infradead.org, stable@kernel.org, yu.c.chen@intel.com, 
	zhanxusheng@xiaomi.com
Cc: stable@vger.kernel.org
Date: Tue, 29 Sep 2026 15:12:01 -0700
In-Reply-To: <2026092932-unmanaged-nectar-23d8@gregkh>
References: <2026092932-unmanaged-nectar-23d8@gregkh>
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
> git cherry-pick -x 0d6526f82c3cdefcca47f73f5fc08dc6f335eac6

This patch seems to apply cleanly on latest 7.2.8:
commit 9a66fdc0d7fd55f54235524a73435af99051e46f (tag: v7.2.8, stable/linux-=
7.2.y)

[tim@b04f130c83f2 linux]$ git fetch https://git.kernel.org/pub/scm/linux/ke=
rnel/git/stable/linux.git/ linux-7.2.y
From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
 * branch                        linux-7.2.y -> FETCH_HEAD
[tim@b04f130c83f2 linux]$ git checkout FETCH_HEAD
HEAD is now at 9a66fdc0d7fd5 Linux 7.2.8
[tim@b04f130c83f2 linux]$ git cherry-pick -x 0d6526f82c3cdefcca47f73f5fc08d=
c6f335eac6
Auto-merging kernel/sched/fair.c
[detached HEAD 9d0e82dcbce41] sched/cache: Keep nr_pref_llc_running in the =
runnable domain, to fix LLC mis-scheduling bug
 Date: Mon Sep 21 17:37:22 2026 -0700
 1 file changed, 58 insertions(+), 5 deletions(-)


Thanks.

Tim

> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092932-=
unmanaged-nectar-23d8@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'
>=20
> Possible dependencies:
>=20
>=20
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------------ original commit in Linus's tree ------------------
>=20
> From 0d6526f82c3cdefcca47f73f5fc08dc6f335eac6 Mon Sep 17 00:00:00 2001
> From: Tim Chen <tim.c.chen@linux.intel.com>
> Date: Mon, 21 Sep 2026 17:37:22 -0700
> Subject: [PATCH] sched/cache: Keep nr_pref_llc_running in the runnable do=
main,
>  to fix LLC mis-scheduling bug
>=20
> alb_break_llc() decides whether to break LLC preference during active
> load balance. It does so by testing that every runnable fair task on the
> source rq prefers its LLC:
>=20
> 	env->src_rq->nr_pref_llc_running =3D=3D env->src_rq->cfs.h_nr_runnable
>=20
> But the two counters cover different sets. nr_pref_llc_running is updated
> in account_llc_enqueue()/account_llc_dequeue(), next to cfs_rq->nr_queued=
,
> so it follows queued tasks. h_nr_runnable is updated in set_delayed()/
> clear_delayed() and drops delay-dequeued tasks.
>=20
> So under DELAY_DEQUEUE, a preferring task that goes to sleep stays counte=
d
> in nr_pref_llc_running while h_nr_runnable falls. The equality then break=
s,
> alb_break_llc() returns false, and active balance is free to pull a task
> off its preferred LLC. Active balance only moves runnable tasks, and this
> is the only LLC check it consults: once the stopper runs, LBF_ACTIVE_LB
> skips the per-task test in can_migrate_task(). The runnable set is the on=
e
> we want.
>=20
> Fix it on the counter side. A task should be counted in
> nr_pref_llc_running exactly while it is both queued on its preferred LLC
> (pref_llc_queued) and runnable (!sched_delayed). Define that membership
> once in task_pref_llc_runnable(), and adjust the counter only through
> pref_llc_running_inc()/pref_llc_running_dec() from the four sites that
> change either input: account_llc_enqueue(), account_llc_dequeue(),
> set_delayed() and clear_delayed(). Gating every update on the same
> predicate keeps the delay, wake and dequeue paths from double-counting
> or underflowing; see the comments at those sites for the ordering.
>=20
> nr_llc_running and sd->llc_counts are not touched and stay on queued
> semantics.
>=20
> Fixes: 714059f79ff0 ("sched/cache: Handle moving single tasks to/from the=
ir preferred LLC")
> Closes: https://lore.kernel.org/lkml/20260827135000.735138-1-zhanxusheng@=
xiaomi.com/
> Reported-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> Suggested-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
> Cc: <stable@kernel.org> # v7.2.x
> Link: https://patch.msgid.link/06af61afedac32e6477f57feb4d658f6c411c3af.1=
790035273.git.tim.c.chen@linux.intel.com
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7455a83a6a99..de3d589fa8eb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1546,6 +1546,28 @@ static bool invalid_llc_nr(struct mm_struct *mm, s=
truct task_struct *p,
>  			(scale * per_cpu(sd_llc_size, cpu)));
>  }
> =20
> +/*
> + * A task counts in nr_pref_llc_running while it is queued on its prefer=
red
> + * LLC (pref_llc_queued) and runnable (!sched_delayed), keeping the coun=
ter in
> + * the runnable domain so alb_break_llc() can compare it with h_nr_runna=
ble.
> + */
> +static bool task_pref_llc_runnable(struct task_struct *p)
> +{
> +	return p->pref_llc_queued && !p->se.sched_delayed;
> +}
> +
> +static void pref_llc_running_inc(struct rq *rq, struct task_struct *p)
> +{
> +	if (task_pref_llc_runnable(p))
> +		rq->nr_pref_llc_running++;
> +}
> +
> +static void pref_llc_running_dec(struct rq *rq, struct task_struct *p)
> +{
> +	if (task_pref_llc_runnable(p))
> +		rq->nr_pref_llc_running--;
> +}
> +
>  static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
>  {
>  	int pref_llc, pref_llc_queued;
> @@ -1557,7 +1579,6 @@ static void account_llc_enqueue(struct rq *rq, stru=
ct task_struct *p)
> =20
>  	pref_llc_queued =3D (pref_llc =3D=3D task_llc(p));
>  	rq->nr_llc_running++;
> -	rq->nr_pref_llc_running +=3D pref_llc_queued;
> =20
>  	/*
>  	 * Record whether p is enqueued on its preferred
> @@ -1575,6 +1596,9 @@ static void account_llc_enqueue(struct rq *rq, stru=
ct task_struct *p)
>  	 */
>  	p->pref_llc_queued =3D pref_llc_queued;
> =20
> +	/* Skipped while delayed; clear_delayed() adds it back on wake. */
> +	pref_llc_running_inc(rq, p);
> +
>  	sd =3D rcu_dereference_all(rq->sd);
>  	if (sd && (unsigned int)pref_llc < sd->llc_max)
>  		sd->llc_counts[pref_llc]++;
> @@ -1591,7 +1615,12 @@ static void account_llc_dequeue(struct rq *rq, str=
uct task_struct *p)
> =20
>  	rq->nr_llc_running--;
>  	if (p->pref_llc_queued) {
> -		rq->nr_pref_llc_running--;
> +		/*
> +		 * Skipped if still delayed (set_delayed() already removed it);
> +		 * clearing pref_llc_queued below also stops clear_delayed()
> +		 * from re-adding it.
> +		 */
> +		pref_llc_running_dec(rq, p);
>  		/*
>  		 * Update the status in case
>  		 * other logic might query
> @@ -1995,6 +2024,7 @@ void init_sched_mm(struct task_struct *p)
>  	 * polluting account_llc_enqueue().
>  	 */
>  	p->preferred_llc =3D -1;
> +	p->pref_llc_queued =3D 0;
>  }
> =20
>  #else /* CONFIG_SCHED_CACHE */
> @@ -2016,6 +2046,10 @@ static void account_llc_enqueue(struct rq *rq, str=
uct task_struct *p) {}
> =20
>  static void account_llc_dequeue(struct rq *rq, struct task_struct *p) {}
> =20
> +static void pref_llc_running_inc(struct rq *rq, struct task_struct *p) {=
}
> +
> +static void pref_llc_running_dec(struct rq *rq, struct task_struct *p) {=
}
> +
>  #endif /* CONFIG_SCHED_CACHE */
> =20
>  /*
> @@ -6390,15 +6424,27 @@ static __always_inline void return_cfs_rq_runtime=
(struct cfs_rq *cfs_rq);
> =20
>  static void set_delayed(struct sched_entity *se)
>  {
> -	se->sched_delayed =3D 1;
> -
>  	/*
>  	 * Delayed se of cfs_rq have no tasks queued on them.
>  	 * Do not adjust h_nr_runnable since __dequeue_task()
>  	 * will account it for blocked tasks.
> +	 *
> +	 * This check can be removed because when flat pick
> +	 * patches get merged as only task can get delayed,
> +	 * same for clear_delayed().
>  	 */
> -	if (!entity_is_task(se))
> +	if (!entity_is_task(se)) {
> +		se->sched_delayed =3D 1;
>  		return;
> +	}
> +
> +	/*
> +	 * Drop a task leaving the runnable set.
> +	 * Needs to be called before sched_delayed is set.
> +	 * clear_delayed() mirrors this after clearing the flag.
> +	 */
> +	pref_llc_running_dec(rq_of(cfs_rq_of(se)), task_of(se));
> +	se->sched_delayed =3D 1;
> =20
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> @@ -6420,6 +6466,13 @@ static void clear_delayed(struct sched_entity *se)
>  	if (!entity_is_task(se))
>  		return;
> =20
> +	/*
> +	 * Re-add on wake, after sched_delayed is cleared. On a final delayed
> +	 * dequeue account_llc_dequeue() already cleared pref_llc_queued, so
> +	 * this does nothing.
> +	 */
> +	pref_llc_running_inc(rq_of(cfs_rq_of(se)), task_of(se));
> +
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> =20
