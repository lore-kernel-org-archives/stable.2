Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A37440A13;
	Mon, 17 Aug 2026 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979872; cv=none; b=MB3n4OtVRTmFG3HhHGmQJdtO+YXpOGAtPB/CfxdhfBNX337TjH6lCqeNpf/MBybaXjJio7fEaCqjODYj5C6tD/zCFfdlmCd8OxC8TrRzEaggDOVoM6xxfQzKOk3i1tG9r7CTCOOS0dbSDan1GTuIXDQ3LzpEt6TR5kOlQTvLpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979872; c=relaxed/simple;
	bh=e3BUskELDxzWsNaOkWVl9/P3X8lKT1YXroISrA+LOms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJ3V8vg2Wz6qxdQGs2JGBg69DXljo79QEgxGv4hrKymxXxgUNbSUFvkRV8/4XkSrUuVYXnzaM20R+AR725YzoBNumLE8OFHXBpidF6xQpE2dAayj4HWaBsdVKVXwhDo8lomlx1pkaRUYR6KBlgMNoxAnrTZ4b/B5iFfEzGTzSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ9lgMsH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ9lgMsH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD1B1F00A3A;
	Mon, 17 Aug 2026 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786979871;
	bh=ss7U/2YTy9A3C2Z/p5RynpbaJ0lWEE5CiNvY0Z+Tm0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cZ9lgMsH0gcoBRT6droiOSss6vTfVMkynwppmaixyAeQbiHrChEVYwLx6zbdsnvUU
	 1yzab0a1foS+QPnbxd3PaHMVQXk+tSp5x7Rc7oXKkW1zwBtMQ4MWuS1Hv8GXP+7YWc
	 5tPa4N8MK5peK7eXOooRYnCgWBodRnwDkVcwRXDmy1N9fnPW6dKTrc6JamxcalIHxG
	 cYcc581bTE458B0CLv8nuY2+I95Wj1B3gcEYTXHbgeCo1WjfXmvIweuCORA/Yo4V2L
	 jFDnNcJdTGeWQpSCexKo4W6vGD5mePjsfbB9wYRxh6hN423MIPE8P+/A52DrFkauSC
	 oQokxOfT52wCA==
Date: Mon, 17 Aug 2026 16:17:46 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Shen Yongchao <grayhat@foxmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: nv: Fix life cycle of the nested_mmus
 array
Message-ID: <aoMhRtpohuNHcEzw@gremlin>
References: <20260814103230.858578-1-maz@kernel.org>
 <20260814103230.858578-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814103230.858578-2-maz@kernel.org>

On Fri, Aug 14, 2026 at 11:32:29AM +0100, Marc Zyngier wrote:
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

One issue with a typo'd type below (the compiler is ok with it because it's
expressed as a sizeof(ptr) but it should be fixed) and a small nit, and
also Wei Lin had a comment re: the commit message.

With those addressed LGTM so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/kvm_host.h   |  2 +-
>  arch/arm64/include/asm/kvm_nested.h |  2 +-
>  arch/arm64/kvm/arm.c                |  8 ++-
>  arch/arm64/kvm/nested.c             | 93 +++++++++++++----------------
>  4 files changed, 51 insertions(+), 54 deletions(-)
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

OK I see, rather than having to deal with the dynamic array-type stuff and all
the mess that comes with that, just allocate at S2_MMU_PER_VCPU granularity,
i.e. the amount that can be expanded at any time.

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
>  	kvm_arm_teardown_hypercalls(kvm);
>  }
>
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index 20af94197a8a7..254cbd8703b3d 100644
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

As pointed out by Sashiko/Karl this seems to be a typo, should be kvm_s2_mmu?

> +					       GFP_KERNEL_ACCOUNT);
>  	kvm->arch.nested_mmus_size = 0;
>  	atomic_set(&kvm->arch.vncr_tlb_count, 0);
> +
> +	return kvm->arch.nested_mmus ? 0 : -ENOMEM;
>  }
>
>  static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
> @@ -69,8 +73,9 @@ static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
>  int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> -	struct kvm_s2_mmu *tmp;
> -	int num_mmus, ret = 0;
> +	int num_mmus;
> +
> +	lockdep_assert_held(&kvm->arch.config_lock);
>
>  	if (test_bit(KVM_ARM_VCPU_HAS_EL2_E2H0, kvm->arch.vcpu_features) &&
>  	    !cpus_have_final_cap(ARM64_HAS_HCR_NV1))
> @@ -83,51 +88,40 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
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

I guess this can only ever be kvm->arch.nested_mmus_size + S2_MMU_PER_VCPU?

Maybe worth an assert if so? But not sure how useful it'd be in practice.

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

Nice to do more stuff outside of the lock.

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

This seems to make the !ret above redundant so maybe:

		for (i = 0; !ret && i < S2_MMU_PER_VCPU; i++)
			ret = init_nested_s2_mmu(kvm, &tmp[i]);

Or:

		for (i = 0; i < S2_MMU_PER_VCPU; i++) {
			ret = init_nested_s2_mmu(kvm, &tmp[i]);
			if (ret)
				break;
		}

Which seems a bit clearer.

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

I seem to remember from my explorations of this that there are some ways in
which can get referenced by someone, but again I think you fix all this in 2/2
anyway.

> +		}
> +
> +		guard(write_lock)(&kvm->mmu_lock);

This guard does make it much neater :)

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
> @@ -741,7 +735,7 @@ void kvm_s2_mmu_iterate_by_vmid(struct kvm *kvm, u16 vmid,
>  	write_lock(&kvm->mmu_lock);
>
>  	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (!kvm_s2_mmu_valid(mmu))
>  			continue;
> @@ -783,7 +777,7 @@ struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu)
>  	 *   if S2 translation is disabled.
>  	 */
>  	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (!kvm_s2_mmu_valid(mmu))
>  			continue;
> @@ -822,7 +816,7 @@ static struct kvm_s2_mmu *get_s2_mmu_nested(struct kvm_vcpu *vcpu)
>  	for (i = kvm->arch.nested_mmus_next;
>  	     i < (kvm->arch.nested_mmus_size + kvm->arch.nested_mmus_next);
>  	     i++) {
> -		s2_mmu = &kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
> +		s2_mmu = kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
>
>  		if (atomic_read(&s2_mmu->refcnt) == 0)
>  			break;
> @@ -1269,7 +1263,7 @@ void kvm_nested_s2_wp(struct kvm *kvm)
>  		return;
>
>  	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (kvm_s2_mmu_valid(mmu))
>  			kvm_stage2_wp_range(mmu, 0, kvm_phys_size(mmu));
> @@ -1288,7 +1282,7 @@ void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
>  		return;
>
>  	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (kvm_s2_mmu_valid(mmu))
>  			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
> @@ -1307,7 +1301,7 @@ void kvm_nested_s2_flush(struct kvm *kvm)
>  		return;
>
>  	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>
>  		if (kvm_s2_mmu_valid(mmu))
>  			kvm_stage2_flush_range(mmu, 0, kvm_phys_size(mmu));
> @@ -1316,16 +1310,15 @@ void kvm_nested_s2_flush(struct kvm *kvm)
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
>  	}
> -	kvfree(kvm->arch.nested_mmus);
> -	kvm->arch.nested_mmus = NULL;
>  	kvm->arch.nested_mmus_size = 0;
>  	kvm_uninit_stage2_mmu(kvm);

This is still all racey, but you address it in 2/2.

>  }
> --
> 2.47.3
>
>

--
Cheers, Lorenzo
