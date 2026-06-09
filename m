Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E68372EC1
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780975897; cv=none; b=sneMgpWtwbDRcicAMwgcGNOjKiyDDZyz4X3GytPnzO8xMV/yIx/VyD9FANoGhZThR175VuANFZ8tBhvW2B3vZl+Ur9fcMJPLoP5PL6LbLPKZtZQ6XYnlMn5kqBDfiuk3JQQNz9QEjx6hXwNq2k++yuh+5RCvh1eCvxFAkcXLBbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780975897; c=relaxed/simple;
	bh=jfe0Gv32TJvkzmDAezzNMWcuvBvk140gbHR2Jyv9rfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YHFWLnq16fB6t/sMIyTnTUM63GuEFc3s+SMRt4UW6efUPsvL0VVk5HCnDZ/TjPKigbp1vDj54JqXbX2AcNNU5SXU997FptMBKny8W7oHRGYCjJTQB/k0Nv4LTYUX1bB6Y/2S0KvBsycjX/wHI/dOS6bfW4o0kumL1MjCI88fpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LfkVgTXj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LfkVgTXj"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-842211d6e48so5804525b3a.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 20:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780975894; x=1781580694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4QWk8m6cD8s0kHa/VMPBa/DWD4qEXAmgem93o9OWtA=;
        b=LfkVgTXjWg6w2Pa92RZVsOYk5zPx3oLfnJqAWpStN/Nc2cOJm9wTgqhh90rcciZszt
         INDN5/ONVbpjfjJa2eity9kmz9XFIQ2tx+5blzmuMNqwarJ/aC0eHNpVwkwa4bAVGgOS
         NN+GjHP8UoSugXRBUNpiZYxitQO1UKrqEgdaHg5JIxo6VQ1/exJgBnJnD9MK3cV6ZT7S
         0fa/Pa9aZqPVPdbSKJB0xZWFcoNzl3J84ppfVPILsJuxjpg/mENGYF1NN+LT9Rb2NHNg
         +u8leYn2RqBurcN0H0Xiid7TrhZCYdk8kYSIgdNtK0SFkbKKwv9OtEmVEYFc0WLJIzrk
         4MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780975894; x=1781580694;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4QWk8m6cD8s0kHa/VMPBa/DWD4qEXAmgem93o9OWtA=;
        b=pFbyn29YFKdE0llOm0Hj/CpC+ElJHS3EKdpiwy6/Ck+g5TWGdGb0U/JhHdXXXQVFF1
         /i0oG7r+GLLVJOmJZVO369bnaIihdeFzUg/YJxudRDMd/ytlIH/iDi+PG2CucQ+YJwrS
         Exzu5xojbevchm2E/Xmk1vlcIofc6KIc9x1eq1k3ANuesR0yxne7qr4hMBmJ+RBrW5q4
         N7imCZSyC5rO/YKUdMAFX8HOuoFajSe34ikGuJ+nHE15C8vMbqTL+uvIk4Zs+OH8H3L/
         dCrLjyGDcmVIXmDRytawgdVhZWg5GVgnOTOLX8l6GIG8CvRFKyfGXc/eIZJh+bK1m8cj
         hirw==
X-Forwarded-Encrypted: i=1; AFNElJ8OF1Ofc+n/mtU+/rxFZeQnV4rjD8NUx5sr2QfnYDuwFmD6FokaiEE7lS6eK3G+ySJBxg+M6Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIn9Vchiwp4NOMybuWIViCQ0y88h2o8vH+2fpgbZyPcmw9sNh
	J6nF5WU0JwlN/u8ThlZmDnrvmBQs9A9CherKTm9kceUwa58IDY/lSkfQAtBUmqh+STw290HVnVj
	TppBXrw==
X-Received: from pfn35.prod.google.com ([2002:a05:6a00:a223:b0:842:b0e7:887d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1d8e:b0:842:6099:c55c
 with SMTP id d2e1a72fcca58-842b0d82a44mr18014085b3a.3.1780975894067; Mon, 08
 Jun 2026 20:31:34 -0700 (PDT)
Date: Mon, 8 Jun 2026 20:31:33 -0700
In-Reply-To: <20260604160733.12555-2-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604160733.12555-1-pbonzini@redhat.com> <20260604160733.12555-2-pbonzini@redhat.com>
Message-ID: <aieJFWE3gQBwkS07@google.com>
Subject: Re: [PATCH 1/3] KVM: nVMX: unwind PDPTR load if processor triggers a
 nested VMFail
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Paolo Bonzini wrote:
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 4690a4d23709..d612a5d071fc 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4947,6 +4947,7 @@ static inline u64 nested_vmx_get_vmcs01_guest_efer(struct vcpu_vmx *vmx)
>  
>  static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
>  {
> +	enum vm_entry_failure_code ignored;
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	struct vmx_msr_entry g, h;
> @@ -4984,20 +4985,19 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
>  	vmx_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
>  
>  	nested_ept_uninit_mmu_context(vcpu);
> -	vcpu->arch.cr3 = vmcs_readl(GUEST_CR3);
> -	kvm_register_mark_available(vcpu, VCPU_REG_CR3);
>  
>  	/*
> -	 * Use ept_save_pdptrs(vcpu) to load the MMU's cached PDPTRs
> -	 * from vmcs01 (if necessary).  The PDPTRs are not loaded on
> -	 * VMFail, like everything else we just need to ensure our
> -	 * software model is up-to-date.
> +	 * Now that nested EPT has been disabled, load the MMU's CR3 and
> +	 * possibly PDPTRs from vmcs01 (if necessary).  This should not
> +	 * happen for VMFail, but we get here if the check was caught by
> +	 * the processor and therefore the guest CR3 was loaded prematurely.
>  	 */
> +	kvm_mmu_unload(vcpu);
> +	if (nested_vmx_load_cr3(vcpu, vmcs_readl(GUEST_CR3), false, !enable_ept, &ignored))
> +		nested_vmx_abort(vcpu, VMX_ABORT_LOAD_HOST_PDPTE_FAIL);

This isn't quite correct either.  I mean, none of this is architecturally correct,
but this is less correct than the other incorrect code here :-)

To do this "right", KVM should snapshot the PDPTRs and shove them into the MMU,
without touching guest memory.

On a very related topic, I have a patch to stash CR3 in software instead of
abusing vmcs01.GUEST_CR3, as KVM fails to restore vmcs01.GUEST_CR3 to its proper
state if nested_vmx_enter_non_root_mode() bails after clobbering vmcs01.GUEST_CR3,
but before loading guest state.  We could probably do the same thing for PDPTRs?

https://lore.kernel.org/all/20260603223418.1720035-3-seanjc@google.com

>  	if (enable_ept && is_pae_paging(vcpu))
>  		ept_save_pdptrs(vcpu);
>  
> -	kvm_mmu_reset_context(vcpu);
> -
>  	/*
>  	 * This nasty bit of open coding is a compromise between blindly
>  	 * loading L1's MSRs using the exit load lists (incorrect emulation
> -- 
> 2.52.0
> 
> 
