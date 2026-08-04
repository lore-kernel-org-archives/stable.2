Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0228446C0F;
	Tue,  4 Aug 2026 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841420; cv=none; b=PC1y7AWYfhizIPjJSDgfP30Rx94GdrZNSlAvBdb6CQPR8wZ2GoOijSG9kG07/G5KRFcAPUFLMpwA/afUgKJU6Oq2e+sWJ4Z23dHz8hENxwR47+nahK5z5p3xKWSt8I4RO/LYMHj+1WZhYMpnh8AyTRC03ibVLpnPDoNeF94hEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841420; c=relaxed/simple;
	bh=SgwKNbrHwnJpm25FFSsLsZaT69eqYUN0KvJYoY0Fzy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryv8Qn1eWW+2MU9wWPfoUxXtgKQjSvcjxIRJCxLKk7iiXjas1id3mG8/5ainATwamVKXPqkK8CZrO5xnBGQt1Yd1777XqNAenaZfpByZngBg8ItzXkWpbogkIy62M1KK2FWSQ1iK6sdxvHfbUQaQFF0LOAGcUjwFUGiHdHEZ/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qRebEx96; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qRebEx96"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F07FC1476;
	Tue,  4 Aug 2026 04:03:33 -0700 (PDT)
Received: from e143914.arm.com (e143914.arm.com [10.2.213.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B24D73F86F;
	Tue,  4 Aug 2026 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785841418; bh=SgwKNbrHwnJpm25FFSsLsZaT69eqYUN0KvJYoY0Fzy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRebEx96D8hhZCIoA1J28U6rLx5SB6DovYNS+PGVRnflpvzd65/a14xsPAviWomTg
	 m+JySxGpMSekcX0g44GbqzPVSHg1CgkOwOUI5G019CiP0/HYCBSUyygMagnb+BsAu2
	 +fInVuN8xI1q5hlpZ/nmcfU+AO4uXhTNpmmGD4lA=
Date: Tue, 4 Aug 2026 12:03:31 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/6] KVM: arm64: Consider SCTLR_EL2.M when mapping the L1
 VNCR page
Message-ID: <anHHA9Fj3be5ndmB@e143914.arm.com>
References: <20260801124818.366274-1-maz@kernel.org>
 <20260801124818.366274-4-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801124818.366274-4-maz@kernel.org>

Hi Marc,

Two small comments/suggestions.

On Sat, Aug 01, 2026 at 01:48:15PM +0100, Marc Zyngier wrote:
> We record a VNCR TLB even when SCTLR_EL2.M is 0 in order to make
> our life easier. But this is not something that the architecture
> anticipate.
> 
> As a consequence, a hypervisor is free to set VNCR_EL2 to
> some PA when SCTLR_EL2.M==0, use it to run a guest which indirectly
> accesses the VNCR page, then eventually set SCTLR_EL2.M==1 with
> the same VA. Yes, this is odd, but apparently legal.
> 
> A common trick in HW is to invalidate the TLBs on SCTLR_ELx.M being
> flipped. But doing this is a not a good idea for us (we'd need to
> trap SCTLR accesses), and wouldn't scale as we nest deeper.
> 
> Instead, use the fact that the S1 MMU being off at the point of
> translation is cached in our TLB, and simply ignore it if it
> doesn't match the current MMU state.

Could you expand/change this a little, something like:
	
	Instead, use the fact that the S1 MMU being off at the point of
	translation is cached in our VNCR TLB, and if it doesn't match
	the current MMU state, leave the VNCR unmapped.

> 
> Fixes: 2a359e072596f ("KVM: arm64: nv: Handle mapping of VNCR_EL2 at EL2")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/kvm_nested.h | 7 +++++++
>  arch/arm64/kvm/at.c                 | 2 --
>  arch/arm64/kvm/nested.c             | 3 +++
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 012d711034d17..cc48817a5bf7a 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -388,6 +388,8 @@ struct s1_walk_result {
>  	bool	failed;
>  };
>  
> +#define S1_MMU_DISABLED		(-127)
> +
>  static inline void fail_s1_walk(struct s1_walk_result *wr, u8 fst, bool s1ptw)
>  {
>  	wr->fst		= fst;
> @@ -396,6 +398,11 @@ static inline void fail_s1_walk(struct s1_walk_result *wr, u8 fst, bool s1ptw)
>  	wr->failed	= true;
>  }
>  
> +static inline bool s1_mmu_disabled(struct s1_walk_result *wr)
> +{
> +	return wr->level == S1_MMU_DISABLED;
> +}
> +
>  int __kvm_translate_va(struct kvm_vcpu *vcpu, struct s1_walk_info *wi,
>  		       struct s1_walk_result *wr, u64 va);
>  int __kvm_find_s1_desc_level(struct kvm_vcpu *vcpu, u64 va, u64 ipa,
> diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
> index 640f2dc00a8ba..0926426b87989 100644
> --- a/arch/arm64/kvm/at.c
> +++ b/arch/arm64/kvm/at.c
> @@ -11,8 +11,6 @@
>  #include <asm/kvm_mmu.h>
>  #include <asm/lsui.h>
>  
> -#define S1_MMU_DISABLED		(-127)
> -
>  static int get_ia_size(struct s1_walk_info *wi)
>  {
>  	return 64 - wi->txsz;
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index 035cda256e2a5..d7dba02dc84fe 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -1578,6 +1578,9 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
>  	if (!vt->valid)
>  		return;
>  
> +	if (!(vcpu_read_sys_reg(vcpu, SCTLR_EL2) & SCTLR_ELx_M) != s1_mmu_disabled(&vt->wr))
> +		return;

A comment here would also be useful for future archaeology (also current
reading since the !( .. != ) code is confusing).

Or maybe:

	bool mmu_disabled_sctlr = vcpu_read_sys_reg(vcpu, SCTLR_EL2) & SCTLR_ELx_M) == 0;
	if (mmu_disabled_sctlr != s1_mmu_disabled(&vt->wr)) 

> +
>  	if (read_vncr_el2(vcpu) != vt->gva)
>  		return;
>  

Thanks,
Joey
