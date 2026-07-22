Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041DB43D4FA
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756497; cv=none; b=t17j51DBb/3qXTC5b3zvAkk+7Uj50yZ0MZBDCiHT+Sm0BaKDnmf65K5HVcfY0xAbim56Nqs0Haa9ro/DPa89UztDZIpc+LGRtzUakkdyCgFveWLUvXXXGD8hKNZVuWRxv8IjKDpL8MZ/IwbLgtfcDw0yGMFHk64uIbQT20r6qMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756497; c=relaxed/simple;
	bh=YfkqlJk+XSEH5Mo/29taOhKllufEXeXgArzlZpRjJUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ROIUY2O+n6FsX73FDWVJfKZConI8/9GaNh01igciizcdbY+10juy3JILkYR3j0bhua7TPTjsSszwtqxCat9SVyZQFPP5oQNc7Ih6geVb25gs4+LJ5SnEFNQXFUYwa3JTudacwbwmYV7X2eRcBnim0+hAJZel5OggrgZBAcZjWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gud3F5M+; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gud3F5M+"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84842381150so22719307b3a.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784756495; x=1785361295; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=653NAsUW4hEJZx8eIBt2dUKInbAtAlowc+ioGHT72WQ=;
        b=gud3F5M+hQ1XLZnAHjcqN10mR/WSw+Kk3h25kIfDehuFmXpd/tydr2Mirfsmd824W2
         P/YZz0AFLURUy2hHCo00X6ZP2GUpToOJYN5A1edWCA1rqO6TpsMdNiFEqT26Zjd7OBrQ
         7YuBukorQsy9Y4jH4GlhQtNskK7xum34236AKcXJkNjK8lBnC6F6B/vUkn2jltpCG2R0
         bNvfUxo9YSP8qEq+o8ScMZMgdSvNqQwS/mo/eSyCv5THsxYjeF0WfKLd68e22bS0oCbh
         ESmxztZX4mb8c+OYEhZeaU4LB5+YsrfxjbqmGHYgMezYKxdwqaj+lsNPi79oqKraCHFJ
         SNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756495; x=1785361295;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=653NAsUW4hEJZx8eIBt2dUKInbAtAlowc+ioGHT72WQ=;
        b=MUrgspiP5lE77bmOttsnPK91Sjn1MkGfUGrMLJXjX+CV1NAHJ71NMk+dAmuH+NVbRp
         MMF5jCcqJxcvn/exknJv5K5e0qtBF2nr7e3vrQV0LB5Nmqursm89PjLHtJBv97rW08Mf
         7s0FlCXF2q01qbYYD0UrbcGIkoes9KnbRITv/Cn+xYr/oO2rBac6DIoTrF8rMJeQh01x
         wbGYrRT8z/j73QC5zn5u6pyYSWiwQON5XVKR83Oxz5c/ImBBkAkFfrs/35p1p6RjSZqC
         mFDXocBBk9AnisRszvZT/RKrgiN4FVY857D0R+Xu1/Fae73sAXJ1pp5Am6OrSSnPSG2l
         SwRw==
X-Forwarded-Encrypted: i=1; AHgh+RqmcHy2dH3IBZ8Dwg0O1e9z08U941GBGnh/8B+gIURwyNcPJfbOE2dkFXosSp5jx7taRnKixJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykIMScHHuBHccGlt8XBJMZBmiaEPpMOhZ7tLHiUdVaWQsgmZW5
	iel7hEpUldet70EWVznmxTGty7f5dHFEQCpcgbk+dzKHTsMGzESPEoGRGadd7v92uqALZiCRbSh
	o9FRNHQ==
X-Received: from pgaz10.prod.google.com ([2002:a05:6a02:50ea:b0:c88:b675:3609])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:32cf:b0:84e:1da9:6a53
 with SMTP id d2e1a72fcca58-84e2b8688bcmr624911b3a.19.1784756495031; Wed, 22
 Jul 2026 14:41:35 -0700 (PDT)
Date: Wed, 22 Jul 2026 14:41:34 -0700
In-Reply-To: <20260717060505.2971514-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717060505.2971514-1-yosry@kernel.org>
Message-ID: <amE5DiLbq5PdYuNn@google.com>
Subject: Re: [PATCH] KVM: nVMX: Only update last_vpid on a successful nested VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 17, 2026, Yosry Ahmed wrote:
> ---
>  arch/x86/kvm/vmx/nested.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index b5460de4b1a72..0a4ea410b0483 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2818,8 +2818,6 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  	if (kvm_caps.has_tsc_control)
>  		vmcs_write64(TSC_MULTIPLIER, vcpu->arch.tsc_scaling_ratio);
>  
> -	nested_vmx_transition_tlb_flush(vcpu, vmcs12, true);
> -
>  	if (nested_cpu_has_ept(vmcs12))
>  		nested_ept_init_mmu_context(vcpu);
>  
> @@ -3739,6 +3737,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  		vmx_start_preemption_timer(vcpu, timer_value);
>  	}
>  
> +	nested_vmx_transition_tlb_flush(vcpu, vmcs12, true);

Hmm, so the SDM doesn't explicitly say _when_ TLB flushes happen, but I suspect
this doesn't match how hardware behaves.  My guess is that any TLB flushes happen
once VM-Enter has gotten past the VM-Fail consistency checks, i.e. once a VM-Exit
is guaranteed.

The SDM doesn't actually say anything about VM-Enter, so I don't think KVM *must*
implement *that* specific behavior, but I do think we should leave the call to
nested_vmx_transition_tlb_flush() where it's at, and instead service the local
pending flushes in the pseudo-VM-Exit path.  Because the other way the TLB flushes
can be queued during VM-Enter is via the MSR load lists:

  If any MSR is being loaded in such a way that would architecturally require
  a TLB flush, the TLBs are updated so that, after VM entry, the logical
  processor will not use any translations that were cached before the transition.

E.g. if L1 successfully loads one or more MTRRs on VM-Enter to L2[*], then fails
on a subsequent MSR, architecturally I believe L2 TLB entries are guaranteed to
be flushed.

I'm speculatingly heavily on all of this, but even if I'm wrong (or it's uarch-
specific behavior), explicitly servicing pending flushes in the VM-Exit(ish) path
feels safe in the long run:

diff --git arch/x86/kvm/vmx/nested.c arch/x86/kvm/vmx/nested.c
index 3266c63046ee..49aeecc2f093 100644
--- arch/x86/kvm/vmx/nested.c
+++ arch/x86/kvm/vmx/nested.c
@@ -3760,6 +3760,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 vmentry_fail_vmexit_guest_mode:
        if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
                vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
+
+       /*
+        * Handle any TLB flush requests that were queued for L2 if KVM made it
+        * far enough along to switch to L2 context.  Note, loading host state
+        * will generate any flushes for L1 required by VM-Exit.
+        */
+       kvm_service_local_tlb_flush_requests(vcpu);
+
        leave_guest_mode(vcpu);
 
 vmentry_fail_vmexit:


[*] https://lore.kernel.org/all/20260717230542.3555587-4-jmattson@google.com

> +
>  	/*
>  	 * Note no nested_vmx_succeed or nested_vmx_fail here. At this point
>  	 * we are no longer running L1, and VMLAUNCH/VMRESUME has not yet
> 
> base-commit: 6bc96b971766fbbbbdd9fb2642cedacaf02da957
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
