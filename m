Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184B3B9DAD
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781900578; cv=none; b=dmZGZdKOLoqNmkvg97FumXyV4so/AIhlcB8uHfmeXiq+o3KHmGPYQKRk8x3X9zitYQXeOOURkGKyhXy7NBnqj71FxG7iJtFGAbhv4kQ8SIBBVZTyCw8SdhjEPVeRGplpueq8OvDjMpgbyh/GgUdY/eHW+5D9X1WSh0mJyUorI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781900578; c=relaxed/simple;
	bh=u3DS0RW8qwKnPXbLqw4zkRsFPGr0SmLyS4ByHV94B/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEOpGsc8918vXPxIz1obQjBUkXRPmKjYPr40QmUA92xenpMZlSOFw2xxfNz4TJVOSBFtib8wdIN4/vWIfmhRbdbNv1m8dnG6f/EFjkImycQV1dwHl3lbWyx3eLPpYaCrkiyB4zsPBQsTCGy7ejHk60sMguXLPQ7yTl8wbLVUwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zid7w9KX; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zid7w9KX"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8dea42b547eso14040326d6.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781900574; x=1782505374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd1mWB6GNyNzgHCKDKsPJpGXztRF54FOFrBz+pWkAI8=;
        b=Zid7w9KXsGbhEKdzMLDTLrJopHDTO3ZPyLjdmC++YjYIfcKXkxN9sPtLzIwWeFAd7j
         dUA+OVP1IWV2mIjRAKNFanpGH5fcqOcUlHeb0koOMCb+z0vwfonkR2ZW9d8tX4yprkSf
         xpTt6wxBvRuu6Oc49ndujtv5IAhx6BpKRCxfG0frdGY4G9p72nNSmDFMp1nib9Af85gi
         ZZErnWGny5vV+bGS0K9A21l+1IFWyvkTn0aMhZUHiiWZ2HhM9xoZZ1yO2b+E5dgDvPdI
         N9EHE7GXEJ6ZP1RFLO9tt/c/Yr4gf8FOPEadjEih349MV1F8QIa1BfBKiepdcMXTuVUN
         FZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781900574; x=1782505374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bd1mWB6GNyNzgHCKDKsPJpGXztRF54FOFrBz+pWkAI8=;
        b=sTbHKZ1J0+H2UdaqjAfWmzj79iNv4kY4ncFE/FVzxkaXOJyv5lUyeCN1NUc1yBJ63J
         hRFzdk2fXucrrx8zwF+8FEE9OAtMiXjiBcfYW4NVBKI1xU8iwYZJTdD3av1PNaqQ73hU
         iaFg+YMKx8gA8twQ2uvMThnlDmy0GClxHPkU8czyxbmqeIVbIqnqUSjmJQhYzM0hi60x
         C5F3rf1blssbXg7XQhEe3gzouYb74+uZ+rPolHB6p/UCmZSvfsmP152og1u6FjIbb2im
         bL8bBnnp3kz1w7CntdeMcOO6QXL7weXn1NQhTboK50NTz8BvcwaEI+Sn0XjITSS4KHwD
         7CgA==
X-Gm-Message-State: AOJu0YzXjUdmDENmWM3J4fpk1bWDu6P1zOJoaQrMXitgIGaooyz7o1qx
	zWyMrJWvjouHmNSRokNXxLXl5FDFPjOxogr2K6decpDtDmlItZbEejk7X+4ZGmYGgts=
X-Gm-Gg: AfdE7ck4uqpgHXhw4PNTB/WePo/33Yl3AM7lSocBiLR9TQRRdgo/uZJFyKVaaqGyWG1
	CRhvTfELORze6FiKaEwdY54Wm7VwQ/N55lJI1L6DfxWUVfNwuc2NpC/F0tjhRMLQG5ScaDjAGpK
	Z4DU3Tcbkj1RDVEfP1GYDle1Yk2nIiavNXZzgMy3JWsWulAl9/uu5kZMBE+rcXfj4b4n23V4Gvs
	+mPa67dbp/OZlzon1EU+I3DY5RMP1BDGAh5DEINriFDZKZXy0nUOtMND4SADSTEoeOmrcjB13Ap
	yvHywE4SR1Lzt4J15xsMKEp8dqnC7bPKUelKZAEbzduXgTTnYWA086fvxuPIGO3MsYxl3NKYnrO
	7Tu9A6ardoitmpvMKhpJpyJbsCpWazLuJOnF5hjXdNlD1aal9H/lWxlHr4URfB1DDZRccFRGv97
	6rnXD/0yu/Xn9AwAw=
X-Received: by 2002:a05:622a:1652:b0:517:6804:3732 with SMTP id d75a77b69052e-519e4e3c500mr77294351cf.55.1781900574208;
        Fri, 19 Jun 2026 13:22:54 -0700 (PDT)
Received: from TurinLinux.. ([37.19.212.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a0984da98sm3921561cf.15.2026.06.19.13.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:22:53 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: main.kalliope@gmail.com
Cc: stable@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.1.y 1/3] KVM: nVMX: Add a helper to get highest pending from Posted Interrupt vector
Date: Fri, 19 Jun 2026 16:22:23 -0400
Message-Id: <20260619202225.2749389-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619202225.2749389-1-main.kalliope@gmail.com>
References: <20260619202225.2749389-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit d83c36d822be44db4bad0c43bea99c8908f54117 upstream.

Add a helper to retrieve the highest pending vector given a Posted
Interrupt descriptor.  While the actual operation is straightforward, it's
surprisingly easy to mess up, e.g. if one tries to reuse lapic.c's
find_highest_vector(), which doesn't work with PID.PIR due to the APIC's
IRR and ISR component registers being physically discontiguous (they're
4-byte registers aligned at 16-byte intervals).

To make PIR handling more consistent with respect to IRR and ISR handling,
return -1 to indicate "no interrupt pending".

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240607172609.3205077-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Nicholas Dudar: backport to 6.1.y. 6.1.y defines struct pi_desc in
  posted_intr.h and predates the move to <asm/posted_intr.h>, so the helper
  and the <linux/find.h> include go in posted_intr.h. ]
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/x86/kvm/vmx/nested.c      |  5 +++--
 arch/x86/kvm/vmx/posted_intr.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bdc462944..7d8e18dbe 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -12,6 +12,7 @@
 #include "mmu.h"
 #include "nested.h"
 #include "pmu.h"
+#include "posted_intr.h"
 #include "sgx.h"
 #include "trace.h"
 #include "vmx.h"
@@ -3818,8 +3819,8 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
 		return 0;
 
-	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
-	if (max_irr != 256) {
+	max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
+	if (max_irr > 0) {
 		vapic_page = vmx->nested.virtual_apic_map.hva;
 		if (!vapic_page)
 			goto mmio_needed;
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index 269920765..88cea0dac 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -2,6 +2,8 @@
 #ifndef __KVM_X86_VMX_POSTED_INTR_H
 #define __KVM_X86_VMX_POSTED_INTR_H
 
+#include <linux/find.h>
+
 #define POSTED_INTR_ON  0
 #define POSTED_INTR_SN  1
 
@@ -103,4 +105,12 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 		       uint32_t guest_irq, bool set);
 void vmx_pi_start_assignment(struct kvm *kvm);
 
+static inline int pi_find_highest_vector(struct pi_desc *pi_desc)
+{
+	int vec;
+
+	vec = find_last_bit((unsigned long *)pi_desc->pir, 256);
+	return vec < 256 ? vec : -1;
+}
+
 #endif /* __KVM_X86_VMX_POSTED_INTR_H */
-- 
2.34.1

