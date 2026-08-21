Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DEC388873;
	Fri, 21 Aug 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336154; cv=none; b=nPH95Ws81QfWWvr1FmPN6E6BWhizmn6Wg6dijPYVcEE0rwRXR+lcjlRmw4uYworpLacZu2YkZrab0yRsC22l00TMPMLWAu0NHOHyOApdU/9e/TEwzS8zxD9ZJMpXdEyqQ98Ucew1m+cM147X8RJzharxANwlc3x51LDRHCBpGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336154; c=relaxed/simple;
	bh=+99XM01RcrT4lcPtGr0SsrKGPUdEPI6dT2JeqiRU4DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReaLoqd7tus0ZAhVDtMNQodwWQ+0lwioUBgLkGJJ0qXyYM5P9bK5+D30vGFrqCu8TAh2MDnlFI5PYBkxLC14nstNKz5AyY7Le5puSu5gyy2+Y9wdQ9C/JiH6fnLwclSsdyKM1oHZtjHUvvykY5e5YxCXlepPTBg56+VFKfdidIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYIUd8ZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYIUd8ZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A111F000E9;
	Fri, 21 Aug 2026 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787336151;
	bh=Ha7VqklCByafbMscCYK5sdSaBdyQHFxscjntKch3xYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QYIUd8ZRyIYZtnSUpGlYCZBdotfIv/c9uZQV/LJbOq3p5eaUgBdw4PvhPgyKATm/A
	 CnrGasr7GX8WJBcdTCmcu5ftVt4g5W15eCCrTqJRgk/pixnO1+oYIZmYczpjcvsFR5
	 Gi3s3zZD/Cne2LZONbqO/vkBW9Yr9z6lQJFVTbdxldafnKRQwaviFjUu1ge4+7YgHI
	 egEAPOYD2viQixM/JK5ujpl5yyukDnlQZEvPPeH4DbDCyJ1En3YyV13xkfSrkI6DZu
	 jnAY+mLEsIxbgAQuiYeqJSF2JNHO7TWURQ/Ae7B4/s8JToBTJe4MjJRPsyh2sYlNLT
	 8VP2mMzcIqa3A==
Date: Fri, 21 Aug 2026 19:15:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Shen Yongchao <grayhat@foxmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] KVM: arm64: nv: Delay freeing of shadow S2
 structures until VM destruction
Message-ID: <aoiQuVs5jzB5La4i@gremlin>
References: <20260821161829.1032561-1-maz@kernel.org>
 <20260821161829.1032561-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821161829.1032561-3-maz@kernel.org>

On Fri, Aug 21, 2026 at 05:18:29PM +0100, Marc Zyngier wrote:
> We free the shadow S2 structures from kvm_arch_flush_shadow_all(), which
> is a Bad Idea(tm). Freeing the page tables is fair game (this is what
> this callback is for), but freeing the container that could still be
> referenced by another part of the system is not great.

Yes.

>
> Instead, grow separate destructors that gets called when we tear the VM
> down for good. From there, we can nuke both the individual MMUs as well
> as the global array that points to them, safe in the knowledge that the
> vcpus themselves have been destroyed already.
>
> Fixes: 4f128f8e1aaac ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
> Signed-off-by: Marc Zyngier <maz@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

A couple thoughts/questions below.

> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/kvm_nested.h |  1 +
>  arch/arm64/kvm/arm.c                |  4 ++--
>  arch/arm64/kvm/nested.c             | 15 ++++++++++-----
>  3 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 5b8edb2e8a87d..586026e859030 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -67,6 +67,7 @@ static inline u64 translate_ttbr0_el2_to_ttbr0_el1(u64 ttbr0)
>  extern bool forward_smc_trap(struct kvm_vcpu *vcpu);
>  extern bool forward_debug_exception(struct kvm_vcpu *vcpu);
>  extern int kvm_init_nested(struct kvm *kvm);
> +extern void kvm_destroy_nested(struct kvm *kvm);
>  extern int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu);
>  extern void kvm_init_nested_s2_mmu(struct kvm_s2_mmu *mmu);
>  extern struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 7607173c1a40c..2b069c6440669 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -269,7 +269,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>
>  err_uninit_mmu:
>  	kvm_uninit_stage2_mmu(kvm);
> -	kvfree(kvm->arch.nested_mmus);
> +	kvm_destroy_nested(kvm);
>  err_free_cpumask:
>  	free_cpumask_var(kvm->arch.supported_cpus);
>  err_unshare_kvm:
> @@ -327,7 +327,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>
>  	kvm_unshare_hyp(kvm, kvm + 1);
>
> -	kvfree(kvm->arch.nested_mmus);
> +	kvm_destroy_nested(kvm);
>  	kvm_arm_teardown_hypercalls(kvm);
>  }
>
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index 05266f8b87304..00580ba6e8ba0 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -55,6 +55,15 @@ int kvm_init_nested(struct kvm *kvm)
>  	return kvm->arch.nested_mmus ? 0 : -ENOMEM;
>  }
>
> +void kvm_destroy_nested(struct kvm *kvm)
> +{
> +	for (int i = 0; i < kvm->arch.nested_mmus_size; i+= S2_MMU_PER_VCPU)
> +		kvfree(kvm->arch.nested_mmus[i]);
> +
> +	kvm->arch.nested_mmus_size = 0;
> +	kvfree(kvm->arch.nested_mmus);
> +}
> +
>  static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
>  {
>  	/*
> @@ -1310,16 +1319,12 @@ void kvm_nested_s2_flush(struct kvm *kvm)
>
>  void kvm_arch_flush_shadow_all(struct kvm *kvm)
>  {
> -	for (int i = kvm->arch.nested_mmus_size - 1; i >= 0; i--) {
> +	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {

Hmm why this was in reverse before? :) I guess some product of the
kvfree() bit or maybe something else?

>  		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (!WARN_ON(atomic_read(&mmu->refcnt)))
>  			kvm_free_stage2_pgd(mmu);

Yeah I think the mmu write lock taken by the function and the fact mmus are
marked invalid here (VTTBR_CNP_BIT set kvm_free_stage2_pgd() ->
kvm_init_nested_s2_mmu()) makes this entirely fine to do here, as you say.

> -
> -		if ((i % S2_MMU_PER_VCPU) == 0)
> -			kvfree(mmu);
>  	}
> -	kvm->arch.nested_mmus_size = 0;

And, neatly, this makes the patch simply take away the bad bits to do here and
to do them in the correct place.

>  	kvm_uninit_stage2_mmu(kvm);
>  }
>
> --
> 2.47.3
>

--
Cheers, Lorenzo
