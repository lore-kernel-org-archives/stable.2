Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE355C31C
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080240; cv=none; b=Y9dMAiACq6kfuuQEf0bKk+KvRj+GzngE/eXkBmoLQXf637YmzrHYnP9YfG5JIWXpfsv8aknLO5KaXEqFuMGYqMYx3XMgzAALwn84+A9gDZ1MaypaSrJQcHPup/kRYuLuhg1DFJGC0MznJ/1ijmYOsdk2XY0Ni1jf6wwvv/2PS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080240; c=relaxed/simple;
	bh=KvbIjug+XBjJ8+q6eUmAaqLmbq7NeEQbmpeTsgRct8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cz5XkTE8lt76KV7/WN5L8HvnibrDNoK3wb+xojgfRqDlz7V/iA3rclHEjXMp9y3XIu1cyLFeIlgniCZ+EwZRhvLEuhEyTfxV7OtK1MD3pIbsN06D+dhvlj/6m0diJFOgaiGi4O5+25CRb81TYigsPSXQPRFwkPAabzoPhdbZKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6nCM740; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6nCM740"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c5aef2a74so4103973eec.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792080229; x=1792685029; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrP53zkylH5jmJtpHdY3kkUPtRKe9lF58R5x6xGvDVo=;
        b=e6nCM740uJtxl5QXBzbqpHsO3w/Iw9At71WZ96a8nvtpsvoKBDMw8Q2V5LY2PM81He
         ngPC2k7nMZ8oLDo0cLj5Zq8F1satFaBKDzlMeOb+w44XFdGqJrprSgjSQYmwr5OJtrVn
         4DBJDbMh8gaLly7QMvkarnMDYfe6jfKC6FmMGBXdno370KFc9Wz7hadARJqSq4vFZdRx
         44XaswHTX3rLA8pIMVIAbxJ480aaqq+HpSPTPvPtWIXEFo1Z/wLrHXC82hV5Y0uyK6Yx
         QtQbBr8uHgYwJANuDcLRFtUrR6u8WTe82jpwcZwF9BHutTFG3YwFVRVEB4qt+7gFYmpO
         k1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080229; x=1792685029;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FrP53zkylH5jmJtpHdY3kkUPtRKe9lF58R5x6xGvDVo=;
        b=ZZgXEKh949pgSe5iuz6XZFp13bBwTvgO1pa6p8fbE6DR1ic50jvv19/7FEgo1NqUHH
         +HvJLdgeU7sJZ2lrpbrmLUmHh8G1+DLbKwKxXqrekqw2vIeg0IG3RNmLgz3btD5QpyDf
         zrrGLvOyTznVWWTZfAyZJy5DBHFd/KnRzSe3HVDvmE1wGHIH10RGw8eEcAi3NNQUMYTI
         B+s8czJ84sMNzSR2+4ziamm+8kxl0Zc/8MCcM8+wQnoJM7erq4gba+VDBlmxMhUxRUny
         ljCZtq8zwJqtcXSJ3CYX/yzywweacHmNRJSf4xQuLdhdCJnTZfIzaZOlzuO09CMFvT13
         pSaQ==
X-Gm-Message-State: AFq9FYI2tWP7RGNqD2lk4TW717dBaPbB22evIv9WyuL/X4oHYzU+auuP
	tShhT3dKRBvrHOL9BlYATZXyRI19FYlz67URp/O60X9xqBveJCMoIjcA+fErR/MLx9Y5LxzmO/o
	9SmPtgm+niZ/BGVFBch2P4RRyFiCVDe4vbfrg5TGfFUBK0NeYuurhjzlXbB9/C3nQi5SfDM7gLJ
	5/i3JqUDynAp/ok5wq4BKGYMhOzM7vAxSPn7JMP5dOZWVNo7U=
X-Received: from dybmd37.prod.google.com ([2002:a05:7301:1825:b0:351:1da6:c2e7])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:8420:b0:351:7f5c:dbe1 with SMTP id 5a478bee46e88-3537e02318amr29269341eec.28.1792080228503;
 Thu, 15 Oct 2026 09:03:48 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:03:41 +0000
In-Reply-To: <20261015160346.181835-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015160346.181835-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015160346.181835-2-aaltinay@google.com>
Subject: [PATCH 6.18.y v2 1/6] KVM: x86: Ignore cpuid faulting in SMM
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Anil Altinay <aaltinay@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

commit 690dc03859e7907bc995f389618c748619559477 upstream.

The Intel Virtualization Technology FlexMigration Application Note says,
"When CPUID faulting is enabled, all executions of the CPUID instruction
outside system-management mode (SMM) cause a general-protection exception
(#GP(0)) if the current privilege level (CPL) is greater than 0."

Always allow the execution of CPUID in SMM.

Fixes: db2336a80489 ("KVM: x86: virtualize cpuid faulting")
Signed-off-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260210234613.1383279-1-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Anil Altinay <aaltinay@google.com>
---
 arch/x86/kvm/cpuid.c   | 3 ++-
 arch/x86/kvm/emulate.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 913ffb995279..bfa89fbe826b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -2098,7 +2098,8 @@ int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 {
 	u32 eax, ebx, ecx, edx;
 
-	if (cpuid_fault_enabled(vcpu) && !kvm_require_cpl(vcpu, 0))
+	if (!is_smm(vcpu) && cpuid_fault_enabled(vcpu) &&
+	    !kvm_require_cpl(vcpu, 0))
 		return 1;
 
 	eax = kvm_rax_read(vcpu);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 9dbf3623e79e..8aa10d0e9894 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3560,10 +3560,10 @@ static int em_cpuid(struct x86_emulate_ctxt *ctxt)
 	u64 msr = 0;
 
 	ctxt->ops->get_msr(ctxt, MSR_MISC_FEATURES_ENABLES, &msr);
-	if (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
-	    ctxt->ops->cpl(ctxt)) {
+	if (!ctxt->ops->is_smm(ctxt) &&
+	    (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) &&
+	    ctxt->ops->cpl(ctxt))
 		return emulate_gp(ctxt, 0);
-	}
 
 	eax = reg_read(ctxt, VCPU_REGS_RAX);
 	ecx = reg_read(ctxt, VCPU_REGS_RCX);
-- 
2.56.0.385.gd3acb90ef8-goog

