Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B97367B85;
	Sun,  9 Aug 2026 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786309830; cv=none; b=sBImWF4si7vTlzMXiUzNHLKgXbuYKG/0QPPFN4kPCMr6iKIp2b5QnhUmcCqcxIkgkrjtUsGta3K5q+lJaYnqgiN5xFcceQwMY7t0IHdu8NdLCgThEbOMvGWvnNEC7iwQKH6yPpHTG1zJuWMfX8+sT1zmnNz/7aWI/k1iGWPUX84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786309830; c=relaxed/simple;
	bh=aUenOQaxYfurqAqvCj57DN6G70zQmIE9xEPJQtycqtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CquyGIPpRFcqQZTdNv9DmUx03B6WsveR5kpSWVKHa8xvnzlrj4zVbIzJusCZarBnQN/s+gzqwrGAvWoUBNoCw2Phee8NsG4sa+nJ1IzFLucYw+3jfLqGGQRjNchWJk4W7y3ZjgZsJ7VF8PFLUqoVH/LD9xxakEBiSSCXehegKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jWGWc+x2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jWGWc+x2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 995BD1516;
	Sun,  9 Aug 2026 14:10:16 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D95E43F673;
	Sun,  9 Aug 2026 14:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786309820; bh=aUenOQaxYfurqAqvCj57DN6G70zQmIE9xEPJQtycqtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWGWc+x2RiRkdSWgVaLkkFiJjpGxXeWWG5N7cY627JtHUEKuR25MtyyQRiBk05oeB
	 hob+ot8gudp0s6nAYrlRV1n2u1NIbUMNu9TVj0zghB/fva4V3HdeA1Z9H5bONxVLiT
	 A0d0/ZBt6CFiggPk/eWlJosIdjo7HYvp9LYMk+WY=
Date: Sun, 9 Aug 2026 22:10:08 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Yao Yuan <yaoyuan@linux.alibaba.com>, ljs@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/8] KVM: arm64: Correctly handle end of VA space TLBI
 invalidation
Message-ID: <25bqhok76mwuuqbklccvvrstatnlorxjimopx66pef2kgffsbr@aof7o3w4aocz>
References: <20260806091026.620700-1-maz@kernel.org>
 <20260806091026.620700-5-maz@kernel.org>
 <yifz3wn5gk5sr6mapi32trgk5m5kp33bquctsjmkifebnsnndt@fix6u4rthx4g>
 <86wltz9n6u.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wltz9n6u.wl-maz@kernel.org>

On Sun, Aug 09, 2026 at 07:13:45PM +0100, Marc Zyngier wrote:
> On Sat, 08 Aug 2026 22:41:31 +0100,
> Wei-Lin Chang <weilin.chang@arm.com> wrote:
> > 
> > Hi Marc,
> > 
> > On Thu, Aug 06, 2026 at 10:10:22AM +0100, Marc Zyngier wrote:
> > > Our TLB invalidation by VA code is based on comparing two ranges,
> > > one defined by the TLB, and one defined by the TLBI instruction.
> > > 
> > > Each range is defined by a start and a size. However, the way the
> > > comparison is done doesn't account for address rollover, as it
> > > compares an address with (base + size). This works nicely until
> > > this expression represent the last page/block in the TTBR1 VA space,
> > > as the result is a big fat 0. And a failed TLB invalidation.
> > > 
> > > Rewrite the comparison in a way that is immune to the address
> > > rollover (making the end address inclusive instead of exclusive),
> > > and move this into a common helper that is used by both VA and IPA
> > > invalidations, as suggested by Hyunwoo Kim (although the IPA version
> > > didn't suffer from this particular problem, obviously).
> > > 
> > > Fixes: 4ffa72ad8f37e ("KVM: arm64: nv: Add S1 TLB invalidation primitive for VNCR_EL2")
> > > Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  arch/arm64/kvm/nested.c | 43 ++++++++++++++++++-----------------------
> > >  1 file changed, 19 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> > > index 27bc7ee4b3382..8a602d074dbb4 100644
> > > --- a/arch/arm64/kvm/nested.c
> > > +++ b/arch/arm64/kvm/nested.c
> > > @@ -999,6 +999,20 @@ static void invalidate_vncr(struct vncr_tlb *vt)
> > >  		clear_fixmap(vncr_fixmap(vt->cpu));
> > >  }
> > >  
> > > +static bool vncr_tlb_intersects(struct vncr_tlb *vt, u64 addr,
> > > +				u64 scope_start, u64 scope_size)
> > > +{
> > > +	u64 tlb_size, tlb_start, tlb_end, scope_end;
> > > +
> > > +	tlb_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift, vt->wr.level));
> > > +
> > > +	tlb_start = addr & ~(tlb_size - 1);
> > > +	tlb_end = tlb_start + tlb_size - 1;
> > > +	scope_end = scope_start + scope_size - 1;
> > 
> > I think if scope_end overflows,
> > 
> > > +
> > > +	return !(tlb_end < scope_start || tlb_start > scope_end);
> > 
> > tlb_start > scope_end can evaluate to true and we return false even when
> > there is overlap near the end of the TTBR1 address space.
> 
> I assume that you are implicitly talking about TLB Range Invalidation,
> right? Because we otherwise align base on size, making overflows
> impossible with this patch.

Yes, I am talking about TLB range invalidations.

> 
> > Therefore I think we need to saturate scope_end to ULONG_MAX when overflow
> > happens. This is also what the architecture does when looking at the
> > pseudocode J1.2.3.442 TLBIRange (M.c).
> 
> That's one possible implementation, because the pseudocode is dealing
> with start/end directly, but that's not how our scope works (it deals
> with start and size).
> 
> For that we need to cap the *size*, similarly to what is done in
> handle_ripas2e1is() (see patch #6). Something like the hack below.

Makes sense.

> 
> 	M.
> 
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 21d0f4cbe07f1..5b8edb2e8a87d 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -305,6 +305,12 @@ static inline u64 decode_range_tlbi(u64 val, u64 *range, u16 *asid)
>  	num	= FIELD_GET(GENMASK(43, 39), val);
>  	*range	= __TLBI_RANGE_PAGES(num, scale) << shift;
>  
> +	/* Cap the range to the correct half of the address space */
> +	if (!(base & BIT(48)))
> +		*range = min(*range, (BIT(48) - base));
> +	else
> +		*range = min(*range, ~base + 1);
> +
>  	return base;
>  }

This looks correct to me!

Thanks,
Wei-Lin Chang

>  
> 
> -- 
> Without deviation from the norm, progress is not possible.
