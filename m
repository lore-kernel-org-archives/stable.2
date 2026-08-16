Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C3F3C09E2
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786841104; cv=none; b=HR7jot+rqqMzTcjHoS7OES82e0Zo3SlCRQr0/id5GDeiOWh/+Fj5Er5hXR/NIzPjkXTv4HZBsl30BOlcloxliYXxuzixJqKJQdfBZDqnXDG5+iclSzAIeMQCJKSCy98nopz2s4inoxw8EGxRzITYLLN61TTBm2MyE+wIfYSD9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786841104; c=relaxed/simple;
	bh=+EW7yBAgOs+cnUKsieEofViU2UFBNGtlBW5FLGSXq7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJizKMdTNZ8gV+Zeof/mjwpN0hf4nFq4tg5hdC8q6aAblQ7p60Sld/tpviL2k3SZqUfWOatWCqqQGBdRXZRh7zcjOyhnRWJZcIs435K2NJ/f2e4lsrxd0/NVfrYLOI66rVjNjxZecOCHf+iReognbeRA7AIBxP7zLJBCUoCbTWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bHlYzfGL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bHlYzfGL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69C521595;
	Sat, 15 Aug 2026 17:44:56 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E2483F66F;
	Sat, 15 Aug 2026 17:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786841100; bh=+EW7yBAgOs+cnUKsieEofViU2UFBNGtlBW5FLGSXq7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHlYzfGLuSxzn+vqITNqw39GnQ5tVbpNJuWPYSI2iqOwQpsoA6UwqrRT/IFLf96ha
	 jEb+1TSFjiJ1+slX6dzbmJE4xrXyZxm2X5RvoWzxHwDCd1pTyqdQXoSbTCzFi/D1Rn
	 CIAvw4Hhwdd12MewlhTpXx4udAZbG7C3mv+k587U=
Date: Sun, 16 Aug 2026 01:44:50 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, ljs@kernel.org, 
	Shen Yongchao <grayhat@foxmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] KVM: arm64: nv: Delay freeing of shadow S2
 structures until VM destruction
Message-ID: <4rr77zka26omz5onb25niwjbvqzxqwqzjwqbmfgnyu7yop5f2z@zggt74l2wh4c>
References: <20260814103230.858578-1-maz@kernel.org>
 <20260814103230.858578-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814103230.858578-3-maz@kernel.org>

On Fri, Aug 14, 2026 at 11:32:30AM +0100, Marc Zyngier wrote:
> We free the shadow S2 structures from kvm_arch_flush_shadow_all(), which
> is a Bad Idea(tm). Freeing the page tables is fair game (this is what
> this callback is for), but freeing the container that could still be
> referenced by another part of the system is not great.
> 
> Instead, grow separate destructors that gets called when we tear the VM
> down for good. From there, we can nuke both the individual MMUs as well
> as the global array that points to them, safe in the knowledge that the
> vcpus themselves have been destroyed already.
> 
> Note that similarly to what happens for the canonical S2 MMU, we need to
> manage the freeing of the page tables both in kvm_arch_flush_shadow_all
> (called on address space teardown) and VM teardown (as a result of
> closing the VM fd, amongst others), as there is no guaranteed ordering
> between these two events.

From my understanding, for a normal teardown, address space vs VM
teardown ordering does not matter. kvm_arch_flush_shadow_all() will
always be run before kvm_arch_destroy_vm(). (there is
mmu_notifier_unregister() before kvm_arch_destroy_vm() in
kvm_destroy_vm())

The reason we need kvm_uninit_stage2_mmu() in both functions is if
kvm_create_vm() fails the canonical pgt could be allocated without the
mmu notifier registered. Therefore a kvm_uninit_stage2_mmu() in
kvm_arch_destroy_vm() is required.

For nested mmus we have different conditions. No pgts can be allocated
unless the VM is successfully created, this makes
kvm_uninit_shadow_stage2_mmu() redundant in kvm_destroy_nested().

I don't oppose to having kvm_uninit_shadow_stage2_mmu() in
kvm_destroy_nested(), as it makes the operations symmetric for canonical
and nested mmus.

For this last paragraph, maybe we can just remove it, or describe the
extra kvm_uninit_shadow_stage2_mmu() in kvm_destroy_nested() as
defensive.

Thanks,
Wei-Lin Chang

> 
> Fixes: 4f128f8e1aaac ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/kvm_nested.h |  1 +
>  arch/arm64/kvm/arm.c                |  4 ++--
>  arch/arm64/kvm/nested.c             | 32 ++++++++++++++++++++---------
>  3 files changed, 25 insertions(+), 12 deletions(-)
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
> index 254cbd8703b3d..d0c05db554b1c 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -55,6 +55,27 @@ int kvm_init_nested(struct kvm *kvm)
>  	return kvm->arch.nested_mmus ? 0 : -ENOMEM;
>  }
>  
> +static void kvm_uninit_shadow_stage2_mmu(struct kvm *kvm)
> +{
> +	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
> +
> +		if (!WARN_ON(atomic_read(&mmu->refcnt)))
> +			kvm_free_stage2_pgd(mmu);
> +	}
> +}
> +
> +void kvm_destroy_nested(struct kvm *kvm)
> +{
> +	kvm_uninit_shadow_stage2_mmu(kvm);
> +
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
> @@ -1310,16 +1331,7 @@ void kvm_nested_s2_flush(struct kvm *kvm)
>  
>  void kvm_arch_flush_shadow_all(struct kvm *kvm)
>  {
> -	for (int i = kvm->arch.nested_mmus_size - 1; i >= 0; i--) {
> -		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
> -
> -		if (!WARN_ON(atomic_read(&mmu->refcnt)))
> -			kvm_free_stage2_pgd(mmu);
> -
> -		if ((i % S2_MMU_PER_VCPU) == 0)
> -			kvfree(mmu);
> -	}
> -	kvm->arch.nested_mmus_size = 0;
> +	kvm_uninit_shadow_stage2_mmu(kvm);
>  	kvm_uninit_stage2_mmu(kvm);
>  }
>  
> -- 
> 2.47.3
> 
