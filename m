Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72587481AB3
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013334; cv=none; b=KyVQQ1baaOtMyj3mdplocqZJDS7RbsLsjULsJvFAdkEX5cwS7GHdCvu5WXHPQOkrWXrKi8Xrx98nVERlwIgUVURVDRPXfe99H4KtD2rXXb28znS6nNSrkIDNphb5ml0gSE9XVqaSot/Ra5i0l3vlkXJUzYP7GLc7TpSM1zpTDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013334; c=relaxed/simple;
	bh=lIFtPDefGN4pZKmx1LcIKtuSPr3sotoJH/LTeXaKqYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ORMF5/Sxpr0L6ee4Pl/TA5u/muewywvBkUaKILLy5orOI9BmTfc/Ay43/YmdX8Yzusk5d1XenwrFNq/Kk6SKaWhkJqnVQT87S3m3A6Aluh0h1WUHShMxrH5wxyKDUpB6sfY4YeUc8MthpkXdnbQr/0CNN0DRch1S1bJDY8S4OII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9FqA+zZ; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9FqA+zZ"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-151ba226e1bso5200786c88.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792013332; x=1792618132; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Gya7QDSttHHSh0N+pmuAtqEl5ohukr8BqBh3CqW+rU=;
        b=c9FqA+zZi7Dx618uGEFeMCSOpNyoVjEDv/otfUOXve5d659Fr8vDPTJCQI2elFvqMR
         m1/po+Dp58/jLIeVfQI6HofgCEyjfIZoONSwB2pJ6XEEkpX/n1yJW7Bw6NF7Wbu8dzmF
         2jhULtRA0dMTN6iqz7PoapPe9FC24rAmoF/a2WrQFECTBu7unBUQvHYdqqHK2qXlRGgJ
         bTf8OS+CLjdRqs/rsTzh3XjYwysPmq+uoR//xo831Eb2NjLnQkiiGFbuH0YrzVmSaKSe
         RU/u2gZvfMtHEyqNXZnA1Mfam0GTERUffpjHYZbr3zXlR4meBXc10pGurSb0OtV5ZeS9
         /i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792013332; x=1792618132;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Gya7QDSttHHSh0N+pmuAtqEl5ohukr8BqBh3CqW+rU=;
        b=Ec/+bZzt0JBqAADYqArZet7Tjl1pOvycfeft4b46P9oBxel8Eyhgu4cPYXzzgcVLcx
         jksIa1+C6fCDbv0t/jasamAd3/nsNdejy3Asosdiuw7CL9TAbjWLQVoS0Win+Rz6M4/a
         v6mPDoZy8dOqYs5ZTyOQZqKjHWRKibDX3MlcxtxsfnkcaeXeA4bEHZ5L3iTU7XiH6mkY
         8IO/q4om7bYnwbXQi22Az5I8+Sov1v7tGoseo02snrr0JqNbnyF/zd42jAJsiFzxCpw6
         QA7NJhtcvBEb42OQK+LMykAOUeLWmEKwfYH8HQtll4Fd/CCnDQepibTL/7ZuCL0Vd2Ev
         XnwQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6eQcOYfMPlmx9v9Pbmmy94g6pROavh/3KD8chVW/2bU/Z/4wW71QsVypMV1cdqSDO0UtTPUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+X7YRy7Q8+p4oLe4DXzC9XEBIGiO+ja9G9sAfW+MnhbMKJ5OA
	Mjn8t9RhsUOxr1Ygh4vn39gnhiKkyqsQmbjtI4eGkgfotdeP1GpENupk7ZDS1AfMQCEnjyKI+p8
	bs8nqgvASPAVB9A==
X-Received: from dybry11.prod.google.com ([2002:a05:7301:4d0b:b0:355:6d34:db1c])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:454b:20b0:168:6ad8:e8c6 with SMTP id a92af1059eb24-16a5dcf59b8mr21932300c88.15.1792013332218;
 Wed, 14 Oct 2026 14:28:52 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:28:44 +0000
In-Reply-To: <20261014212844.11997-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261014212844.11997-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014212844.11997-7-aaltinay@google.com>
Subject: [PATCH 6.18.y 6/6] KVM: selftests: Update hwcr_msr_test for CPUID
 faulting bit
From: Anil Altinay <aaltinay@google.com>
To: aaltinay@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

commit b16c2aca369d180dc94275343b34966194317528 upstream.

Add BIT_ULL(35) (CpuidUserDis) to the valid mask in hwcr_msr_test, now that
KVM accepts writes to this bit when the guest CPUID advertises
CpuidUserDis.

Signed-off-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260527174347.2356165-6-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ 6.18 KVM selftests still use uint64_t rather than u64 ]
Signed-off-by: Anil Altinay <aaltinay@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 1 +
 tools/testing/selftests/kvm/x86/hwcr_msr_test.c     | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 51cd84b9ca66..64e57cbbd6d7 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -206,6 +206,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
 #define X86_FEATURE_SEV_SNP		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
+#define	X86_FEATURE_GP_ON_USER_CPUID	KVM_X86_CPU_FEATURE(0x80000021, 0, EAX, 17)
 #define	X86_FEATURE_PERFMON_V2		KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
 #define	X86_FEATURE_LBR_PMC_FREEZE	KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 2)
 
diff --git a/tools/testing/selftests/kvm/x86/hwcr_msr_test.c b/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
index 10b1b0ba374e..a9ae72279582 100644
--- a/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
+++ b/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
@@ -11,12 +11,17 @@
 void test_hwcr_bit(struct kvm_vcpu *vcpu, unsigned int bit)
 {
 	const uint64_t ignored = BIT_ULL(3) | BIT_ULL(6) | BIT_ULL(8);
-	const uint64_t valid = BIT_ULL(18) | BIT_ULL(24);
-	const uint64_t legal = ignored | valid;
+	uint64_t valid = BIT_ULL(18) | BIT_ULL(24);
 	uint64_t val = BIT_ULL(bit);
 	uint64_t actual;
+	uint64_t legal;
 	int r;
 
+	if (kvm_cpu_has(X86_FEATURE_GP_ON_USER_CPUID))
+		valid |= BIT_ULL(35);
+
+	legal = ignored | valid;
+
 	r = _vcpu_set_msr(vcpu, MSR_K7_HWCR, val);
 	TEST_ASSERT(val & ~legal ? !r : r == 1,
 		    "Expected KVM_SET_MSRS(MSR_K7_HWCR) = 0x%lx to %s",
-- 
2.56.0.385.gd3acb90ef8-goog

