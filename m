Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BCC43D508;
	Tue,  4 Aug 2026 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839121; cv=none; b=kEu6ONma8SoyIy88hJ05ZILOzYkWVyKuoiLvh6yQOn+18E8eAlo3rAVP4KoXqWenzoifbePaOf6LqF85GdQKqEvzLPXQWLUNlL1JpUblXkVBRB06tSM7KT8sdtNGybcbrfikhEwu4CwbiNo1ApPOJbeXwH4enegGAkDu1QF6m84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839121; c=relaxed/simple;
	bh=ypAXrYlU3284ZQhZ9clrIQrMOuh27KFxBPJSFxwpKPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtT9QlXIbMs1Qr//ynCc6LVvIYS3K3Lgnk+47N47Yfu0d/ZSzxVFwf1NWWclbajYGZuen+Vlyg+El1xPBrFZacDVTmDHAuo/XhaRtITcOUpsWa5Qsnw41sF1qRT+zH4bc1Fmr/MNpFYO1WFrcgW3W3Bn0690zxORCBGm4mWgPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S/xwpGme; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S/xwpGme"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D70A1476;
	Tue,  4 Aug 2026 03:25:14 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00BB93F86F;
	Tue,  4 Aug 2026 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785839118; bh=ypAXrYlU3284ZQhZ9clrIQrMOuh27KFxBPJSFxwpKPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/xwpGmePFvakgf8QMuF5FP0Il5C4azvj3bbFsPNiYLlqtClLeXcB3R0JH53isPdZ
	 5+fdbTQqwrtOULwTFa+QqdLbWibAmhmaqd/MpmgFdGaMhxZSUOLqCobo/Zt/jVL76L
	 vVeVu8ZVJPLZ7JERn48usH4pgK7HQI5oMsgVjf/c=
Date: Tue, 4 Aug 2026 11:24:59 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: arm64: nv: Allocate the shadow S2 MMUs
 individually
Message-ID: <it25udexjmb33rrfnugdcjzzbe5a3zpwpwyp2s3rvjfpyy7moy@wjlokfxjqp3v>
References: <20260803224405.41468-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803224405.41468-1-kmehltretter@gmail.com>

Hi Karl,

On Tue, Aug 04, 2026 at 12:44:04AM +0200, Karl Mehltretter wrote:
> A vCPU in L2 caches its shadow S2 MMU in vcpu->arch.hw_mmu.
> kvm_vcpu_init_nested() can grow kvm->arch.nested_mmus while initialising
> another vCPU: it copies the MMUs, publishes the new allocation, and frees
> the old one.  It updates pgt->mmu back-pointers, but not hw_mmu, leaving
> the first vCPU with a pointer to freed memory.  hw_mmu cannot be fixed up
> the same way: a running vCPU reads it without holding mmu_lock.  Copying
> also duplicates the MMU's refcount, leaving the live copy permanently
> elevated.
> 
> KASAN reports this as a slab-use-after-free in kvm_handle_guest_abort().
> 
> Make nested_mmus a pointer table and allocate each MMU separately.
> Growing the table now moves only pointer entries, preserving cached
> hw_mmu pointers, pgt->mmu back-pointers, and each MMU's refcount.  Fully
> initialise new MMUs before publishing the table and its size under
> mmu_lock.
> 
> The old failure path passed uninitialised entries to
> kvm_free_stage2_pgd(), which needs mmu->arch.  Use an allocation helper
> that returns only fully initialised MMUs, so error cleanup frees only
> completed objects; kvm_init_stage2_mmu() unwinds a failed initialisation.

Just a comment, instead of allocaing the nested mmus individually
another option is to just fail VCPU_INIT if any of the nested mmus have
refcnt > 0.

However, we probably want to return EBUSY in that case, but that's a
uAPI change.

Thanks,
Wei-Lin Chang

> 
> Fixes: 4f128f8e1aaa ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> 
> Tested on an arm64 KASAN kernel under QEMU TCG with EL2 emulation
> (-machine virt,virtualization=on -cpu max, kvm-arm.mode=nested): the
> selftest in patch 2 reports the slab-use-after-free without this patch
> and passes with it.
> 
>  arch/arm64/include/asm/kvm_host.h |  6 +-
>  arch/arm64/kvm/nested.c           | 92 +++++++++++++++++++++----------
>  2 files changed, 67 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index bae2c4f92ef5..f587b01039f9 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -319,10 +319,10 @@ struct kvm_arch {
>  	u64 fgu[__NR_FGT_GROUP_IDS__];
>  
>  	/*
> -	 * Stage 2 paging state for VMs with nested S2 using a virtual
> -	 * VMID.
> +	 * Stage 2 paging state for VMs with nested S2 using a virtual VMID.
> +	 * MMUs are individually allocated to keep their addresses stable.
>  	 */
> -	struct kvm_s2_mmu *nested_mmus;
> +	struct kvm_s2_mmu **nested_mmus;
>  	size_t nested_mmus_size;
>  	int nested_mmus_next;
>  
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index dfb96edbdc43..af804a5ddca7 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/err.h>
>  #include <linux/kvm.h>
>  #include <linux/kvm_host.h>
>  
> @@ -66,11 +67,36 @@ static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
>  	return kvm_init_stage2_mmu(kvm, mmu, kvm_get_pa_bits(kvm));
>  }
>  
> +static struct kvm_s2_mmu *alloc_nested_s2_mmu(struct kvm *kvm)
> +{
> +	struct kvm_s2_mmu *mmu;
> +	int ret;
> +
> +	mmu = kzalloc_obj(*mmu, GFP_KERNEL_ACCOUNT);
> +	if (!mmu)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = init_nested_s2_mmu(kvm, mmu);
> +	if (ret) {
> +		/* kvm_init_stage2_mmu() frees its internal allocations on error */
> +		kfree(mmu);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return mmu;
> +}
> +
> +static void free_nested_s2_mmu(struct kvm_s2_mmu *mmu)
> +{
> +	kvm_free_stage2_pgd(mmu);
> +	kfree(mmu);
> +}
> +
>  int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> -	struct kvm_s2_mmu *tmp;
> -	int num_mmus, ret = 0;
> +	struct kvm_s2_mmu **tmp;
> +	int i, num_mmus, ret = 0;
>  
>  	if (test_bit(KVM_ARM_VCPU_HAS_EL2_E2H0, kvm->arch.vcpu_features) &&
>  	    !cpus_have_final_cap(ARM64_HAS_HCR_NV1))
> @@ -96,38 +122,48 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
>  		if (!tmp)
>  			return -ENOMEM;
>  
> +		/*
> +		 * Populate new slots before publishing: table walkers hold
> +		 * mmu_lock and iterate up to nested_mmus_size.
> +		 */
> +		for (i = kvm->arch.nested_mmus_size; i < num_mmus; i++) {
> +			struct kvm_s2_mmu *mmu = alloc_nested_s2_mmu(kvm);
> +
> +			if (IS_ERR(mmu)) {
> +				ret = PTR_ERR(mmu);
> +				break;
> +			}
> +
> +			tmp[i] = mmu;
> +		}
> +
> +		if (ret) {
> +			while (i-- > kvm->arch.nested_mmus_size)
> +				free_nested_s2_mmu(tmp[i]);
> +
> +			kvfree(tmp);
> +
> +			free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
> +			vcpu->arch.ctxt.vncr_array = NULL;
> +
> +			return ret;
> +		}
> +
>  		write_lock(&kvm->mmu_lock);
>  
>  		if (kvm->arch.nested_mmus_size) {
>  			memcpy(tmp, kvm->arch.nested_mmus,
>  			       size_mul(sizeof(*tmp), kvm->arch.nested_mmus_size));
> -
> -			for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
> -				tmp[i].pgt->mmu = &tmp[i];
>  		}
>  
>  		swap(kvm->arch.nested_mmus, tmp);
> +		kvm->arch.nested_mmus_size = num_mmus;
>  
>  		write_unlock(&kvm->mmu_lock);
>  
>  		kvfree(tmp);
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
> @@ -725,7 +761,7 @@ void kvm_s2_mmu_iterate_by_vmid(struct kvm *kvm, u16 vmid,
>  	write_lock(&kvm->mmu_lock);
>  
>  	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>  
>  		if (!kvm_s2_mmu_valid(mmu))
>  			continue;
> @@ -767,7 +803,7 @@ struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu)
>  	 *   if S2 translation is disabled.
>  	 */
>  	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>  
>  		if (!kvm_s2_mmu_valid(mmu))
>  			continue;
> @@ -806,7 +842,7 @@ static struct kvm_s2_mmu *get_s2_mmu_nested(struct kvm_vcpu *vcpu)
>  	for (i = kvm->arch.nested_mmus_next;
>  	     i < (kvm->arch.nested_mmus_size + kvm->arch.nested_mmus_next);
>  	     i++) {
> -		s2_mmu = &kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
> +		s2_mmu = kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
>  
>  		if (atomic_read(&s2_mmu->refcnt) == 0)
>  			break;
> @@ -1223,7 +1259,7 @@ void kvm_nested_s2_wp(struct kvm *kvm)
>  		return;
>  
>  	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>  
>  		if (kvm_s2_mmu_valid(mmu))
>  			kvm_stage2_wp_range(mmu, 0, kvm_phys_size(mmu));
> @@ -1242,7 +1278,7 @@ void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
>  		return;
>  
>  	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>  
>  		if (kvm_s2_mmu_valid(mmu))
>  			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
> @@ -1261,7 +1297,7 @@ void kvm_nested_s2_flush(struct kvm *kvm)
>  		return;
>  
>  	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>  
>  		if (kvm_s2_mmu_valid(mmu))
>  			kvm_stage2_flush_range(mmu, 0, kvm_phys_size(mmu));
> @@ -1273,10 +1309,10 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
>  	int i;
>  
>  	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
>  
>  		if (!WARN_ON(atomic_read(&mmu->refcnt)))
> -			kvm_free_stage2_pgd(mmu);
> +			free_nested_s2_mmu(mmu);
>  	}
>  	kvfree(kvm->arch.nested_mmus);
>  	kvm->arch.nested_mmus = NULL;
> 
> base-commit: 38436106b2f5ceb55950a7098c1a5804de2bde62
> -- 
> 2.39.5 (Apple Git-154)
