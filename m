Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6539B969
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687851; cv=none; b=nZix2g+tGv+vntru0PpFFPC4ImKKQnjweYOiKIrz6T+b0l5k2iYGfJvUML4ddRNnigElVg5HFdMrANa+e5AsgcT1IVB113VTza65SBnaT8HGIws/dAPPAp4xtkmPeEzMpgMfIEK246FRvb8TtRImhwnH3VICXRmO35yFKRymjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687851; c=relaxed/simple;
	bh=WzzfVyCP2CKJWE9hG85VQhglRzrRfvCBy/dID+zqyIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW+IByc5Fc0VjK4jGAXK9jX+cAKmuMeaKv0O+10JO/U0EHkJmjF/8x6UpDcO55/7WqJJwpRQpqIJMaMLmblZq/erPLu0fV2ns2NKFoayZLKEDS92znpqCSht6fMU9IC5zITdL1n/vcQcQMNhtyU04ndboAIlBNNsLA07MtFF9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR4CfvDW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR4CfvDW"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c3546924so35979455ad.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781687849; x=1782292649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEZb6LJ8Uk1AgrpJuSRf5PMAcIBsdsc1p+ANTmomdOU=;
        b=mR4CfvDWHmdak87k5BocYFiUJMFPEVwL4ztX2Bbq8v72oovy4osd4BtXAsT32zDgsr
         BDWrtP16rOjhwFZrsEwnoUkFfLvVpTsWUFyAhWWcN6c5zI8XY5AfHHbISecIsAmGLnL0
         bJvaySd/t4iPauyou5Z0fcGIAS7gxw/VKdTBTSOyr0k5rrEBehy/UxvXLIxd7wNhkSR9
         6RDNINUAHfknp63zlpCSQnIzcI2PKbJaBdTH7AMZ09ixLAiQXgwd0+5HyOFsRgKETUE+
         y8hRCBToKVaKveNFLWGNh3Ei3Tlahgo1lnZ49wdbUTsktICIuuPYH58phL6NLgk9NZwT
         PaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781687849; x=1782292649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEZb6LJ8Uk1AgrpJuSRf5PMAcIBsdsc1p+ANTmomdOU=;
        b=qJVyTkez13GgehxiQsiSkOELSuLdHarcXm+g/kN5PL1V+Vw94U3/3l0/fw3PjbVn4e
         tWPmG5HM0guTkfc8Y6GtCcsXEafm+RrXcm+ghPdqFgm1+3P4ucGJSDXAnELutfuzfHgZ
         bEWF6X742Ce79xgCvBb34fL8+LzmsGcWSOAXTxEOwnkREkChHN3n5NbE0speZSKdaMVB
         KtCNQXBRk637EYxcsGbA+xRcmSiH3zKsSHrTt7U1m9WnAU4xqcmR1wsY5ElpzquZqRkk
         sSnyCV7/XrrQ05PAlMtiYvjeqGGQsbexhpQsIJmyucBYjEUJOi6J2w0qEGEWD4hGje9B
         kzOA==
X-Forwarded-Encrypted: i=1; AFNElJ8TUeAw84vulylmQVHynIzTJrpYOKdKeLP/ZDEsThEXhYA/LW1on5RZBsH5Jw/Gwzqc2c6TcrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwijyBzmPhQ48n+cOW22M9vha8+gjlzdl4YvKGi8V3DrQ164KSr
	koE47UKr05qTk7xgGKarOEwSMxKaQhnTh12P8EJUbOC31Nv0RMBDfhq3
X-Gm-Gg: AfdE7cnKqxiT5k4H68TmBQuxdXsJMW9wW3qPUb9JGCFmZPjL2FSrAhvYFwTwdFWd8Do
	s4CMw0g9CY7RtsVZsolaQ95sWizZxz9pY4p2/VY5gMx3atPNvW5ir1PjL16MZ6dWracH0mFdBwo
	D37ILPukDfMFufKaeKM5KaeDIP/y8FFOHZvk8sFzpmudTtdz79XPor7RhRu+VZ3QxEoJGlBmxw3
	i/QNA7lLD4yfjqRRh/BRWcgLKowyPBIPi+7vyibLIhgzztpuu0WhaRfwwcDTy/iw6VklvUV+Iq2
	TqpGwK9hbKHC9sCUkj0E6x9djPd/KzTVdWNZxa8jRrXfG0H52N/KghXLMQ+BguQQj6jB7Co7hCD
	kymIHGeFc8FmijuBEIMtgDVW980D2CpS2OyrjuRj3dLJOOPWFnhOVMW51p6qkhB433rFQwCmJ+U
	Pw3qClY6ag3ILmMq5Ugh3sJDydIIJfglkVuxyTBManrMpuonrM+NyDRVqN
X-Received: by 2002:a17:902:e88e:b0:2bd:606d:b342 with SMTP id d9443c01a7336-2c6bc21f1f9mr27060005ad.26.1781687849338;
        Wed, 17 Jun 2026 02:17:29 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a1878493sm41114495ad.81.2026.06.17.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:17:28 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:47:21 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Message-ID: <ajJlstOjsnAQ-SEH@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260616163405.96962-1-amachhiw@linux.ibm.com>
 <ajJknRi0n7tJDOKQ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajJknRi0n7tJDOKQ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

On Wed, Jun 17, 2026 at 02:43:15PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Tue, Jun 16, 2026 at 10:04:05PM +0530, Amit Machhiwal wrote:
> > On IBM POWER systems, newer processor generations can operate in
> > compatibility modes corresponding to earlier generations. This becomes
> > relevant for nested virtualization, where nested KVM guests may need to
> > run with a specific processor compatibility level.
> > 
> > Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> > logical partition (L1) booted in Power10 compatibility mode, the guest
> > fails to boot while setting 'arch_compat'. This happens because the CPU
> > class is derived from the hardware PVR (via mfspr()), which reflects the
> > physical processor generation (Power11), rather than the effective
> > compatibility mode (Power10).
> > 
> > As a result, userspace may request a Power11 arch_compat for the L2
> > guest. However, the L1 partition, running in Power10 compatibility, has
> > only negotiated support up to Power10 with the Power Hypervisor (L0).
> > When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> > hypervisor rejects the request, leading to a late guest boot failure:
> > 
> >   KVM-NESTEDv2: couldn't set guest wide elements
> >   [..KVM reg dump..]
> > 
> > This situation should be detected earlier and rejected by KVM. Without
> > proper validation, if userspace ignores the error, the guest may continue
> > to boot in Power11 raw mode on a Power10 compatibility host, which should
> > not be allowed.
> > 
> > Introduce a validation mechanism that detects unsupported arch_compat
> > values early in the guest initialization path. When an unsupported
> > arch_compat is requested (e.g., Power11 on a Power10 compatibility mode
> > host), kvmppc_set_arch_compat() uses cpu_has_feature(CPU_FTR_P11_PVR) to
> > detect the mismatch and sets arch_compat to PVR_ARCH_INVALID (0xffffffff).
> > This sentinel value is architecturally safe: PAPR specifies that valid
> > logical PVR values must have 0x0f as the first byte, ensuring 0xffffffff
> > lies permanently outside the specification-defined range. Setting this
> > value triggers kvmppc_sanity_check() to mark the vCPU as invalid by
> > setting vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
> > checks this flag and returns -EINVAL, preventing the guest from running
> > with an invalid processor compatibility configuration.
> > 
> > With this, when a Power11 arch_compat is requested on a Power10
> > compatibility mode host, the guest fails early during boot with:
> > 
> >   error: kvm run failed Invalid argument
> > 
> > This provides a much clearer failure mode compared to the previous
> > behavior where the guest could boot in Power11 raw mode (if userspace
> > ignored the error) or fail late during H_GUEST_SET_STATE.
> > 
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Acked-by: Gautam Menghani <gautam@linux.ibm.com>
> > Cc: stable@vger.kernel.org # v6.13+
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> > Testing: Both Anushree and I have tested the below scenarios:
> > 1. P11 guest on P11 host - Works
> > 2. P10 compat guest on P11 host - Works
> > 3. P11 guest on compat-P10 host - Correctly fails with "Invalid argument"
> > 4. P10 guest on compat-P10 host - Works
> > 
> > Changes in v4:
> > * Added documentation for PVR_ARCH_INVALID explaining why 0xffffffff is
> >   architecturally safe to use as a sentinel value (PAPR constraint on
> >   first byte being 0x0f) [Ritesh]
> > * Updated commit message
> > * v3: https://lore.kernel.org/all/20260609053327.61563-1-amachhiw@linux.ibm.com/
> > 
> > Changes in v3:
> > * Fixed null pointer dereference in kvmppc_sanity_check(): added check for
> >   vcpu->arch.vcore before accessing arch_compat, as vcore is NULL for Book3S
> >   PR and BookE guests (only Book3S HV uses vcore) [Reported by Sashiko AI]
> > * Added Reviewed-by tag from Vaibhav
> > * v2: https://lore.kernel.org/all/20260608201001.65760-1-amachhiw@linux.ibm.com/
> > 
> > Changes in v2:
> > * Fixed issue where v1 allowed guest to boot in Power11 raw mode when
> >   userspace ignored the error, by adding validation in kvmppc_sanity_check()
> >   to ensure early failure during vCPU run [Found the issue after posting v1,
> >   also reported by Gautam.]
> > * Introduced PVR_ARCH_INVALID constant for marking invalid arch_compat
> > * Dropped all Reviewed-by and Tested-by tags due to code changes; requesting
> >   fresh reviews
> > * v1: https://lore.kernel.org/all/20260603141539.47620-1-amachhiw@linux.ibm.com/
> > 
> > Changes in v1:
> > * Moved this patch out of the v3 series [1] as discussed here [2]
> > * Addressed below review comments from Ritesh:
> >   - Based the PVR validation on cpu features
> >   - Fixed hcall name typo
> >   - Stable backport
> > 
> > [1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
> > [2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
> > ---
> >  arch/powerpc/include/asm/reg.h | 12 ++++++++++++
> >  arch/powerpc/kvm/book3s_hv.c   | 15 ++++++++++++++-
> >  arch/powerpc/kvm/powerpc.c     |  4 ++++
> >  3 files changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> > index 3449dd2b577d..b9ab9df1e2bc 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -1357,6 +1357,18 @@
> >  #define PVR_ARCH_31	0x0f000006
> >  #define PVR_ARCH_31_P11	0x0f000007
> >  
> > +/*
> > + * Kernel-internal sentinel for invalid processor compatibility modes.
> > + * PAPR specifies that the first byte of a valid logical PVR value is
> > + * 0x0f. So 0xffffffff lies permanently outside the PAPR-defined range
> > + * and is safe to repurpose. KVM stores it in vcpu->arch.arch_compat
> > + * when userspace requests an unsupported compatibility mode (e.g.,
> > + * Power11 PVR on a Power11 host booted in Power10 compat).
> > + * kvmppc_sanity_check() detects this and prevents the vCPU from
> > + * running with an unsupported arch_compat.
> > + */
> > +#define PVR_ARCH_INVALID	0xffffffff
> > +
> nit:
> I think the description of the invalid value should go into the commit
> message rather then here. It creates an unnecessary clutter here. If
> anyone wants to know why it's added they can always get the blame and
> get the description.
> 
> Apart from this.
> 
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

I just saw the conversation on previous version. After that it makes
sense to have it here.

Regards,
Mukesh
> >  /* Macros for setting and retrieving special purpose registers */
> >  #ifndef __ASSEMBLER__
> >  
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 61dbeea317f3..f9380ef65750 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -446,7 +446,19 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
> >  			guest_pcr_bit = PCR_ARCH_300;
> >  			break;
> >  		case PVR_ARCH_31:
> > +			guest_pcr_bit = PCR_ARCH_31;
> > +			break;
> >  		case PVR_ARCH_31_P11:
> > +			/*
> > +			 * Need to check this for ISA 3.1, as Power10 and
> > +			 * Power11 share the same PCR. For any subsequent ISA
> > +			 * versions, this will be taken care of by the guest vs
> > +			 * host PCR comparison below.
> > +			 */
> > +			if (!cpu_has_feature(CPU_FTR_P11_PVR)) {
> > +				arch_compat = PVR_ARCH_INVALID;
> > +				goto out;
> > +			}
> >  			guest_pcr_bit = PCR_ARCH_31;
> >  			break;
> >  		default:
> > @@ -469,6 +481,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
> >  			return -EINVAL;
> >  	}
> >  
> > +out:
> >  	spin_lock(&vc->lock);
> >  	vc->arch_compat = arch_compat;
> >  	kvmhv_nestedv2_mark_dirty(vcpu, KVMPPC_GSID_LOGICAL_PVR);
> > @@ -479,7 +492,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
> >  	vc->pcr = (host_pcr_bit - guest_pcr_bit) | PCR_MASK;
> >  	spin_unlock(&vc->lock);
> >  
> > -	return 0;
> > +	return kvmppc_sanity_check(vcpu);
> >  }
> >  
> >  static void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 00302399fc37..98de68379b18 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -258,6 +258,10 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
> >  	if (!vcpu->arch.pvr)
> >  		goto out;
> >  
> > +	if (vcpu->arch.vcore &&
> > +		vcpu->arch.vcore->arch_compat == PVR_ARCH_INVALID)
> > +		goto out;
> > +
> >  	/* PAPR only works with book3s_64 */
> >  	if ((vcpu->arch.cpu_type != KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
> >  		goto out;
> > 
> > base-commit: 6b5a2b7d9bc156e505f09e698d85d6a1547c1206
> > -- 
> > 2.50.1 (Apple Git-155)
> > 
