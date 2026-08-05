Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844003D567F;
	Wed,  5 Aug 2026 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961179; cv=none; b=JcVdTHucdbETt2G8TuA126dbIm9AUj9SxzSbCdQQGa0G44tPCW9+hjhnMzPat8nGwEMlOkourkmvQteY93DTaBr6nUrZ+bSO4EScDgA8II/EtD5UnzSKCVs6S0rLT0jLIhx0t3gpRJTjZL5ot4puqeiXPCf8QyG/BArcoc04gI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961179; c=relaxed/simple;
	bh=MsBh9GRCXAr77Z5rYG3numskBPj+yN4O41T8gtSGGF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NCCRpOHoEKp4wYRhOs4+dfUA/h8Uumu0z4xvdxiTn4MXnzshiZjQd4Ipdt8Drs9DsEvCk2CYm99RjejvpW/Y2ETy6rI2ZxgkwIMVEY0i8leLGObzmmxvHi7Jue4JzWU75g9zpfd6kK6A5ccN3WRcgh7mzHT/w8d/C6VK9eCY84I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4GodY3A; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4GodY3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785961177; x=1817497177;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MsBh9GRCXAr77Z5rYG3numskBPj+yN4O41T8gtSGGF8=;
  b=N4GodY3A/nr6u9iUMI07//efzo5wX2M1yUVeB9c4nR6lhP6YR9yT7Fzn
   0M5GjxaCCYnR7BHpgJssE1uT99zMCnFioMle7aeNaiT4R2dw9FXSLnp6P
   b3lDPM0AeTCK70czV/BjZtjzt0d0j9CJfLFeL2fmuaNc7tfqazCbfIKSc
   9+0SOMUY4gaK0F4CkL6Rj7thoFIMOfWBXuyH338JdLC8khzXXcqVmsQcT
   efuf9MrSxcKhH+It4YPvx9YJaYUa1UyCKY7jl+AM1VPdFDg+nHLG8oRz+
   BDHB7AP5MucME2U0ymsOwWRaqHi5nosB5EhHKIuZff+4a89c0j+HQVbjH
   g==;
X-CSE-ConnectionGUID: bkB4ZBq8TtWavBbrg5WDtg==
X-CSE-MsgGUID: exC9UG9CTO6YOzliuaVX4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86624694"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86624694"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 13:19:37 -0700
X-CSE-ConnectionGUID: L/wLtGeHTqmj5KT7rnjPxg==
X-CSE-MsgGUID: iT5DvPITTcipG4M3CcuAnw==
X-ExtLoop1: 1
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 13:19:36 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: David Lee <david.lee@trailofbits.com>, jhs@mojatatu.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>, Dominik 'Disconnect3d' Czarnota
 <dominik.czarnota@trailofbits.com>, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, David Lee <david.lee@trailofbits.com>
Subject: Re: [PATCH net] net/sched: sch_taprio: do not requeue a deactivated
 qdisc
In-Reply-To: <20260805102514.740834-1-david.lee@trailofbits.com>
References: <20260805102514.740834-1-david.lee@trailofbits.com>
Date: Wed, 05 Aug 2026 13:19:36 -0700
Message-ID: <87ecgc48x3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Lee <david.lee@trailofbits.com> writes:

> From: Kyle Zeng <kylebot@openai.com>
>
> Root qdisc replacement and deletion call dev_deactivate() without
> resetting the old qdisc. This marks the qdisc deactivated and waits for
> existing runs to finish, but leaves TAPRIO's private hrtimer active.
> advance_sched() can therefore requeue the old root after the final busy
> check, allowing a new run to overlap reset and destruction.
>
> Do not schedule TAPRIO after its root has been deactivated. Keep the
> test in the existing RCU read-side critical section so that it pairs
> with the synchronize_net() in dev_deactivate_many(): a callback which
> observes an active qdisc must finish before the final busy check, while
> a later callback observes the deactivated state and skips the requeue.
>
> Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Co-developed-by: David Lee <david.lee@trailofbits.com>
> Signed-off-by: David Lee <david.lee@trailofbits.com>
> ---
> Bug found and triaged by OpenAI Security Research and
> validated by Trail of Bits.
>
> The supplied v7.2-rc3 trace contains a KASAN use-after-free. The
> reproducer did not trigger a sanitizer report in the current v7.2-rc5
> campaign and can be shared if needed.
>
>  net/sched/sch_taprio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 299234a5f..2cf76df43 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -990,7 +990,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  	hrtimer_set_expires(&q->advance_timer, end_time);
>  
>  	rcu_read_lock();
> -	__netif_schedule(sch);
> +	if (!test_bit(__QDISC_STATE_DEACTIVATED, &sch->state))
> +		__netif_schedule(sch);
>  	rcu_read_unlock();
>

I'll be the first one to admit that taprio is a weird one (that it keeps
a timer around while it's running among others), but it looks to me that
this check would make more sense inside __netif_schedule().

Let's see what others think.


Cheers,
-- 
Vinicius
