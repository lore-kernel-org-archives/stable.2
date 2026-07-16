Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909661A2C25
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202108; cv=none; b=Gk+4CtF8WEWofrtt9hb3VTW+ObaAw3AG2vWWKl+en1TgIaOaLDxWczTnHdSWjx7UfGjP3J8wndonfqvQpneMhp+PgejmSFrUAXMO2x6t1jj7wiFjiLUsU7urn0HHtGdbE/4sFALQNgYB8oBPf9/b7tPH1i5z1NZ0qiYgh22cdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202108; c=relaxed/simple;
	bh=UfvO+VHOcqsHwd+13kpisT0K1cMd+9gvcSLH4px0Hnc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FSLOOmwAmnUom8dQ8JnCqx0ZN01vUCP1dprgIEFZI71jY643vLURUVplowFV1zW2V18qyP+fABbUhTQgmoErhIlYndUnSMPOpyKbXgCqOWih7KZZpn0OBwzaUhEhbTUE98q7w/LXz86bpRRUSzMLopCzFDyVphXL5YwxFDEQKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jn5YUwVQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jn5YUwVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0401F000E9;
	Thu, 16 Jul 2026 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202107;
	bh=QC1HzxiinG2FqBjoegYThHxta6ctysMbudjBXc+JJAw=;
	h=Subject:To:Cc:From:Date;
	b=jn5YUwVQVcZCPeLlnIKEM4PLCsNGcjP0ivvqh8/aXHHcvAoSbMsIWRbJOiGuX1q/I
	 HXl5AHrdI6qp79/AkpOErBD3q1g/94WY8pFbD3CdWdtqWYxCpFDhrYKDEmptwE6GyJ
	 1VyrC/7BZWnsDtNLG5hgN3i7QqWgbJ+dP3RxTKyE=
Subject: FAILED: patch "[PATCH] KVM: x86: Unconditionally recompute CR8 intercept on PPR" failed to apply to 5.10-stable tree
To: clopez@suse.de,pbonzini@redhat.com,seanjc@google.com,sgarzare@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:41:32 +0200
Message-ID: <2026071632-puzzle-oblivion-cde0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x bb365a506b1e6fb050c0fceaad354fe395385ef0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071632-puzzle-oblivion-cde0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bb365a506b1e6fb050c0fceaad354fe395385ef0 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
Date: Thu, 18 Jun 2026 10:43:47 -0700
Subject: [PATCH] KVM: x86: Unconditionally recompute CR8 intercept on PPR
 update
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The TPR_THRESHOLD field in the VMCS is used by VMX to induce VM exits
when the guest's virtual TPR falls under the specified threshold,
allowing KVM to inject previously masked interrupts.

KVM handles these VM exits in handle_tpr_below_threshold().
Commit eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
optimized this function by calling apic_update_ppr() instead of raising
KVM_REQ_EVENT. apic_update_ppr() then raises KVM_REQ_EVENT if there is
a pending, deliverable interrupt.

However, if there are no new interrupts pending, apic_update_ppr() does
not issue the request. Thus, kvm_lapic_update_cr8_intercept() and
vmx_update_cr8_intercept() are not called before VM entry, which results
in a high, stale TPR_THRESHOLD. This is problematic due to the following
sentence in 28.2.1.1 "VM-Execution Control Fields" in the SDM:

  The following check is performed if the “use TPR shadow” VM-execution
  control is 1 and the “virtualize APIC accesses” and “virtual-interrupt
  delivery” VM-execution controls are both 0: the value of bits 3:0 of
  the TPR threshold VM-execution control field should not be greater
  than the value of bits 7:4 of VTPR.

This error condition is typically not observed when KVM runs on a bare
metal system because modern processors support APICv, which enables
virtual-interrupt delivery, and which KVM uses when possible. This
causes the processor to no longer generate TPR-below-threshold exits
and to no longer check TPR_THRESHOLD on entry. However, when running
on older platforms, or under nested virtualization on a hypervisor that
does not support virtual-interrupt delivery and enforces this check
(like Hyper-V) this can cause a VM entry failure with hardware error
0x7, as seen in [1].

Call kvm_lapic_update_cr8_intercept() if apic_update_ppr() does not
find a deliverable interrupt (and thus does not raise KVM_REQ_EVENT).
Remove calls to kvm_lapic_update_cr8_intercept() on paths that end up in
apic_update_ppr(), as they now become redundant. This ensures that any
path that updates the guest's PPR also figures out if KVM needs to wait
for a TPR change (using TPR_THRESHOLD on VMX or CR8 intercepts on SVM).

Link: https://github.com/coconut-svsm/svsm/issues/1081 [1]
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Cc: stable@vger.kernel.org
Fixes: eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
Signed-off-by: Carlos López <clopez@suse.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260618174347.1981064-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e733ca6b9792..6f30bbdddb5a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -980,6 +980,8 @@ static void apic_update_ppr(struct kvm_lapic *apic)
 	if (__apic_update_ppr(apic, &ppr) &&
 	    apic_has_interrupt_for_ppr(apic, ppr) != -1)
 		kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
+	else
+		kvm_lapic_update_cr8_intercept(apic->vcpu);
 }
 
 void kvm_apic_update_ppr(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9d51803b7b2..96c465040756 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5317,7 +5317,6 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
 	r = kvm_apic_set_state(vcpu, s);
 	if (r)
 		return r;
-	kvm_lapic_update_cr8_intercept(vcpu);
 
 	return 0;
 }
@@ -12418,8 +12417,6 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
 	kvm_x86_call(post_set_cr3)(vcpu, sregs->cr3);
 
-	kvm_set_cr8(vcpu, sregs->cr8);
-
 	*mmu_reset_needed |= vcpu->arch.efer != sregs->efer;
 	kvm_x86_call(set_efer)(vcpu, sregs->efer);
 
@@ -12448,7 +12445,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	kvm_set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	kvm_set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
-	kvm_lapic_update_cr8_intercept(vcpu);
+	kvm_set_cr8(vcpu, sregs->cr8);
 
 	/* Older userspace won't unhalt the vcpu on reset. */
 	if (kvm_vcpu_is_bsp(vcpu) && kvm_rip_read(vcpu) == 0xfff0 &&

