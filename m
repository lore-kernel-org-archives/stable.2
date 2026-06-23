Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E56D14B977
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782180119; cv=none; b=AxEUwUwhusbNDfRCJD2tZuONt/9ZKPLF4uyYfIHBewIkvkWv2pMdfo8NQRkJJVA1QhswkzEgUK9eYsCEzrxHBTuq/7N5UBoP2Hx9UQLHLQuI8n3M49aqVuhHN9tKehademjxW7AojNnnbJORyRyAuXE9W6+ErLtQc7di5Pdl8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782180119; c=relaxed/simple;
	bh=cXRM/ck9Ey6nTrzyIvWXOB+TWiaSF3rdZ+AA5+bAIBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KmnQ6qL/lC+VX2mT6+sv4mQ4DcEoHQxfEBqpEQ7g0iE0p2zQ272SzwyoqyvHY4LZkEY/6bR1QP5XQfDCr38aZQalI7mXu45i6IcerSKu3hxHgXbwkqJ4fQN328Ooax15tcGDOQSPwuKPdV11zDegUh/UGXVXv6n1kpxuYuH5iIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUX8rAlL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUX8rAlL"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422ca754d8so3621765b3a.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782180117; x=1782784917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/3fefL+h6R1cURFIrvEhDQHtPAvcJLZFYApQsGXUq4=;
        b=cUX8rAlLKt+8SRG/Jy5GeqjBrK8zSKnCVi2V5FTIpbriIPEK60YqZNZSgw/Uj6PKqw
         j4iJtHgAnzojXN92/104gKbbcJiwfzeRCPmTSd6WOrU5u1Opqr/v3iAk6d4vv3FApxwT
         /ujanUxSzkw/hmkTRTEOsLhu9hbvoXSdc6FpZholnfnVLRFV+3Q/H0wSqwhhMKhomn6v
         BQsvKmp/7lSlkVCHI3gMkEksNECeBj0DaKdjHlF29cC6uqfhje9S5w/pAl2GqtWSU22e
         qFt/1LlqzCAhD2rSeNs9XrAJdfYavWZ4GwXCqSdMTGlwYIQ3BHepRx3uixwbRH7Rho6A
         dlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782180117; x=1782784917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/3fefL+h6R1cURFIrvEhDQHtPAvcJLZFYApQsGXUq4=;
        b=gTz+3IwzmK7cg4ZWYch0PynyHlODBeCydNYtFM9mc1iXiy0Mba6Y6y2XDMbU6lHkaK
         gIWRjrW3l5fa+Gy5WiVVnTEdNQVCOp/+puGmL95YmBm/UGyChVIuqkqmbvJJ4F/NLsHQ
         5KsQXyigriCZ9m4mSZguYX76K1zLL539fl5UeRfwPCAAxd1BbEFhnbpRGKnZXeH00MX8
         FprrFD12OugjMoVLpmZIE41ZOU7RyPn382YmlqRcRz9+++zuHYPLF9fy/DcH0sln97YS
         WEApRDK847daTTp2dz6WnoV44/vhdVQNh1GogSpdHJBz7jGb7T2Kg9nmcTX3I8rEMUmf
         1OXw==
X-Gm-Message-State: AOJu0Yz6SHDZxV8Wgkrxf2vKoOURcH8oOIlUFiBKAhsN2gWrsoUnC7e/
	ne/kZOvB6uRYdyCrtT1/L7bIKTK0SxmILmc4ZADkXIOkagpr1SKvLvUdxnJ1+FjZkf9VXKf6qMp
	DDvvBDg==
X-Received: from pfog9.prod.google.com ([2002:aa7:8749:0:b0:842:69d7:10b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2992:b0:841:dc85:1638
 with SMTP id d2e1a72fcca58-845625b5631mr17043425b3a.42.1782180117171; Mon, 22
 Jun 2026 19:01:57 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:01:56 -0700
In-Reply-To: <20260619203107.2752678-2-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619203107.2752678-1-main.kalliope@gmail.com> <20260619203107.2752678-2-main.kalliope@gmail.com>
Message-ID: <ajnpFEwXcqw07XCm@google.com>
Subject: Re: [PATCH v2 6.1.y 1/3] KVM: nVMX: Add a helper to get highest
 pending from Posted Interrupt vector
From: Sean Christopherson <seanjc@google.com>
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, gregkh@linuxfoundation.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 0wn@theori.io, 
	mlevitsk@redhat.com, jmattson@google.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 19, 2026, Nicholas Dudar wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> commit d83c36d822be44db4bad0c43bea99c8908f54117 upstream.
> 
> Add a helper to retrieve the highest pending vector given a Posted
> Interrupt descriptor.  While the actual operation is straightforward, it's
> surprisingly easy to mess up, e.g. if one tries to reuse lapic.c's
> find_highest_vector(), which doesn't work with PID.PIR due to the APIC's
> IRR and ISR component registers being physically discontiguous (they're
> 4-byte registers aligned at 16-byte intervals).
> 
> To make PIR handling more consistent with respect to IRR and ISR handling,
> return -1 to indicate "no interrupt pending".
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240607172609.3205077-2-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ Nicholas Dudar: backport to 6.1.y. 6.1.y defines struct pi_desc in
>   posted_intr.h and predates the move to <asm/posted_intr.h>, so the helper
>   and the <linux/find.h> include go in posted_intr.h. ]

This is misleading.  The helper is in arch/x86/kvm/vmx/posted_intr.h, even in
upstream.  I don't know if I *intentionally* put the helper in KVM code, but for
for whatever reason, I did.

Commit 699f67512f04 caused a conflict that needed to be resolved in the 6.1
backport, but that didn't have anything to do with needing to re-home the helper.

That only matters because I was going to ask if we'd be better off backporting
asm/posted_intr.h so that the helper would live in it's "proper" location, but
the answer on that front is "no", because it's already there.

FWIW, I got the same conflict resolution, it's just the blurb that's confusing.

> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> ---
>  arch/x86/kvm/vmx/nested.c      |  5 +++--
>  arch/x86/kvm/vmx/posted_intr.h | 10 ++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index bdc462944..7d8e18dbe 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -12,6 +12,7 @@
>  #include "mmu.h"
>  #include "nested.h"
>  #include "pmu.h"
> +#include "posted_intr.h"
>  #include "sgx.h"
>  #include "trace.h"
>  #include "vmx.h"
> @@ -3818,8 +3819,8 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
>  	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
>  		return 0;
>  
> -	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
> -	if (max_irr != 256) {
> +	max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
> +	if (max_irr > 0) {
>  		vapic_page = vmx->nested.virtual_apic_map.hva;
>  		if (!vapic_page)
>  			goto mmio_needed;
> diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
> index 269920765..88cea0dac 100644
> --- a/arch/x86/kvm/vmx/posted_intr.h
> +++ b/arch/x86/kvm/vmx/posted_intr.h
> @@ -2,6 +2,8 @@
>  #ifndef __KVM_X86_VMX_POSTED_INTR_H
>  #define __KVM_X86_VMX_POSTED_INTR_H
>  
> +#include <linux/find.h>
> +
>  #define POSTED_INTR_ON  0
>  #define POSTED_INTR_SN  1
>  
> @@ -103,4 +105,12 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
>  		       uint32_t guest_irq, bool set);
>  void vmx_pi_start_assignment(struct kvm *kvm);
>  
> +static inline int pi_find_highest_vector(struct pi_desc *pi_desc)
> +{
> +	int vec;
> +
> +	vec = find_last_bit((unsigned long *)pi_desc->pir, 256);
> +	return vec < 256 ? vec : -1;
> +}
> +
>  #endif /* __KVM_X86_VMX_POSTED_INTR_H */
> -- 
> 2.34.1
> 
