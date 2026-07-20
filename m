Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5E414DCC
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550100; cv=none; b=GDBjeoPgsPw2VcPGY2Kzq+uwLgRaDNsfvPanMTbksYK7/PO/SDXI1ER11HV6uKHm75ZDdUWdCkwnBdACnvD4O1YLGWlVJbpXwAOLTtlcPfCU0Q2jbIghDldAjVJnaa/9Miy0ZvLNkK81xvJkLdLpTfmiJxVm0s0LUGC6BviiXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550100; c=relaxed/simple;
	bh=VVJaE4nL5fg68gE1I4jdMuVlQe6pC+dlo15JvIgccT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fr4HwWg6J3ggcXsoLm3SNBoNZ62UH4mV5TlMbjjparimWQc97Ah9JRs+tg2cWLvF7G1DJ+nVQr+0wgMEsjIbImnOjI6oiziMqiDLXdUiEAD7uYPxQZz8hElq0FbZQl/ZtGtlVr9y1s+KGmnNzE2y/iqm3wnf0eP5nT/bQIkdPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J61wBSNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J61wBSNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF95F1F00A3A;
	Mon, 20 Jul 2026 12:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550099;
	bh=JxSoetTEjLx+uXxfW1Hdxii00w/E22NDvq309oD4ugE=;
	h=Subject:To:Cc:From:Date;
	b=J61wBSNBE51G9yOTVGXn1+kgWpzc6GEkAkB7JPeLeOx0uZKKn6lESnBpApSsIheyg
	 nCl6PmVhu344CIJt6QIx3lPKBFKb4GRT837hdhV28qfIO5eEFjJbThTDifVilfbKM8
	 QGBYtvlkFIs6oXyp6yepu404EdEdLwciNT1BhgNg=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's CR3" failed to apply to 6.6-stable tree
To: seanjc@google.com,jmattson@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:21:16 +0200
Message-ID: <2026072016-retry-prewar-fa32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3e6dd2b9b7b2884743ed7a0873b8743cc0df6d40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072016-retry-prewar-fa32@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e6dd2b9b7b2884743ed7a0873b8743cc0df6d40 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 07:56:42 -0700
Subject: [PATCH] KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's CR3
 when EPT is disabled

Add a dedicated field in "struct nested_vmx" to track L1's pre-VM-Enter CR3
instead of using vmcs01.GUEST_CR3, which isn't anywhere near as safe as the
comment purports it to be.  E.g. in addition to the warn_on_missed_cc bug
(that was fixed by relocating the consistency check), if getting vmcs12
pages (during actual nested VM-Entry) fails and EPT is disabled (in KVM),
KVM will return control to userspace with vmcs01.GUEST_CR3 holding a guest-
controlled value.

Alternatively, KVM could force a reload of vmcs01.GUEST_CR3 by resetting
the MMU context in the error path, but as above, the safety of the vmcs01
approach is extremely questionable, e.g. it took all of ~4 months for the
code to break.

Fixes: 671ddc700fd0 ("KVM: nVMX: Don't leak L1 MMIO regions to L2")
Cc: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260612145642.452392-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4fc4349810a3..bb0eb40b4448 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3658,19 +3658,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 				    &vmx->nested.pre_vmenter_ssp_tbl);
 
 	/*
-	 * Overwrite vmcs01.GUEST_CR3 with L1's CR3 if EPT is disabled.  In the
-	 * event of a "late" VM-Fail, i.e. a VM-Fail detected by hardware but
-	 * not KVM, KVM must unwind its software model to the pre-VM-Entry host
-	 * state.  When EPT is disabled, GUEST_CR3 holds KVM's shadow CR3, not
-	 * L1's "real" CR3, which causes nested_vmx_restore_host_state() to
-	 * corrupt vcpu->arch.cr3.  Stuffing vmcs01.GUEST_CR3 results in the
-	 * unwind naturally setting arch.cr3 to the correct value.  Smashing
-	 * vmcs01.GUEST_CR3 is safe because nested VM-Exits, and the unwind,
-	 * reset KVM's MMU, i.e. vmcs01.GUEST_CR3 is guaranteed to be
-	 * overwritten with a shadow CR3 prior to re-entering L1.
+	 * Stash L1's CR3, so that in the event of a "late" VM-Fail, i.e. a
+	 * VM-Fail detected by hardware but not KVM, KVM can unwind its
+	 * software model to the pre-VM-Entry host state.  When EPT is
+	 * disabled, GUEST_CR3 holds KVM's shadow CR3, not L1's "real" CR3,
+	 * and so simply restoring from vmcs01.GUEST_CR3 would corrupt
+	 * vcpu->arch.cr3.
 	 */
-	if (!enable_ept)
-		vmcs_writel(GUEST_CR3, vcpu->arch.cr3);
+	vmx->nested.pre_vmenter_cr3 = kvm_read_cr3(vcpu);
 
 	vmx_switch_vmcs(vcpu, &vmx->nested.vmcs02);
 
@@ -4982,7 +4977,7 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 	vmx_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
 
 	nested_ept_uninit_mmu_context(vcpu);
-	vcpu->arch.cr3 = vmcs_readl(GUEST_CR3);
+	vcpu->arch.cr3 = vmx->nested.pre_vmenter_cr3;
 	kvm_register_mark_available(vcpu, VCPU_REG_CR3);
 
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index de9de0d2016c..dc8517f15bc4 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -159,6 +159,13 @@ struct nested_vmx {
 	bool has_preemption_timer_deadline;
 	bool preemption_timer_expired;
 
+	/*
+	 * Used to restore L1's CR3 if hardware detects a VM-Fail Consistency
+	 * Check that KVM does not, in which case KVM needs to unwind CR3 back
+	 * to its pre-VM-Enter state, NOT to vmcs01.HOST_CR3.
+	 */
+	unsigned long pre_vmenter_cr3;
+
 	/*
 	 * Used to snapshot MSRs that are conditionally loaded on VM-Enter in
 	 * order to propagate the guest's pre-VM-Enter value into vmcs02.  For

