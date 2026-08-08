Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FF1A683A;
	Sat,  8 Aug 2026 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786225307; cv=none; b=gthJs9L9pN6zeEQith9CuVytJUkn7wzc71mngs75PYz2KV2JS2R/6W7aOhD9kou/MqxXlmQFKPIkdp/RL2sGzbjkgG6PD71rFmPNPmdW84VciMmo5Zjl2iuFAW6NncqfItyp8d8yrFDUnBoNziA70j/P85m9+b6/x+8DAkEz2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786225307; c=relaxed/simple;
	bh=I4DdleW8mzxVeMyiB3L8HY8f1W4aXjk83V1EP/T4+I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7S4oamDmHX2zm6F4cGvxLa89Xkz0w3q9ppUYyrC6hqL7Ze2c2EpET62VcfIjX1H67/MD2N1btPTi9Oa7suXQhm4bXK35y1p5oyP6iClcrHIdZeZooQYT6mTFkvb7XMTdiNn9E/3e5np1XWTduGLKVN5WSdjxSd31ZIV4wqX2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BI9ksKow; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BI9ksKow"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B301C152B;
	Sat,  8 Aug 2026 14:41:39 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7C103F9A2;
	Sat,  8 Aug 2026 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786225303; bh=I4DdleW8mzxVeMyiB3L8HY8f1W4aXjk83V1EP/T4+I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BI9ksKowFBrkK396n5hsWjimnlOOable3MsLV4y3n7S5+1tgNqP6N6WFXFGtDTE32
	 hEr/u9esRbfm0i0MrHb1lIeDuaaWjUuK/9esr7GvjoQEWbNKWioArCRJofLMM62J3r
	 8+yBNoBgpQhKZ7WczfW/mYTuBK0b3wymIrkMqDnE=
Date: Sat, 8 Aug 2026 22:41:31 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Hyunwoo Kim <imv4bel@gmail.com>, Yao Yuan <yaoyuan@linux.alibaba.com>, ljs@kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/8] KVM: arm64: Correctly handle end of VA space TLBI
 invalidation
Message-ID: <yifz3wn5gk5sr6mapi32trgk5m5kp33bquctsjmkifebnsnndt@fix6u4rthx4g>
References: <20260806091026.620700-1-maz@kernel.org>
 <20260806091026.620700-5-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806091026.620700-5-maz@kernel.org>

Hi Marc,

On Thu, Aug 06, 2026 at 10:10:22AM +0100, Marc Zyngier wrote:
> Our TLB invalidation by VA code is based on comparing two ranges,
> one defined by the TLB, and one defined by the TLBI instruction.
> 
> Each range is defined by a start and a size. However, the way the
> comparison is done doesn't account for address rollover, as it
> compares an address with (base + size). This works nicely until
> this expression represent the last page/block in the TTBR1 VA space,
> as the result is a big fat 0. And a failed TLB invalidation.
> 
> Rewrite the comparison in a way that is immune to the address
> rollover (making the end address inclusive instead of exclusive),
> and move this into a common helper that is used by both VA and IPA
> invalidations, as suggested by Hyunwoo Kim (although the IPA version
> didn't suffer from this particular problem, obviously).
> 
> Fixes: 4ffa72ad8f37e ("KVM: arm64: nv: Add S1 TLB invalidation primitive for VNCR_EL2")
> Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kvm/nested.c | 43 ++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index 27bc7ee4b3382..8a602d074dbb4 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -999,6 +999,20 @@ static void invalidate_vncr(struct vncr_tlb *vt)
>  		clear_fixmap(vncr_fixmap(vt->cpu));
>  }
>  
> +static bool vncr_tlb_intersects(struct vncr_tlb *vt, u64 addr,
> +				u64 scope_start, u64 scope_size)
> +{
> +	u64 tlb_size, tlb_start, tlb_end, scope_end;
> +
> +	tlb_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift, vt->wr.level));
> +
> +	tlb_start = addr & ~(tlb_size - 1);
> +	tlb_end = tlb_start + tlb_size - 1;
> +	scope_end = scope_start + scope_size - 1;

I think if scope_end overflows,

> +
> +	return !(tlb_end < scope_start || tlb_start > scope_end);

tlb_start > scope_end can evaluate to true and we return false even when
there is overlap near the end of the TTBR1 address space.

Therefore I think we need to saturate scope_end to ULONG_MAX when overflow
happens. This is also what the architecture does when looking at the
pseudocode J1.2.3.442 TLBIRange (M.c).

Thanks,
Wei-Lin Chang

> +}
> +
>  /*
>   * VNCR TLB invalidation occurs from MMU notifiers or TLBI instructions, and
>   * either can race against a vcpu not being onlined yet (no pseudo-TLB
> @@ -1021,19 +1035,9 @@ static void kvm_invalidate_vncr_ipa(struct kvm *kvm, u64 start, u64 end)
>  	if (!kvm_has_feat(kvm, ID_AA64MMFR4_EL1, NV_frac, NV2_ONLY))
>  		return;
>  
> -	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm) {
> -		u64 ipa_start, ipa_end, ipa_size;
> -
> -		ipa_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift,
> -							    vt->wr.level));
> -		ipa_start = vt->wr.pa & ~(ipa_size - 1);
> -		ipa_end = ipa_start + ipa_size;
> -
> -		if (ipa_end <= start || ipa_start >= end)
> -			continue;
> -
> -		invalidate_vncr(vt);
> -	}
> +	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm)
> +		if (vncr_tlb_intersects(vt, vt->wr.pa, start, end - start))
> +			invalidate_vncr(vt);
>  }
>  
>  struct s1e2_tlbi_scope {
> @@ -1059,28 +1063,19 @@ static void invalidate_vncr_va(struct kvm *kvm,
>  	lockdep_assert_held_write(&kvm->mmu_lock);
>  
>  	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm) {
> -		u64 va_start, va_end, va_size;
> -
> -		va_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift,
> -							   vt->wr.level));
> -		va_start = vt->gva & ~(va_size - 1);
> -		va_end = va_start + va_size;
> -
>  		switch (scope->type) {
>  		case TLBI_ALL:
>  			break;
>  
>  		case TLBI_VA:
> -			if (va_end <= scope->va ||
> -			    va_start >= (scope->va + scope->size))
> +			if (!vncr_tlb_intersects(vt, vt->gva, scope->va, scope->size))
>  				continue;
>  			if (vt->wr.nG && vt->wr.asid != scope->asid)
>  				continue;
>  			break;
>  
>  		case TLBI_VAA:
> -			if (va_end <= scope->va ||
> -			    va_start >= (scope->va + scope->size))
> +			if (!vncr_tlb_intersects(vt, vt->gva, scope->va, scope->size))
>  				continue;
>  			break;
>  
> -- 
> 2.47.3
> 
