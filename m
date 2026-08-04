Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BC24A21;
	Tue,  4 Aug 2026 03:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815238; cv=none; b=cYqYloRA9esKK0il6WKp9siKJ1S1k7D4IejN69EdroDAOWEuA0+I9wOOhs9zZfiPQMr+S7RoicHjecnP2wjd6mYXTpCyIrrLvKX5o1RRkvKYWI9lHjOe8gP5LDqnJFE666EhNGimvMrnG/oCsd7ukLTxdW1TC5ORWvnzBTPW96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815238; c=relaxed/simple;
	bh=MpNAUrNQ6mrcpoJ6eyqy8Ugz4dZpRH+hXtNtbHGIFXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6BssWNgnq3mxN+YdacN20Q2q101h6moJththszHK50eQjKOkiF+ComsgXPBREduoIONYzVNjgQdGw+cRv6wn1c7M9O3zMlMD30+lKwe3wfB6mFOn/rGbxbn5k4NiMr8hJeKBCBFI1HfxVPghhII1sMCeQCkZbkMn425wOjRWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BveHJmsR; arc=none smtp.client-ip=47.90.199.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BveHJmsR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785815215; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=VjSgLvpVkLAlpt0h3TqURSDDPzFkTT5uHnKOEmZFvx0=;
	b=BveHJmsRyAwech8UWwWsPPySw3ynwY1Vy0+4I9YrwzEyIl2Bho7qMouX5tJtQHjY3MBzge9mQ5WepS7UrHAP3XTS6t8hUuwUUXVfu+1WbkrZmVb6EdRLWbBaVtSR15QfI/8wwhlu2QCZFDkl4KLKiwCOyRQ4KNNLhPZJ26N1HgM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X8MUVM._1785815214;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X8MUVM._1785815214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 11:46:54 +0800
Date: Tue, 4 Aug 2026 11:46:52 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	Hyunwoo Kim <imv4bel@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 4/6] KVM: arm64: Correctly handle end of VA space TLBI
 invalidation
Message-ID: <bebthvofsp6rdtj7da7rtqgsdi6sjoq5dmodqzpi445r3msyoh@fd4pndoqqmix>
References: <20260801124818.366274-1-maz@kernel.org>
 <20260801124818.366274-5-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801124818.366274-5-maz@kernel.org>

On Sat, Aug 01, 2026 at 01:48:16PM +0800, Marc Zyngier wrote:
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
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kvm/nested.c | 43 ++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index d7dba02dc84fe..47d61d3cf053c 100644
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
> +
> +	return !(tlb_end < scope_start || tlb_start > scope_end);

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

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
