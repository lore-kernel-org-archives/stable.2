Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885010;
	b=3H35E0XzCOcXv+r1hmPq5NbvIrgQ47+k79KdDU8sqWi2rFWWcFYAWlRLELWGiupuCH0+
	 1REKf/xWP+yX+niX3o4VhBOo6OqBFSFaGcP1E21gCMPQWGNyY8VJg63Bx1qWxE9aVKuPB
	 PgptaezYRZHYx+cAio9A9Y3w1endXAXsHM92l3xaIVS443S9aP4w36Z9KRAQRnoPQyic1
	 2peQT0tsM4rirJ5zyRFOdlLRaBCOMKdyMIJajTbgOFRGbBueW3fy2+eiiVwrnYUkczYit
	 J3g4Eqha7wfagX2eBuBrH5q7dMcQE7GMd8xpU8shorE5+ZapqFz6HrSD6q8KEHAslIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885010;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZxTT9i+ILNul39ARG4FLn5WWls600D2oa0wlIsH0HPc=;
	b=hGGIvV/ctvV1em/pAtCmhhSa+TE37K7hZHNgN//1ZBCwcM4p3VUttkFC+xCsNgvhsCjd
	 Lx4JPG4EqEVm5TkI9ZxOh8H7FJ2ut7+WzmGgognmP2Hmd82FezSvPS6sbuKIBlqtqO3PT
	 PxGktT9nCDSKnGbKB2lgI9SVEhby+2Tp483gMK0wX7AuaYclIDOmTGWNjstJ0iO1CTdSR
	 znD1HxcgW+J8hVpdOjHcDgvtBprhrYEqN2vUBLJ+Wsc+5EL218o8PDgOcU9yLHWibBtDI
	 XsxuuFwGfCsrWvmDTNhSAmqjPEJLZS7IshznBa0CiudQSJ9Yanq9xUd68kPF4BSe5QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QBbdhMpE;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB619606D803;
	Thu,  5 Nov 2026 13:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB619606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QBbdhMpE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECB281596;
	Thu,  5 Nov 2026 05:23:25 -0800 (PST)
Received: from [10.57.10.82] (unknown [10.57.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FAFE3F628;
	Thu,  5 Nov 2026 05:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793885009; bh=fmSAFaLie0xOSVQMYENoCEVnhmqkanh9g3dnKuhD5yI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QBbdhMpEhWjk73nrmCV4dkYGyL7SFavUIbyopSiikN6z/lS9wTr6KYm5K9+6WP0qK
	 PqmgU2i0I2zsd+1Y76OavT4w3JcfwKSAebeymTGvJyY+rQbwq+bIwC/bhLDJZzMH1G
	 CIwJIbiWplcUJc28pgQUDBfcRVpzJnblxC8eO1T0=
Message-ID: <cbec4a5b-b5c8-4db0-95cd-09c73bd3976f@arm.com>
Date: Thu, 5 Nov 2026 13:23:58 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Exclude boost frequencies from inefficiency
 ranking
To: Guo Chen <guo.chen@oss.qualcomm.com>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, Matthias Kaehlcke
 <mka@chromium.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 xin.liu@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
 tengfei.fan@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
 "Rafael J . Wysocki" <rafael@kernel.org>
References: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/26 11:21, Guo Chen wrote:
> em_compute_costs() ranks all the frequencies of the table, boost ones
> included. A non-boost frequency can be marked inefficient only because
> a faster boost frequency has a lower or equal cost, e.g.
> 
>    3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)
> 
> With boost disabled 4.1 GHz cannot be selected, but 4.0 GHz is still
> skipped by governors rounding down to efficient frequencies (e.g.
> ondemand with CPUFREQ_RELATION_HE), which land on 3.9 GHz instead of
> the best selectable frequency. Several frequencies can be affected.
> 
> Exclude the boost frequencies from the ranking in em_compute_costs() and
> keep them all efficient, using the highest non-boost frequency of the
> CPUFreq table, returned by the new helper
> cpufreq_table_max_nonboost_freq(), as the boundary.
> 
> Fixes: c8ed99533dbc ("PM: EM: Mark inefficient states")
> Signed-off-by: Guo Chen <guo.chen@oss.qualcomm.com>
> ---
> Changes in v2:
> - Drop prev_boost and keep all boost states efficient by resetting
>    prev_cost for them, as suggested by Lukasz. Boost states are no
>    longer ranked against each other.
> - Retitle the patch to match the new behaviour (was "Rank boost and
>    non-boost frequencies separately") and reword the commit message.
> 
> Link to v1: https://lore.kernel.org/all/20261030-em-rank-boost-separately-v1-1-238a6b2bb888@oss.qualcomm.com/
> ---
>   include/linux/cpufreq.h     | 24 ++++++++++++++++++++++++
>   kernel/power/energy_model.c | 16 ++++++++++++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d3d0d9d02aa4..c93316141a11 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1155,6 +1155,24 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
>   	return -EINVAL;
>   }
>   
> +static inline unsigned int
> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_frequency_table *pos;
> +	unsigned int max = 0;
> +
> +	if (!policy->freq_table)
> +		return 0;
> +
> +	/* The table may be unsorted, scan all of it for the highest one. */
> +	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
> +		if (!(pos->flags & CPUFREQ_BOOST_FREQ) && pos->frequency > max)
> +			max = pos->frequency;
> +	}
> +
> +	return max;
> +}
> +
>   static inline int parse_perf_domain(int cpu, const char *list_name,
>   				    const char *cell_name,
>   				    struct of_phandle_args *args)
> @@ -1219,6 +1237,12 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
>   	return -EINVAL;
>   }
>   
> +static inline unsigned int
> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
> +{
> +	return 0;
> +}
> +
>   static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
>   						     const char *cell_name, struct cpumask *cpumask,
>   						     struct of_phandle_args *pargs)
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index d19a65461ae8..5b1d095fd376 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -255,15 +255,24 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>   			    unsigned long flags)
>   {
>   	unsigned long prev_cost = ULONG_MAX;
> +	struct cpufreq_policy *policy;
> +	unsigned int max_nonboost = 0;
>   	int i, ret;
>   
>   	/* This is needed only for CPUs and EAS skip other devices */
>   	if (!_is_cpu_device(dev))
>   		return 0;
>   
> +	policy = cpufreq_cpu_get(dev->id);
> +	if (policy) {
> +		max_nonboost = cpufreq_table_max_nonboost_freq(policy);
> +		cpufreq_cpu_put(policy);
> +	}
> +
>   	/* Compute the cost of each performance state. */
>   	for (i = nr_states - 1; i >= 0; i--) {
>   		unsigned long power_res, cost;
> +		bool boost = max_nonboost && table[i].frequency > max_nonboost;
>   
>   		if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
>   			ret = cb->get_cost(dev, table[i].frequency, &cost);
> @@ -284,6 +293,13 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>   			table[i].flags = EM_PERF_STATE_INEFFICIENT;
>   			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
>   				table[i].frequency);
> +		} else if (boost) {
> +			/*
> +			 * Keep all boost states efficient. Resetting prev_cost
> +			 * also keeps the highest non-boost state efficient,
> +			 * then rank the rest on their own.
> +			 */
> +			prev_cost = ULONG_MAX;
>   		} else {
>   			prev_cost = table[i].cost;
>   		}
> 
> ---
> base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> change-id: 20261029-em-rank-boost-separately-a7e7c7d78058
> 
> Best regards,
> --
> Guo Chen <guo.chen@oss.qualcomm.com>


LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

