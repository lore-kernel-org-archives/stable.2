Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1041A781
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202017; cv=none; b=Fz1XNpA38VUdXnK2iodOwQo3YA+/O5nnw4MDcea95bXxCXP3URkcUfi2dJ3TS0yBMc0Cvb1ZBnFuWIHWYygzsKdgneLOChyWPg+C83NwOWbJljrWrhzA6dMy30Lp17S6jy9h+vk12M0+ZX8TmkDaUihsmSXBtVMpW2G1thkm1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202017; c=relaxed/simple;
	bh=t5LYsn6RGYkK2/ZAlXTdz37FVzyb/lomTwOHSJY94QI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q+s3cMjbd2TINcTDwWGIAoq0ElRbYExqGI2FV953MUNcIbaKUs2ga2GEAoJKRhwuIyehGCv5y93f0V+QbnHwE9gei31cElmjE4K1Lk/GPR4I5W/f0kMF6vaAisqQfvQOgAkntAPr43bd4Bk0zIsZD4fHcTyp1zWzCkU84Y5S1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pIa4BeHK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pIa4BeHK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93451F000E9;
	Thu, 16 Jul 2026 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202012;
	bh=bFJx51eMcqtTSKvOdGOXEN4fgXxioMacWebhnm3ppEU=;
	h=Subject:To:Cc:From:Date;
	b=pIa4BeHKxKYck8cHipcjOqXuoKwBXhDIL7JjzLP6vsGiY+6/IqEZpa+nolMOTD739
	 KldwCxKy0BEnDAhyfpgrHQcXtG1Ks0ouoPMHlLpkvTX/u91fdWKUM0OGTTFsBzOWLU
	 1yuLRzDRKoqEdBgNe/L3WXS3Grfk9vGpGeFtkNF0=
Subject: FAILED: patch "[PATCH] KVM: SVM: Only disable x2AVIC WRMSR interception for MSRs" failed to apply to 6.12-stable tree
To: seanjc@google.com,naveen@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:39:57 +0200
Message-ID: <2026071657-purgatory-gallantly-e473@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8c63179d975f2029c948ecce622f72af616dbff7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071657-purgatory-gallantly-e473@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c63179d975f2029c948ecce622f72af616dbff7 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:31:15 -0700
Subject: [PATCH] KVM: SVM: Only disable x2AVIC WRMSR interception for MSRs
 that are accelerated

When x2AVIC is enabled, disable WRMSR interception only for MSRs that are
actually accelerated by hardware.  Disabling interception for MSRs that
aren't accelerated is functionally "fine", and in some cases a weird "win"
for performance, but only for cases that should never be triggered by a
well-behaved VM (writes to read-only registers; the #GP will typically
occur in the guest without taking a #VMEXIT, even for fault-like exits).

But overall, disabling interception for MSRs that aren't accelerated is at
best confusing and unintuitive, and at worst introduces avoidable risk, as
the APM's documentation is imperfect and contradictory.  The table in
"15.29.3.1 Virtual APIC Register Accesses" of simply states that such
writes generate exits, where as "Section 15.29.10 x2AVIC" says:

  x2APIC MSR intercept checks and access checks have higher priority than
  AVIC access permission checks.

CPU behavior follows the latter (which makes perfect sense), but all in
all there's simply no reason to disable interception just to make a #GP
faster.

Note, the set of MSRs that are passed through for write is identical to
VMX's set when IPI virtualization is enabled.  This is not a coincidence,
and is another motiviating factor for cleaning up the intercepts, as x2AVIC
is functionally equivalent to APICv+IPIv.

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://patch.msgid.link/20260514213115.1637082-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 8e4926c7b8dc..724a45c2aa23 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -124,39 +124,6 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	u64 rd_regs;
-
-	static const u32 x2avic_passthrough_msrs[] = {
-		X2APIC_MSR(APIC_ID),
-		X2APIC_MSR(APIC_LVR),
-		X2APIC_MSR(APIC_TASKPRI),
-		X2APIC_MSR(APIC_ARBPRI),
-		X2APIC_MSR(APIC_PROCPRI),
-		X2APIC_MSR(APIC_EOI),
-		X2APIC_MSR(APIC_RRR),
-		X2APIC_MSR(APIC_LDR),
-		X2APIC_MSR(APIC_DFR),
-		X2APIC_MSR(APIC_SPIV),
-		X2APIC_MSR(APIC_ISR),
-		X2APIC_MSR(APIC_TMR),
-		X2APIC_MSR(APIC_IRR),
-		X2APIC_MSR(APIC_ESR),
-		X2APIC_MSR(APIC_ICR),
-		X2APIC_MSR(APIC_ICR2),
-
-		/*
-		 * Note!  Always intercept LVTT, as TSC-deadline timer mode
-		 * isn't virtualized by hardware, and the CPU will generate a
-		 * #GP instead of a #VMEXIT.
-		 */
-		X2APIC_MSR(APIC_LVTTHMR),
-		X2APIC_MSR(APIC_LVTPC),
-		X2APIC_MSR(APIC_LVT0),
-		X2APIC_MSR(APIC_LVT1),
-		X2APIC_MSR(APIC_LVTERR),
-		X2APIC_MSR(APIC_TMICT),
-		X2APIC_MSR(APIC_TMCCT),
-		X2APIC_MSR(APIC_TDCR),
-	};
 	int i;
 
 	if (intercept == svm->x2avic_msrs_intercepted)
@@ -171,9 +138,10 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 		svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
 					  MSR_TYPE_R, intercept);
 
-	for (i = 0; i < ARRAY_SIZE(x2avic_passthrough_msrs); i++)
-		svm_set_intercept_for_msr(vcpu, x2avic_passthrough_msrs[i],
-					  MSR_TYPE_W, intercept);
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TASKPRI), MSR_TYPE_W, intercept);
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_EOI), MSR_TYPE_W, intercept);
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W, intercept);
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_ICR), MSR_TYPE_W, intercept);
 
 	svm->x2avic_msrs_intercepted = intercept;
 }

