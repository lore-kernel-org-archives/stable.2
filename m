Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8D346FA1;
	Mon,  8 Jun 2026 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936425; cv=none; b=W6Wg+Ytvx0W4YsdKXlc3kg9XyQwwP2lmpFq0W+nNR3OtdDEgT/YPuycrhxy9FO+RaYWGi8Hgi6MNk7PvDJLjXS433HZCk2P8pCJYqt6XATo/uKpaYMgRA64iG82escNChXrhRGBbfnHUCVcxB4ATwx6jk4Ct9ZGutaZYz+yx0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936425; c=relaxed/simple;
	bh=dbuWpgijrhwiHDsIsbjpvKv+/uhVxdSwAyfo5gJi1kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4M3IiXXjqlnxazeVH9guX9MtKwOn0vWuul+s36SMzT8lqAkpOrgKyUcReFmvMtk2yp8X7N98YffQ6hwTMlHbVHfgA0+ndCZuWKYIvFfuzVts1+1Xt5C3gs2c7iP6IGQD+Ps827pjYnl+jWNKmVs7ylXYfk4DsVqB8QCtl5nrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk9Z4Yoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk9Z4Yoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6411B1F00893;
	Mon,  8 Jun 2026 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780936424;
	bh=IvBqSXhSd0+ciY4t6uSyUxq+YGf55pIi3P3ho2un0FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lk9Z4YocwsJ6/Lori8Zu06XkPFHAr+wuediCAZhdXunEpVhN+HkMFp+DF2an6tK+k
	 5QrEervLDBN/4F+qxGk3DXJ8jb5EG8wQjjrz7GPkkXDar1LikvH6jMLoir8x4WKwjB
	 9GBInAU4XfCeebAYA1GI1/CeTDWOa9REaCp3JojCjFfeix1yRIgCn2f1FJ6fBtvAPo
	 bcAIlnoHxlyraPq4iPG241VyQat3Udacw2BG+xRjfCM8nqlyK7e+Yy5WigpLhNhSC3
	 RG9OpQzgWv5L9Hgkz3cQZS7UTO7FN4o2E0xW5iZzS8pFS5d102JEdzurf51Zo2lvlO
	 s3fbvfeqbMPNw==
Date: Mon, 8 Jun 2026 09:33:43 -0700
From: Oliver Upton <oupton@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, Hyunwoo Kim <imv4bel@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Add kvm_for_each_vncr_tlb() helper
Message-ID: <aibu532apl5w0lXU@kernel.org>
References: <20260607175745.297793-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607175745.297793-1-maz@kernel.org>

Hey Marc,

Especially since this is a stable-worthy fix, it might be worth calling
out the bug in the shortlog, e.g.

  KVM: arm64: nv: Avoid dereferencing NULL VNCR pseudo-TLB

On Sun, Jun 07, 2026 at 06:57:45PM +0100, Marc Zyngier wrote:
> VNCR TLB invalidation occurs from MMU notifiers or TLBI instructions,
> and either can race against a vcpu not being onlined yet (no pseudo-TLB
> allocated). Similarly, the TLB might be invalid, and the invalidation
> should be skipped in this case.
> 
> Both kvm_invalidate_vncr_ipa() and kvm_invalidate_vncr_va() are
> expected to perform the same checks, except that the latter doesn't
> check for the allocation and blindly dereferences the pointer.
> 
> Solve this by introducing a new iterator built on top of the usual
> kvm_for_each_vcpu() that checks for both of the above conditions,
> and convert the two users to it.
> 
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/aiUvSbrWndQeUPc8@v4bel
> Fixes: 4ffa72ad8f37 ("KVM: arm64: nv: Add S1 TLB invalidation primitive for VNCR_EL2")
> Cc: stable@vger.kernel.org

Looks good

Reviewed-by: Oliver Upton <oupton@kernel.org>

Thanks,
Oliver

> ---
>  arch/arm64/kvm/nested.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index f8d3f3a723282..690b8e8564166 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -908,9 +908,21 @@ static void invalidate_vncr(struct vncr_tlb *vt)
>  		clear_fixmap(vncr_fixmap(vt->cpu));
>  }
>  
> +/*
> + * VNCR TLB invalidation occurs from MMU notifiers or TLBI instructions, and
> + * either can race against a vcpu not being onlined yet (no pseudo-TLB
> + * allocated). Similarly, the TLB might be invalid.  Skip those, as they
> + * obviously don't participate in the invalidation at this stage.
> + */
> +#define kvm_for_each_vncr_tlb(idx, vcpup, tlbp, kvm)	\
> +	kvm_for_each_vcpu(idx, vcpup, kvm)		\
> +		if (((tlbp) = vcpup->arch.vncr_tlb) &&	\
> +		    (tlbp)->valid)
> +
>  static void kvm_invalidate_vncr_ipa(struct kvm *kvm, u64 start, u64 end)
>  {
>  	struct kvm_vcpu *vcpu;
> +	struct vncr_tlb *vt;
>  	unsigned long i;
>  
>  	lockdep_assert_held_write(&kvm->mmu_lock);
> @@ -918,24 +930,9 @@ static void kvm_invalidate_vncr_ipa(struct kvm *kvm, u64 start, u64 end)
>  	if (!kvm_has_feat(kvm, ID_AA64MMFR4_EL1, NV_frac, NV2_ONLY))
>  		return;
>  
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
> +	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm) {
>  		u64 ipa_start, ipa_end, ipa_size;
>  
> -		/*
> -		 * Careful here: We end-up here from an MMU notifier,
> -		 * and this can race against a vcpu not being onlined
> -		 * yet, without the pseudo-TLB being allocated.
> -		 *
> -		 * Skip those, as they obviously don't participate in
> -		 * the invalidation at this stage.
> -		 */
> -		if (!vt)
> -			continue;
> -
> -		if (!vt->valid)
> -			continue;
> -
>  		ipa_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift,
>  							    vt->wr.level));
>  		ipa_start = vt->wr.pa & ~(ipa_size - 1);
> @@ -965,17 +962,14 @@ static void invalidate_vncr_va(struct kvm *kvm,
>  			       struct s1e2_tlbi_scope *scope)
>  {
>  	struct kvm_vcpu *vcpu;
> +	struct vncr_tlb *vt;
>  	unsigned long i;
>  
>  	lockdep_assert_held_write(&kvm->mmu_lock);
>  
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
> +	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm) {
>  		u64 va_start, va_end, va_size;
>  
> -		if (!vt->valid)
> -			continue;
> -
>  		va_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift,
>  							   vt->wr.level));
>  		va_start = vt->gva & ~(va_size - 1);
> -- 
> 2.47.3
> 
