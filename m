Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C0499F0C
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636100; cv=none; b=jkfQ0Jj7ppUVU9nqtM0kjBqpleKXFUSktqhHcbuD8IEgRrq8xpos9DUEXTeUmMgQoaqwfe4SksqtDdje5rBm4clk+2b1o/HJuKfNXC8YTVvSfFyOqBK1ym1srOtVXf/3oqlJT5OWJV3uevGaqmq8A65gPD0nz2MAXFk0ySbKLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636100; c=relaxed/simple;
	bh=m74lr8LoG/ylJgenev9YkvH/ytiCSiyudyVpiSIKlw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EJMQCRfzsOkcS5pdGP+Aiof16s3XlblZ+yQzfbkRPLy2kxeWptr/fjtJCSZYWvLhVNsgM04Yiu8E+MLG+GRpVy5kVA/3HW9FYFDGAR76xycMHgoaxxl+0GWbl6WnqPf9k2Q+jMwVth21BK3N/QYFasdqwGqV+Qs2jc5sNhgDTjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8nWqzJO; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8nWqzJO"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc79125e4b8so1720476a12.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790636097; x=1791240897; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHF3bdTRwFplOoq2cs8Ws3l+4hhDs1tM2IjzYePrw0I=;
        b=a8nWqzJOLpL2HnthUZhB2raZ7a6xkjsfEjkUcZQQ8GpiXSNy98xcn/aNFuxbPZZ6wZ
         UA/Gwy2XFvhZW9vmt+g2vKIhj4fs29HYPV+SDBBa+bQUEXy3RypNbBFDfEQC9W5Q9Use
         Y/TkoC2NtPWaO8BtebWvpofE4gLfkWwawd1UFxO7TscvdmYirll7PqcdZDlAOuoKF7Dp
         B6D30wQunajB1UBwX7QrHL4dHU5sNVhbno+FocwFeJxEaPMLlinEY56jcF4Ol37VD+hb
         mS89V3vOnNzCcNiNmRRpxQmlL4w6EnBUmqG0VuTTkDgVJZOuAZGeiORk5ShkshxlSmSb
         eDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790636097; x=1791240897;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WHF3bdTRwFplOoq2cs8Ws3l+4hhDs1tM2IjzYePrw0I=;
        b=C30cBCBwqHny7XKCNSguYEFZA4DWTe8NRGpAgXzTdpHw47jEPotviEtR2cr8bAdDxq
         mlSESzgJOm44aXGhAFDCFenYQIE2gvT4IQ9PYrLB3esb0DIIzGedSC+HtavrkHwgRwMK
         TSxABO1j0NJxxrZzXUjh4P3dmfGwLQnsZ9hR/dzo1g+EHB9dDCRXSwiB6Zt7dM/nXJR5
         Z7g1IWMOpXRz35coksRAZ9JXmMa+ycSB4nns42J/fYaUiPGUDrDu6aN9tjFalSliQcQm
         DRhW/wNX/GvGDlNwoWySuwrQyT4SQl8ZmFzveycu1OmOrJdw34vYUSkNHrPTDYz51haY
         5HIg==
X-Forwarded-Encrypted: i=1; AKwUvBzsojpnsUw1me2s7O7twmy2V1kzS7pNoK+lK5UXUNGFYNFDOXw7X5oG5TEgUz/6y1V+jaOpJVs=@vger.kernel.org
X-Gm-Message-State: AFuF++ka645T4hg7mMy3rMlQhLJTjHm+ktdg+QO7G1KMvg72gTgRz4cK
	SK5bu0Ds89IkmtNrNpZvTqIyAzmr7o4T7tCGV/vkAevUb1Xs8E0HZSX0lVyRX3balkvnN7bts7h
	Lx2ByyQ==
X-Received: from pldm6.prod.google.com ([2002:a17:902:db86:b0:2dd:63c:daa3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8c5:b0:2df:8b09:93c2
 with SMTP id d9443c01a7336-2df8b09982fmr96875675ad.43.1790636097191; Mon, 28
 Sep 2026 15:54:57 -0700 (PDT)
Date: Mon, 28 Sep 2026 15:54:56 -0700
In-Reply-To: <20260820123512.87236-1-duankeqiangcym@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260820123512.87236-1-duankeqiangcym@gmail.com>
Message-ID: <arrwQKQJpFZtARmN@google.com>
Subject: Re: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace
 makes a vCPU not-halted
From: Sean Christopherson <seanjc@google.com>
To: Keqiang Duan <duankeqiangcym@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Qinguang Chen <chenqinguang@kuaishou.com>, 
	Zhiping Du <duzhiping@kuaishou.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 20, 2026, Keqiang Duan wrote:
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index cdb38d940cfb..45e47f502a37 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -95,6 +95,7 @@ int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection);
>  int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection);
>  bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
>  void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
> +void vmx_clear_hlt(struct kvm_vcpu *vcpu);
>  void vmx_enable_nmi_window(struct kvm_vcpu *vcpu);
>  void vmx_enable_irq_window(struct kvm_vcpu *vcpu);
>  void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d94b59140c45..3b224c3bbe42 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9058,6 +9058,21 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  	}
>  
>  	kvm_set_mp_state(vcpu, mp_state->mp_state);
> +
> +	/*
> +	 * Force the vCPU out of any hardware-tracked halted state, e.g. VMX's
> +	 * GUEST_ACTIVITY_STATE=HLT, when userspace puts the vCPU into a state
> +	 * other than HALTED.  The hardware state is sticky across VM-Exit and
> +	 * VM-Enter and is not touched by any other ioctl, so a vCPU that halted
> +	 * with HLT-exiting disabled stays wedged even after userspace rewrites
> +	 * its registers, e.g. when a VMM emulates a machine reset.  Waking from
> +	 * HLT is architecturally allowed to be spurious, so clearing it is

Everything looks good except this claim that spurious wakeups is architecturally
allowed.  I'm 99% certain that is straight up wrong.  The SDM explicitly states
what will break HLT:

  An enabled interrupt (including NMI and SMI), a debug exception, the BINIT#
  signal, the INIT# signal, or the RESET# signal will resume execution.

and the APM goes a step further, and in addition to listing the wake events:

  Execution resumes when an unmasked hardware interrupt (INTR), non-maskable
  interrupt (NMI), system management interrupt (SMI), RESET, or INIT occurs.

very clearly states that doing HLT with RFLAGS.IF=0 means:

  If rFLAGS.IF = 0, the system will remain in a HALT state until an NMI, SMI,
  RESET, or INIT occurs.

AFAIK, nothing in either the SDM or APM suggests spurious HLT wakeups are allowed.
And FWIW, this is not a theoretical issue.  A few years back we had a customer
issue where a spurious HLT wakeup due to a KVM bug crashed the guest (IIRC, the
guest offlined CPUs and put them in HLT, then kexec'd into a new kernel which
unmapped the code containing the HLT loop).

Anyways, unless someone cares enough to want to back up the claim that spurious
wakeups are ok, I'll just drop that line when applying.  I don't see any reason
to mention spurious wakes: the vCPU is clearly being moved out of HALTED state,
it's on userspace not to screw up (for this particular case; there are other live
migration issues that userspace can't solve).

> +	 * always safe.
> +	 */
> +	if (kvm_hlt_in_guest(vcpu->kvm) &&
> +	    mp_state->mp_state != KVM_MP_STATE_HALTED)
> +		kvm_x86_call(clear_hlt)(vcpu);
> +
>  	kvm_make_request(KVM_REQ_EVENT, vcpu);
>  
>  	ret = 0;
> 
> base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
> -- 
> 2.24.3
> 
> 
