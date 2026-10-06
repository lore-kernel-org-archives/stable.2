Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A226A3BD22F
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276120; cv=none; b=vDcFi6vazjfg0OlAkBMXpPZ5j3GGPqsfpimTbytycf4/MxSiMD6HN+khZ83QITzerKreFV/29/n/O0p+s2onWlIN9RzWAfjElIL4bQEZxkXaiO9FxMRAtSvfxzGlBYD21RIQYM8uS8xB9x8NyOT2rtQhhnw4zT5FAwZb7/3oNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276120; c=relaxed/simple;
	bh=dI6QfOuGCXdwMDYzCv1ozVs6Q/NxOK9fuswck1oG5KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmvPu2OrBAlRZ2pa9gGcHQligGhtfmKO0bRdRy1kOo/5TmpBUs08kE2K2gZF2vvLChTdJezdU6PKYithA+HZcpzjtfjq+omPtaAzXvrBpVzsadbIPa8eSc5dM+6o6PbPLcY+JE0ljtJdn4hobJJWMQavT5IoL3vX4cqcFzJ34PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CEgSRgwJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CEgSRgwJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6142C152B;
	Tue,  6 Oct 2026 01:41:53 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CCC83F86F;
	Tue,  6 Oct 2026 01:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791276116; bh=dI6QfOuGCXdwMDYzCv1ozVs6Q/NxOK9fuswck1oG5KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEgSRgwJQfA/12V/r9XJ4qxlKtnLNRKUWUm7DIdzxxaBSv4aZ0euKXIw4oddgAMmJ
	 /vtsbkndj9RzIG3dmMo/NgG2xKVdpcPcInua4GiFHzVZnMB8qGdpAykJUKWQfowuMc
	 P5WUrOVGSI/DbZU/TnrSYt6isoDtCxARWy1H1hWg=
Date: Tue, 6 Oct 2026 10:41:52 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7.2.y 1/2] arm64: errata: Factor out broken AMU const
 counter cap
Message-ID: <asS0UA_V0tHFPFrQ@arm.com>
References: <2026100500-widget-handcart-8d85@gregkh>
 <20261005225325.3487067-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005225325.3487067-1-sashal@kernel.org>

Hi Sasha,

Was just about to deal with the backports.
All looks good.

Thank you for that!

---
BR
Beata
On Mon, Oct 05, 2026 at 06:53:33PM -0400, Sasha Levin wrote:
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
> Omit the comment update in amu_read_core_const_ctrs(), since paired
> CPPC FFH counter reads are not implemented here. Keep the capability
> rename in the existing counter-read and initialization paths, together
> with the shared MIDR range list needed by the additional erratum.
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
> index fc57d90d92c1d..a38a3940cf208 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1017,9 +1017,17 @@ config ARM64_ERRATUM_1902691
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
> index be47908bb9d22..a6dc9f20373e5 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -377,6 +377,16 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
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
> @@ -904,14 +914,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
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
> index 103e70d683ca2..5dbc20d6d9694 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2087,7 +2087,7 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
>  		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
>  
>  		/* 0 reference values signal broken/disabled counters */
> -		if (!this_cpu_has_cap(ARM64_WORKAROUND_2457168))
> +		if (!this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT))
>  			update_freq_counters_refs();
>  	}
>  }
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index a0d5870bcb657..15035f051c25b 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -390,7 +390,7 @@ static void cpu_read_constcnt(void *val)
>  	 * the counter is disabled. A return value of 0 at counter read is
>  	 * properly handled as an error case by the users of the counter.
>  	 */
> -	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
> +	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT) ?
>  		      0UL : read_constcnt();
>  }
>  
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 9b85a84f6fd49..050175dfa3240 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -103,7 +103,6 @@ WORKAROUND_1902691
>  WORKAROUND_2038923
>  WORKAROUND_2064142
>  WORKAROUND_2077057
> -WORKAROUND_2457168
>  WORKAROUND_2645198
>  WORKAROUND_2658417
>  WORKAROUND_4193714
> @@ -128,3 +127,4 @@ WORKAROUND_REPEAT_TLBI
>  WORKAROUND_SPECULATIVE_AT
>  WORKAROUND_SPECULATIVE_SSBS
>  WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> +WORKAROUND_BROKEN_AMU_CONSTCNT
> -- 
> 2.53.0
> 
