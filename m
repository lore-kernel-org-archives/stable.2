Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930E41A918
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202028; cv=none; b=qt14D5sEwSHMxbEskc3wutlWMExOXBpQ263aOU6NYQtSI1/9OIffMWu2NmTFZuF4SuYZazyB7OqO0hkqJLKGCcJoni0gNz4G+SyVaVca3TRaJvGMQ84u383ECK+A7gISUVG+DhV/+8eHyj3GM/xycS5lxukdLCEa3P3KhvZDGgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202028; c=relaxed/simple;
	bh=TLLM8D/CZsE9qmjbmr26gqVG6GlZ97qthkNHpHtXqoA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G1WoMxgCM4I3ihD2ygUXna2UB+1CwAcmfFPIEu6xEU6NfbWhzKLfbee5VEkgtJPND19B2w6UU1gnmb4aOdd+oFcdHfs7iSqzd1zjcFYkeNxPyUgakNWody341y56nBkZHrCjLZvGUseHWPvzKU4/zMvbcsYUf+jL+p5RjLBsTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aS0Kbh+T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aS0Kbh+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110081F00A3E;
	Thu, 16 Jul 2026 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202023;
	bh=Faph2a6oiWU0dF4jd8PUgWg3Qrw9omZVhq2uiJGo0/Q=;
	h=Subject:To:Cc:From:Date;
	b=aS0Kbh+TBkjq7EkY+GKheo+lPCZQTGs/B7exm4woC2ftlvG5A9SNkzTi+WypJVtJT
	 dk1jKwm/rlhJUnz5WnA+nk+ytZs5b0nX747lIDRnBbU5DwhdMkoeM1TjuN4eHtDK0s
	 pzLmwbbXx4rAhDahtVU4cCQrnUQ3niQ0pRfkCdHs=
Subject: FAILED: patch "[PATCH] KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS on all" failed to apply to 5.15-stable tree
To: seanjc@google.com,houwenlong.hwl@antgroup.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:40:12 +0200
Message-ID: <2026071612-detail-getting-2cec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c5bad4fa2d5dfd8c25140051a9807eba387a19b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071612-detail-getting-2cec@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c5bad4fa2d5dfd8c25140051a9807eba387a19b8 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:29 -0700
Subject: [PATCH] KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS on all
 injected #DBs

Move KVM's stuffing of GUEST_PENDING_DBG_EXCEPTIONS.BS when RFLAGS.TF=1 and
MOV/POP SS or STI blocking is active into the exception injection code so
that KVM fixes up the VMCS for all injected #DBs, not only those that are
reflected back into the guest after #DB interception.  E.g. if KVM queues
a #DB in the emulator, or more importantly if userspace does save/restore
exactly on the #DB+shadow boundary, then KVM needs to massage the VMCS to
avoid the VM-Entry consistency check.

Opportunistically update the wording of the comment to describe the
behavior as a workaround of flawed CPU behavior/architecture, to make it
clear that the *only* thing KVM is doing is fudging around a consistency
check.  Per the SDM:

  There are no pending debug exceptions after VM entry if any of the
  following are true:

    * The VM entry is vectoring with one of the following interruption
      types: external interrupt, non-maskable interrupt (NMI), hardware
      exception, or privileged software exception.

I.e. forcing GUEST_PENDING_DBG_EXCEPTIONS.BS does *not* impact guest-
visible behavior.

Fixes: b9bed78e2fa9 ("KVM: VMX: Set vmcs.PENDING_DBG.BS on #DB in STI/MOVSS blocking shadow")
Cc: stable@vger.kernel.org
Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Closes: https://lore.kernel.org/all/b1a294bc9ed4dae532474a5dc6c8cb6e5962de7c.1757416809.git.houwenlong.hwl@antgroup.com
Reviewed-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Link: https://patch.msgid.link/20260515222638.1949982-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d81b22359918..cf9f2f55f569 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1909,6 +1909,24 @@ void vmx_inject_exception(struct kvm_vcpu *vcpu)
 	u32 intr_info = ex->vector | INTR_INFO_VALID_MASK;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	/*
+	 * When injecting a #DB, single-stepping is enabled in RFLAGS, and STI
+	 * or MOV-SS blocking is active, set vmcs.PENDING_DBG_EXCEPTIONS.BS to
+	 * prevent a false positive from VM-Entry consistency check.  VM-Entry
+	 * asserts that a single-step #DB _must_ be pending in this scenario,
+	 * as the previous instruction cannot have toggled RFLAGS.TF 0=>1
+	 * (because STI and POP/MOV don't modify RFLAGS), therefore the one
+	 * instruction delay when activating single-step breakpoints must have
+	 * already expired.  However, the CPU isn't smart enough to peek at
+	 * vmcs.VM_ENTRY_INTR_INFO_FIELD and so doesn't realize that yes, there
+	 * is indeed a #DB pending/imminent.
+	 */
+	if (ex->vector == DB_VECTOR &&
+	    (vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
+	    vmx_get_interrupt_shadow(vcpu))
+		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
+			    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
+
 	kvm_deliver_exception_payload(vcpu, ex);
 
 	if (ex->has_error_code) {
@@ -5485,26 +5503,9 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 			 * avoid single-step #DB and MTF updates, as ICEBP is
 			 * higher priority.  Note, skipping ICEBP still clears
 			 * STI and MOVSS blocking.
-			 *
-			 * For all other #DBs, set vmcs.PENDING_DBG_EXCEPTIONS.BS
-			 * if single-step is enabled in RFLAGS and STI or MOVSS
-			 * blocking is active, as the CPU doesn't set the bit
-			 * on VM-Exit due to #DB interception.  VM-Entry has a
-			 * consistency check that a single-step #DB is pending
-			 * in this scenario as the previous instruction cannot
-			 * have toggled RFLAGS.TF 0=>1 (because STI and POP/MOV
-			 * don't modify RFLAGS), therefore the one instruction
-			 * delay when activating single-step breakpoints must
-			 * have already expired.  Note, the CPU sets/clears BS
-			 * as appropriate for all other VM-Exits types.
 			 */
 			if (is_icebp(intr_info))
 				WARN_ON(!skip_emulated_instruction(vcpu));
-			else if ((vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
-				 (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
-				  (GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS)))
-				vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
-					    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
 
 			kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
 			return 1;

