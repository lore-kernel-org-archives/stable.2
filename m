Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C4E37BE6E
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276400; cv=none; b=GQ1NwpEk17Enl6ggbrMK8RPnmlMu/+B/5D+/g2nvOxNKo22TWFioI8V1NzXo+edECVrdPqMOqVV2+Jl6+RlShLfMcRgzX0lg6e3aKEKVmItRfeugBx00MfOZHo2XwINoqHKUeL6ChAKYhP75lqG4NjNpxVADe2TLJDvkRNfsM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276400; c=relaxed/simple;
	bh=F+L9o7yvevvvTy/BhYG3WAfKqv4cCDS/YBXm05DfIys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTp5eSZUhk5Sd50B2IBEfka8ltRHuyrmmBLS/SUfVGiE5KeH6NfYDHigyUQp+iNIv87V+wgZpmfcSIUzbrljdtBHkiIo5j+8o3fo6Sso6uARYstqszik+y0W9tZsgYA4LIxYkxqz46wy3HsXm/W/cOTH0QNj6wTxeFeq7AwROdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LjqQWiaK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LjqQWiaK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8994B1516;
	Tue,  6 Oct 2026 01:46:34 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FB233F86F;
	Tue,  6 Oct 2026 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791276397; bh=F+L9o7yvevvvTy/BhYG3WAfKqv4cCDS/YBXm05DfIys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjqQWiaKDCTnwhCtUPXpTc7AWydYL5WKwof2P2ETFvYieBvNwo2lMHPRRKflopB1I
	 tESrAhb93fbsL9FYxJYMTmZIJtLnmuFY3DMASZysBRQFzXZ58Fe/cgFugnFSWc1bSP
	 dRnBVl5BzvPxjL4A4oHCRyfvk7wD0IHWN3nYF9iQ=
Date: Tue, 6 Oct 2026 10:46:33 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6.18.y 1/2] arm64: errata: Factor out broken AMU const
 counter cap
Message-ID: <asS1aS8s3kSzRqkx@arm.com>
References: <2026100500-elsewhere-excretion-642e@gregkh>
 <20261006000910.3554634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006000910.3554634-1-sashal@kernel.org>

LGTM. Thank you!

---
BR
Beata
On Mon, Oct 05, 2026 at 08:09:26PM -0400, Sasha Levin wrote:
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
> The paired CPPC FFH counter-read helper is absent here, so omit its
> comment-only update. Retain the shared capability and MIDR range list,
> and update the existing AMU initialization and constant-counter read
> paths. This preserves Cortex-A510 handling and prepares the shared
> workaround for Cortex-A725.
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
> index f7c4cb4fbaf1b..8f483df09dbe7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1049,9 +1049,17 @@ config ARM64_ERRATUM_1902691
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
> index 1a7425375d0e1..917231415c007 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -353,6 +353,16 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
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
> @@ -869,14 +879,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
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
> index 39a798f74778e..bb73d05318a92 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2054,7 +2054,7 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
>  		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
>  
>  		/* 0 reference values signal broken/disabled counters */
> -		if (!this_cpu_has_cap(ARM64_WORKAROUND_2457168))
> +		if (!this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT))
>  			update_freq_counters_refs();
>  	}
>  }
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 1be36a30d9e6c..6ad8ea3c7258b 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -431,7 +431,7 @@ static void cpu_read_constcnt(void *val)
>  	 * the counter is disabled. A return value of 0 at counter read is
>  	 * properly handled as an error case by the users of the counter.
>  	 */
> -	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
> +	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT) ?
>  		      0UL : read_constcnt();
>  }
>  
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 16d123088ddd4..3e2c5c1914d88 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -98,7 +98,6 @@ WORKAROUND_1902691
>  WORKAROUND_2038923
>  WORKAROUND_2064142
>  WORKAROUND_2077057
> -WORKAROUND_2457168
>  WORKAROUND_2645198
>  WORKAROUND_2658417
>  WORKAROUND_4193714
> @@ -122,3 +121,4 @@ WORKAROUND_REPEAT_TLBI
>  WORKAROUND_SPECULATIVE_AT
>  WORKAROUND_SPECULATIVE_SSBS
>  WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> +WORKAROUND_BROKEN_AMU_CONSTCNT
> -- 
> 2.53.0
> 
