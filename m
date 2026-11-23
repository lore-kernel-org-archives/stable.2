Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425652;
	b=RmSfCk1J3tDHu86n9q7QMZPgAzUyL07BiXM2AqLIyHFkVWzBgNIYIW29LxlQ/nQ9xNGk
	 dAWLAqP0iCLjtX/JrANAIsg52J1maDnXk1LkpKZ78lzS83SEE7ds+xgNRPfEbhqPynUxP
	 rD2xGFaYIIGiRYZps3ncm3I5oKsG0YkOB8QaSYlftuIQTjqwlheGmDPmdQYw4PtQOOckK
	 lrWXE5Kadkc1xjEprxLPhJzFoa6Vo8o3ieo/SZRzXP65IiO9wCfYtvLJARbSS2l08gP5E
	 GNKHFHWcG6DI8COiT9NDJVQ42hivTiMH/mQyS9S3933/DaiVpxxhF08yfJiL9gx31zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425652;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lHyRaJe2Oxu6YF/YZuFS79LHuEjt4FTk13YOidFcKI0=;
	b=KuqQDhiMSISvWfWrSBsPvTbqHt1qH3WXAs2ruIKS1vg1jYNMMsDOFqhIZdshG4YgjkJP
	 yEuWrlEubpptbQ/2sfm1gVCYt2R9gR5DeVi9cyctU/8mYSFRsTaSh/ad1VZ1J68dPEYzJ
	 qCTvfhNofJcMYXzdfgAEz9ifuK90ZJDyqqon00+w1rq9TeKPq4Awh3FX0+jQJIXgefd1P
	 mBTm92u7pJpbApRWiOT8w/x4+5lt7fx1kTC9M2hZ1HIc5Fz1RPK3UShhVdjDFeJEdteaU
	 BQHmmB2JQmvMscAG4v2NLJc+2bwFby3JSv0m62tSaHZuPywHLgPfTIUEFNonLp1/oYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FQFfSCeT;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7512606A31F;
	Mon, 23 Nov 2026 09:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7512606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FQFfSCeT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 489121476;
	Mon, 23 Nov 2026 01:20:48 -0800 (PST)
Received: from localhost (a079125.arm.com [10.164.21.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F56C3F632;
	Mon, 23 Nov 2026 01:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795425651; bh=sjyw09+6rOZQXtyPBevqw2Txy/HdpRHEm1XHUYTVWQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQFfSCeT03MCVMYM6WdTXW5pv96OMoHNbrbaoBV0kV3ZyS9Skat5hbubcRn4GCPYY
	 Qc8vcmuM3sdMjmGSFU0kfk09qVx2V5xUI3whlekXrJKUb726o0zmc//w3HaOC70SUd
	 9PhFFOWVyCwXdsG76Wk7bf+RpHbrx365abQt7g3M=
Date: Mon, 23 Nov 2026 14:50:47 +0530
From: Linu Cherian <linu.cherian@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/6] arm64: cpufeature: Remove Neoverse-V3/AE from the
 BBML3 allow list
Message-ID: <cw2i2nfhwffg7wwybrttwynnmuujckh25dhe5jrlmmr3byowrz@ggccunczsoka>
References: <20261113145022.2592454-1-ryan.roberts@arm.com>
 <20261113145022.2592454-2-ryan.roberts@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113145022.2592454-2-ryan.roberts@arm.com>

On Fri, Nov 13, 2026 at 02:50:15PM +0000, Ryan Roberts wrote:
> Neoverse-V3 and Neoverse-V3AE erratum 3053180 can cause a load or store
> to livelock when mapping size changes without break-before-make or when
> contiguous hints are programmed inconsistently.
> 
> The erratum was previously reported as fixed in r0p2. On that basis,
> commit 5aa4b625762e ("arm64: Add BBM Level 2 cpu feature") allowed
> Neoverse-V3 from r0p2, and commit 8fca3852e33d ("arm64: cpufeature: add
> Neoverse-V3AE to BBML2 allow list") did the same for Neoverse-V3AE.
> 
> The updated SDENs, MP168 v11 for Neoverse-V3 and MP172 v12 for
> Neoverse-V3AE, dated 9 June 2026, list r0p0, r0p1 and r0p2 as affected
> and the erratum as open. There is no fixed revision on which to base
> either allow-list entry.
> 
> Remove both entries so these CPUs observe break-before-make, and record
> the workaround in the silicon errata registry.
> 
> Cc: stable@vger.kernel.org
> Link: https://support.arm.com/documentation/109231/11-0/?lang=en
> Link: https://support.arm.com/documentation/109704/12-0/?lang=en
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  Documentation/arch/arm64/silicon-errata.rst | 4 ++++
>  arch/arm64/kernel/cpufeature.c              | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> index afe109afe692..9ad965d3e1ea 100644
> --- a/Documentation/arch/arm64/silicon-errata.rst
> +++ b/Documentation/arch/arm64/silicon-errata.rst
> @@ -243,10 +243,14 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-V2     | #4193787        | ARM64_ERRATUM_4118414       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Neoverse-V3     | #3053180        | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-V3     | #4193784        | ARM64_ERRATUM_4118414       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Neoverse-V3AE   | #3053180        | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-V3AE   | #4193784        | ARM64_ERRATUM_4118414       |
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 34c5c03c0c9b..b15619690f42 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2012,8 +2012,6 @@ bool cpu_supports_bbml3(void)
>  	/* CPUs that support BBML3 but dont advertise through ID_AA64MMFR2_EL1 */
>  	static const struct midr_range supports_bbml3_list[] = {
>  		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> -		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> -		MIDR_REV_RANGE(MIDR_NEOVERSE_V3AE, 0, 2, 0xf),
>  		MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
>  		MIDR_ALL_VERSIONS(MIDR_NVIDIA_RIGEL),
>  		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
> -- 
> 2.43.0


Reviewed-by: Linu Cherian <linu.cherian@arm.com>
