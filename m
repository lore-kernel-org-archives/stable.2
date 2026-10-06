Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2933AB288
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294612; cv=none; b=FUon8hhj0udyLzVjNCSBY3kkQ+ghQNEeDov982vQQWyFyLUNgTCQSolldN0riXE9Wr29mIBPlOH51UMwsTJThO7JvYzm3OMTAOcgkxcFSknaAvoFDdeQlLnq3iSWk5+YH0clcH1AK3AaBCbp1n1KdRQiNRiq5Q8QGCjdHj0MAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294612; c=relaxed/simple;
	bh=ncWkEg5xSkIhQz2Z016lFzxVyp41vxyNjMV408OdiPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXSQoZxtYrgiZaKWj9wtjPpf25TEDiGOM/MQoxSpGqY346T2fAi7xW9qZaEY9cU+sfWfZ2nEJXjQHoD+Naq0bICPPv5kAIg6bAelNN1WSttqcQedt6Kvx0EpBQJuSKuvG703y1d7dUt4Uwp4tHLxSpwgqFJsBkSaZFgWoQTkQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TZposKuL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TZposKuL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 762141516;
	Tue,  6 Oct 2026 06:50:06 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1A723F763;
	Tue,  6 Oct 2026 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791294609; bh=ncWkEg5xSkIhQz2Z016lFzxVyp41vxyNjMV408OdiPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZposKuL4TErv8OGFjGExZUhJquj/ybgVnVbdG8FMhHfjmt8H0qefjvK4g9uXe5BH
	 XonRbANk+RQY1dm+paoQnoUdD904ahZp4OmjKvQ3EHkM2SZ+PDpqErdoZ+1aOK0vaX
	 i29en8iDQRRsApgdiMWWoJ8oU9qRxbp4VOo3xsts=
Date: Tue, 6 Oct 2026 15:50:05 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6.6.y] arm64: errata: Add Cortex-A725 erratum 3821522
 workaround
Message-ID: <asT8jRt_zAH_jKGf@arm.com>
References: <2026100501-bulginess-bullfight-da31@gregkh>
 <20261006080810.3667859-1-sashal@kernel.org>
 <asS2JVf26_1CD5Wi@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asS2JVf26_1CD5Wi@arm.com>

On Tue, Oct 06, 2026 at 10:49:46AM +0200, Beata Michalska wrote:
> This one seems to be mixing relevant commits and is missing some changes.
> Should I post the backport for this one ?
> 
Posted as a reply to:
https://lore.kernel.org/stable/2026100501-bulginess-bullfight-da31@gregkh/

---
BR
Beata
> ---
> BR
> Beata
> On Tue, Oct 06, 2026 at 04:09:22AM -0400, Sasha Levin wrote:
> > From: Beata Michalska <beata.michalska@arm.com>
> > 
> > [ Upstream commit 45f7304679875eb000d67e194090ee7abd05c89c ]
> > 
> > Cortex-A725 erratum 3821522 affects the CNT_CYCLES event, which can
> > incur a significant increment error when a CPU enters and subsequently
> > exits WFE or WFI, and may no longer track the system counter
> > frequency.
> > 
> > The AMEVCNTR01_EL0 counter is used as the AMU constant counter for
> > frequency invariance and CPPC FFH feedback counters. Wire the affected
> > Cortex-A725 range into the shared broken AMU constant-counter capability
> > so the affected counter is treated as unavailable by returning zero in
> > the AMU counter paths. This prevents the broken counter from being used
> > as a reference source.
> > 
> > The erratum can also affect PMUv3 users of the CNT_CYCLES event,
> > but this workaround intentionally does not change PMU event handling.
> > Hiding or rejecting the PMU event from the erratum code would change
> > the perf-visible PMU event interface, including raw event selection,
> > and would need a separate PMU-specific approach rather than being
> > folded into the AMU reference-counter workaround.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > [ sashal: Reused ARM64_WORKAROUND_2457168 instead of the unavailable ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT capability. ]
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  Documentation/arch/arm64/silicon-errata.rst |  2 ++
> >  arch/arm64/Kconfig                          | 21 ++++++++++++++++++
> >  arch/arm64/kernel/cpu_errata.c              | 24 ++++++++++++++++-----
> >  arch/arm64/kernel/topology.c                |  9 ++++----
> >  4 files changed, 47 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> > index b5b46b6ab2778..c40e6271072f6 100644
> > --- a/Documentation/arch/arm64/silicon-errata.rst
> > +++ b/Documentation/arch/arm64/silicon-errata.rst
> > @@ -161,6 +161,8 @@ stable kernels.
> >  +----------------+-----------------+-----------------+-----------------------------+
> >  | ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
> >  +----------------+-----------------+-----------------+-----------------------------+
> > +| ARM            | Cortex-A725     | #3821522        | ARM64_ERRATUM_3821522       |
> > ++----------------+-----------------+-----------------+-----------------------------+
> >  | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
> >  +----------------+-----------------+-----------------+-----------------------------+
> >  | ARM            | Cortex-X1       | #4193791        | ARM64_ERRATUM_4118414       |
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 723e73042c1a2..3233ba5ac495a 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1037,6 +1037,27 @@ config ARM64_ERRATUM_2645198
> >  
> >  	  If unsure, say Y.
> >  
> > +config ARM64_ERRATUM_3821522
> > +	bool "Cortex-A725: 3821522: workaround for possible CNT_CYCLES increment error due to WFE/WFI"
> > +	depends on ARM64_AMU_EXTN
> > +	default y
> > +	help
> > +	  This option adds the workaround for ARM Cortex-A725 erratum 3821522.
> > +
> > +	  On affected A725 cores, the CNT_CYCLES event may incur a significant
> > +	  increment error when entering and subsequently exiting WFx.
> > +	  As a result, the CNT_CYCLES may diverge from the system counter
> > +	  frequency at which it is expected to increment.
> > +	  This renders the AMU counter AMEVCNTR01, that implements CNT_CYCLES,
> > +	  being unreliable and unsuitable for use.
> > +
> > +	  Since there is no hardware workaround, reads of the affected CNT_CYCLES
> > +	  counter return 0 in the relevant paths. This causes users of the counter
> > +	  to treat it as unavailable and is functionally equivalent to firmware
> > +	  disabling the affected counter.
> > +
> > +	  If unsure, say Y.
> > +
> >  config ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> >  	bool
> >  
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index 03a4382799091..ab5fead3e6f87 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -275,6 +275,21 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
> >  };
> >  #endif
> >  
> > +#if defined(CONFIG_ARM64_ERRATUM_2457168) || \
> > +	defined(CONFIG_ARM64_ERRATUM_3821522)
> > +static const struct midr_range workaround_amu_constcnt_list[] = {
> > +#ifdef CONFIG_ARM64_ERRATUM_2457168
> > +	/* Cortex-A510 r0p0-r1p1 */
> > +	MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
> > +#endif
> > +#ifdef CONFIG_ARM64_ERRATUM_3821522
> > +	/* Cortex-A725 r0p0 - r0p2 */
> > +	MIDR_RANGE(MIDR_CORTEX_A725, 0, 0, 0, 2),
> > +#endif
> > +	{}
> > +};
> > +#endif
> > +
> >  #ifdef CONFIG_CAVIUM_ERRATUM_23154
> >  static const struct midr_range cavium_erratum_23154_cpus[] = {
> >  	MIDR_ALL_VERSIONS(MIDR_THUNDERX),
> > @@ -766,14 +781,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
> >  		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
> >  	},
> >  #endif
> > -#ifdef CONFIG_ARM64_ERRATUM_2457168
> > +#if defined(CONFIG_ARM64_ERRATUM_2457168) || \
> > +	defined(CONFIG_ARM64_ERRATUM_3821522)
> >  	{
> > -		.desc = "ARM erratum 2457168",
> > +		.desc = "Broken AMU AMEVCNTR01 (const counter)",
> >  		.capability = ARM64_WORKAROUND_2457168,
> >  		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
> > -
> > -		/* Cortex-A510 r0p0-r1p1 */
> > -		CAP_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1)
> > +		CAP_MIDR_RANGE_LIST(workaround_amu_constcnt_list)
> >  	},
> >  #endif
> >  #ifdef CONFIG_ARM64_ERRATUM_2038923
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 1a2c72f3e7f80..59bff1f860a65 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -268,10 +268,11 @@ static void cpu_read_corecnt(void *val)
> >  static void cpu_read_constcnt(void *val)
> >  {
> >  	/*
> > -	 * Return 0 if the current CPU is affected by erratum 2457168. A value
> > -	 * of 0 is also returned if the current CPU does not support AMUs or if
> > -	 * the counter is disabled. A return value of 0 at counter read is
> > -	 * properly handled as an error case by the users of the counter.
> > +	 * Return 0 if the current CPU is affected by a HW erratum.
> > +	 * A value of 0 is also returned if the current CPU does not
> > +	 * support AMUs or if the counter is disabled. A return
> > +	 * value of 0 at counter read is properly handled as an error
> > +	 * case by the users of the counter.
> >  	 */
> >  	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
> >  		      0UL : read_constcnt();
> > -- 
> > 2.53.0
> > 
