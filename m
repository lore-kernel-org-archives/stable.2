Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198753E63B5
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562464; cv=none; b=W6nHHpJ2bicyXVNvC/ufSa9KoA/SgekhZg4B3825iJ4kQhJXgEHk4F6RUQ+UBuMGkeQ0iIKDnkyS9peuUkwX1zvAp4TiAuuNzCtYS2+rAgDSTleh7/1PxIiJ1V8nrY1Ipt+gzM7GH9R0QrF8dEANNp3267vRBDj+kMAMMO7OVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562464; c=relaxed/simple;
	bh=+FVjQH9ME/3hxzIB23RryAQBjWyQfNOtKe2JIfFCIJM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W8pI/GIxtk4dzwxa3f5wQNlyOCUMtr7MXdD28CHGIjvSJ6Db6P2kZ9yzPE36MxliPdVl0PYuARZ3i5Hqqq+MQr8XO2ynw5Bheze90PxEk5/RLj/igEbNYktt2b0jLNZPboFVjb17ZAzXcWTY7wKcjbFb0YwsS5XymVknHozGcq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+Yz6IkC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+Yz6IkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF83F1F0089B;
	Thu,  4 Jun 2026 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562453;
	bh=T6322EfmIirXuUsK0zjIC7iaMNRod9GpyLnvlQUbaec=;
	h=Subject:To:Cc:From:Date;
	b=E+Yz6IkCa/or3FSWUvoqGO/rLp4Sh/tuWLu5KwO8Ry1VWbyUO299aDzhcM26ZaxMt
	 8qV3pVCXJ3uyIPq3k9fH6JnPb5O7g7YqM0SVBllxBHst9eHjKKntEblM2pRzGjIK2I
	 QCJJi+JdUh09rhfKhPPP9Y8843vCk+rwuTMWVp0I=
Subject: FAILED: patch "[PATCH] KVM: SVM: Flush the current TLB when transitioning from xAVIC" failed to apply to 6.1-stable tree
To: seanjc@google.com,naveen@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:39:56 +0200
Message-ID: <2026060456-distinct-jockstrap-0b3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a9e18aa3263f356edae305e29830e5fe63d8597a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060456-distinct-jockstrap-0b3b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9e18aa3263f356edae305e29830e5fe63d8597a Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 10:15:36 -0700
Subject: [PATCH] KVM: SVM: Flush the current TLB when transitioning from xAVIC
 => x2AVIC

Flush the current TLB when xAVIC *or* x2AVIC is activated, as KVM is
(apparently) responsible for purging TLB entries when transitioning from
xAVIC to x2AVIC.  The APM says a whole lot of nothing about TLB flushing
with respect to (x2)AVIC, but empirical data strongly suggests hardware
also does a whole lot of nothing.

Failure to flush the TLB when enabling x2AVIC can lead to guest accesses
to the APIC base address getting incorrectly redirected to the virtual
APIC page.  The flaw most visibly manifests as failures in KVM-Unit-Test's
verify_disabled_apic_mmio() testcase when x2APIC is enabled (though for
reasons unknown, the test only reliably fails with EFI builds).

Fixes: 0ccf3e7cb95a ("KVM: SVM: Flush the "current" TLB when activating AVIC")
Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://patch.msgid.link/20260515171536.1841645-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index adf211860949..e8bd60156941 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -206,6 +206,35 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 
 	svm_clr_intercept(svm, INTERCEPT_CR8_WRITE);
 
+	/*
+	 * Flush the TLB when enabling (x2)AVIC and when transitioning between
+	 * xAVIC and x2AVIC, as the CPU may have inserted a TLB entry for the
+	 * "wrong" mapping.
+	 *
+	 * KVM uses a per-VM "scratch" page to back the APIC memslot, because
+	 * KVM also uses per-VM page tables *and* maintains the page table (NPT
+	 * or shadow page) mappings for said memslot even if one or more vCPUs
+	 * have their local APIC hardware-disabled or are in x2APIC mode, i.e.
+	 * even if one or more vCPUs' APIC MMIO BAR is effectively disabled.
+	 *
+	 * If xAVIC is fully enabled, hardware ignores the physical address in
+	 * KVM's page tables, i.e. in the leaf SPTE for the APIC memslot, and
+	 * instead redirects the access to the AVIC backing page, i.e. to the
+	 * vCPU's virtual APIC page.  If xAVIC is not enabled (APIC is either
+	 * hardware-disabled or in x2APIC mode), then guest accesses will use
+	 * the page table mapping verbatim, i.e. will access the per-VM scratch
+	 * page, as normal memory.
+	 *
+	 * In both cases, the CPU is allowed to cache TLB entries for the APIC
+	 * base GPA.  So, KVM needs to flush the TLB when enabling xAVIC, as
+	 * accesses need to be redirected to the virtual APIC page, but the TLB
+	 * may contain entries pointing at the scratch page.  KVM also needs to
+	 * flush the TLB when enabling x2AVIC, as accesses need to go to the
+	 * scratch page, but the TLB may contain entries tagged as xAVIC, i.e.
+	 * entries pointing to the vCPU's virtual APIC page.
+	 */
+	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
+
 	/*
 	 * Note: KVM supports hybrid-AVIC mode, where KVM emulates x2APIC MSR
 	 * accesses, while interrupt injection to a running vCPU can be
@@ -219,12 +248,6 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 		/* Disabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, false);
 	} else {
-		/*
-		 * Flush the TLB, the guest may have inserted a non-APIC
-		 * mapping into the TLB while AVIC was disabled.
-		 */
-		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
-
 		/* Enabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, true);
 	}

