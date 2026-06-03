Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7B4DC52E;
	Wed,  3 Jun 2026 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527972; cv=none; b=LUuDC8DJykVwF7glJegKi5efaORIFIUSwIxlNWGEm8qS4r9VUFAJy41s5OKL8YIw3fRzt4gIau05ylPR9qqsHMVSFewh75WFJRw33yeuyqelwkn4Fb9zFMDnoiHt7XlgT1xL8Bq10TF0FIQmMaKjzrkrrQwJw0zSQvkxd2V9+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527972; c=relaxed/simple;
	bh=IL96f8vaZHi4J1IGkcBxcGT9Q3agVadrOgTM1Ho7n0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PARuawSs/ww7kM0WLAVnjG7MU7GvVZU4ZNZDAuBWt6m4LVKXUvOXKiTcFcg+qZ3fA+qkVj/3tyH4lZ8DcEkYj7YGGWFp2xos4izTBgznsLcUZVIY5mMCIZgcuGy2QY4Yc+NZ8izkatwv36HDdA1+X7RxoaVEj1iHJynw9LeHCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXa1h3zQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXa1h3zQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889A21F00893;
	Wed,  3 Jun 2026 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780527970;
	bh=as6FH2hv4swdsW6FTLIY1Q97Yv9YKNX/KNr2I9/MfPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eXa1h3zQ9LSkU15VI0BOq3tm/UyscMZ5M+eHZXBH7u9FlryjQblSU7Sy7y3qpTC0W
	 la14cevey0PblSWHhrIU0wV6gYZUQNFhDkccKi+QFj+YFV7/ergxdxeol6jUXG0bMP
	 2FOeQ0cwGrfSL8pd0wq/SS3G/yAZ4WL11GgSsp5Ri71hsluDfuQVxxw5doMKGHiyvY
	 CT7mqs7YkDtwi+8P4csdRrjbuljkDrA2yAGC2qG7tJskgVoYjIZNTp1tEnFZUWw2GQ
	 Sd31u3/v8qJ7Stn6ueGkf2wP+sAaPBjVjm1GtCdistJv1sZnbR7zuW9IYCsmYIAthi
	 qydhv8Xe797Zw==
Date: Wed, 3 Jun 2026 16:06:09 -0700
From: Oliver Upton <oupton@kernel.org>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: nv: Fix handling of XN[0] when
 !FEAT_XNX
Message-ID: <aiCzYWoSmKIRpMre@kernel.org>
References: <20260602165901.52800-1-oupton@kernel.org>
 <20260602165901.52800-2-oupton@kernel.org>
 <zzprmfdgkd4sfxjuvbj65ssmdbcxvb2lrdv7lgywysuthx6t4i@ffehlydwbwy7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zzprmfdgkd4sfxjuvbj65ssmdbcxvb2lrdv7lgywysuthx6t4i@ffehlydwbwy7>

Hey Wei-Lin,

Thanks for the review.

On Wed, Jun 03, 2026 at 11:57:20PM +0100, Wei-Lin Chang wrote:
> Hi Oliver,
> 
> On Tue, Jun 02, 2026 at 09:59:00AM -0700, Oliver Upton wrote:
> > XN has already been extracted from its bitfield position so using
> > FIELD_PREP() on the mask that clears XN[0] is completely broken, having
> > the effect of unconditionally granting execute permissions...
> > 
> > Fix the obvious mistake by manipulating the right bit.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: d93febe2ed2e ("KVM: arm64: nv: Forward FEAT_XNX permissions to the shadow stage-2")
> > Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
> > Signed-off-by: Oliver Upton <oupton@kernel.org>
> > ---
> >  arch/arm64/include/asm/kvm_nested.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> > index 091544e6af44..a0eb83319c2e 100644
> > --- a/arch/arm64/include/asm/kvm_nested.h
> > +++ b/arch/arm64/include/asm/kvm_nested.h
> > @@ -131,7 +131,7 @@ static inline bool kvm_s2_trans_exec_el0(struct kvm *kvm, struct kvm_s2_trans *t
> >  	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
> >  
> >  	if (!kvm_has_xnx(kvm))
> > -		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
> > +		xn &= 0b10;
> >  
> >  	switch (xn) {
> >  	case 0b00:
> > @@ -147,7 +147,7 @@ static inline bool kvm_s2_trans_exec_el1(struct kvm *kvm, struct kvm_s2_trans *t
> >  	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
> >  
> >  	if (!kvm_has_xnx(kvm))
> > -		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
> > +		xn &= 0b10;
> >  
> 
> Now that the other patch brings up kvm_pgtable_stage2_pte_prot(), what
> do you think about also using that here? It can save a little bit of
> duplicated decode logic.
> 
> Other than this being in a header and we'll have to move the code
> around for this to work, I'm curious are there any other issues with
> this idea?

No issues with your suggestion but I plan on nuking the kvm_s2_trans*()
accessors soon :)

Ultimately kvm_s2_trans should just contain pre-computed permissions,
which matters more when dealing with descriptor fields that require the
MMU context to make sense of (like DBM). On top of that, getters for
obviously named fields isn't adding a whole lot.

Any concerns with leaving as-is for now?

-- 
Thanks,
Oliver
