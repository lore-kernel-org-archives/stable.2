Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F44489FA4;
	Fri, 25 Sep 2026 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330452; cv=none; b=MW3YTffx7PGKGJNrhnV6zMDSBpzykDuT8qzuovmfsUA/qmbixscy+JonaceK78giDwGUm9bEWizPsJ31RnRqjGLqF44jJ3p57BWCpQhVhwMH/L5KizYCXzaAyrqfH4B6QEMsxupC9ehnscSUJD7DWWOsO4E5/J3VFpUkehgsvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330452; c=relaxed/simple;
	bh=wiQuVEoBIaZ8IE6Cbv6FzXa8XQ+QrHXi2uEhpHQjf2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8NvnLJ73wAPS3wtFM7tquaFLgJA64YBGr6CTK0gRpWHOxO9ytfPF7vAIe0bEIMsxEzUKspnzy8Hl82mxwDo16NiRCliYDedrpEoevsBvUV6l6j5fCunYJ554kNzS0up3EUWquEUNTAU1w0B260WAz8aUs/96aNaUqH+syRK1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otlwK+XF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otlwK+XF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FCF1F000FF;
	Fri, 25 Sep 2026 10:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790330450;
	bh=091cobKw1OczUPtMjUVWe4j3hvI4PcnBahesORRu4pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=otlwK+XFcIczRvU351HmIuZLYxMIZCirmb0t07v8w5giskWGcbwuFfzinfGMydPP5
	 kjhdNcTzGVQH+jRBwqQ0UrYXs9lJgs8+4bSBhexyCrdiFqRfxzFOIVjUJBuSHocuIk
	 DM5DlzSuOe4hA1pSD7uYeF6oqzFiwhJhLEmuy1tcpnSooMGO+GebjyIn9PvlyazEEq
	 bhc9PBHLH0Q8xZF1klnLahZKGwaXIU7XohAjArScJG53G899SQRH5tSw82GNMBoAE5
	 tetOqVHn9nULkXQcgzBdvC+XT4ftE4WmCNgwp8bxWEvHUck12Wt/tp7gTwhvs26EZ1
	 V2cixsZ2Fo60A==
Date: Fri, 25 Sep 2026 11:00:46 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Charlie Garner <charlie@akao.au>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, Dhruva Gole <d-gole@ti.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: perf: ignore an implausible
 sustained frequency
Message-ID: <20260925-native-glorious-kelpie-8bf5dd@sudeepholla>
References: <20260923152245.44624-1-charlie@akao.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923152245.44624-1-charlie@akao.au>

On Thu, Sep 24, 2026 at 12:52:45AM +0930, Charlie Garner wrote:
> On a Dell Inspiron 14 Plus 7441 (Snapdragon X Plus X1P64100, soc_id 615)
> the SCMI firmware reports a sustained frequency below the lowest available
> OPP for performance domains NCC1 and NCC2. It reports zero for both
> sustained_freq_khz and sustained_perf_level there, while NCC0 reports
> 3417600 kHz at level 12. All three domains use level indexing mode, so
> mult_factor is fixed at 1000 and the OPP frequencies come from
> indicative_freq; this is not a units or mult_factor problem.
> 
> scmi_dvfs_device_opps_add() then flags every OPP in NCC1 and NCC2 as turbo:
> 
> 	data.turbo = freq > dom->sustained_freq_khz * 1000UL;
> 
> cpufreq_frequency_table_cpuinfo() skips boost-flagged entries and fails
> when none are left:
> 
> 	if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
> 	    && (pos->flags & CPUFREQ_BOOST_FREQ))
> 		continue;
> 	...
> 	if (min_freq == ~0)
> 		return -EINVAL;
> 
> cpufreq_policy_online() drops the policy on that error without logging
> anything. Only one of the three performance domains ends up with a policy.
> The part has 10 cores (the x1e80100 DT describes 12, CPUs 7 and 11 fail to
> boot): 4 of them can scale, the other 6 get no policy, no governor, and no
> cpufreq cooling device.
> 
> This cannot be worked around by enabling boost. policy->boost_enabled is
> still 0 during that validation, and both places that set it -
> boost_supported in cpufreq_table_validate_and_sort(), boost_enabled in
> cpufreq_online() - run after the call that already returned -EINVAL. A
> domain whose OPPs are all flagged turbo can therefore never get a policy.
> 
> Confirmed by probing dev_pm_opp_add_dynamic() on the affected machine: all
> 13 OPPs are added with turbo=0 for domain NCC0 and turbo=1 for every CPU in
> NCC1 and NCC2, across an identical 710400-3417600 kHz table. The raw domain
> attributes above were read the same way, with a kprobe on
> scmi_dvfs_device_opps_add() fetching the perf_dom_info fields.
> 
> A sustained frequency below the lowest OPP carries no information - it
> cannot separate sustained levels from boost levels. Treat it as "this
> domain has no turbo levels" instead of letting it disable the domain
> entirely, and say so once with a FW_BUG warning, since the failure is
> otherwise silent. A sustained frequency equal to the lowest OPP is left
> alone, it already leaves that OPP non-turbo.
> 
> Fixes: a897575e79d7 ("firmware: arm_scmi: Add support for marking certain frequencies as turbo")
> Cc: stable@vger.kernel.org
> Signed-off-by: Charlie Garner <charlie@akao.au>
> ---
> 
> Notes:
>     The SCMI quirks framework (quirks.c) would also work here, and this
>     platform already has two quirks enabled. I went with a generic check
>     because a sustained frequency below every OPP is meaningless on any
>     platform, and the check is a no-op for firmware that reports a sane value.
>     Happy to turn it into a quirk if you'd prefer that.
> 

I am unable to decide which is better approach. I am more inclined to quirks
so that other systems are not penalised by unnecessary checks but at the same
time it seems like a sensible generic check.

Cristian,

Any strong opinion/inclination ?

>  drivers/firmware/arm_scmi/perf.c | 34 ++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 4583d02bee1c..94f644996f9d 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -861,11 +861,20 @@ static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
>  	dom->fc_info = fc;
>  }
>  
> +static unsigned long scmi_perf_opp_freq(const struct perf_dom_info *dom,
> +					int idx)
> +{
> +	if (!dom->level_indexing_mode)
> +		return dom->opp[idx].perf * dom->mult_factor;
> +
> +	return dom->opp[idx].indicative_freq * dom->mult_factor;
> +}
> +
>  static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>  				     struct device *dev, u32 domain)
>  {
>  	int idx, ret;
> -	unsigned long freq;
> +	unsigned long freq, sustained_hz, lowest_hz = ULONG_MAX;
>  	struct dev_pm_opp_data data = {};
>  	struct perf_dom_info *dom;
>  
> @@ -873,14 +882,27 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>  	if (IS_ERR(dom))
>  		return PTR_ERR(dom);
>  
> +	for (idx = 0; idx < dom->opp_count; idx++)
> +		lowest_hz = min(lowest_hz, scmi_perf_opp_freq(dom, idx));
> +

Just wondering how badly the perf values are also screwed up on this system ?
If we are adding it as generic, I am thinking of just using the sorted
opp list and lowest_hz = scmi_perf_opp_freq(dom, 0), no ? It avoids
unnecessary loop above.

-- 
Regards,
Sudeep
