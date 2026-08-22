Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3D3563CD;
	Sat, 22 Aug 2026 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787408804; cv=none; b=QKRPy1hO9yo5qPscUHuP4YyXXg7sZIeafQfDLOzb34CLEnzU55MdGXoSmQ0T94kQHGrVQzWywE29J/YsDkXSy8cVl8s7g4RYD9CjvIkOeDfNycpWdWrp9D9vuFNDtDE9P/4NJOrokw4EsmlsZ2xLksFMAnr9j7FPCIQYu+GXTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787408804; c=relaxed/simple;
	bh=js0FkFkqiKp8QwqOs2NW86sBkl9Up9ciGXAN21SCalw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTEwKLCGvFiigkJ/L3Ai5csiOCizmZaOgIITdKdvmiMTEgKcwwMufqtMIMPSXAPzTvWweZutqGVUQg+11VNP8AhmpqCOUN5Eke/Qxer9EyRIBBcv7R8IneT2324NBBrDL1pdBBP4amwDvidwvZ+hMe91Qi80CtfDkb/JGYFxgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuKRZhu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuKRZhu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB771F000E9;
	Sat, 22 Aug 2026 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787408793;
	bh=EZ6C0Isq4P3g9HCeDb2DCK4xJJyRP1XpM/O6f7kjrf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FuKRZhu3u7sHEKjTJsJSyY192beLDzTRq2ZCTupKepDO7+Pqmz67aqtuhRIdme8fX
	 goDZEVsdTyzm1PRecpMxydmcOr7Z1k3d8jda7PS/XtOROWbYelZe26m5xwsWl+TMbJ
	 1bbMfV3KKRpJJQzMz2YOpAyXXRKepZ2IEL6VS3G7eEYs11d/jRE4gBp+PhkqSewbuX
	 YAsQz1oFUjtgXpkzkVflCU/JZUVNw6Qq3NVCdlIDA7sE8dwYKOzKB13NVaoI3zigVt
	 qgjhwIXUUT/xU76BkjdMLv+zWx3aZLSeXoXmP8EOWL+Q1r3Ie4GHs7wirI4CC+fNi5
	 WzYmQYmX+3dLg==
Date: Sat, 22 Aug 2026 15:26:25 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jintack Lim <jintack.lim@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: arm64: nv: Fix null ptr deref in
 kvm_nested_s2_unmap() on S2 teardown
Message-ID: <aomxdiB1gXnUZAz5@gremlin>
References: <20260812-kvm-arm-nested-virt-fix-v1-0-4ad883f1b6a5@kernel.org>
 <20260812-kvm-arm-nested-virt-fix-v1-2-4ad883f1b6a5@kernel.org>
 <86y0dy4nm3.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86y0dy4nm3.wl-maz@kernel.org>

On Sat, Aug 22, 2026 at 08:32:04AM +0100, Marc Zyngier wrote:
> On Wed, 12 Aug 2026 14:31:21 +0100,
> "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> >
> > Commit 7270cc9157f4 ("KVM: arm64: nv: Handle VNCR_EL2 invalidation from MMU
> > notifiers") introduced VNCR_EL2 invalidation in kvm_nested_s2_unmap().
> >
> > However at the point of this being performed concurrent stage 2 teardown of
> > a nested guest can cause kvm->arch.mmu.pgt to be set to NULL.
> >
> > This happens in kvm_flush_shadow_all() -> kvm_arch_flush_shadow_all() ->
> > kvm_free_stage2_pgd() and is performed under the kvm->mmu_lock.
> >
> > Commit ec14c272408a ("KVM: arm64: nv: Unmap/flush shadow stage 2 page
> > tables") introduced the teardown of the entire nested MMU range, which then
> > invokes stage2_apply_range() with resched=true:
> >
> > mmu_notifier_invalidate_range_start()
> >   -> ... -> kvm_mmu_notifier_invalidate_range_start()
> >     -> kvm_mmu_unmap_gfn_range()
> >       -> kvm_unmap_gfn_range()
> >         -> kvm_nested_s2_unmap()
> >           -> kvm_stage2_unmap_range()
> >             -> __unmap_stage2_range()
> >                 -> stage2_apply_range()
> >
> > This means that stage2_apply_range() can drop the kvm->mmu_lock and thus
> > concurrent progress can be made in lockstep with
> > kvm_arch_flush_shadow_all().
> >
> > If kvm_arch_flush_shadow_all() advances ahead of stage2_apply_range() and
> > completes its operation it guarantees a NULL pointer deref.
> >
> > Since kvm_free_stage2_pgd() is performed under the kvm->mmu_lock this will
> > either be observed NULL or not and serialised against
> > kvm_free_stage2_pgd().
> >
> > Resolve the issue by explicitly checking for a NULL value. Since this
> > shouldn't be possible if blocking is not allowed, raise a warning if it is
> > ever NULL in this case.
> >
> > Fixes: 7270cc9157f4 ("KVM: arm64: nv: Handle VNCR_EL2 invalidation from MMU notifiers")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  arch/arm64/kvm/nested.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> > index 17123f0b6dab..9fc0b1696dcb 100644
> > --- a/arch/arm64/kvm/nested.c
> > +++ b/arch/arm64/kvm/nested.c
> > @@ -1295,7 +1295,11 @@ void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
> >  			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
> >  	}
> >
> > -	kvm_invalidate_vncr_ipa(kvm, 0, BIT(kvm->arch.mmu.pgt->ia_bits));
> > +	/* NULL pgt should only be possible if raced when mmu_lock dropped. */
> > +	if (kvm->arch.mmu.pgt)
> > +		kvm_invalidate_vncr_ipa(kvm, 0, BIT(kvm->arch.mmu.pgt->ia_bits));
> > +	else
> > +		WARN_ON(!may_block);
>
> I don't think the WARN_ON() should be here. We already have one at the
> iterator level, which will fire in the same conditions.

Ack, was an abundance of caution, will take out on respin.

>
> Thanks,
>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

--
Cheers, Lorenzo
