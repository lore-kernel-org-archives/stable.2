Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287AB493D5C;
	Fri,  2 Oct 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946432; cv=none; b=Ck/8e5TdSUpkfF+2s/8PcuqYf3T2/gAg83RD5pbE4ifP5dSmxJGaefCnJ+ZMPFfYbHxohxAh0YWbso+OXxW/M7gHPZkqKeaunAk+Jqxhk2plrcFrJ/JpA5DDOK0Po6nASGqJ+hO9uX1E5cel6Ci0izPUmywa2k5azryS0v2RV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946432; c=relaxed/simple;
	bh=SmWO9czKKNw17CGtACa7yQz8CEXetXq7HrZMxVrdduQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKFoBlsjEEjzrG7Qfk/AQPRIHJ1/V22UG1neylueLp4elgGMuDXFYfq9oO8JBu9wKoshBLJGKTjpknMXppOo1L87QkIih3Trm69E7i+TS9/hUWuUbwsrkMfP1Z1CRn6Zh2LwmrecVVJdXLliT0zQ526xw07wJJwSFhks/jsyFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9QcbWUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9QcbWUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6AB1F000FF;
	Fri,  2 Oct 2026 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790946428;
	bh=zutG9mUcjLueo0MzuInQdFJ8bIEoz3oYFAJlUN7gtlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F9QcbWULshIQZvrn1zMqIefdmWtYOHM01umX8e189rB6EyZcm6vGk2Lyo95pkctjr
	 Nl44pNLm7NmBJvHZtMqt5mwnYXCJEIlGQLY/Gd/7RpmJQQT0Cei+610YcgytZGxGnE
	 fWNXRY6TmzB2nYKUlvtE4JdK49sb1wwL2459HLaPZtkx6ndVgCJHJKoimUuXwPsAnr
	 wLGEz5f9DjqtDt2F94H+5p01EM7zDXn2uW6tGSgS7tRWEER8Ca8YpAMItgRlj4zLER
	 N0NHG6MrfA8cmo8lRp8UUrdroQRDGk0HLzk7vmfRqL3gSDkM+cF+7wtcv5bfN5X/I2
	 KRizQpBGpd8ig==
Date: Fri, 2 Oct 2026 14:07:02 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	Yuchao Zhang <ndaugoing@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] KVM: arm64: Move OUTSIDE_GUEST_MODE publication
 past context being saved
Message-ID: <ar-sdhZPCg7YKtGM@willie-the-truck>
References: <20260929093548.3598547-1-maz@kernel.org>
 <20260929093548.3598547-2-maz@kernel.org>
 <CA+EHjTwZSFUZmavbB4tE-eFxHg9WF80CA230EwvynuNcZQ0prg@mail.gmail.com>
 <86a4p0403b.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a4p0403b.wl-maz@kernel.org>

Hi folks,

Sorry, but this is probably an incredibly unhelpful drive-by comment
but Marc was talking about vcpu->mode the other day and I couldn't
resist looking at it some more. Like a moth to a flame...

See below.

On Tue, Sep 29, 2026 at 03:13:28PM +0100, Marc Zyngier wrote:
> On Tue, 29 Sep 2026 13:59:23 +0100,
> Fuad Tabba <fuad.tabba@linux.dev> wrote:
> > On Tue, 29 Sep 2026 10:35:42 +0100, Marc Zyngier <maz@kernel.org> wrote:
> > > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > [...]
> > > @@ -1386,6 +1385,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> > >
> > >               kvm_arch_vcpu_ctxsync_fp(vcpu);
> > >
> > > +             /*
> > > +              * All the state has been synchronised, let advertise
> > > +              * we're outside of the guest.
> > > +              */
> > > +             smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
> > 
> > Pardon my atomics :)
> 
> This is not an atomic instruction. However, it composes with atomics.
> 
> > , but what does the release pair with? On the halt
> > path, the only reader I can find is the cmpxchg() in
> > kvm_vcpu_exiting_guest_mode()
> 
> From Documentation/atomic_t.txt:
> 
> <quote>
>  - RMW operations that have a return value are fully ordered;
> 
>  - RMW operations that are conditional are unordered on FAILURE,
>    otherwise the above rules apply.
> </quote>
> 
> The acquire side of cmpxchg() is therefore interacting with the above
> release, which gives us the required ordering.
> 
> However, there is a problem if cmpxchg() fails, as there is no
> ordering in that case, and I'm not sure the smp_mb__before_atomic()
> saves the bacon in that case. It feels we'd need an acquire
> somewhere, a bit like this:

(as discussed off list, you can use smp_acquire__after_ctrl_dep() if
you're feeling really brave)

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 03bfc92864b6e..2efb4febcb235 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -563,9 +563,15 @@ static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
>  	 * The memory barrier ensures a previous write to vcpu->requests cannot
>  	 * be reordered with the read of vcpu->mode.  It pairs with the general
>  	 * memory barrier following the write of vcpu->mode in VCPU RUN.
> +	 *
> +	 * cmpxchg() is not ordered when failing, so make sure we perform an
> +	 * acquire in that case.
>  	 */
>  	smp_mb__before_atomic();
> -	return cmpxchg(&vcpu->mode, IN_GUEST_MODE, EXITING_GUEST_MODE);
> +	if (cmpxchg(&vcpu->mode, IN_GUEST_MODE, EXITING_GUEST_MODE) != IN_GUEST_MODE)
> +		return smp_load_acquire(&vcpu->mode);
> +
> +	return IN_GUEST_MODE;
>  }
>  
>  /*
> 
> > , and the LPI-disable and MOVALL halts
> > then take ap_list_lock or irq_lock. Would WRITE_ONCE() be enough?
> 
> We need a release so that we know for sure that any state stored
> before is visible by the time we can observe OUTSIDE_GUEST_MODE, and
> WRITE_ONCE() doesn't provide that (it can be reordered).
> 
> I don't see what taking a lock changes to the ordering requirement.
> 
> >
> > Should the early exit path (the kvm_vcpu_exit_request() bail-out) get
> > the same treatment? I think that's what Sashiko is trying to say in
> > the patch 5 review [1].
> 
> I don't understand what sashiko is trying to say, but this is clearly
> missing from the patch, see below. Not sure how I missed that one.
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 9a4871cd796bc..1a3a15bc6f55c 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1333,13 +1333,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
>  
>  		if (ret <= 0 || kvm_vcpu_exit_request(vcpu, &ret)) {
> -			vcpu->mode = OUTSIDE_GUEST_MODE;
>  			isb(); /* Ensure work in x_flush_hwstate is committed */
>  			if (kvm_vcpu_has_pmu(vcpu))
>  				kvm_pmu_sync_hwstate(vcpu);
>  			if (unlikely(!irqchip_in_kernel(vcpu->kvm)))
>  				kvm_timer_sync_user(vcpu);
>  			kvm_vgic_sync_hwstate(vcpu);
> +			smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);

I'm struggling to see why a release is sufficient here, but I'm also
struggling to understand the bigger picture so I'm probably just confused.

I can see why a release is necessary for the saved state to be visible
to another CPU that has kicked the vCPU out of the guest and then uses
vcpu->mode == OUTSIDE_GUEST_MODE as the indication that the state is
safe to consume. However, don't we also need to make sure that any
subsequent check for a pending request on _this_ vCPU is ordered after
that write to the mode? Now that we've toggled it away from IN_GUEST_MODE,
I think IPIs can be elided by the kick, so a subsequent call to
e.g. kvm_request_pending() must be observed after that toggle, otherwise
I think we could miss a request.

Can you see the tree I'm barking up here?

Will
