Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19F3B9D9E
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276683; cv=none; b=HrfohWjMUxYyN5bOO/nNLzfx+JouBfhjFBYkF0TVGUcbF0YxOadg7B56VG8wDHNR49G+nfKovHk8GbwygzWqUtidyXNRkarMjXBkruY1I0f1R2B9x9932vKHYmGcUwA9ahvUIcUu0X5Id0fYrSJ/RGc+lvJ7TblydJES5lypjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276683; c=relaxed/simple;
	bh=esKVpiK8T5DHRr86gE+NWx03wG+K05UVkNwP7QblqGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixUg6glv1pwVVBqsoThinNSP4Kax71omIiqgM++FvoSDR1l3kGJ9CmPj73/R9j5mgf5tgtMttYwayjWzqWiwJqv2oupS9ILYn3XMvAH1Sl4fOgJ9kk6QLNCR9++XQldJ+S3WTuq8vkW03gHe2Rh62wd2WbkvKESY47FwAO6gcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WSSubnG+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WSSubnG+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D060152B;
	Tue,  6 Oct 2026 01:51:17 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B8693F86F;
	Tue,  6 Oct 2026 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791276680; bh=esKVpiK8T5DHRr86gE+NWx03wG+K05UVkNwP7QblqGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSSubnG+HqMxG7YcQZA2IXl+oJqLdYkwtK1H6FnWYksTIWCuhXosjpXKCYmVgrPAK
	 AyMajpmk8FwfAkAJjVehORYfsPC1FlICPOXm/Grpo7PGo+RVjHW7E4wSt0pVaRFUOn
	 pyhaZOGjYSzMAkpJIKSjXjgO+OrByrxFhcqfECkk=
Date: Tue, 6 Oct 2026 10:51:16 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] arm64: errata: Factor out broken AMU const
 counter cap
Message-ID: <asS2hPO-vNg8juGW@arm.com>
References: <2026100501-unsubtle-blank-50b6@gregkh>
 <20261006002934.3618253-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006002934.3618253-1-sashal@kernel.org>

LGTM. Thank you.

---
BR
Beata
On Mon, Oct 05, 2026 at 08:29:47PM -0400, Sasha Levin wrote:
> From: Beata Michalska <beata.michalska@arm.com>
> 
> [ Upstream commit 573371caf7aea8582212da81dcead2c3f48fac4b ]
> 
> Move the workaround from the erratum 2457168-specific cpucap to a generic
> broken AMU constant-counter one. This keeps the existing Cortex-A510
> handling unchanged while allowing other errata with similar AMU constant
> counter issue to share the capability bit and call sites.
> 
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> 
> Omit the comment-only update to the paired AMU counter reader, which
> is absent here. Retain the shared capability, CPU matching list, and
> the checks in the existing counter-read and frequency-invariance paths.
> 
> Stable-dep-of: 45f730467987 ("arm64: errata: Add Cortex-A725 erratum 3821522 workaround")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm64/Kconfig             |  8 ++++++++
>  arch/arm64/kernel/cpu_errata.c | 20 ++++++++++++++------
>  arch/arm64/kernel/cpufeature.c |  2 +-
>  arch/arm64/kernel/topology.c   |  2 +-
>  arch/arm64/tools/cpucaps       |  2 +-
>  5 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 938bf2f96b1a8..d2901607b4f9e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1023,9 +1023,17 @@ config ARM64_ERRATUM_1902691
>  
>  	  If unsure, say Y.
>  
> +config ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
> +	bool
> +	# Targeting errata affecting AMEVCNTR01, the AMU constant counter.
> +	# On affected CPUs the counter may not increment at the expected rate,
> +	# making it unreliable. As a result, AMU users should treat it as
> +	# unavailable rather than relying on misleading counter values.
> +
>  config ARM64_ERRATUM_2457168
>  	bool "Cortex-A510: 2457168: workaround for AMEVCNTR01 incrementing incorrectly"
>  	depends on ARM64_AMU_EXTN
> +	select ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
>  	default y
>  	help
>  	  This option adds the workaround for ARM Cortex-A510 erratum 2457168.
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 80e47d3e86af4..1dc2373fc1b9c 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -259,6 +259,16 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
>  };
>  #endif
>  
> +#ifdef CONFIG_ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
> +static const struct midr_range workaround_amu_constcnt_list[] = {
> +#ifdef CONFIG_ARM64_ERRATUM_2457168
> +	/* Cortex-A510 r0p0-r1p1 */
> +	MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
> +#endif
> +	{}
> +};
> +#endif /* CONFIG_ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT */
> +
>  #ifdef CONFIG_CAVIUM_ERRATUM_23154
>  static const struct midr_range cavium_erratum_23154_cpus[] = {
>  	MIDR_ALL_VERSIONS(MIDR_THUNDERX),
> @@ -750,14 +760,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
>  	},
>  #endif
> -#ifdef CONFIG_ARM64_ERRATUM_2457168
> +#ifdef CONFIG_ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
>  	{
> -		.desc = "ARM erratum 2457168",
> -		.capability = ARM64_WORKAROUND_2457168,
> +		.desc = "Broken AMU AMEVCNTR01 (const counter)",
> +		.capability = ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT,
>  		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
> -
> -		/* Cortex-A510 r0p0-r1p1 */
> -		CAP_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1)
> +		CAP_MIDR_RANGE_LIST(workaround_amu_constcnt_list)
>  	},
>  #endif
>  #ifdef CONFIG_ARM64_ERRATUM_2038923
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 8246015fd2d73..ae4782ce523a6 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2070,7 +2070,7 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
>  		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
>  
>  		/* 0 reference values signal broken/disabled counters */
> -		if (!this_cpu_has_cap(ARM64_WORKAROUND_2457168))
> +		if (!this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT))
>  			update_freq_counters_refs();
>  	}
>  }
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index cb180684d10d5..d21b4e963f6b7 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -271,7 +271,7 @@ static void cpu_read_constcnt(void *val)
>  	 * the counter is disabled. A return value of 0 at counter read is
>  	 * properly handled as an error case by the users of the counter.
>  	 */
> -	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
> +	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT) ?
>  		      0UL : read_constcnt();
>  }
>  
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index eedb5acc21ed9..edb2e35e5e7ee 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -85,7 +85,6 @@ WORKAROUND_1902691
>  WORKAROUND_2038923
>  WORKAROUND_2064142
>  WORKAROUND_2077057
> -WORKAROUND_2457168
>  WORKAROUND_2645198
>  WORKAROUND_2658417
>  WORKAROUND_AMPERE_AC03_CPU_38
> @@ -105,3 +104,4 @@ WORKAROUND_REPEAT_TLBI
>  WORKAROUND_SPECULATIVE_AT
>  WORKAROUND_SPECULATIVE_SSBS
>  WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> +WORKAROUND_BROKEN_AMU_CONSTCNT
> -- 
> 2.53.0
> 
