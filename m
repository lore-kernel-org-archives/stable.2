Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B043B477E4C
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576666; cv=none; b=bi1QsU4xnEbp4kms/RcssDsSB9oIwdzPBLZ0zj9OwCc3b8WN9ahPGEmNDA6UnqFEA0DuXAFsx7g60MCLw9d+thcdtT+JNzUWu8LT4T7HupsJCABynJS3tLbOVHuC4siKmGySh/URguXkwa4mW4+DF1RkEWkj9juqoCbKuuxUCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576666; c=relaxed/simple;
	bh=OLXEt5OdYDqmqIFWkc7g+qGatoVE1nQg/rQWaLcMQGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X73XOL/v/iZAHow0j7fNo6ax6i6UzMbWv0jo+5SRz1FI+UbT8lOnaOQ4QCaybgLhJ/IEMl8N6kf3Vt4xfnnhmH8bt4h6uz0npA8zHSTCdwVAEOK+uMi0zUjjkmpXsiMb64hSoWojTjLtaW6mxYmwoJSPvVGflyH+qhGLzlem+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sX1iF088; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sX1iF088"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA8BF1570;
	Thu,  4 Jun 2026 05:37:35 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0B693F7D8;
	Thu,  4 Jun 2026 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780576660; bh=OLXEt5OdYDqmqIFWkc7g+qGatoVE1nQg/rQWaLcMQGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sX1iF088rZLldCYYKpJvWYqmQHTkJEP+JmwxVAF6k/SUxSjWqdZmaVojJufze24oZ
	 aDrVKF0zurbhmTZqpfRnlHXRi2QEE1ZRYQBluukz7+7sDqkw3EHCwBIyKHb2AiHzxF
	 8a/CH6u+vpBRjavgKbeJTo9WOKCrEa+Nmix1+Dcg=
Date: Thu, 4 Jun 2026 13:37:32 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: nv: Fix handling of XN[0] when
 !FEAT_XNX
Message-ID: <xbkllyg55nyobj7367wdgbznxtdacdajdkqnoli2dutpj6wvvq@ksfdfkflfocw>
References: <20260602165901.52800-1-oupton@kernel.org>
 <20260602165901.52800-2-oupton@kernel.org>
 <zzprmfdgkd4sfxjuvbj65ssmdbcxvb2lrdv7lgywysuthx6t4i@ffehlydwbwy7>
 <aiCzYWoSmKIRpMre@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiCzYWoSmKIRpMre@kernel.org>

On Wed, Jun 03, 2026 at 04:06:09PM -0700, Oliver Upton wrote:
> Hey Wei-Lin,
> 
> Thanks for the review.
> 
> On Wed, Jun 03, 2026 at 11:57:20PM +0100, Wei-Lin Chang wrote:
> > Hi Oliver,
> > 
> > On Tue, Jun 02, 2026 at 09:59:00AM -0700, Oliver Upton wrote:
> > > XN has already been extracted from its bitfield position so using
> > > FIELD_PREP() on the mask that clears XN[0] is completely broken, having
> > > the effect of unconditionally granting execute permissions...
> > > 
> > > Fix the obvious mistake by manipulating the right bit.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: d93febe2ed2e ("KVM: arm64: nv: Forward FEAT_XNX permissions to the shadow stage-2")
> > > Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
> > > Signed-off-by: Oliver Upton <oupton@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/kvm_nested.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> > > index 091544e6af44..a0eb83319c2e 100644
> > > --- a/arch/arm64/include/asm/kvm_nested.h
> > > +++ b/arch/arm64/include/asm/kvm_nested.h
> > > @@ -131,7 +131,7 @@ static inline bool kvm_s2_trans_exec_el0(struct kvm *kvm, struct kvm_s2_trans *t
> > >  	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
> > >  
> > >  	if (!kvm_has_xnx(kvm))
> > > -		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
> > > +		xn &= 0b10;
> > >  
> > >  	switch (xn) {
> > >  	case 0b00:
> > > @@ -147,7 +147,7 @@ static inline bool kvm_s2_trans_exec_el1(struct kvm *kvm, struct kvm_s2_trans *t
> > >  	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
> > >  
> > >  	if (!kvm_has_xnx(kvm))
> > > -		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
> > > +		xn &= 0b10;
> > >  
> > 
> > Now that the other patch brings up kvm_pgtable_stage2_pte_prot(), what
> > do you think about also using that here? It can save a little bit of
> > duplicated decode logic.
> > 
> > Other than this being in a header and we'll have to move the code
> > around for this to work, I'm curious are there any other issues with
> > this idea?
> 
> No issues with your suggestion but I plan on nuking the kvm_s2_trans*()
> accessors soon :)

Ah, cool cool.

> 
> Ultimately kvm_s2_trans should just contain pre-computed permissions,
> which matters more when dealing with descriptor fields that require the
> MMU context to make sense of (like DBM). On top of that, getters for
> obviously named fields isn't adding a whole lot.

I see, makes sense to me.

> 
> Any concerns with leaving as-is for now?

No, and thanks for sharing!

Thanks,
Wei-Lin Chang

> 
> -- 
> Thanks,
> Oliver
