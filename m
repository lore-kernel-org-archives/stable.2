Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800416;
	b=IJZUUsJJVnw2sT0CXMsPonah/LspkyIvRTY10syqngKx/nav3E7y5dxABPWfMdqgTZCM
	 ZWLxiSus/xLV1AWDkElg3GSnt4VApGBUeEAm1E8rFaIRKfTd0lhfJbTXNGNEeRv6ZkQXU
	 sza2vVZNVp/LfRQPbl+TC27lN77j0IVL52AXuG7kOyCuGgKmiwrl9oNvp/nkF3xZzAtF1
	 e4dbVkd4jL/KEtqpYJDpSTbYDgpw1TZZV6pksHN+5qQgvfS64ofw3PztOK00K00DC+JQ4
	 dbQaccgfCJ4f6mM7gTkZnOURbd/8iGXFLmS0cCReWrt6P8v6shYdcBNROa2d5PaXTww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800416;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0XmBI/vsqTPBFjciFZ00jSFFbSfcYJDZA86bCCNbmx4=;
	b=hzCA+/orQXi+pKPklQtyJRVmBoIJB36p58pXW+vkHpYLYvfMKaDDPUteqROwfiNQxexg
	 fq20A4RZIlLH450usiajBYiL1hhaPUbSsla1zudHTumnAgYfH0HBRd/7mE7gPAjwwg+pB
	 dMTNWowz0H2CZLsWpsVcsZH8Eu/HsXF7bybvdzibSnyVlyk4WA63DlR4dru1SY7ZKsTdn
	 odGKOqz9D9/afzv0gtZtcuOd9nUeUPT1+u028zdG5SzVlSTKc6j/FLBHZhDz/I2ezJgz5
	 n/RYY3+F70UA87JRPn8Jp4YjxO1R/5P5AbEf03LWMP+UyqfjBbmLhG6kA+rGE5TwWXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAeX8wcz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD5606A31F;
	Fri, 27 Nov 2026 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAeX8wcz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996B61F00899;
	Fri, 27 Nov 2026 17:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795800415;
	bh=0XmBI/vsqTPBFjciFZ00jSFFbSfcYJDZA86bCCNbmx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hAeX8wczzScMlEi3kseFTivVf002FWoibXkMKuLG6apA2bRnJyiRirF5XbENTHJDp
	 0x6ugFO3kD0HQzi3PtEw7kD20tOU2MDWYPDxSjhTAD2gZ8EqsSR2g9EAk+FsL2kiDy
	 TZ1heB+nrzY+3cwOvy0TCS0afFYTdANPqm7LIu//Z1TZaK5oUXQ+ippkqyqynlQKRO
	 PGQXOjOCEE1GkIQEiIyfpBvA5w4PolyCkmXNCsTfNj6edRzylITYCv5tBdxU5EYxOn
	 B8bP4MOti4xv6qTcxcx/QnFGAKuL1NkuxFnkgsFMWDdRss1C4TXJnY+oCJ0T+I2Mt5
	 J6lEthLHAmaGA==
Date: Fri, 27 Nov 2026 17:26:47 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Christoffer Dall <christoffer.dall@linaro.org>, Jintack Lim <jintack.lim@linaro.org>, 
	Leonardo Bras <leo.bras@arm.com>, Wei-Lin Chang <weilin.chang@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Top up the mmu memcache on user fault for NV
Message-ID: <awm5PZYWxVOXdBfm@gremlin>
References: <20261126-fix-nv-cache-topup-v1-1-a22c936872fe@kernel.org>
 <20261127152237.108363-1-usama.arif@linux.dev>
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
In-Reply-To: <20261127152237.108363-1-usama.arif@linux.dev>

On Fri, Nov 27, 2026 at 07:22:36AM -0800, Usama Arif wrote:
> On Thu, 26 Nov 2026 17:28:29 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> > The S2 user fault path tops up the MMU memcache (used for page table
> > pre-allocation as the point at which page tables are installed may not
> > allocate) except when:
> >
> > * It's a permission fault AND
> > * dirty page logging is disabled AND
> > * pKVM is disabled
> >
> > At which point it is assumed no page table will be allocated.
> >
> > However nested virtualisation adds another edge case - the mapping size of
> > a shadow S2 is clamped to that of the guest's own S2. If the guest
> > hypervisor replaces a block mapping with a table, a permission fault on the
> > shadow block has to be mapped at PAGE_SIZE, which requires a page table to
> > collapse the block into.
> >
> > With the memcache empty, kvm_mmu_memory_cache_alloc() hits its
> > guest-triggerable WARN_ON(!nobjs) and falls back to a GFP_ATOMIC allocation
> > under mmu_lock, with a BUG_ON() if that fails.
> >
> > Therefore, also top up the memcache for permission faults taken on a
> > shadow S2.
> >
> > Note that dirty logging had a similar issue, addressed in commit
> > 56fd1fc526e6 ("KVM: arm64: Top up stage-2 memcache for dirty logging
> > faults").
> >
> > Fixes: fd276e71d1e7 ("KVM: arm64: nv: Handle shadow stage 2 page faults")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  arch/arm64/kvm/mmu.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index a0d4981ebb99..e09a8f2c0482 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -2256,16 +2256,18 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd,
> >
> >  	/*
> >  	 * Permission faults just need to update the existing leaf entry,
> > -	 * and so normally don't require allocations from the memcache. The
> > -	 * only exception to this is when dirty logging is enabled at runtime
> > +	 * and so normally don't require allocations from the memcache. One
> > +	 * exception to this is when dirty logging is enabled at runtime
> >  	 * and a fault needs to collapse a block entry into a table.
> >  	 * Under pKVM a permission fault can also collapse pages into a block,
> >  	 * which needs a fresh mapping object, and the hypervisor requires the
> >  	 * min-pages memcache even when the install allocates nothing.
> > +	 * With nested, a shadow stage-2 block may also need to be collapsed
> > +	 * into a table if the guest's own stage-2 mapping has become smaller.
> >  	 */
> >  	memcache = get_mmu_memcache(s2fd->vcpu);
> >  	if (!perm_fault || memslot_is_logging(s2fd->memslot) ||
> > -	    is_protected_kvm_enabled()) {
> > +	    is_protected_kvm_enabled() || s2fd->nested) {
> >  		ret = topup_mmu_memcache(s2fd->mmu, memcache);
> >  		if (ret)
> >  			return ret;
> >
>
> Thanks for the fix!
>
> On the narrow condition being the smaller backport: I don't think it
> is. The hunk already conflicts on 7.3, where topup_mmu_memcache() still
> takes the vCPU, and the condition looks different on 7.2 and older, so
> every stable tree needs a small manual backport either way.
>
> A permission fault can also allocate outside NV. For example, take an
> exec permission fault on a THP block, where the VMM replaces that
> memory with 64K hugetlb pages before the fault looks up the VMA:
>
>   - the MMU notifier unmaps the block, and mmu_seq is read afterwards
>   - kvm_s2_resolve_vma_size() forces PAGE_SIZE for the CONT_PTE hugetlb
>   - PAGE_SIZE != perm_fault_granule, so kvm_pgtable_stage2_map() runs
>     and allocates a table, with no top-up
>
> That one is narrow and VMM-driven, but topping up for every fault would
> cover it too, and it costs a single comparison when the cache already
> holds enough pages.
>

Reads a little schloppy ;) But I think you're right yeah.

Good bloody lord @ 64 KiB hugetlb pages being a thing... obscene :)

Anyway, I'll send an unconditional v2, it's really not that much delta in
general.

--
Cheers, Lorenzo
