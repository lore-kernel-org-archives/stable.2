Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46A17D6
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935456; cv=none; b=Q3tmXjofzrKtu2dMlT5RuzoJ48qRemtDr+/r1lSSevCWAdGas10GB/cvY4qrMmQR6MnzU8YjYnPy0Mr6dFqGV81dPMK9u5Tik9gVKOY/AziIPR81pA1ngBiafZJOiGs/l1xShESMrxWVCyyhvqZKdeaFqk/dnbmz/skhfIsgXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935456; c=relaxed/simple;
	bh=/I5Mc1ebPKPWdBNfJSaWuANVoACGKHBWSqfg79ug5oA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=teOVkNmr5m2hCqFfw8sMJzn0pUoNX28EkFR+7c3c7lx6XRSPAMb1cBI744BTvzkLoZbjV/1KcrfzBX8SS/pMBtaAxLyz1Z7Vpo50nzbxgpGhQuhj/XZ8BrpUfhocuOfR9kz6Q0ajsNSPrYa2w8UmTdVTUIawEuJ05bME5QV7rCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lPC5J88B; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPC5J88B"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bbdcf36f0so3967144a91.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780935454; x=1781540254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFIdMowpiA9D/8Xvjmdd4zA6Jq31An7uG18cK9bdKCs=;
        b=lPC5J88BEmtVkX6lbMgMZRYEv19vX9/q2IInt2WqLWikDgC8TkWXla9rd7Fy1dCM02
         0BkEe8ZwbU90bTQ/zWxCIhHyaxWXKk+ic0JRZaYILb+yEC72q2bSm/5i/5b1/XV0Gn8J
         ub3AknotenB1sD6NMVaivtAMUyCXqhi+BBWwb87zD1j2ulU+3hlUA0TLhmH5JMjKpAMd
         +IQBl3NPQEi7VZB5gHtFpmaATsOxEjzG/VFjiUZzEPtcAlV7HvxVitcJIsvuCpNAE7LK
         z9xe5wGZEsvwNlNNPs3LXsuyCCE+HAXtDg4LKG+K0B1PmKQUG1NaaSjaoRY0kKDOiu14
         DrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935454; x=1781540254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFIdMowpiA9D/8Xvjmdd4zA6Jq31An7uG18cK9bdKCs=;
        b=dsqOc0RQpsrclSeBICC8X1LdkhKjaMONlfRz8EbRyLoiH/27+iaXdG/P0UtoboBV/n
         V0OpbXZ2VyYo9ZgS8EFmFgLIgSdJTnjv91h1n1F1ZpfzrQUleGwStEOxFO/jiTXqCGts
         hlMB7hu2WQQsQ20aBy5U/ztbIQEsbLgzbjrKrJpY504oh0MdVTa+aqJgpuhLg+NTAaFn
         lkJRQHBqssjuNiGNP5pKBSkIfYYqm8cAkXO1Tj0EK9wt1QklPVwiHFaJ+HQjvMy9aCwk
         5DF8deOZFre+JM3/Gkt7mcA5QyTLVo0Tp2UMW87M9h6txdEU7O5ZyrglOw6GEaz/8BJj
         tizg==
X-Forwarded-Encrypted: i=1; AFNElJ+4J03xOEo/UosLWctw8Kmfqhk62T+4odYrRfLbQwlkloPDW+UepLi1VZAa08Kkec6yZApvBv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpyk5YHIyE5jfjTGVPIAW0gNrTFRe5jHK2atbyObjo1/ehpP3
	cyMTO/rXEvBgooERCo2TYGJVfyZEfybWYnyaRKA7LxE/39VjDkK5T+JzG1W1qZQTa1fl2Xr7QAx
	72IftXg==
X-Received: from pjot6.prod.google.com ([2002:a17:90a:9506:b0:36b:a8c4:4c94])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b86:b0:36a:8519:a4e9
 with SMTP id 98e67ed59e1d1-37133569a9bmr12370219a91.18.1780935454108; Mon, 08
 Jun 2026 09:17:34 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:17:33 -0700
In-Reply-To: <87o6hlhuz5.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aiQyZIJtO-2Aj_xN@v4bel> <87o6hlhuz5.fsf@redhat.com>
Message-ID: <aibrHTY54o9ygVt6@google.com>
Subject: Re: [PATCH] KVM: x86: hyper-v: Bound the bank index in hv_is_vp_in_sparse_set()
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 08, 2026, Vitaly Kuznetsov wrote:
> Hyunwoo Kim <imv4bel@gmail.com> writes:
> 
> > hv_is_vp_in_sparse_set() uses valid_bit_nr, i.e. vp_id divided by
> > HV_VCPUS_PER_SPARSE_BANK, as the test_bit() index into
> > valid_bank_mask. valid_bank_mask is a single u64 and a sparse vCPU
> > set holds at most HV_MAX_SPARSE_VCPU_BANKS banks, so valid_bit_nr
> > must be less than HV_MAX_SPARSE_VCPU_BANKS.
> >
> > The caller in kvm_hv_send_ipi_to_many() passes kvm_hv_get_vpindex(),
> > which is below KVM_MAX_VCPUS and therefore always within that bound.
> > The L2 direct flush branch in kvm_hv_flush_tlb(), however, passes
> > hv_v->nested.vp_id, copied verbatim from the enlightened VMCS
> > without any bounds check, so valid_bit_nr can reach
> > HV_MAX_SPARSE_VCPU_BANKS or more and test_bit() then reads beyond
> > valid_bank_mask.
> >
> > Return false before the test_bit() when valid_bit_nr is not below
> > HV_MAX_SPARSE_VCPU_BANKS, since such a VP cannot be present in the
> > set.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c58a318f6090 ("KVM: x86: hyper-v: L2 TLB flush")
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  arch/x86/kvm/hyperv.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 4438ecac9a89..d8782cb7ba02 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -1839,6 +1839,10 @@ static bool hv_is_vp_in_sparse_set(u32 vp_id, u64 valid_bank_mask, u64 sparse_ba
> >  	int valid_bit_nr = vp_id / HV_VCPUS_PER_SPARSE_BANK;
> >  	unsigned long sbank;
> >  
> > +	/* A bank index beyond the mask can't be set, the VP isn't in the set. */
> > +	if (valid_bit_nr >= HV_MAX_SPARSE_VCPU_BANKS)
> > +		return false;
> > +
> >  	if (!test_bit(valid_bit_nr, (unsigned long *)&valid_bank_mask))
> >  		return false;
> 
> I think the concern is valid, so

Yeah, easy to trigger with KASAN and:

diff --git tools/testing/selftests/kvm/x86/hyperv_evmcs.c tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index c7fa114aee20..0cf5f891a20d 100644
--- tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -59,6 +59,10 @@ void l2_guest_code(void)
        vmcall();
        rdmsr_from_l2(MSR_GS_BASE); /* intercepted */
 
+       asm volatile ("movq %0, %%xmm0" :: "r"(-1ull));
+       hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE | HV_HYPERCALL_FAST_BIT, 0x0,
+                        HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES);
+
        /* L2 TLB flush tests */
        hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE | HV_HYPERCALL_FAST_BIT, 0x0,
                         HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES | HV_FLUSH_ALL_PROCESSORS);
@@ -117,7 +121,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
        current_evmcs->partition_assist_page = hv_pages->partition_assist_gpa;
        current_evmcs->hv_enlightenments_control.nested_flush_hypercall = 1;
        current_evmcs->hv_vm_id = 1;
-       current_evmcs->hv_vp_id = 1;
+       current_evmcs->hv_vp_id = -1;
        current_vp_assist->nested_control.features.directhypercall = 1;
        *(u32 *)(hv_pages->partition_assist) = 0;
 


> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> what I'm not sure about if we should also deliberately crash the VM
> which does such a hypercall. This way it would be easier to find buggy
> L1s but given that they are most likely Windows, we need to do some
> tests to see if this is not actually happening today (e.g. Hyper-V usign
> VP_ID or '-1' for something). Let's have this as a future TODO item.

+1
