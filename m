Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660833E0758
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276291; cv=none; b=oFyfsilGq3kUmc8Ld2o241jSbozkNKSB1lfoV/CbQXe3KLQ2b8yUJoR9g8XSI7gKXZZbv1u+1m26NgavyyH/Rmce+KMc8K8xgJmNRyOFynduuzOvW1hd6OgQcbflPQw4EE4pT7KoWRESWRcPMukMZLOCvayko4CCjbjh33GAPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276291; c=relaxed/simple;
	bh=E2uU1WDy0gwUq4IH1PBe7jtfNx76scXurF8ZQefG+Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+KzMAzy+WA3RIO8vX+n+iBNQhkg9OEFSvGw8Rc3Nwyn8+JxLYsKW+eZhv6z5FRrNW5IGH5Dbn1Qoo0zlvAEw1ht0FA1J0k1fJJfrwAWgkBh0SjqhyiC1a+HPiCawgK6+LJyaCSYYwp5fhAG6RNvGOgiPnq4Ziccrz5F29KSy+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZAmb+Hhi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZAmb+Hhi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35E5E152B;
	Tue,  6 Oct 2026 01:44:45 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 625CB3F86F;
	Tue,  6 Oct 2026 01:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791276288; bh=E2uU1WDy0gwUq4IH1PBe7jtfNx76scXurF8ZQefG+Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAmb+HhidGQEdWAC1OwMvj8DqCJIMGXItT9TyHNR5NNV7E3xmWdTuxjDi/+fE8AEF
	 Zeq9bi2rdbaAEKgkXByvPWAPno+44UEXHpYr7RtNWu7UiwGf4FhcEr201dzfeRHpvs
	 yDPv17Hh+E1vnC7FDfHWHYb7609f4AactKaI+SV0=
Date: Tue, 6 Oct 2026 10:44:44 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7.2.y 2/2] arm64: errata: Add Cortex-A725 erratum 3821522
 workaround
Message-ID: <asS0_Ku1UMClEJqG@arm.com>
References: <2026100500-widget-handcart-8d85@gregkh>
 <20261005225325.3487067-1-sashal@kernel.org>
 <20261005225325.3487067-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005225325.3487067-2-sashal@kernel.org>


LGTM
Thank you!

---
BR
Beata

On Mon, Oct 05, 2026 at 06:53:34PM -0400, Sasha Levin wrote:
> From: Beata Michalska <beata.michalska@arm.com>
> 
> [ Upstream commit 45f7304679875eb000d67e194090ee7abd05c89c ]
> 
> Cortex-A725 erratum 3821522 affects the CNT_CYCLES event, which can
> incur a significant increment error when a CPU enters and subsequently
> exits WFE or WFI, and may no longer track the system counter
> frequency.
> 
> The AMEVCNTR01_EL0 counter is used as the AMU constant counter for
> frequency invariance and CPPC FFH feedback counters. Wire the affected
> Cortex-A725 range into the shared broken AMU constant-counter capability
> so the affected counter is treated as unavailable by returning zero in
> the AMU counter paths. This prevents the broken counter from being used
> as a reference source.
> 
> The erratum can also affect PMUv3 users of the CNT_CYCLES event,
> but this workaround intentionally does not change PMU event handling.
> Hiding or rejecting the PMU event from the erratum code would change
> the perf-visible PMU event interface, including raw event selection,
> and would need a separate PMU-specific approach rather than being
> folded into the AMU reference-counter workaround.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/arch/arm64/silicon-errata.rst |  2 ++
>  arch/arm64/Kconfig                          | 22 +++++++++++++++++++++
>  arch/arm64/kernel/cpu_errata.c              |  4 ++++
>  arch/arm64/kernel/topology.c                |  9 +++++----
>  4 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> index 88b4aa45a2066..826dfb90c8f7a 100644
> --- a/Documentation/arch/arm64/silicon-errata.rst
> +++ b/Documentation/arch/arm64/silicon-errata.rst
> @@ -174,6 +174,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-A725     | #3821522        | ARM64_ERRATUM_3821522       |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-X1       | #1502854        | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a38a3940cf208..89b6a7dc6d32d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1058,6 +1058,28 @@ config ARM64_ERRATUM_2645198
>  
>  	  If unsure, say Y.
>  
> +config ARM64_ERRATUM_3821522
> +	bool "Cortex-A725: 3821522: workaround for possible CNT_CYCLES increment error due to WFE/WFI"
> +	depends on ARM64_AMU_EXTN
> +	select ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
> +	default y
> +	help
> +	  This option adds the workaround for ARM Cortex-A725 erratum 3821522.
> +
> +	  On affected A725 cores, the CNT_CYCLES event may incur a significant
> +	  increment error when entering and subsequently exiting WFx.
> +	  As a result, the CNT_CYCLES may diverge from the system counter
> +	  frequency at which it is expected to increment.
> +	  This renders the AMU counter AMEVCNTR01, that implements CNT_CYCLES,
> +	  being unreliable and unsuitable for use.
> +
> +	  Since there is no hardware workaround, reads of the affected CNT_CYCLES
> +	  counter return 0 in the relevant paths. This causes users of the counter
> +	  to treat it as unavailable and is functionally equivalent to firmware
> +	  disabling the affected counter.
> +
> +	  If unsure, say Y.
> +
>  config ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
>  	bool
>  
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index a6dc9f20373e5..f67ae51dc2395 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -382,6 +382,10 @@ static const struct midr_range workaround_amu_constcnt_list[] = {
>  #ifdef CONFIG_ARM64_ERRATUM_2457168
>  	/* Cortex-A510 r0p0-r1p1 */
>  	MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
> +#endif
> +#ifdef CONFIG_ARM64_ERRATUM_3821522
> +	/* Cortex-A725 r0p0 - r0p2 */
> +	MIDR_RANGE(MIDR_CORTEX_A725, 0, 0, 0, 2),
>  #endif
>  	{}
>  };
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 15035f051c25b..b4f6eb213aa89 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -385,10 +385,11 @@ static void cpu_read_corecnt(void *val)
>  static void cpu_read_constcnt(void *val)
>  {
>  	/*
> -	 * Return 0 if the current CPU is affected by erratum 2457168. A value
> -	 * of 0 is also returned if the current CPU does not support AMUs or if
> -	 * the counter is disabled. A return value of 0 at counter read is
> -	 * properly handled as an error case by the users of the counter.
> +	 * Return 0 if the current CPU is affected by a HW erratum.
> +	 * A value of 0 is also returned if the current CPU does not
> +	 * support AMUs or if the counter is disabled. A return
> +	 * value of 0 at counter read is properly handled as an error
> +	 * case by the users of the counter.
>  	 */
>  	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT) ?
>  		      0UL : read_constcnt();
> -- 
> 2.53.0
> 
