Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865E1FE44A
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080248; cv=none; b=oE6e0JO8bhNrGnHderBLfQn0kumeElqeLG8/yxEkpOtFL4ba0w9CiTJPlFrpvcfUEQP+fAFm5jMSfULBumZtRzvMyEGTuOJ8WGfsQ8ad0wPTSdR7zL9LyQgxenSVmzKcIglYXdKqILsSm9CS8F9WvnaKXPDmPqZV9PLQe/9Cfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080248; c=relaxed/simple;
	bh=gWK8Y6FBWvhqz0btGx1LmwUcE/dTxHRwTzZ3bPzjbFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j8llfaRBZuaFqYGoSPEYdJaCFhmEPCem3C+SOQ6EhwTcHOkY3pvpdqP3FGbu94F97slp/sVS0wgIoMJNYRe0LbFjuPEy3f+kEIsV8S1f6rbtTaHCd8u8sWpd/xL4zdxzxRDgEwHO2niiyDqsI1ICJ5WJgaxPlne2XUUAd57RlM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjLeRW2n; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjLeRW2n"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c902e0da2so114309eec.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792080234; x=1792685034; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/HTMhf4d9uTe7pfHFO8gXnRLSbjR8N6Nyp6yU1jUvI=;
        b=RjLeRW2nON7xmX3dVuh6SSW96LSox50SLEoSaOruLn7bhGjG4rzh4SrC48BHziydNU
         fk5JYHMHjympQ3bdlssqu3M3b5TePRMXekz46+4me0IvF44ax1XmGhAFO25rnPdp2/bF
         puxnkHCJJJ0zO/Q4qx8WX0ZhS4mXT6CJ2qwMlImDXoLUf0uCL0B2fxakIxRx2+yr3IjQ
         dnqabJMEPdtJAQHMpf3k8+KZ9mNY35nl4X/L3bDUafdbwZ4odSzHOjsapssjxZcGjshl
         NqBFJeV0IzHtuSI4ydHPJF4DWKgIqEHdtvTs7poURhRuAUsnd+4pURjVK2oBTa79hlOw
         WKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080234; x=1792685034;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/HTMhf4d9uTe7pfHFO8gXnRLSbjR8N6Nyp6yU1jUvI=;
        b=H3BdCKOs22L7QA25GkdO8DMlMr2PcWcNgjxmRWbCfHGkUWegcBKdBsc0qpstkOVj3Z
         KX/+fhnyVfDMPhDi+bhaz5ic0S093qgegRy0v90g+vT4p4UT0RtdWuWYHfRPBoAg2acb
         ln7XLG1tWv8z2CUOxr35OkquIgH+FqLVqBF6J52VISPzfe4+XEKkcK/YfP1WkPd9U4l2
         o0H0hfPsGxVHwNXPMMX7oqoTbF2yUSIM846MkEvXOBSrPtTB/+jZ/yW3xt4yfGU/bj6k
         d6CTFJFsHNu5yko3e0cuX+z8TxYE7X2sqFCHmH5GqQzlrLUvClb96k1lY0etAFrobuPp
         09fw==
X-Gm-Message-State: AFq9FYLw/mX3lio6h3B31IPN6usa9a2bEsFRcvfZWA7KNUPpgLz1pnT0
	f+1b3IP3TSV3V5ugxhi0VHtGi9V5PxAV90Lr2cbJgoolpfyL06sFz1ItVRVpwsiqjb4Ipg73jCT
	V2WGnyttJRI35WMOvG3vG3Uh4dABLEoimnfiq+ahXXU8QFoeUZnd7DruvZXPks63oSjuCKPi9pa
	5Uz6JeagNHeGHbvH7DQPZep+RtuUQCAg7lJilhC1v6WwVFQ0o=
X-Received: from dlam5-n1.prod.google.com ([2002:a05:701b:2085:10b0:15f:abb4:cfc6])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:20c2:10b0:353:804a:5e83 with SMTP id 5a478bee46e88-3602d6e5a11mr455669eec.8.1792080233613;
 Thu, 15 Oct 2026 09:03:53 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:03:45 +0000
In-Reply-To: <20261015160346.181835-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015160346.181835-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015160346.181835-6-aaltinay@google.com>
Subject: [PATCH 6.18.y v2 5/6] KVM: x86: Virtualize AMD CPUID faulting
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Anil Altinay <aaltinay@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

commit e93a93f11490992a477546d38d3a37b9b8dc6a5f upstream.

On AMD CPUs, CPUID faulting support is advertised via
CPUID.80000021H:EAX.CpuidUserDis[bit 17] and enabled by setting
HWCR.CpuidUserDis[bit 35].

Advertise the feature to userspace regardless of host CPU support. Allow
writes to HWCR to set bit 35 when the guest CPUID advertises
CpuidUserDis. Update cpuid_fault_enabled() to check HWCR.CpuidUserDis as
well as MSR_FEATURE_ENABLES.CPUID_GP_ON_CPL_GT_0.

Unlike VMX, SVM prioritizes the CPUID intercept over the #GP induced by
CPUID faulting.[1] This behavior has been confirmed on a Turin CPU (F/M/S
1AH/2/1).

Link: https://lore.kernel.org/r/DS7PR12MB82011943131DF5415365E19E940B2@DS7PR12MB8201.namprd12.prod.outlook.com [1]
Signed-off-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260527174347.2356165-5-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Anil Altinay <aaltinay@google.com>
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kvm/cpuid.c             |  2 +-
 arch/x86/kvm/cpuid.h             |  5 +++--
 arch/x86/kvm/x86.c               | 18 ++++++++++++------
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d0a0cc8e8bd9..71bbdd920ac3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -863,6 +863,7 @@
 #define MSR_K7_HWCR_IRPERF_EN_BIT	30
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_HWCR_CPUID_USER_DIS_BIT	35
+#define MSR_K7_HWCR_CPUID_USER_DIS	BIT_ULL(MSR_K7_HWCR_CPUID_USER_DIS_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 #define MSR_K7_HWCR_CPB_DIS_BIT		25
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3f2689fdc304..5edd00ac7fa0 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1220,7 +1220,7 @@ void kvm_set_cpu_caps(void)
 		F(PREFETCHI),
 		EMULATED_F(NO_SMM_CTL_MSR),
 		/* PrefetchCtlMsr */
-		/* GpOnUserCpuid */
+		EMULATED_F(GP_ON_USER_CPUID),
 		/* EPSF */
 		SYNTHESIZED_F(SBPB),
 		SYNTHESIZED_F(IBPB_BRTYPE),
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 872bc99c55ed..0d757852a1e5 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -177,8 +177,9 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
 
 static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.msr_misc_features_enables &
-		  MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
+	return (vcpu->arch.msr_misc_features_enables &
+		MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) ||
+		(vcpu->arch.msr_hwcr & MSR_K7_HWCR_CPUID_USER_DIS);
 }
 
 static inline bool kvm_is_cpuid_allowed(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a91599e5d8db..8e2ef1e45bc7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3656,22 +3656,28 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_EFER:
 		return set_efer(vcpu, msr_info);
-	case MSR_K7_HWCR:
-		data &= ~(u64)0x40;	/* ignore flush filter disable */
-		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
-		data &= ~(u64)0x8;	/* ignore TLB cache disable */
-
+	case MSR_K7_HWCR: {
 		/*
 		 * Allow McStatusWrEn and TscFreqSel. (Linux guests from v3.2
 		 * through at least v6.6 whine if TscFreqSel is clear,
 		 * depending on F/M/S.
 		 */
-		if (data & ~(BIT_ULL(18) | BIT_ULL(24))) {
+		u64 valid = BIT_ULL(18) | BIT_ULL(24);
+
+		data &= ~(u64)0x40;	/* ignore flush filter disable */
+		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
+		data &= ~(u64)0x8;	/* ignore TLB cache disable */
+
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_GP_ON_USER_CPUID))
+			valid |= MSR_K7_HWCR_CPUID_USER_DIS;
+
+		if (data & ~valid) {
 			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 			return 1;
 		}
 		vcpu->arch.msr_hwcr = data;
 		break;
+	}
 	case MSR_FAM10H_MMIO_CONF_BASE:
 		if (data != 0) {
 			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
-- 
2.56.0.385.gd3acb90ef8-goog

