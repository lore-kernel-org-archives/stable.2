Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9DE481AB3
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013332; cv=none; b=ElSDCAZrQozqY2MxgktCEBmIZgrYe/XAQ6XPLykP6Rp60DXXwQKBquPpVp4N25bRPdWIgw5M2DzV/vTNW2ynd6pznLw5CONfJoy0JlPRBZlLKcvZ8RkuZf23D7AWBJCjhnUUHxo/3CYdlRL2eu41Pp+iTmAo56xku3T4r8H5E+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013332; c=relaxed/simple;
	bh=J+jkhnGVw3vvhDoqG6FR+sdYUrS5qCP0EWyTOgkwu1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZQbu2ZkiVy1bYM9qkXgED8VpLqDW2W1ThKga2H71NlomoiClZTR7mFSPGG4v1EKejqdqkyKwl1EAlYMkT9+pZcYLkqVYx4fEMPhtddXN80Z30uPFRybhvhw8o3Tew6KR1ntZLmm4C6U7WczYhqrfH8rJGPQ6wnuLJOBZrVu4C4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VGa1HP5W; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGa1HP5W"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3552883bd19so8532177eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792013330; x=1792618130; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxNJDyDJG3p3TODXcLYOqAKzmxTypvEoRRB1/QzaNZI=;
        b=VGa1HP5WByiQodxVGKp4tYFsWMfGWFmaoPMI+zzcfV5xgol6Bh6laa1TRg4MbyG479
         M6r4ZeCEzST14PCqWpR4bc6JGXxk42MoJPmijq/X+Ncvcd9KIcHbYJPfnOQwPY+bx2m6
         0Ffw3rS9r0pZkv2a7P5eEUSzVBtEURhYrKDUMKrfKsqFc+hRY+tr3gQ3KwUWMMXcIUN1
         wAgM7yQjejZN5D9afJg6p8E9Ft8OiO65tkhtl8MfkLW5945t5DEbnNvgL72jbBLFi1vL
         aJGLLago1my2eOKkvVeoRSeF/uBDJd6BugPcXdu1Hs8EIbDE0x2KDBYG9Y/XluYjMuW9
         SCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792013330; x=1792618130;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxNJDyDJG3p3TODXcLYOqAKzmxTypvEoRRB1/QzaNZI=;
        b=ipAFAoqADj1SPr4Js/+dtq7s2KhXPj9jraL+N0dYt6VahL3yCHEJdyH1L1QmwVmhmg
         +CmCOmpxs3W9G/C+Qlh4hxSmbZRCBw88Hjmea66+4fDc30yJQulRSHHQ4lqAogCmmqSE
         Un6ek9wHNHH9x+Wyz2hiGKmFgpd9agVxS5OiUaPBm0cB4MpVXcVhTCemmGnakyFe8+KA
         NaautsSESFd+t9n93FeD+QM22EQJ9bU5bdY1zuGDvDWNRJRZLNYhOI+0zr4+HTHC6z9V
         As/ljDppYYxBY3VazlxIA6ZpARMo9HlWfVt4f3kn4ZQJNyWKJ751tQI1NNk+aS+ifZGs
         upQw==
X-Forwarded-Encrypted: i=1; AKwUvBw0x+us/gNEY/HwTratJ4GUokVIEX/DgTUewMijpzcO+cBGSvt5rdIJDgbajIAotCVTRvwHB9g=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1zzHfFZ/iKgLJHHx12/EHQSLEYQZKYSYQ2DzVQaXdo0RijKE6
	sknUIvCJuCbfhjgzpgADAL9e0+1hALeTzv9kJgAc57iJMfG/heDJnkSeuM6MVRLE5N2ZBcR0M8x
	mMzFw1szOiteb8Q==
X-Received: from dybvo17.prod.google.com ([2002:a05:7301:7711:b0:343:c524:e6f8])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:103:b0:35d:f7f4:bc1c with SMTP id 5a478bee46e88-35df7f4bd83mr3993081eec.6.1792013330167;
 Wed, 14 Oct 2026 14:28:50 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:28:42 +0000
In-Reply-To: <20261014212844.11997-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261014212844.11997-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014212844.11997-5-aaltinay@google.com>
Subject: [PATCH 6.18.y 4/6] KVM: x86: Remove supports_cpuid_fault() helper
From: Anil Altinay <aaltinay@google.com>
To: aaltinay@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

commit d1bc99885a59d89e408f52f4c147b07bca9a686f upstream.

The function, supports_cpuid_fault(), tests specifically for guest support
of Intel's CPUID faulting feature. It does not test for guest support of
AMD's CPUID faulting feature.

To avoid confusion, remove the helper.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Link: https://patch.msgid.link/20260527174347.2356165-4-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Anil Altinay <aaltinay@google.com>
---
 arch/x86/kvm/cpuid.h | 5 -----
 arch/x86/kvm/x86.c   | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index c5399ab7e5ae..872bc99c55ed 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -175,11 +175,6 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
 	return x86_stepping(best->eax);
 }
 
-static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
-}
-
 static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.msr_misc_features_enables &
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6f76290e79c9..a91599e5d8db 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3913,7 +3913,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_MISC_FEATURES_ENABLES:
 		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
 		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
-		     !supports_cpuid_fault(vcpu)))
+		     !(vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT)))
 			return 1;
 		vcpu->arch.msr_misc_features_enables = data;
 		break;
-- 
2.56.0.385.gd3acb90ef8-goog

