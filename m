Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7743370AC0;
	Wed, 12 Aug 2026 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543528; cv=none; b=qkQi8lWGy9cqN0O2xgQX8o1fy2fBr28Y/EdE1oficcHeGrmGPsCoiswWR6EDDBvNGjJm2D8scJbXV1dCR4kIK3dy0lsdhmOjzmKJuZFWN7zDPXKdGKpHkwLPaNY5dSzwPmt0beeQ3awm2zfABWJKF6h4B6vUT7fdbiMzmMde+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543528; c=relaxed/simple;
	bh=WIv3iFlndL7YJ9amqtt2khgvAsZiLkvuDj2PrfWWAK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQcUinEkxzqpg6ANpwT2aGPxwUFRPElWGrRhWjt6cdEUDwFWYyiKsQUuLNPlUhtCBrxsF3BPnJQwWISi/biniYAKWXb6A3HphLZNEs5IL0t1WwnXs61IbN7Ydm74cBV9T/npGmZsHA9785+cut1oKe6VRKA8u26EuA5L75lfw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDZcVYja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDZcVYja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345591F000E9;
	Wed, 12 Aug 2026 14:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543526;
	bh=RS4fQroz8OYjD+ueOwoIruqpQsxvyB1tTlBSDqRy6u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MDZcVYja7W34AdZhzc8uDmnsxH5R93Jycc4KEEu6AoAIh59HVP27FeBuFyHuTG5KH
	 IbfwFoLg9Fbjz9Xzqrw+eLyHkVR7Qw4Wk+Zw5qIIQInSUg2f5/qheqIBry0ts9gD1D
	 NMbGxzxEzI09yHZmGH3d/OEy+QO7jcLrcopnlajqiAWqF/KiUB0EGM4vptDpQ74+w2
	 ar6KepIVbsVu6MTW5OJ0DtiLdmVK4mzPml8+4KjW6kITGBYCPLP7ztRVLqTCj59yTK
	 vILsy5fAvnEnPV4wGXKpxFYfDHNbjRcoaDUnOGE6/o1M6e+scL9DNr3oA/zHL+QSvl
	 bKukIMGb+xhcg==
Date: Wed, 12 Aug 2026 15:05:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Shen Yongchao <grayhat@foxmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: nv: Fix life cycle of the nested_mmus array
Message-ID: <anx6Wa5i1M2hidVK@gremlin>
References: <20260811122057.754772-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811122057.754772-1-maz@kernel.org>

On Tue, Aug 11, 2026 at 01:20:57PM +0100, Marc Zyngier wrote:
> The nested_mmus array holds the shadow page tables that are used when
> a guest is running a nested context. These structures are allocated on
> VCPU_INIT for whole guest, which implies that they may have to be
> relocated as the array grows.
>
> Should a VCPU_INIT occur whilst a vcpu is actively running an L2 and
> that the allocation requires relocation, that vcpu will still be
> running with a pointer to the previous structure, which will have been
> freed.
>
> Fix this by turning the array of structures to an array of pointers,
> which is now allocated at VM creation, sized to the absolute maximum
> that KVM can handle.
>
> In turn, each VCPU_INIT contributes S2_MMU_PER_VCPU to the pool. No
> reallocation is ever performed, and the life cycle of each object is
> much clearer:
>
> - the nested_mmus array is allocated in kvm_init_nested(), and freed
>   in kvm_arch_destroy_vm()
>
> - s2_mmu structures are allocated in kvm_vcpu_init_nested(), and freed
>   on kvm_arch_flush_shadow_all()
>
> Finally, the freeing of vcpu->arch.vncr_array is made consistent
> rather than being done on some failure paths, but not others.
>
> Fixes: 4f128f8e1aaa ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
> Reported-by: Shen Yongchao <grayhat@foxmail.com>
> Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
> Suggested-by: Karl Mehltretter <kmehltretter@gmail.com>
> Link: https://lore.kernel.org/r/20260803224405.41468-1-kmehltretter@gmail.com
> Signed-off-by: Marc Zyngier <maz@kernel.org>

This addresses the same kind of stuff I had a couple of patches in my
series for :>)

I think there are still some problems with it, see below.

Also I attach my original patch for the UAF below in case it's useful! I
had another for the init stuff, will reply with that separately also :)

> Cc: stable@vger.kernel.org
> ---
>
> Notes:
>     Sending this as a first class patch, since the other approaches were even
>     uglier than this one. I'm still displeased with kvm_arch_flush_shadow_all(),
>     but that's a step in the direction of tightening it:

Yeah from what I've seen it does seem problematic :)

>
>  arch/arm64/include/asm/kvm_host.h   |  2 +-
>  arch/arm64/include/asm/kvm_nested.h |  2 +-
>  arch/arm64/kvm/arm.c                |  8 ++-
>  arch/arm64/kvm/nested.c             | 91 +++++++++++++----------------
>  4 files changed, 49 insertions(+), 54 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 108966a9db12b..08b2f24dc3c79 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -322,7 +322,7 @@ struct kvm_arch {
>  	 * Stage 2 paging state for VMs with nested S2 using a virtual
>  	 * VMID.
>  	 */
> -	struct kvm_s2_mmu *nested_mmus;
> +	struct kvm_s2_mmu **nested_mmus;
>  	size_t nested_mmus_size;
>  	int nested_mmus_next;
>
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 1ed7083358096..5b8edb2e8a87d 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -66,7 +66,7 @@ static inline u64 translate_ttbr0_el2_to_ttbr0_el1(u64 ttbr0)
>
>  extern bool forward_smc_trap(struct kvm_vcpu *vcpu);
>  extern bool forward_debug_exception(struct kvm_vcpu *vcpu);
> -extern void kvm_init_nested(struct kvm *kvm);
> +extern int kvm_init_nested(struct kvm *kvm);
>  extern int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu);
>  extern void kvm_init_nested_s2_mmu(struct kvm_s2_mmu *mmu);
>  extern struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 50adfff75be82..7607173c1a40c 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -223,8 +223,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	mutex_unlock(&kvm->lock);
>  #endif
>
> -	kvm_init_nested(kvm);
> -
>  	ret = kvm_share_hyp(kvm, kvm + 1);
>  	if (ret)
>  		return ret;
> @@ -239,6 +237,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	if (ret)
>  		goto err_free_cpumask;
>
> +	ret = kvm_init_nested(kvm);
> +	if (ret)
> +		goto err_uninit_mmu;
> +
>  	if (is_protected_kvm_enabled()) {
>  		/*
>  		 * If any failures occur after this is successful, make sure to
> @@ -267,6 +269,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>
>  err_uninit_mmu:
>  	kvm_uninit_stage2_mmu(kvm);
> +	kvfree(kvm->arch.nested_mmus);
>  err_free_cpumask:
>  	free_cpumask_var(kvm->arch.supported_cpus);
>  err_unshare_kvm:
> @@ -324,6 +327,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>
>  	kvm_unshare_hyp(kvm, kvm + 1);
>
> +	kvfree(kvm->arch.nested_mmus);

Yes this seems the right place for this.

>  	kvm_arm_teardown_hypercalls(kvm);
>  }
>
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index 20af94197a8a7..50d6dcc75582c 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -44,11 +44,15 @@ struct vncr_tlb {
>   */
>  #define S2_MMU_PER_VCPU		2
>
> -void kvm_init_nested(struct kvm *kvm)
> +int kvm_init_nested(struct kvm *kvm)
>  {
> -	kvm->arch.nested_mmus = NULL;
> +	kvm->arch.nested_mmus = kvmalloc_array(KVM_MAX_VCPUS * S2_MMU_PER_VCPU,
> +					       sizeof(struct s2_mmu *),
> +					       GFP_KERNEL_ACCOUNT);
>  	kvm->arch.nested_mmus_size = 0;
>  	atomic_set(&kvm->arch.vncr_tlb_count, 0);
> +
> +	return kvm->arch.nested_mmus ? 0 : -ENOMEM;
>  }
>
>  static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
> @@ -69,8 +73,7 @@ static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
>  int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
>  {

Ah these changes supercede another patch of mine :) will share that separately
in case it's useful :)

>  	struct kvm *kvm = vcpu->kvm;
> -	struct kvm_s2_mmu *tmp;
> -	int num_mmus, ret = 0;
> +	int num_mmus;
>
>  	if (test_bit(KVM_ARM_VCPU_HAS_EL2_E2H0, kvm->arch.vcpu_features) &&
>  	    !cpus_have_final_cap(ARM64_HAS_HCR_NV1))
> @@ -83,51 +86,40 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
>  	if (!vcpu->arch.ctxt.vncr_array)
>  		return -ENOMEM;
>
> -	/*
> -	 * Let's treat memory allocation failures as benign: If we fail to
> -	 * allocate anything, return an error and keep the allocated array
> -	 * alive. Userspace may try to recover by initializing the vcpu
> -	 * again, and there is no reason to affect the whole VM for this.
> -	 */
>  	num_mmus = atomic_read(&kvm->online_vcpus) * S2_MMU_PER_VCPU;
>
>  	if (num_mmus > kvm->arch.nested_mmus_size) {
> -		tmp = kvcalloc(num_mmus, sizeof(*tmp), GFP_KERNEL_ACCOUNT);
> +		struct kvm_s2_mmu *tmp;
> +		int i, ret = 0;
> +
> +		tmp = kvcalloc(S2_MMU_PER_VCPU, sizeof(*tmp), GFP_KERNEL_ACCOUNT);
>  		if (!tmp)
> -			return -ENOMEM;
> +			ret = -ENOMEM;
>
> -		write_lock(&kvm->mmu_lock);
> -
> -		if (kvm->arch.nested_mmus_size) {
> -			memcpy(tmp, kvm->arch.nested_mmus,
> -			       size_mul(sizeof(*tmp), kvm->arch.nested_mmus_size));
> -
> -			for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
> -				tmp[i].pgt->mmu = &tmp[i];
> +		for (i = 0; !ret && i < S2_MMU_PER_VCPU; i++) {
> +			ret = init_nested_s2_mmu(kvm, &tmp[i]);
> +			if (ret)
> +				break;
>  		}
>
> -		swap(kvm->arch.nested_mmus, tmp);
> +		if (ret) {
> +			while (--i >= 0)
> +				kvm_free_stage2_pgd(&tmp[i]);
>
> -		write_unlock(&kvm->mmu_lock);
> +			kvfree(tmp);
> +			free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
> +			vcpu->arch.ctxt.vncr_array = NULL;
> +			return ret;
> +		}
> +
> +		guard(write_lock)(&kvm->mmu_lock);
>
> -		kvfree(tmp);
> +		for (i = 0; i < S2_MMU_PER_VCPU; i++)
> +			kvm->arch.nested_mmus[i + kvm->arch.nested_mmus_size] = &tmp[i];
> +
> +		kvm->arch.nested_mmus_size += S2_MMU_PER_VCPU;
>  	}
>
> -	for (int i = kvm->arch.nested_mmus_size; !ret && i < num_mmus; i++)
> -		ret = init_nested_s2_mmu(kvm, &kvm->arch.nested_mmus[i]);
> -
> -	if (ret) {
> -		for (int i = kvm->arch.nested_mmus_size; i < num_mmus; i++)
> -			kvm_free_stage2_pgd(&kvm->arch.nested_mmus[i]);
> -
> -		free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
> -		vcpu->arch.ctxt.vncr_array = NULL;
> -
> -		return ret;
> -	}
> -
> -	kvm->arch.nested_mmus_size = num_mmus;
> -
>  	return 0;
>  }
>
> @@ -741,7 +733,7 @@ void kvm_s2_mmu_iterate_by_vmid(struct kvm *kvm, u16 vmid,
>  	write_lock(&kvm->mmu_lock);
>
>  	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (!kvm_s2_mmu_valid(mmu))
>  			continue;
> @@ -783,7 +775,7 @@ struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu)
>  	 *   if S2 translation is disabled.
>  	 */
>  	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (!kvm_s2_mmu_valid(mmu))
>  			continue;
> @@ -822,7 +814,7 @@ static struct kvm_s2_mmu *get_s2_mmu_nested(struct kvm_vcpu *vcpu)
>  	for (i = kvm->arch.nested_mmus_next;
>  	     i < (kvm->arch.nested_mmus_size + kvm->arch.nested_mmus_next);
>  	     i++) {
> -		s2_mmu = &kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
> +		s2_mmu = kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
>
>  		if (atomic_read(&s2_mmu->refcnt) == 0)
>  			break;
> @@ -1269,7 +1261,7 @@ void kvm_nested_s2_wp(struct kvm *kvm)
>  		return;
>
>  	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (kvm_s2_mmu_valid(mmu))
>  			kvm_stage2_wp_range(mmu, 0, kvm_phys_size(mmu));
> @@ -1288,7 +1280,7 @@ void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
>  		return;
>
>  	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (kvm_s2_mmu_valid(mmu))
>  			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
> @@ -1307,7 +1299,7 @@ void kvm_nested_s2_flush(struct kvm *kvm)
>  		return;
>
>  	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (kvm_s2_mmu_valid(mmu))
>  			kvm_stage2_flush_range(mmu, 0, kvm_phys_size(mmu));
> @@ -1316,16 +1308,15 @@ void kvm_nested_s2_flush(struct kvm *kvm)
>
>  void kvm_arch_flush_shadow_all(struct kvm *kvm)
>  {
> -	int i;
> -
> -	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +	for (int i = kvm->arch.nested_mmus_size - 1; i >= 0; i--) {
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (!WARN_ON(atomic_read(&mmu->refcnt)))
>  			kvm_free_stage2_pgd(mmu);
> +
> +		if ((i % S2_MMU_PER_VCPU) == 0)
> +			kvfree(mmu);

Hmm I think that this can still be referenced if a concurrent e.g. mmu notifier
thread doing S2 nested teardown is referencing it?

Maybe defer this to kvm_arch_destroy_vm() also?

>  	}
> -	kvfree(kvm->arch.nested_mmus);
> -	kvm->arch.nested_mmus = NULL;
>  	kvm->arch.nested_mmus_size = 0;

This is racey (concurrent S2 teardown again) and should be
done with the kvm->mmu_lock held I think.

In my original patch (see below) I simply did:

	/* We may be raced by concurrent S2 teardown. */
	scoped_guard(write_lock, &kvm->mmu_lock)
		kvm->arch.nested_mmus_size = 0;


>  	kvm_uninit_stage2_mmu(kvm);
>  }
> --
> 2.47.3
>
>

--
Cheers, Lorenzo

My original patch:

----8<----
From aad74d801e045e8bd26d389883233387f4ba5c40 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 11 Aug 2026 19:17:34 +0100
Subject: [PATCH] KVM: arm64: nv: Fix UAF in kvm_nested_s2_unmap() on S2
 teardown

When tearing down stage 2 page tables kvm_arch_flush_shadow_all() frees and
sets kvm->arch.nested_mmus to NULL and kvm->arch.nested_mmus_size to zero
with no kvm->mmu_lock held.

	void kvm_arch_flush_shadow_all(struct kvm *kvm)
	{
		... tear down nested mmus ...

		kvfree(kvm->arch.nested_mmus);
		kvm->arch.nested_mmus = NULL;
		kvm->arch.nested_mmus_size = 0;
		kvm_uninit_stage2_mmu(kvm);
	}

This is problematic as commit ec14c272408a ("KVM: arm64: nv: Unmap/flush
shadow stage 2 page tables") opens the door to a concurrent thread invoking
kvm_nested_s2_unmap(), for instance on MMU notification of an invalidation
of GFNs:

mmu_notifier_invalidate_range_start()
  -> ... -> kvm_mmu_notifier_invalidate_range_start()
    -> kvm_mmu_unmap_gfn_range()
      -> kvm_unmap_gfn_range()
        -> kvm_nested_s2_unmap()
          -> kvm_stage2_unmap_range()
            -> __unmap_stage2_range()
               -> stage2_apply_range()

stage2_apply_range() as invoked by __unmap_stage2_range() iterates over
blocks of guest physical address space for each nested mmu, and
importantly - can do so (and does so on MMU invalidation) while dropping
kvm->mmu_lock after each block.

If it happens to relinquish the lock at such a time that
kvm_arch_flush_shadow_all() is about to complete its teardown of nested
mmus, it means that kvm_arch_flush_shadow_all() can perform some or all of
these changes before stage2_apply_range() can reacquire it.

kvm_nested_s2_unmap() accesses kvm->arch.nested_mmus_size and dereferences
kvm->arch.nested_mmus[] and kvm->arch.mmu.pgt on the assumption that it is
safe to do so with the kvm->mmu_lock held:

	void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
	{
		...

		if (!kvm->arch.nested_mmus_size)
			return;

		for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
			struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];

			if (kvm_s2_mmu_valid(mmu))
				kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu),
						       may_block);
		}

		kvm_invalidate_vncr_ipa(kvm, 0, BIT(kvm->arch.mmu.pgt->ia_bits));
	}

This is a race, so resolve it by setting kvm->arch.nested_mmus_size to zero
with the kvm->mmu_lock held.

kvm->arch.nested_mmus cannot be safely freed here without racers
potentially accessing invalid data, nor would doing so under the mmu lock
make sense, so defer the freeing of this to kvm_arch_destroy_vm().

Since all accesses to kvm->arch.nested_mmus should be limited to
kvm->arch.nested_mmus_size, there is no need to set this NULL, and keeping
this around allows for the deferred free in kvm_arch_destroy_vm().

Fixes: ec14c272408a ("KVM: arm64: nv: Unmap/flush shadow stage 2 page tables")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/kvm/arm.c    | 1 +
 arch/arm64/kvm/nested.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ccae82c1242b..8ddd0ab792bf 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -319,6 +319,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_uninit_stage2_mmu(kvm);
 	kvm_destroy_mpidr_data(kvm);

+	kvfree(kvm->arch.nested_mmus);
 	kfree(kvm->arch.sysreg_masks);
 	kvm_destroy_vcpus(kvm);

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 17123f0b6dab..0288aa5bc9bd 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1325,9 +1325,10 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 		if (!WARN_ON(atomic_read(&mmu->refcnt)))
 			kvm_free_stage2_pgd(mmu);
 	}
-	kvfree(kvm->arch.nested_mmus);
-	kvm->arch.nested_mmus = NULL;
-	kvm->arch.nested_mmus_size = 0;
+
+	/* We may be raced by concurrent S2 teardown. */
+	scoped_guard(write_lock, &kvm->mmu_lock)
+		kvm->arch.nested_mmus_size = 0;
 	kvm_uninit_stage2_mmu(kvm);
 }

--
2.55.0
