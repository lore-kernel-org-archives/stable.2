Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539947;
	b=da5cZNQpo7bViDrcudg/I4PtPOX6VquOWmNtNy0+piTxqH3YRVnjOyPyGnFsyTJaxxXg
	 A8t7ssa2l0TJwEsrJB0zDjekWYrbWlm506fShDTy/iAcw2cjyFMVBZL8J9othV+VDWDT1
	 AZqO+LrGAGuTIMduF/+po6s2sYzG36AGtxWE2Iwy7PoFOoggri2gXORHaFbHecsYzT1wr
	 OkDpvFD5eBfPkNhAgikwQnTdXFJjZXDGeDttTGu5qn7dyle0gWMuyQOJRAFjHzvnYjKgf
	 AwpyTG61ttIWqERNLEnJRuTBCyq7sezjF6/JnGXbvWEHxBENllWI1nXNFIYi/uoYSqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=W+TfMg64jOFPKI8BrWsSCAubaYF+Edkz42TVHe5mp54=;
	b=CQBxvcCq8VkLj7eeLEDMGqxzBOmkkb0DALYLyOQB8ycAh6+wto0cfF7U/iSwvG2VE+Qj
	 iTHsfQnYr8lutxH2IY7MUZfd64AC6IbtDbFM1tkzcYn01b+f7pV7TedQUuBE/Zvz9V6bg
	 0nfTCamg5g+XOxbuHD5ooAh8h5WkE2C1pA7969ta84FgLAb79G8mJIVYi2h1wTeq/l2ZP
	 jNWOVJGRyTswESWKLZfMpv8h3+hboPZ28Iz3DssYqHCoHhbTUk2qlT7uzQLuqrhTBb5zO
	 PRWqGmEbQszQe/rRZcrbYDaZ/Ki55TmAjebvglgncaaH3rJAhwUMDfRxQqVaoWnoTaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fNqBYri7;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396B606A31F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 23:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1396B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fNqBYri7
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cec4226c70so1167695ad.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792539946; x=1793144746; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+TfMg64jOFPKI8BrWsSCAubaYF+Edkz42TVHe5mp54=;
        b=fNqBYri7Wtk5slO02Y5jEVgsAVAgpJfH3SIXMDKq6j1HcMVW+ULbdTgjbkIcJSYQCQ
         05HAmnLteeAvznFgbI+yJ2vBw3pgiAmuMlN41PN191jMcloX12swGd6ECKfdliVkHwA1
         PfDzPOV3FTzYCVlze+cfeLCmkL/EB99hoMZZlRZcPRc3FINNWRj0B095geK0pvoGjfmy
         CXFvagXTgxiDdvbHbD8DfaKBNXUbt3QyWzW9kId4pTaN/tQEDubpaNsm4yk/IgskZ9lf
         gs95ghKGf8WiXViAnmRS9T1YF2t72wPQdUqVgHYi342SR3Ew40CCwmj0j4iuu+5/kGFF
         dgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792539946; x=1793144746;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+TfMg64jOFPKI8BrWsSCAubaYF+Edkz42TVHe5mp54=;
        b=SoBXyTV4OP+mm+P4Fx2srG6ffQiCH6uZm/v5377SpEJNoYdDpcssTWrjowcsw8Oxqn
         G32V5QYiQB6FpcvERhrM8E9or5bvd91SV+0tL6yFOxUNirN+i1qiKo7Pclb6jKUhuP3g
         uRMq3ok1Y5kVCvwzaiZx3EqK+VEKl0LDoxa6bh7DMF5yOzj1SKQ1O6fQPIsWeb2fJV4f
         UpTnBHAO1SJvqEw7m0amQqQACbY7vctWmpQEwur3m47Jvfyeb6CwVHZRyocjQ5wwEXqY
         SjroTSlCxMirvHidc8KpkO/YIkS6lTNav4oV97A4mKf2t3Xg7zCBnz1Z/hE7SD7X1XJw
         MsnQ==
X-Forwarded-Encrypted: i=1; AKwUvByufenkuOmQniVoHhOr6vIzdxGiGKFD74pn4S3uy4BLH27SSdOOt1ACzOjcONvmkkpsG/JjYmU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEOENX5GVsXk0U0HlK6l6T2nNkWfjo33r68wRXDeo3zcFpqhWw
	BjmLCgEY0ijcBcAzVOrW3U7l2z0zWHuU9uFG5HcmtyJ84/llLcLW1lnUtGDY7sSDPop17zczR/4
	qLetOlOYtUOZzIA==
X-Received: from plbkk5.prod.google.com ([2002:a17:903:705:b0:2e9:7e8e:b72e])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc6:b0:2dd:ad73:c98b with SMTP id d9443c01a7336-2ea43f928abmr2553835ad.35.1792539945981;
 Tue, 20 Oct 2026 16:45:45 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:45:27 -0700
In-Reply-To: <20261020234535.3182385-1-jmattson@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020234535.3182385-1-jmattson@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020234535.3182385-2-jmattson@google.com>
Subject: [PATCH 1/4] KVM: SVM: Always update LBR MSR intercepts on full MSR
 intercept recalc
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Like Xu <likexu@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Split the "already up-to-date" check out of the code that writes the LBR
MSR intercepts, and write the intercepts unconditionally from
svm_recalc_msr_intercepts(), so that changes to userspace MSR filters are
reflected in the MSR permissions map.

svm_recalc_msr_intercepts() is invoked in response to
KVM_REQ_RECALC_INTERCEPTS, which is raised on MSR filter updates.  But
svm->lbr_msrs_intercepted tracks only the interception KVM wants, not
what is actually in the bitmap after the filter is applied.  If the LBR
MSRs are passed through when userspace installs a filter that denies
them, the early return leaves them passed through, and the guest can
access them without exiting to userspace.  Conversely, if a filter
forced interception when LBR virtualization was enabled, relaxing the
filter leaves the MSRs needlessly intercepted.  Either way, the bitmap
remains stale until the next change to LBR_CTL.

Full intercept recalculations are rare (e.g. on RESET/INIT, EFER.SVME
toggles, and CPUID, PERF_CAPABILITIES, and MSR filter updates), and
never happen on nested VMRUN or #VMEXIT, so writing the intercepts there
does not reintroduce the redundant per-VMRUN bitmap updates that the
check was added to avoid.  And because svm_recalc_msr_intercepts()
already unconditionally writes the intercepts for many other MSRs (and
thus marks Hyper-V's nested enlightenments dirty), writing the LBR MSR
intercepts there doesn't introduce any new invalidations.

Add a comment to clarify that lbr_msrs_intercepted reflects KVM's
desired interception, not necessarily the state of the bitmap.

Fixes: 3fa05f96fc08 ("KVM: SVM: Fix redundant updates of LBR MSR intercepts")
Cc: stable@vger.kernel.org
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 28 +++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.h |  6 ++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fe0cba4731b2..55b3ee840365 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -721,14 +721,11 @@ void *svm_alloc_permissions_map(unsigned long size, gfp_t gfp_mask)
 	return pm;
 }
 
-static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
+static void svm_set_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool intercept = !(svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
 
-	if (intercept == svm->lbr_msrs_intercepted)
-		return;
-
 	svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTBRANCHFROMIP, MSR_TYPE_RW, intercept);
 	svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTBRANCHTOIP, MSR_TYPE_RW, intercept);
 	svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTINTFROMIP, MSR_TYPE_RW, intercept);
@@ -740,6 +737,22 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 	svm->lbr_msrs_intercepted = intercept;
 }
 
+static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	bool intercept = !(svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
+
+	/*
+	 * Skip redundant updates from svm_update_lbrv(), e.g. on every nested
+	 * VMRUN and #VMEXIT.  Note, svm_recalc_msr_intercepts() updates the
+	 * bitmap unconditionally, as userspace MSR filters may have changed.
+	 */
+	if (intercept == svm->lbr_msrs_intercepted)
+		return;
+
+	svm_set_lbr_msr_intercepts(vcpu);
+}
+
 void svm_vcpu_free_msrpm(void *msrpm)
 {
 	__free_pages(virt_to_page(msrpm), get_order(MSRPM_SIZE));
@@ -795,8 +808,13 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 	svm_disable_intercept_for_msr(vcpu, MSR_SYSCALL_MASK, MSR_TYPE_RW);
 #endif
 
+	/*
+	 * Unconditionally refresh the LBR MSR intercepts, as userspace MSR
+	 * filters may have changed, in which case the bitmap may be stale even
+	 * if KVM's desired interception hasn't changed.
+	 */
 	if (lbrv)
-		svm_recalc_lbr_msr_intercepts(vcpu);
+		svm_set_lbr_msr_intercepts(vcpu);
 
 	if (cpu_feature_enabled(X86_FEATURE_IBPB))
 		svm_set_intercept_for_msr(vcpu, MSR_IA32_PRED_CMD, MSR_TYPE_W,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 84f19026d3e8..62e08d6d4706 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -364,6 +364,12 @@ struct vcpu_svm {
 
 	bool avic_irq_window;
 	bool x2avic_msrs_intercepted;
+
+	/*
+	 * True if KVM wants the LBR MSRs to be intercepted.  Note, userspace MSR
+	 * filters may force interception regardless, i.e. this doesn't
+	 * necessarily reflect the state of the MSR bitmap.
+	 */
 	bool lbr_msrs_intercepted;
 
 	/* Guest GIF value, used when vGIF is not enabled */
-- 
2.56.0.212.g129ede20d9-goog

