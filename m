Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690510;
	b=cGS+dWjsBW+vT5ADIqupA7tF2Zk+78trPPGwt/QjPiv8MbKYWWpT69ao3LoadYNFfncC
	 0E5RnHH9AHZkrj8juJhh3Jbifm1S924lSDr4PmoCILXga4CwAnpirMqwA03anCZ/ULshb
	 EnGhvYW2nnZWsKio0pZPDfXft7H98ph+REftX/HrpW83y9iCzuOuZ1GCtGq6p8fWeRbep
	 WtuUmfMIf9SuBT5wWHrodEyJJaOn/HxRxcdNIdHDsGOb3mK+5kV5kmViC3H0UGk1Yoczn
	 xrqEC7Hq8Mb/A16QRsbkwKxzbVTMEnp+lRTYL2zTY8KlWU9v045vjcil7ijSF0Xmyew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690510;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=oZDEPzuGf1lz0DRDIYtjs2i4JiW3UveAKuGqOol7MfQ=;
	b=GLNjzkeYziKgcrK/loFySWiqMCdgNbt7YiVwv2dfr7C0YAY4Tu0fedJJb/cXkNOK7qe3
	 gTKzVNNmm1hoPz5Y5SgHsjl13XxHz4IYPO9ru/YNdOFmklA3fJa2zWBeJxHbpBW967ah8
	 KNxSAhy4CkffsHuSIQHHOYOydgMSzccp5yVPEt5m1zm3FzatFwrAETLiqI4sGVBH4zYIw
	 BZzXgiCg80UxFymovQwEtgny1C/u0vJMTXay6+hmcctB5rQjy8zEj5bcljB4P8/GIEz4q
	 pMSoVvhUBx2xKwIxvuf9usgO7eWnu7cXN2/M+lqpqOeP0J+b3OE23+0UbH4UGGiSByA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ni2N9b4u;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF9606A33B;
	Thu, 22 Oct 2026 17:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5BF9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ni2N9b4u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792690509; x=1824226509;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KV352jArF/0prf2EvmUlHViwrIAAoX2VbsFxt3XNppU=;
  b=Ni2N9b4uqQD3IOlbb5mLtcPNK3CP14Qo5ICOzOBDa8GvoQJ+CQpiH4yo
   k1Y528vM6r4knG2IoVXbZokZLMkFmarjqHO81+IJChuGEERep861JMYl1
   AOmIFGOCMN0PwdkFbVgCKbxQGvcKobHw26nZDnbS5XH6GyFr535eXdDGB
   D249amqyqFFQuYwNjRZ5vhvVKAcxHAdbXJz5WwH54YEMeWCr9TCi0MO32
   0RcTotGR8TktqPG/DkjiBxcwI/onDlAEdV0TNtmOZOYwYZRlJHgi7Z6CM
   Apl/DGVuau52LEaTkO3LdpwyneN/JIGfixWC4susmf/+6OelJGHHT9MFc
   Q==;
X-CSE-ConnectionGUID: hlK/dCM3TRCnIa1jVhkJag==
X-CSE-MsgGUID: aOQI07CYQvaMX5JQZYeAVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1326018"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1326018"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 10:35:07 -0700
X-CSE-ConnectionGUID: d03YhRjFT8qn9fpcqcPqQg==
X-CSE-MsgGUID: a34KjfOKQx2yl/yS4DrCKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3753159"
Received: from unknown (HELO [10.241.242.209]) ([10.241.242.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 10:35:07 -0700
Message-ID: <93c4de9a3c86e0d00808fd7045b385a5a7069e4d.camel@linux.intel.com>
Subject: Re: [PATCH v3] sched/cache: Honor asym packing over cache aware
 scheduling on hybrid systems
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Chen Yu <yu.c.chen@intel.com>, Mario Limonciello
 <mario.limonciello@amd.com>,  Vishal Badole <Vishal.Badole@amd.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, 
	platform-driver-x86@vger.kernel.org, K Prateek Nayak
 <KPrateek.Nayak@amd.com>,  Ricardo Neri <ricardo.neri@intel.com>, Kayra
 Cizmeci <kayracizmeci@gmail.com>, stable@vger.kernel.org,  Vincent Guittot
 <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Klaus
 Kusche	 <klaus.kusche@computerix.info>
Date: Thu, 22 Oct 2026 10:35:06 -0700
In-Reply-To: <b29badede27bb6bfb4a759e06754cb19657f0778.1791308631.git.tim.c.chen@linux.intel.com>
References: 
	<b29badede27bb6bfb4a759e06754cb19657f0778.1791308631.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-07 at 10:25 -0700, Tim Chen wrote:
> A regression was reported on an AMD Ryzen AI HX 370 running a cache
> intensive Clang full-LTO link. The little cores run at a much lower
> frequency (3.3 GHz vs 5.1 GHz) and have only half of the L3 cache
> (8 MB vs 16 MB), so pinning such a task to the little-core LLC
> hurts twice, and full-LTO builds slow down dramatically compared to
> pre-cache-aware-scheduling kernels.
>=20
> Asym packing and cache aware scheduling express conflicting placement
> strategies. Asym packing wants a task to run on the highest priority CPU,
> whereas cache aware scheduling wants to co-locate the tasks of a process
> on one LLC regardless of the priority of CPUs in that LLC.
>=20
> When asym packing tries to migrate task to an idle core that has higher
> priority than source cpu, let asym packing win.  Moving tasks to a higher
> performing idle core will buy more performance than cache co-location.
>=20
> Prioritize asym packing over LLC balancing for regular and active load
> balancing.
>=20

Hi Peter,

A quick ping on this patch. Do you think it is ready to be applied?

Thanks.

Tim

> Fixes: 23b2b5ccc45c ("sched/cache: Introduce helper functions to enforce =
LLC migration policy")
> Reported-by: Klaus Kusche <klaus.kusche@computerix.info>
> Closes: https://lore.kernel.org/lkml/2180ea5a-eb28-4152-8d4d-cd00b0c24b2e=
@computerix.info/
> Suggested-by: Kayra Cizmeci <kayracizmeci@gmail.com>
> Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
> Tested-by: Klaus Kusche <klaus.kusche@computerix.info>
> Tested-by: Ricardo Neri <ricardo.neri@intel.com>
> Tested-by: Chen Yu <yu.c.chen@intel.com>
> Cc: stable@vger.kernel.org # 7.2.x
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>=20
> Notes:
>     v3: Remove redundant SD_ASYM_PACKING check in llc_balance() (Kayra Ci=
zmeci).
>     Add Tested-by tag from Chen Yu and Reviewed-by tag from Kayra Cizmeci=
.
>     Link v2:
>     https://lore.kernel.org/lkml/77ceef1e51b895760dc5f6c9cde985a1679545b5=
.1791224900.git.tim.c.chen@linux.intel.com/
>=20
>  kernel/sched/fair.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 57360f5cdde4f..e4906486a4fe9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10934,6 +10934,8 @@ static inline bool task_misfits_asym_cpu(struct l=
b_env *env, struct task_struct
>  	return false;
>  }
> =20
> +static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int =
src_cpu);
> +
>  /*
>   * Check if task p can migrate from source LLC to
>   * destination LLC in terms of cache aware load balance.
> @@ -10958,6 +10960,10 @@ static enum llc_mig can_migrate_llc_task(struct =
lb_env *env,
>  	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
>  		return mig_unrestricted;
> =20
> +	/* Prioritize asym packing to idle core over cache awareness */
> +	if (env->idle && sched_asym(env->sd, dst_cpu, src_cpu))
> +		return mig_unrestricted;
> +
>  	/* skip cache aware load balance for too many threads */
>  	if (invalid_llc_nr(grp, p, dst_cpu) ||
>  	    exceed_llc_capacity(grp, dst_cpu)) {
> @@ -12154,6 +12160,14 @@ static inline bool llc_balance(struct lb_env *en=
v, struct sg_lb_stats *sgs,
>  	    sgs->group_misfit_task_load)
>  		return false;
> =20
> +	/*
> +	 * On asym packing domains, if the destination CPU
> +	 * has higher priority than all CPUs in the source group,
> +	 * prioritize asym packing.
> +	 */
> +	if (sgs->group_asym_packing)
> +		return false;
> +
>  	/*
>  	 * Skip cache aware tagging if nr_balanced_failed is sufficiently high.
>  	 * Threshold of cache_nice_tries is set to 1 higher than nr_balance_fai=
led
> @@ -13569,12 +13583,12 @@ static int need_active_balance(struct lb_env *e=
nv)
>  {
>  	struct sched_domain *sd =3D env->sd;
> =20
> -	if (alb_break_llc(env))
> -		return 0;
> -
>  	if (asym_active_balance(env))
>  		return 1;
> =20
> +	if (alb_break_llc(env))
> +		return 0;
> +
>  	if (imbalanced_active_balance(env))
>  		return 1;
> =20
