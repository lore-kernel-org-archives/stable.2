Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053946C4B3
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293505; cv=none; b=LKw5iuMSC79w49qpoU4GxTgWN0zCQH7WqDf6alHfrzPKdQTxFJPBK+qKu5fsRLA7DueFCoVyW3xFTBCYMZhcx/jPKKT9eqr2FeSIr1gSORqC1cLY9iCV3TLFIoR9KHO/EJdeo/HtC4oQSVncAW+ZRLt0FENFM9xdbNEp+3fGyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293505; c=relaxed/simple;
	bh=2Fqvr0jUyVNc4AAmcr3IA39YGbjWXfo4uT7JBJHoRBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTZrAjT/j/56umw28HH/Szw0HApfidkDEYrZHjXM8a7w8usjQ4IIHiUeUiJwYmzezF1ydnU1Y3CT+PKtm1OG42+bsVbUWgGorhVVk7H0ZKkwMK6O+5ajqDkKWMYtabyJhht4DkIuvDy7IEDshm+VaKeo4E0P2JrRtXf4faN5hVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qAcHSkEt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qAcHSkEt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EF0C1516;
	Tue,  6 Oct 2026 06:31:39 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 461103F763;
	Tue,  6 Oct 2026 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791293502; bh=2Fqvr0jUyVNc4AAmcr3IA39YGbjWXfo4uT7JBJHoRBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAcHSkEtTae+CRA3b2mETm1ZDYS877FD3AJmRFbuiUiSihzQEYIEKEIuokjXuuQKw
	 i3a/SztOv8T1W1LFfx7aBiNOopTT9JVRfTsbH0ZUZz4qPMDbwKLIlZcKHqlqhgF1pZ
	 g+MQSgh1saO18VlgBe9fDCT03jt6j6dDVnkgqcuE=
Date: Tue, 6 Oct 2026 15:31:30 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6.1.y] arm64: errata: Add Cortex-A725 erratum 3821522
 workaround
Message-ID: <asT4MsCZ22C_Ekum@arm.com>
References: <2026100502-outtakes-dragonfly-ead9@gregkh>
 <20261006083052.3865406-1-sashal@kernel.org>
 <asS3CH95DxuaLbsA@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asS3CH95DxuaLbsA@arm.com>

On Tue, Oct 06, 2026 at 10:53:32AM +0200, Beata Michalska wrote:
> This one is also missing/mixing things.
> Do let me know if you want me to make the backport.
> 
Posted as a reply to:
https://lore.kernel.org/stable/2026100502-outtakes-dragonfly-ead9@gregkh/T/#t

---
BR
Beata
> ---
> BR
> Beata
> On Tue, Oct 06, 2026 at 04:31:46AM -0400, Sasha Levin wrote:
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
> > [ sashal: Reused ARM64_WORKAROUND_2457168 in place of the unavailable generic AMU capability. ]
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  Documentation/arm64/silicon-errata.rst |  2 ++
> >  arch/arm64/Kconfig                     | 21 +++++++++++++++++++++
> >  arch/arm64/kernel/cpu_errata.c         | 24 +++++++++++++++++++-----
> >  arch/arm64/kernel/topology.c           |  9 +++++----
> >  4 files changed, 47 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> > index fe7b90ac52d7b..74ae9e4f637a7 100644
> > --- a/Documentation/arm64/silicon-errata.rst
> > +++ b/Documentation/arm64/silicon-errata.rst
> > @@ -155,6 +155,8 @@ stable kernels.
> >  +----------------+-----------------+-----------------+-----------------------------+
> >  | ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
> >  +----------------+-----------------+-----------------+-----------------------------+
> > +| ARM            | Cortex-A725     | #3821522        | ARM64_ERRATUM_3821522       |
> > ++----------------+-----------------+-----------------+-----------------------------+
> >  | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
> >  +----------------+-----------------+-----------------+-----------------------------+
> >  | ARM            | Cortex-X1       | #4193791        | ARM64_ERRATUM_4118414       |
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 9cb8867eb1205..314a9ac22be54 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -983,6 +983,27 @@ config ARM64_ERRATUM_2457168
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
> > index cff85a371c353..fbc80f64f3eeb 100644
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
> > @@ -737,14 +752,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
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
> > index 817d788cd8666..575d0f9a76870 100644
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
