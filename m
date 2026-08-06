Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD534423E9B;
	Thu,  6 Aug 2026 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053259; cv=none; b=S7nqOoFVr4a5sOEO4U3QzAwIOEs6/UNJONSm00OIcgfROUNPvjATCHoap/Hpwthv1Hvnh4Sf9bTT9HExRQtaw1aFhYMnW1YicQmxN1gWXs7GjjHMl/zIBH9jz5c5k3WFkFe/90C1VZNqt+Ya+oDs7qn8FSNZuW6WXXD/wPLMmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053259; c=relaxed/simple;
	bh=OBhp8bb+qL85UhoATxzxbQJNiuhv+HIrFounOJ7gTx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU0KCoubObskI7o174rxpY/Pf0cd7FYdj7yvmtNAkrx+dZyQoD2Gu8j+hodHagd3Wlc++XgzQcxTeDOWOm2+S+p4dVQNHqTEcl5fQCA/Z3X71pQtFDK3X7NYGshXCx7Si8vy6SmrpTfT3KGNh2mt9xQB+KAfTg3Bqaz/20zKOO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bKY13eBR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bKY13eBR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 177B7153B;
	Thu,  6 Aug 2026 14:54:12 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 608D53F632;
	Thu,  6 Aug 2026 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786053256; bh=OBhp8bb+qL85UhoATxzxbQJNiuhv+HIrFounOJ7gTx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKY13eBRtkqyCtj2CSBdQuFzfC+3x5lVjWPuIs6qS6U5e6YREM2ek5wB6Kvsql50U
	 zxUSRGsVJfouTJv7BoS8HdFs9teQ1KTMSAVdboIfr6pyt3veTAr9LLoe2mKoKDrDU4
	 L7KzvqLPYfgDNa1iV7Z8R/NQkKardxRUaecNbo5A=
Date: Thu, 6 Aug 2026 22:54:03 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, grayhat@foxmail.com
Subject: Re: [PATCH v3] KVM: arm64: nv: Keep the shadow S2 MMUs at fixed
 addresses
Message-ID: <d5svhw3jkjnkucohx2ntwhphemgbtfcmjt2zoyyw6svz56zfrh@z2ziydov5ras>
References: <20260806192451.10169-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806192451.10169-1-kmehltretter@gmail.com>

On Thu, Aug 06, 2026 at 09:24:51PM +0200, Karl Mehltretter wrote:
> kvm_vcpu_init_nested() can grow kvm->arch.nested_mmus while initialising
> another vCPU: it copies the MMUs, publishes the new allocation, and frees
> the old one. It updates pgt->mmu back-pointers, but not hw_mmu, leaving
> already-running vCPUs with pointers to freed memory. hw_mmu cannot be
> fixed up the same way: a running vCPU reads it without holding mmu_lock.
> The nested S2 ptdump file's debugfs private data is also affected, as it
> points into the freed array.
> 
> KASAN reports an access through the stale hw_mmu pointer as a
> slab-use-after-free in kvm_handle_guest_abort().
> 
> Turn nested_mmus into a pointer table allocated once for the maximum
> number of vCPUs during VM creation. Allocate the MMUs separately as
> vCPUs are initialised and append their pointers to that table. The MMU
> objects never move, so cached hw_mmu pointers, pgt->mmu back-pointers,
> and ptdump private data remain valid.
> 
> Two issues in the old implementation are also fixed:
> 
> - The old failure path passed uninitialised MMUs to
>   kvm_free_stage2_pgd(), which derives kvm from mmu->arch and can
>   therefore dereference an invalid pointer. Only call
>   kvm_free_stage2_pgd() for initialised MMUs.
> - Previously, initialisation of the new MMUs was not ordered before
>   publication of nested_mmus_size. Fix this by taking mmu_lock when
>   increasing nested_mmus_size.
> 
> Fixes: 4f128f8e1aaa ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
> Cc: stable@vger.kernel.org
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

[...]

>  int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> -	struct kvm_s2_mmu *tmp;
> -	int num_mmus, ret = 0;
> +	struct kvm_s2_mmu *mmu;
> +	int num_mmus, ret = 0, i;
>  
>  	if (test_bit(KVM_ARM_VCPU_HAS_EL2_E2H0, kvm->arch.vcpu_features) &&
>  	    !cpus_have_final_cap(ARM64_HAS_HCR_NV1))
> @@ -91,42 +104,38 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
>  	 */
>  	num_mmus = atomic_read(&kvm->online_vcpus) * S2_MMU_PER_VCPU;
>  
> -	if (num_mmus > kvm->arch.nested_mmus_size) {
> -		tmp = kvcalloc(num_mmus, sizeof(*tmp), GFP_KERNEL_ACCOUNT);
> -		if (!tmp)
> -			return -ENOMEM;
> -
> -		write_lock(&kvm->mmu_lock);
> +	if (num_mmus <= kvm->arch.nested_mmus_size)
> +		return 0;
>  
> -		if (kvm->arch.nested_mmus_size) {
> -			memcpy(tmp, kvm->arch.nested_mmus,
> -			       size_mul(sizeof(*tmp), kvm->arch.nested_mmus_size));
> +	lockdep_assert_held(&kvm->arch.config_lock);
>  
> -			for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
> -				tmp[i].pgt->mmu = &tmp[i];
> +	for (i = 0; i < S2_MMU_PER_VCPU; i++) {
> +		mmu = kzalloc_obj(*mmu, GFP_KERNEL_ACCOUNT);
> +		if (!mmu) {
> +			ret = -ENOMEM;
> +			break;
>  		}
>  
> -		swap(kvm->arch.nested_mmus, tmp);
> -
> -		write_unlock(&kvm->mmu_lock);
> +		ret = init_nested_s2_mmu(kvm, mmu);
> +		if (ret) {
> +			kfree(mmu);
> +			free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
> +			vcpu->arch.ctxt.vncr_array = NULL;
> +			break;
> +		}
>  
> -		kvfree(tmp);
> +		kvm->arch.nested_mmus[kvm->arch.nested_mmus_size + i] = mmu;
>  	}
>  
> -	for (int i = kvm->arch.nested_mmus_size; !ret && i < num_mmus; i++)
> -		ret = init_nested_s2_mmu(kvm, &kvm->arch.nested_mmus[i]);
> -
>  	if (ret) {
> -		for (int i = kvm->arch.nested_mmus_size; i < num_mmus; i++)
> -			kvm_free_stage2_pgd(&kvm->arch.nested_mmus[i]);
> -
> -		free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
> -		vcpu->arch.ctxt.vncr_array = NULL;
> +		while (i--)
> +			free_nested_s2_mmu(kvm->arch.nested_mmus[kvm->arch.nested_mmus_size + i]);
>  
>  		return ret;
>  	}
>  
> -	kvm->arch.nested_mmus_size = num_mmus;
> +	guard(write_lock)(&kvm->mmu_lock);
> +	kvm->arch.nested_mmus_size += S2_MMU_PER_VCPU;
>  
>  	return 0;
>  }

Hey sorry for nitpicking once more, I actually like v2 more, as this
version splits the error handling to two places. Marc's implementation
[1] is also good, but that requires a twist in kvm_arch_flush_shadow_all().
So I'd personally go with v2 (+my suggestions for it :)), but also fine if
others have other opinions.

I also think the comment in kvm_vcpu_init_nested() is worth adjusting
slightly, too.

Thanks,
Wei-Lin Chang

[1]: https://lore.kernel.org/kvmarm/86mrv2arf2.wl-maz@kernel.org/

[...]

> @@ -1273,10 +1282,10 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
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
> -- 
> 2.39.5 (Apple Git-154)
> 
