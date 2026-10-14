Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2A47D464
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013329; cv=none; b=s0oEJ+HPjEU11oomR4CAOKg6mvSnRuO6N5vsEgGwID5IYM7aHHp9OYESJWs9BiiGEmNFMdhuUK6Y76CLymxcTKU+cuVZTSNwmEysx1cP7ICZaZRZcm6J0j+BL4jipTHuwfJ4Im4yXymtIp0SkON6afSBoP22WNh3jQPlVGMCW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013329; c=relaxed/simple;
	bh=KvbIjug+XBjJ8+q6eUmAaqLmbq7NeEQbmpeTsgRct8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NTtYJ0FA9wBABjQVLvTewHvKPIDaLWxk277IYUiVgPq3wyLcoqTbn4aMlcGm6aziXoTtuoiQ7VwymaiurKH12qRsNPCE222qnKaLBk5zEslEl2I2I5hYBPBBdLoVo1iFJEAbrZ3ee7u7cKTADDbTAJsd9FAdSgVrgkZU0c92sAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATqRhiMl; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATqRhiMl"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-357e2bc3b1bso7366661eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792013327; x=1792618127; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrP53zkylH5jmJtpHdY3kkUPtRKe9lF58R5x6xGvDVo=;
        b=ATqRhiMlNVuXL/yPvY9dId4aprBvcU/swE4rsgXz24cr0VI/XzzfioFnhEXI/wsMJz
         nZ9/wJM/w3+J2EC7KvgiSvlRY6kdO2R1UrO3GMGa440u4+KPSuvJcS8aT7UuT9An3ASR
         Uu+XBs/6StRMVxbwLU/+h4zKlcRj5IwYg7+4apDt2e8mUD4U/BlZQZXgWNvpw1PRP1mO
         X1f4lbuoYmhmRnhtUGJ3HsHYDB5F2ChTbuJw0eziLjv5J/6PmR0Jws1/d0Vl3ZsbxMQ4
         JFgDSUaBxWa1QZ6JESppyOtsTyI8TIDjsVG8wTrRg1+ufv08/5SpylCSDSG33egQBy6V
         l2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792013327; x=1792618127;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FrP53zkylH5jmJtpHdY3kkUPtRKe9lF58R5x6xGvDVo=;
        b=KB0gChjt5AM3Cy7tMMzeXpcJ7o0cR54d6LjXognLhOrQ/Osdc97ax7Xb4f2A6HUhnS
         1qwmsEql+5lvOJQY0TP7axtg1bq6uzFzwdnUoNYF3UKjBLwjA4CBuFH6v/wma0DpUvtZ
         rHVVlc2fBNeYGq+9/N7xyXH8SbcqupGVvGhhSix+yvpPhJJzPYux2NbJT9bfbCgyw6iN
         37AYKnHzj6k+/JUQuPFCF8F1DrXQ5GSavEtWu1OhjaTyLniJuYv3PiTQtDblPiaFw51I
         pdCgPHqH71HJFAcwTEfzFtGHjhTGZAMEH6Q0plcTUjDYw6w6n9qY7Oeb2YgCQTTVI9I9
         ElpA==
X-Forwarded-Encrypted: i=1; AKwUvBxxkz0nGwjNz8wSrN1DmkH/IMfxsWix03mXy/j9MJGCuJKBF5gOzbpwN4BkkQIWjh8MxFFgVq0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhaImv7xkaU/PT9+EpGGOWqJoia/0kHvbIp62AlqSL1bLUUnra
	3AHWxCjPdYZYSVnhjySvBEoMhHoWoCH2Q1CBpo/ELmGLNP9vzjGnxZBd30YSQ4txkofv0JcS0KJ
	fgoQAM0DudsjM2Q==
X-Received: from dycmo5.prod.google.com ([2002:a05:693c:26c5:b0:35a:9fe1:dbbc])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:71a4:b0:35a:4ad6:d215 with SMTP id 5a478bee46e88-35a4ae61ed4mr14575792eec.22.1792013326375;
 Wed, 14 Oct 2026 14:28:46 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:28:39 +0000
In-Reply-To: <20261014212844.11997-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261014212844.11997-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014212844.11997-2-aaltinay@google.com>
Subject: [PATCH 6.18.y 1/6] KVM: x86: Ignore cpuid faulting in SMM
From: Anil Altinay <aaltinay@google.com>
To: aaltinay@google.com, stable@vger.kernel.org
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

