Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE713A6B76
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080245; cv=none; b=UTAZgaML0IGbbLb6IvRX24A9cQhAY2HHV5aR2JEumRSULKuxEP1l5KvviDw3o/yjK4t91JZBtwu9VPL3t71hLsHbUWIbpmT+0VsEdA8YQ4zbC9/UlKT6mCUyZ2cqDB82KzEwT5+y2wTwRUliUN68AXq7wUivAGAHlgeSqidnGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080245; c=relaxed/simple;
	bh=J+jkhnGVw3vvhDoqG6FR+sdYUrS5qCP0EWyTOgkwu1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ar3jQgFbDm6Ag4ns/Tf1Z497wY4kOg/EJiaSdo1RH0KpZWtBnZBgUiL+MC1hAXpxSycDco2XXp09ImhCGle0ap68K5Lsdrv7x14a/yz/Ou6w25Nsow0pIjpBX5rIvhnDVJbHdJZRfoPIQlytjBCB3JQFJXaGbc+HoVdoHw55vKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcTff0QM; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcTff0QM"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3510d0baf63so6867590eec.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792080233; x=1792685033; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxNJDyDJG3p3TODXcLYOqAKzmxTypvEoRRB1/QzaNZI=;
        b=fcTff0QMjnfZvDjFX9F0c0xMb4WvtiTVRP6ua6mdV9DKM+uMxXSLiry24pNReAJChm
         IW7O2mreWQAooeuvxbdUAiSrZKl0S7jR8iFJneUc/LkTm3I+WiWI5zs79+HWtTPgH4B7
         /0SBlYBZ2xSKM5vdLPGeNMIvCEpUxwPtaGXFTwUtBPbNtx6NOmincq+0BiXisBKcaKXm
         5hROISHONnOaVOE5QsYfFWvG1unFo0uBXCKk1w9wsdLomju0grVkZ3bO7sKkQmwztNsI
         jRS7WnsRZtVpB+npjzjUjBdtkmcbzzbaZWjt51mt8nn+H94XSy38SCK2qzLkTnaz07Lj
         u1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080233; x=1792685033;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxNJDyDJG3p3TODXcLYOqAKzmxTypvEoRRB1/QzaNZI=;
        b=uAl6xY1N0xKfx3c5NFbDzcSNlg1bJ9kwTRyMAo4ut5Q7pmZ42TT62NYQ8Ofcj68bWx
         4CTBsDtIgRpPdoQnU45iQ8CWQAvWC+bqIKKbq3E3ORFjnXMxRQB7cT9qd/v4EvbEVTO7
         4KSZo3j/m5x24TzHYkZP8q+7b5KjuZN2riFY4TJ28koJUHmTaRmGkjX8CZ2G6WXTmrVC
         RiwW5VKZOirHVJYo9Ed+0ztg3SyCx1+AgenILyGvRXnA+9hTp5zUpMJwHCSfLg3YyJ2z
         wFQ+dzwhyXzO/hlmJT4f+1IFeN80RrWWgr1bc8VfZI2wR5QNPaSDclcmW21aK+OeIxb6
         U2yQ==
X-Gm-Message-State: AFq9FYJv2f32N5MOUUM5FOOWxteVdnt2hqpy0Dx03nq/6cgiSzotcdTN
	DoqlmVJ+wX7iMXW0i8ommr1Yh8bL3iPtUnPmOH/Pbgt13Xwn07rj+8JwVy4DO78DD0lWuu7Yqch
	EZKwjLeeAlkBeEAfNhacTLlGIgnZxgkY9TzMz4h+6QpreVGT8xsMtSA2C3VuzEw+PkxozvVVieo
	gwXnZXoXp1aZ7MSoJwL9mtQmaxlwLVPwhnWPHE8vo/tnCAo8k=
X-Received: from dli6-n2.prod.google.com ([2002:a05:7022:286:20b0:15c:6a90:d4ff])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2806:b0:137:5b9d:cf87 with SMTP id a92af1059eb24-16a4e6cb97cmr28450678c88.0.1792080231948;
 Thu, 15 Oct 2026 09:03:51 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:03:44 +0000
In-Reply-To: <20261015160346.181835-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015160346.181835-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015160346.181835-5-aaltinay@google.com>
Subject: [PATCH 6.18.y v2 4/6] KVM: x86: Remove supports_cpuid_fault() helper
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Anil Altinay <aaltinay@google.com>
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

