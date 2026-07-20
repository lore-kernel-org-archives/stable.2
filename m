Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299F414A3A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550097; cv=none; b=JGSHHW5cywIqr2viEeQzuxGsxSVzp8LVYibw7PBnOoJK04HhtU52VLJmjvZ7Srfin2gREwEFKE1pkDtmXO9Ef7Xy42BgMyfDBBNBS6AM73TwwtrMAbrCxl3zmqqgpAzIsihHU8/zQOcyQm8WUD82YwlJ9peZPahNs248+ReYgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550097; c=relaxed/simple;
	bh=wCYM/hWA8XwytYcjIHKt+qZnNOGZ8AfcockvIXAP2SA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VcQfC4lnUXNh6NnQkzyf0hoZqPfPrluvcjlqNQlNZOSVQWUXDuhaXigD26BflS9gagc3oEcflTFS6qLjqFx0CIw/mHnySwknWTc25rQhDbFSMjGKJcDv1ommNtYqJhu47UeIqfsBTUDCQ9X6cIvTD+Ug6+VRABR424bEbRkvUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dVRHBNFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dVRHBNFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B311F00A3D;
	Mon, 20 Jul 2026 12:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550096;
	bh=ZX+OTId+BArOzlqXmI/4IXXqCSPgOYTDfASVfc7NvrE=;
	h=Subject:To:Cc:From:Date;
	b=dVRHBNFz0KByldDdP7vyWzR49ON4zEwuC7yZDMmQdUQemkbMh8+BV5EgO/1iVQK7b
	 uHEsJnOxUdxJikYbL7XaHmHQFmoBPL6EbxhpbwwTK29dXMaSmawqk0Z6HHLyFq7Lgx
	 49d4U8VZ4+BwULYf31t6LowGAAZEPcgZLTPeMHBg=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's CR3" failed to apply to 7.1-stable tree
To: seanjc@google.com,jmattson@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:21:15 +0200
Message-ID: <2026072015-chain-cosmetics-ff0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3e6dd2b9b7b2884743ed7a0873b8743cc0df6d40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072015-chain-cosmetics-ff0e@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

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

