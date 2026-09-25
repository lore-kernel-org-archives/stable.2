Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF519442B15;
	Fri, 25 Sep 2026 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337869; cv=none; b=ZAlvivABfBzlaDpXKRat00SL3BAJRZ6N70BvROKPIXefc+aIGK5LS9wPcx2s1mXDnIgnTSFGOlZ34IbM51SWWLo/isbtI6ino3IMeL3LToPaJj6a5ieog9y6QsJSKliEBo0XFDw1B/GSqasKDplHUMrHD5lMEVSFANqE1xLZAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337869; c=relaxed/simple;
	bh=DPm5L5X/OUylB/usQmYiJR4vbpUS6o8ZX2aJMLsfXdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvy6OPb1MtaUfBGcSmX5JdKcxYp+OF+tm2sFMCZ8gbPWwd0dWGNy7QouJwXMlFyVl4TnjFLTtqRteXhGzE7JMI8TNf8/6CKAzpw7wnryRzMPahhon47I8+/GE6ZS07IPnBXY22fMuqDMDSS+FdEXB1aHoAAxJxYi0Ge+7VCxbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rbt3k4oP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rbt3k4oP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A445169C;
	Fri, 25 Sep 2026 05:04:23 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79FB83F86C;
	Fri, 25 Sep 2026 05:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790337867; bh=DPm5L5X/OUylB/usQmYiJR4vbpUS6o8ZX2aJMLsfXdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbt3k4oPsHwxM0DkF9YdGKCMn7dRYGK6VycvlsaXA95ufMBJvBDXPhxZSF8padwH8
	 Z9zCr6JtZakbEIcih8o9/kxcmtM6TJBRMtayP+ULhPBzrS0TYHn07pXtjezm8QzQfh
	 BOx1jxJU7YNB75Cl3CCVJEkaOji1kum+SR9HbUAM=
Date: Fri, 25 Sep 2026 13:04:17 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Charlie Garner <charlie@akao.au>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, Dhruva Gole <d-gole@ti.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: perf: ignore an implausible
 sustained frequency
Message-ID: <arZjQdIy__kGCAyY@pluto>
References: <20260923152245.44624-1-charlie@akao.au>
 <20260925-native-glorious-kelpie-8bf5dd@sudeepholla>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-native-glorious-kelpie-8bf5dd@sudeepholla>

On Fri, Sep 25, 2026 at 11:00:46AM +0100, Sudeep Holla wrote:
> On Thu, Sep 24, 2026 at 12:52:45AM +0930, Charlie Garner wrote:
> > On a Dell Inspiron 14 Plus 7441 (Snapdragon X Plus X1P64100, soc_id 615)
> > the SCMI firmware reports a sustained frequency below the lowest available
> > OPP for performance domains NCC1 and NCC2. It reports zero for both
> > sustained_freq_khz and sustained_perf_level there, while NCC0 reports
> > 3417600 kHz at level 12. All three domains use level indexing mode, so
> > mult_factor is fixed at 1000 and the OPP frequencies come from
> > indicative_freq; this is not a units or mult_factor problem.
> > 

Hi

seems like I did not receive the original mail anywhhere...

> > scmi_dvfs_device_opps_add() then flags every OPP in NCC1 and NCC2 as turbo:
> > 
> > 	data.turbo = freq > dom->sustained_freq_khz * 1000UL;
> > 
> > cpufreq_frequency_table_cpuinfo() skips boost-flagged entries and fails
> > when none are left:
> > 
> > 	if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
> > 	    && (pos->flags & CPUFREQ_BOOST_FREQ))
> > 		continue;
> > 	...
> > 	if (min_freq == ~0)
> > 		return -EINVAL;
> > 
> > cpufreq_policy_online() drops the policy on that error without logging
> > anything. Only one of the three performance domains ends up with a policy.
> > The part has 10 cores (the x1e80100 DT describes 12, CPUs 7 and 11 fail to
> > boot): 4 of them can scale, the other 6 get no policy, no governor, and no
> > cpufreq cooling device.
> > 
> > This cannot be worked around by enabling boost. policy->boost_enabled is
> > still 0 during that validation, and both places that set it -
> > boost_supported in cpufreq_table_validate_and_sort(), boost_enabled in
> > cpufreq_online() - run after the call that already returned -EINVAL. A
> > domain whose OPPs are all flagged turbo can therefore never get a policy.
> > 
> > Confirmed by probing dev_pm_opp_add_dynamic() on the affected machine: all
> > 13 OPPs are added with turbo=0 for domain NCC0 and turbo=1 for every CPU in
> > NCC1 and NCC2, across an identical 710400-3417600 kHz table. The raw domain
> > attributes above were read the same way, with a kprobe on
> > scmi_dvfs_device_opps_add() fetching the perf_dom_info fields.
> > 
> > A sustained frequency below the lowest OPP carries no information - it
> > cannot separate sustained levels from boost levels. Treat it as "this
> > domain has no turbo levels" instead of letting it disable the domain
> > entirely, and say so once with a FW_BUG warning, since the failure is
> > otherwise silent. A sustained frequency equal to the lowest OPP is left
> > alone, it already leaves that OPP non-turbo.
> > 
> > Fixes: a897575e79d7 ("firmware: arm_scmi: Add support for marking certain frequencies as turbo")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Charlie Garner <charlie@akao.au>
> > ---
> > 
> > Notes:
> >     The SCMI quirks framework (quirks.c) would also work here, and this
> >     platform already has two quirks enabled. I went with a generic check
> >     because a sustained frequency below every OPP is meaningless on any
> >     platform, and the check is a no-op for firmware that reports a sane value.
> >     Happy to turn it into a quirk if you'd prefer that.
> > 
> 
> I am unable to decide which is better approach. I am more inclined to quirks
> so that other systems are not penalised by unnecessary checks but at the same
> time it seems like a sensible generic check.
> 
> Cristian,
> 
> Any strong opinion/inclination ?

No. It is probably an out of spec behaviour that makes sense to spot and
rectify in the original code instead of being doomed to add a string of quirks,
but I am more concerned about upcoming SCMI v4.0 QoS Perf extensions spec which
is public BUT still to come in the implementation, since it makes an extensive
usage of sustained_freq for its own calculation AFAICR

So while now this is flagged as FW_BUG and we carry on because it only impacts
boost, in the future we probably need to shutdown an entire set of features
when this is spotted at discovery, since for anything else that boost I dont
think there is a safe way to guess the proper AND safe sustained levels if
the FW is rotten...

But I suppose we'll take care of that when that time will come...

Thanks,
Cristian
