Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E73264DD;
	Thu, 13 Aug 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634196; cv=none; b=K0BZdHKcX8j1hyiE3w/8QRcXdSSzerDueTCWzdvFDAEWji+pfuheQHCft3Xao47l4C71gm86jGe90GaOAptBzInwJueSefNY0a62SPVKLp5uYBuE/0ZQ5avrpHrubkpS7ZxDPu3gHTPBj3rkmM9UR85BXARlwgaxq/4cDrPJmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634196; c=relaxed/simple;
	bh=QmcHUXxZn/WREDxa5YiVP/mbCZRvfj1uwoB3+wqQ5z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8YitnmPVLDV4DaK1n675LhKcVN1tWsK/eJJ3SQkOcsESKtwLOG3xRNzSd6dPVq4kGEwAfYMWqHX6V5oM6fehIwQSZob3arXI7fyKmlJe1JbVC9ET9XpxDKr7GA8GfVo/kj6FCp438/YBklaAxRa1011xzsMaXXRvQNHsO2L/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qirkgpb2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qirkgpb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499931F000E9;
	Thu, 13 Aug 2026 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786634194;
	bh=W0lMzYnjz5fw9H0XA6YeKyIueK8wflCLPk3st2klDDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qirkgpb27JCfuQCAyjUT16RnAV0o9CsPspRxFy8xhk4l1xe85bBlkq5b3w4AegFOY
	 zyqs2TH4cSQg9CaPvMuU1Dyz7cUX3r2QvKGB9ngJPDP0MCj0EB0Os3f3lDxlFeETsN
	 VQp4FZLbREM5tY+qwIY2GMdn4Hn/yd14SaW77609D3h6N0VCtBEdFwHjebEsaxK9/f
	 rxf9AQQ0NuSy0sF07+799OHfJiyD8KITCYfXf7Rn22YQ+TLJGihC44iuf8jh4/EqKf
	 Zm2wwZB+G2ri9GiHH88hV3+yLkvUaQthqHlDqppDaCC93uIHjOEBClsfuk13/SH4rJ
	 JYYGOsmRCP2cA==
Date: Thu, 13 Aug 2026 16:16:14 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Shen Yongchao <grayhat@foxmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: nv: Fix life cycle of the nested_mmus array
Message-ID: <an3e_kikHdHDVcdm@lucifer>
References: <20260811122057.754772-1-maz@kernel.org>
 <anx6Wa5i1M2hidVK@gremlin>
 <86zeyqys55.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86zeyqys55.wl-maz@kernel.org>

On Thu, Aug 13, 2026 at 04:08:54PM +0100, Marc Zyngier wrote:
> On Wed, 12 Aug 2026 15:05:21 +0100,
> "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> >
> > On Tue, Aug 11, 2026 at 01:20:57PM +0100, Marc Zyngier wrote:
> > > The nested_mmus array holds the shadow page tables that are used when
> > > a guest is running a nested context. These structures are allocated on
> > > VCPU_INIT for whole guest, which implies that they may have to be
> > > relocated as the array grows.
> > >
> > > Should a VCPU_INIT occur whilst a vcpu is actively running an L2 and
> > > that the allocation requires relocation, that vcpu will still be
> > > running with a pointer to the previous structure, which will have been
> > > freed.
> > >
> > > Fix this by turning the array of structures to an array of pointers,
> > > which is now allocated at VM creation, sized to the absolute maximum
> > > that KVM can handle.
> > >
> > > In turn, each VCPU_INIT contributes S2_MMU_PER_VCPU to the pool. No
> > > reallocation is ever performed, and the life cycle of each object is
> > > much clearer:
> > >
> > > - the nested_mmus array is allocated in kvm_init_nested(), and freed
> > >   in kvm_arch_destroy_vm()
> > >
> > > - s2_mmu structures are allocated in kvm_vcpu_init_nested(), and freed
> > >   on kvm_arch_flush_shadow_all()
> > >
> > > Finally, the freeing of vcpu->arch.vncr_array is made consistent
> > > rather than being done on some failure paths, but not others.
> > >
> > > Fixes: 4f128f8e1aaa ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
> > > Reported-by: Shen Yongchao <grayhat@foxmail.com>
> > > Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
> > > Suggested-by: Karl Mehltretter <kmehltretter@gmail.com>
> > > Link: https://lore.kernel.org/r/20260803224405.41468-1-kmehltretter@gmail.com
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> >
> > This addresses the same kind of stuff I had a couple of patches in my
> > series for :>)
> >
> > I think there are still some problems with it, see below.
> >
> > Also I attach my original patch for the UAF below in case it's useful! I
> > had another for the init stuff, will reply with that separately also :)
> >
> > > Cc: stable@vger.kernel.org
> > > ---
> > >
> > > Notes:
> > >     Sending this as a first class patch, since the other approaches were even
> > >     uglier than this one. I'm still displeased with kvm_arch_flush_shadow_all(),
> > >     but that's a step in the direction of tightening it:
> >
>
> [...]
>
> > > @@ -1316,16 +1308,15 @@ void kvm_nested_s2_flush(struct kvm *kvm)
> > >
> > >  void kvm_arch_flush_shadow_all(struct kvm *kvm)
> > >  {
> > > -	int i;
> > > -
> > > -	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> > > -		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> > > +	for (int i = kvm->arch.nested_mmus_size - 1; i >= 0; i--) {
> > > +		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
> > >
> > >  		if (!WARN_ON(atomic_read(&mmu->refcnt)))
> > >  			kvm_free_stage2_pgd(mmu);
> > > +
> > > +		if ((i % S2_MMU_PER_VCPU) == 0)
> > > +			kvfree(mmu);
> >
> > Hmm I think that this can still be referenced if a concurrent e.g. mmu notifier
> > thread doing S2 nested teardown is referencing it?
>
> Yes, but that's a separate fix, as per the notes above.

OK fair enough, missed that!

>
> > Maybe defer this to kvm_arch_destroy_vm() also?
>
> Sort off. I think we need two separate things here:
>
> - In this particular callback, keep the tearing down of the shadow
>   S2s. They need to be emptied (after all, that's what the callback is
>   about), but the s2_mmu structures still need to exist, just as the
>   one that is embedded in the kvm structure doesn't disappear from
>   under our feet.

Yes that makes sense.

>
> - in kvm_arch_destroy_vm(), free the suckers, because that's the only
>   safe point to do so.

Yes, absolutely.

>
> >
> > >  	}
> > > -	kvfree(kvm->arch.nested_mmus);
> > > -	kvm->arch.nested_mmus = NULL;
> > >  	kvm->arch.nested_mmus_size = 0;
> >
> > This is racey (concurrent S2 teardown again) and should be
> > done with the kvm->mmu_lock held I think.
> >
> > In my original patch (see below) I simply did:
> >
> > 	/* We may be raced by concurrent S2 teardown. */
> > 	scoped_guard(write_lock, &kvm->mmu_lock)
> > 		kvm->arch.nested_mmus_size = 0;
>
> As explained above, I don't think this is the place to free the S2
> MMUs at all.

Ah I guess you would need to keep the nested_mmus_size around anyway if you
want to individually free the mmus, makes sense.

>
> I'll prepare some additional fixes for that.

Cool, feel free to cc- me on those would be happy to help with review +
this is all helpful for learning more about the subsystem :)

>
> Thanks,
>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

--
Cheers, Lorenzo
