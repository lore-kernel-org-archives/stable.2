Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FF15476C3;
	Tue, 29 Sep 2026 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704278; cv=none; b=In6wuBctj2H2OiQPmsS9K17KbNZHYk5cNjqk4oAU/sMiNu+nOtIOc1/Sh77RV/sXdpfPkQ5yDSICyhbe70oqRbAopbMzedtq/FJQBUNKYGA9tcyYyxHm6tFk5F3don2f9YxyNwsNres5xXJDeNs2lrvJIk16t5/BDw8N/iDpIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704278; c=relaxed/simple;
	bh=MeJjFj4hIRzyplLhAxnI71a9p+9VbkEjfoce0DJb0BU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eW3CF+qrCjn7HxE7ADLXW17Ps1s5KhuDMEu3Jr+0dDmMVgaMZMB0ywL8aMsU9A35CI8eVDrUtkNqkHggfhT3w1PI4mX62bbGnAkH7pU3FQ41ze/YJKkTvGLQg/cBFXZOE7a2NvWVWjTV0IpUYpnQEuZs0sPRrZCJAg34thf04wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbcad8QG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbcad8QG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790704274; x=1822240274;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MeJjFj4hIRzyplLhAxnI71a9p+9VbkEjfoce0DJb0BU=;
  b=cbcad8QGYQLh8wm/i3irIvadetgZ0cfYfpEjpv4Sd+yywnZycOxxU8AZ
   hQg7lXrJuECw6WWRX2C78fkFkc83qchxWFc338XKJAZU7nCkGjCV6z/G8
   EHJcU2C6JuBtZpNW7uxKY+vbwybGeBd6XAcu/aL0VlbQ7GrDfqaf7FBWU
   yN2QD5sDOJIfyAbcPkoGomN4hKF5Ymv7dwoV7b7057u4GYFCXV6wDd9Mt
   N3DmQiztmgGIIaEC07URHV9sFO5GuxWleXLsJePPD6zHh7cMQalD+S5U+
   U5dsia1JaFMBO389lZgl7zTBGDiEFHbDLpkE6lLOP9Ps9uMJktFzqRq+R
   g==;
X-CSE-ConnectionGUID: n3ZtVm4lT0+jCDsy4dpEmA==
X-CSE-MsgGUID: /7oqOSAdTsuwiLbM2N9zeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90197930"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90197930"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 10:51:13 -0700
X-CSE-ConnectionGUID: kI6vwLTdQFWxABhiqv934g==
X-CSE-MsgGUID: nrR7/EGyRWKkTC69QyaXAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274541967"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.111.124]) ([10.125.111.124])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 10:51:12 -0700
Message-ID: <d7cd3f7d528dff79d2a702543e7d97a44c0c078b.camel@linux.intel.com>
Subject: Re: [PATCH] sched/cache: Honor asym packing over cache aware
 scheduling on hybrid system
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kayra Cizmeci <kayracizmeci@gmail.com>, Nathan Chancellor	
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling	 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: KPrateek.Nayak@amd.com, Vishal.Badole@amd.com,
 klaus.kusche@computerix.info, 	linux-kernel@vger.kernel.org,
 mario.limonciello@amd.com, mingo@redhat.com, 	peterz@infradead.org,
 platform-driver-x86@vger.kernel.org, 	ricardo.neri@intel.com,
 stable@vger.kernel.org, x86@kernel.org, 	yu.c.chen@intel.com,
 llvm@lists.linux.dev
Date: Tue, 29 Sep 2026 10:51:10 -0700
In-Reply-To: <20260928195232.61319-1-kayracizmeci@gmail.com>
References: 
	<221f8b0345328c4b26b65daff4d3eec56a32b06d.1790617047.git.tim.c.chen@linux.intel.com>
	 <20260928195232.61319-1-kayracizmeci@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-28 at 22:52 +0300, Kayra Cizmeci wrote:
> Helloooo Tim,
>=20
> > A regression was reported on an AMD Ryzen AI HX 370 running a cache
> > intensive Clang full-LTO link. The little cores run at a much lower
> > frequency (3.3 GHz vs 5.1 GHz) and have only half of the L3 cache
> > (8 MB vs 16 MB), so pinning such a task to the little-core LLC hurts
> > twice, and full-LTO builds slow down dramatically compared to
> > pre-cache-aware-scheduling kernels.
>=20
> > Asym packing and cache aware scheduling express conflicting placement
> > strategy. Asym packing wants a task to run on the highest priority CPU,
> > whereas cache aware scheduling wants to co-locate the tasks of a proces=
s
> > on one LLC regardless of the priority of CPUs in that LLC.
>=20
> > When asym packing tries to migrate task to an empty
> > core that has higher priority than source cpu, let asym packing win.
> > Moving tasks to a higher performing idle core will buy more
> > performance than cache co-location.
>=20
>=20
> > +static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, in=
t src_cpu);
> > +
> >  /*
> >   * Check if task p can migrate from source LLC to
> >   * destination LLC in terms of cache aware load balance.
> > @@ -10847,6 +10849,10 @@ static enum llc_mig can_migrate_llc_task(struc=
t lb_env *env,
> >  	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
> >  		return mig_unrestricted;
> > =20
> > +	/* Prioritize asym packing over cache awareness */
> > +	if (sched_asym(env->sd, dst_cpu, src_cpu))
> > +		return mig_unrestricted;
> > +
> >  	/* skip cache aware load balance for too many threads */
> >  	if (invalid_llc_nr(grp, p, dst_cpu) ||
> >  	    exceed_llc_capacity(grp, dst_cpu)) {
> > @@ -12043,6 +12049,15 @@ static inline bool llc_balance(struct lb_env *=
env, struct sg_lb_stats *sgs,
> >  	    sgs->group_misfit_task_load)
> >  		return false;
> > =20
> > +	/*
> > +	 * On asym packing domains, if the destination CPU
> > +	 * has higher priority than all CPUs in the source group,
> > +	 * prioritize asym packing.
> > +	 */
> > +	if ((env->sd->flags & SD_ASYM_PACKING) &&
> > +	    sgs->group_asym_packing)
> > +		return false;
> > +
> >  	/*
> >  	 * Skip cache aware tagging if nr_balanced_failed is sufficiently hig=
h.
> >  	 * Threshold of cache_nice_tries is set to 1 higher than nr_balance_f=
ailed
> > @@ -13458,12 +13473,12 @@ static int need_active_balance(struct lb_env =
*env)
> >  {
> >  	struct sched_domain *sd =3D env->sd;
> > =20
> > -	if (alb_break_llc(env))
> > -		return 0;
> > -
> >  	if (asym_active_balance(env))
> >  		return 1;
> > =20
> > +	if (alb_break_llc(env))
> > +		return 0;
> > +
> >  	if (imbalanced_active_balance(env))
> >  		return 1;
> =20
> Hope I could test this. But I don't really have hardware for it :-(.
>=20
> Regardless tho.
>=20
> Let's say when entering can_migrate_llc_task(), dst_cpu is CPU0, while sr=
c_cpu is CPU1.
> And CPU0 has a bigger asym_prio than CPU1. No SMT. When entering can_migr=
ate_llc_task() and sched_asym()
> from there sched_use_asym_prio() returns true without checking if the cor=
e is fully idle or not.

sched_asym() does check whether the destination core is idle in sched_use_a=
sym_prio() for non SMT domain.

                  (false for non-SMT sd)           (check idle core)
       return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);

That is also a pre-condition for setting group_asym_packing.

> And sched_asym_prefer() comes back true too, so sched_asym() returns true=
 and, we just returned mig_unrestricted.
>=20
> I could be missing something, If I'm not tho is that on purpose? If it is=
, the last paragraph needs to change
> since it says that "asym packing tries to migrate task to an empty core" =
and after that "higher performing idle core"

I think I did try to point out the idle core aspect in my commit log:

"When asym packing tries to migrate task to an empty
core that has higher priority than source cpu, let asym packing win.
Moving tasks to a higher performing idle core will buy more
performance than cache co-location."

I am not sure how you would like it changed.

Thanks.

Tim

>=20
> Thanks,
> Kayra
