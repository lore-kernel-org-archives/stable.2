Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63463D79E9
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357814; cv=none; b=Dtkwc4LsUTyc6hlYzwIQSUDJNidkQ3edfxAbTsCY3iHzjaVU6ScNkouQILhOWLdbEWDz0inljmlHMoC9Ctpmfc0knpglJonsEPNUI0XX3l8PEmN5H2fRei0yX2uZTn/B8Qm+ZEwe97euXKopM0oWl0p1w/Mj8r29FPlmt7twiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357814; c=relaxed/simple;
	bh=eUe3fw3CfbiK9WiV4zbNsrqE6pO8Ggm9Gyg8b0vVQ1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6CTKsPQoW4TWOed8Jzt7waxTowTR13TXk5KgfQgS4MXXJn45r4ubfEDehyfJG4O6TmGLt7lieCMGeslQ/kJwaybUHSk8RpRKrbMcqp1JueGZc/l+tEK0vBml8AFq0Q5VqfhKeXDii6wfFPK+nbkZmGe8h/ylWzEkS549n0V+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JI7jvzup; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JI7jvzup"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3B28169C;
	Fri, 25 Sep 2026 10:36:48 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C18873F632;
	Fri, 25 Sep 2026 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790357812; bh=eUe3fw3CfbiK9WiV4zbNsrqE6pO8Ggm9Gyg8b0vVQ1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JI7jvzupOdlrIzgE7q2xd3OjO1eLLJFuytdQUiPAB9pq0h31YG4LQGt4/i4hyTmLH
	 FcxfkbMC/A28aM6TXC2vX+hJSv2OCH1J+wpD0r/SQ+bYgMlz1NxjRIMiiiu0ISsFkZ
	 CJOtqy3rV+0jnMB1OjkRWHgBQkdpxr9MD1gcwkmw=
Date: Fri, 25 Sep 2026 18:36:42 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Vincent Donnefort <vdonnefort@google.com>, maz@kernel.org, 
	oupton@kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	kernel-team@android.com, fuad.tabba@linux.dev, qperret@google.com, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1 5/6] KVM: arm64: Use kvm_s2_fault_vma_info in
 gmem_abort()
Message-ID: <am2rfnuwjkglavbtzkt2lk2gclahvca5irrv5me4vppzkotexf@yauajpybhsnm>
References: <20260922130821.1666713-1-vdonnefort@google.com>
 <20260922130821.1666713-6-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922130821.1666713-6-vdonnefort@google.com>

On Tue, Sep 22, 2026 at 02:08:20PM +0100, Vincent Donnefort wrote:
> From: Fuad Tabba <fuad.tabba@linux.dev>
> 
> gmem_abort() maps at s2fd->fault_ipa, which HPFAR_EL2 holds at 4K
> granularity whatever the page size. The generic page-table code aligns
> it, but pkvm_pgtable_stage2_map() looks up existing mappings over
> [addr, addr + size), so on a pKVM host with pages larger than 4K a
> guest_memfd-backed guest that faults past the first 4K of a page can
> find its neighbour's mapping, get -EAGAIN and take the same fault
> forever.
> 
> Take the addresses from kvm_s2_fault_vma_info instead, as
> user_mem_abort() does, and report the gfn kvm_gmem_get_pfn() failed on
> in the memory fault exit. kvm_s2_fault_get_vma_info() itself isn't
> called: a guest_memfd memslot's userspace_addr doesn't need to be
> backed by a VMA.
> 
> Fixes: a7b57e0995927 ("KVM: arm64: Handle guest_memfd-backed guest page faults")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260913175105.A57AC1F000FF@smtp.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> ---
>  arch/arm64/kvm/mmu.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 5aac624b0442..ee0fcca838c1 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1953,11 +1953,9 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>  	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_SHARED;
>  	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
>  	struct kvm_pgtable *pgt = s2fd->vcpu->arch.hw_mmu->pgt;
> -	unsigned long mmu_seq;
> -	struct page *page;
> +	struct kvm_s2_fault_vma_info s2vi = {};

I'd say it's unfortunate this struct's name contains vma :P

>  	struct kvm *kvm = s2fd->vcpu->kvm;
>  	void *memcache = NULL;
> -	kvm_pfn_t pfn;
>  	gfn_t gfn;
>  	int ret;
>  
> @@ -1968,23 +1966,22 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>  			return ret;
>  	}
>  
> -	if (s2fd->nested)
> -		gfn = kvm_s2_trans_output(s2fd->nested) >> PAGE_SHIFT;
> -	else
> -		gfn = s2fd->fault_ipa >> PAGE_SHIFT;
> +	s2vi.vma_pagesize = PAGE_SIZE;
> +	s2vi.gfn = ALIGN_DOWN(s2fd->fault_ipa, s2vi.vma_pagesize) >> PAGE_SHIFT;
> +	gfn = get_canonical_gfn(s2fd, &s2vi);

Perhaps it is worth reserving plain "gfn" for the value we use as the
IA of the (shadow) page table, and name this variable something like
canonical_gfn. Similar to what kvm_s2_fault_map() does.

>  
>  	write_fault = kvm_is_write_fault(s2fd->vcpu);
>  	exec_fault = kvm_vcpu_trap_is_exec_fault(s2fd->vcpu);
>  
>  	VM_WARN_ON_ONCE(write_fault && exec_fault);
>  
> -	mmu_seq = kvm->mmu_invalidate_seq;
> +	s2vi.mmu_seq = kvm->mmu_invalidate_seq;
>  	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
>  	smp_rmb();
>  
> -	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
> +	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &s2vi.pfn, &s2vi.page, NULL);
>  	if (ret) {
> -		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
> +		kvm_prepare_memory_fault_exit(s2fd->vcpu, gfn_to_gpa(gfn), s2vi.vma_pagesize,

Huh, I guess you also fixed a bug here? s2fd->fault_ipa could be the
nested ipa instead of the canonical ipa.

Thanks,
Wei-Lin Chang

>  					      write_fault, exec_fault, false);
>  		return ret;
>  	}
> @@ -2002,7 +1999,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>  		prot = adjust_nested_exec_perms(kvm, s2fd->nested, prot);
>  
>  	kvm_fault_lock(kvm);
> -	if (mmu_invalidate_retry(kvm, mmu_seq)) {
> +	if (mmu_invalidate_retry(kvm, s2vi.mmu_seq)) {
>  		ret = -EAGAIN;
>  		goto out_unlock;
>  	}
> @@ -2013,16 +2010,17 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>  		 * PTE, which will be preserved.
>  		 */
>  		prot &= ~KVM_NV_GUEST_MAP_SZ;
> -		ret = KVM_PGT_FN(kvm_pgtable_stage2_relax_perms)(pgt, s2fd->fault_ipa,
> +		ret = KVM_PGT_FN(kvm_pgtable_stage2_relax_perms)(pgt, gfn_to_gpa(s2vi.gfn),
>  								 prot, flags);
>  	} else {
> -		ret = KVM_PGT_FN(kvm_pgtable_stage2_map)(pgt, s2fd->fault_ipa, PAGE_SIZE,
> -							 __pfn_to_phys(pfn), prot,
> +		ret = KVM_PGT_FN(kvm_pgtable_stage2_map)(pgt, gfn_to_gpa(s2vi.gfn),
> +							 s2vi.vma_pagesize,
> +							 __pfn_to_phys(s2vi.pfn), prot,
>  							 memcache, flags);
>  	}
>  
>  out_unlock:
> -	kvm_release_faultin_page(kvm, page, !!ret, prot & KVM_PGTABLE_PROT_W);
> +	kvm_release_faultin_page(kvm, s2vi.page, !!ret, prot & KVM_PGTABLE_PROT_W);
>  	kvm_fault_unlock(kvm);
>  
>  	if ((prot & KVM_PGTABLE_PROT_W) && !ret)
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
