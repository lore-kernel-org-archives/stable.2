Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616547;
	b=5emMctMUTesHsFG4PEky0W3MpookOSzc/vBjc5mA8NIjnv2cLL3pKREdWVhka8EupFX7
	 pe1rrRxuoBntiQ0nV1yRzycnLo4WHL9tjqaQ2PLL5hiTKc+nwQ+hn3jQBIBWeoFXxpXAC
	 kgEjeoy677a97Rp7Y8Af3CdwE9ExOFOUlzaTUe2vQSxL1sfLRUk6EHE7oSU1L1zYD3Xnh
	 yyjuJfj96Tl6trA0SVkOWs1H0Yy8NeqR4F99q8qu7AyTmVDLXs+dFZIj+fft1+Yy1m+Sj
	 feKvYRnX9ugL9IjhsOfa81Qkpz6mt+EWHMAF0Z9XYaP/wwuphscmgdlFv/FdDq+4xRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616547;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8pAN+cMNDAKpI0U2TXKKPxCHGtnx0QjdYb7WetjOVfA=;
	b=HQuMl5AKiX6N0IMflrOQZPH2BHGDQX46tVkn2olAm2A1mbHaYn1MieLBig3QNISJ84f2
	 3z9dpZ8bkvKG25TY2RlQEQQLAUy26B7iHOZSP3Szf3+SXCy6Y/AeNkfFQAnI1YbCCG2MX
	 W4QUFBRUjTwy4fxj2i6KCYXAt4mSOJCDVxsrEPIRBCJSAAnCdJ80a91XD2bkOwdEnT4hl
	 DdCLuXjVfdlWr8etF6Mt5Pq6kzSYUaMj65S+V7A4W/7H1p0yNefGk6z1o1arXbgIZYHU1
	 TqawM11hvtv7Yh2tEcSWJZCkdeeQw3pGNZtaoR2D1jcKIrEZYie/Zq4/3C7nKDduCRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QQNt7T0i;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F42606A321;
	Wed, 25 Nov 2026 14:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F42606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QQNt7T0i
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AF482F;
	Wed, 25 Nov 2026 06:22:23 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFBB03F763;
	Wed, 25 Nov 2026 06:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795616546; bh=JMMVosT4VTiw7rOBFumnNRwKpJxvpO3L1Ux34kDKMME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQNt7T0iVQmM94OhDwbo2jUVxlWiS0B4lQHGscliOaWAXcteupZw1IqicwsEEAxPv
	 Az1K1rtUc5oVZuCBWnXAtCgLeG1Xmy9zNmEFL9WTaZkqF0l66mkQezTkvCyZ1a1wGO
	 5E/Dul/2PTdpPER5DMjUevgq8g4Af4GBsV3ogi2g=
Date: Wed, 25 Nov 2026 14:22:21 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Yadong Qi <yadong.qi@linux.alibaba.com>, will@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, robh@kernel.org,
	gregkh@linuxfoundation.org, ptg-linux-kernel@linux.alibaba.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: fixmap: fix missing break-before-make in
 __set_fixmap()
Message-ID: <awbvHVSX7sB8jzYA@arm.com>
References: <20261123093505.974-1-yadong.qi@linux.alibaba.com>
 <awW3Dw743-rw_-cf@arm.com>
 <87mrqxto23.fsf@DESKTOP-5N7EMDA>
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
In-Reply-To: <87mrqxto23.fsf@DESKTOP-5N7EMDA>

On Wed, Nov 25, 2026 at 02:36:36PM +0800, Huang, Ying wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> 
> > On Mon, Nov 23, 2026 at 05:35:05PM +0800, Yadong Qi wrote:
> >> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> >> index f66a0016dd02..5593d7e0d523 100644
> >> --- a/arch/arm64/mm/fixmap.c
> >> +++ b/arch/arm64/mm/fixmap.c
> >> @@ -126,12 +126,19 @@ void __set_fixmap(enum fixed_addresses idx,
> >>  
> >>  	ptep = fixmap_pte(addr);
> >>  
> >> -	if (pgprot_val(flags)) {
> >> -		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
> >> -	} else {
> >> +	/*
> >> +	 * Break-before-make: when the slot still holds a valid mapping
> >> +	 * (e.g. earlycon re-mapping FIX_EARLYCON_MEM_BASE), invalidate the
> >> +	 * old entry and flush the TLB entries caching it before a new
> >> +	 * mapping is installed, so old and new translations never coexist.
> >> +	 */
> >> +	if (pte_valid(__ptep_get(ptep))) {
> >>  		__pte_clear(&init_mm, addr, ptep);
> >> -		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
> >> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> >>  	}
> >> +
> >> +	if (pgprot_val(flags))
> >> +		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
> >>  }
> >
> > I guess that's easier than getting the driver or earlycon code to do
> > clear_fixmap().
> 
> Yes.  And because set_fixmap() flushes the tlb on x86, IMHO, it's a
> little hard to justify the driver modification.
> 
> However, set_fixmap() only flushes the tlb on the local CPU instead of
> broadcasting the flush, because fixmap is either per-CPU or used during
> early boot.  In theory, we could follow that approach and perform a
> local flush instead though the benefit may be marginal.

Local TLBI won't work on arm64 since the page tables are shared (any CPU
can speculatively load the TLB) and only FIX_VNCR has per-CPU entries.

-- 
Catalin
