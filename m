Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3EF480DED
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013333; cv=none; b=FoST3qtEgN7wTrrkSX0MS5du989PG+Nr9qLO6brIkc5OR0yqAmAZbXqTREtaJ/dIisO9uqFLSTfOgQID9RN2enC73wM0B+serAWuKjSljym/M4FTtRhpLp06t23ZisjR/CTLx0KcT+/dqQ6ZvjJnq1ZNBsIEKa36mNmWiQkWSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013333; c=relaxed/simple;
	bh=gWK8Y6FBWvhqz0btGx1LmwUcE/dTxHRwTzZ3bPzjbFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eWuQoKd/NzbpJKzFE8piLUqqryayFgTHlpv7/kRsQHodO/w1/2gtmR/3OCCe5RSUiOTfIGbvUdRj5WsOnqolQnz+BZLO3dvGkKhyAztNyS4nCZ65/sL7/stEAKbRiXztNMWXu9fsIQYMmAd6aSqxoMUwxidAmMbx72UXKl1qmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtFEwqym; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtFEwqym"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1665200f4c2so6386889c88.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792013331; x=1792618131; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/HTMhf4d9uTe7pfHFO8gXnRLSbjR8N6Nyp6yU1jUvI=;
        b=qtFEwqymKvLPTDOtwt5yCJSTrg2x+LIFIORE8KKxwXDlAuuUELyEQYfTZ1Qg/hKy87
         cWOYRuDbBZg8wBDd94X/EjsSX6nCJggl+8LFYuyC76DWYMP26LIXBrLAWD792wDeS57t
         UzNDwCN+BYJNskAMwesgf+q5nYqnE2L+pGAtyDZ0IDppmyV3qNIsLDmzXRgnHCI7wzBY
         TMrLVYQnNvWdu/2Z9alxBLam3l0kvbjer7p1mmg12KR/hlkKF+vPpy/5qADdzFUWk52J
         EdrvPT7ixx+ek87aktzF1Ebv+x3mDNha5ZyuMnSUBxoVvwlvPutgy5mRjObrt5LSbicG
         c8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792013331; x=1792618131;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/HTMhf4d9uTe7pfHFO8gXnRLSbjR8N6Nyp6yU1jUvI=;
        b=Qg2r5dkjnts9GzlORJHH24xQr/tzkV1OmlAJ7AgQM4SrvsWsegxrAWMg4RBkhbYZJI
         n9oAQ10YX/X/z4x0hd0DPDd8olBGAAoVDdsY2xuAqPJWvWhfeL78qodQj1a4MgKOan+R
         m/OtfkyqNHf3O6y4mNcy6szuqJ2NF1pRivsJ0IfCHwyQk9v6dbWS5vBLfJ1FTvyBfEl3
         363gxQsreRWpkms1ji/11CNg8Kugr3GaI7GXzaeIwLvQv8pxG6oHA35bLmYkkk+PMoD5
         z/Koe1cmtyQveo5ieB9+6h2g3tHCyZ7j+1Bxbh3zu3aDU2Cg4dpJBrSi6NVnl+kvzFU6
         fsyA==
X-Forwarded-Encrypted: i=1; AKwUvBwO3J9oBXfTXOqoopHdC62NUqoQTpzgexFq78QjMAqWU3S7aQW7VnTMFiminrMk9mRUg8TFqTY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRb9f2O7nYrvSQ+g2MjANxeZSFLmIMPWL0Dy1HMDOqGsxhbGFj
	HHUFSx6lxAnrL6hqa84WZ4ODmW+8zrXy8sldU3B9uqkUUedDqzoXv3VWJCNGMFuq/ZXibQOLDvR
	RV9Wg13fnoNJdbg==
X-Received: from dlbrc1-n1.prod.google.com ([2002:a05:7022:ea81:10b0:14a:84ec:bd53])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:170a:b0:14b:588b:c817 with SMTP id a92af1059eb24-16a54adb67amr20028813c88.3.1792013331133;
 Wed, 14 Oct 2026 14:28:51 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:28:43 +0000
In-Reply-To: <20261014212844.11997-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261014212844.11997-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014212844.11997-6-aaltinay@google.com>
Subject: [PATCH 6.18.y 5/6] KVM: x86: Virtualize AMD CPUID faulting
From: Anil Altinay <aaltinay@google.com>
To: aaltinay@google.com, stable@vger.kernel.org
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

