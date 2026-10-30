Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356629;
	b=mTK9eYk1R7nJ6eKlk3jjqvNfv8mUCEZioQSAtYtv2dh+Kz5lWbFV6jrBcaMxoPAZGLY0
	 KditkQ99OW7WLRPxB613SVE5RUV500jP2KChd9dNOI6GLonQSH+caKUjPTWR2y5P99LU0
	 72zUCxEWuN4lAkOUrhXX2RWTFt2rD8dXh1cZ4OiLRNRCzG7nAsRuxT0t7e0PLP4E2yNUT
	 p+Ogcxf/tApm5gy2txkI5+CyHpDnCa89AwhwI+xImUphsdorz/udFQEH3RXBbD/RW/S12
	 Mu2JI0eO7D5yNmO4eXgd6nzmHI2wWAVCphGVP2UjddMBOMGPYaji2e0DQDR/Ehg6dOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356629;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=TbschgMNYw6t79kvt52ce0qIbEIOdEmAN9xF56Pg4cA=;
	b=UaOeR1HiAY3IsJpgv95ueFF273xUH3va2Hgfxka/BA7P7uqCy/wmqUnTAx+FOEge1y5Y
	 jLr5HcHcvUkLCiBdrA8o5vG3z0JytkEfPk5YWsdlziq/d8+GkLlbBQOIoYjLZAqX7j8o+
	 EhnAAUb2U2C8lderRcXBlUEM1nm/CWvGNORWU1jd8BpNTRweM/CuN0G6bc8MUEeszXdQm
	 DNDnizxYIRPopakJP3fk3c7ZaU9M7jT8VoZJlHBJFfcvFukzAdImZw2GMy3B3r3CaBdSQ
	 1wbhKnhI6L8qKss1+cyjzW96zEHGDZPA0LmWsoq/xIZ24CIHmuuShpz3DVihakMLySQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=F7YyjmMp;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D23606A60F;
	Fri, 30 Oct 2026 10:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43D23606A60F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=F7YyjmMp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793356629; x=1824892629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TbschgMNYw6t79kvt52ce0qIbEIOdEmAN9xF56Pg4cA=;
  b=F7YyjmMp3kIGIB4l2ZAhLr7jf4g3+88p+XIMORTcCx5JdORur5C+gB22
   gjnwrxRDTkeSsYtHAAujVbOn+luieBFVN72t7JfdK7gxk5owTZcq8LTfM
   /PWgfIalUnsDZ3dVh8RFvKzhKz25OEEvCL0FQmbKAX8j3H14xHuQX9/y8
   +4jLZRUn2PlTX9CrBiSHLBP6szakJENVEPQWFylfxtW56sNj9hJrivM1F
   LH+RBJOxHVoZvpVFzmWpA2OOTbZHXvmYr8qtfdWYOa4kAS12uePgBARL3
   5NwQQlCy/9bkXKgBKBqOLkPjN/vAegREzhHnu8SSOHoIlwzYQCOBg3sZv
   Q==;
X-CSE-ConnectionGUID: gDCg1vNBS/qqamoY0xRgKQ==
X-CSE-MsgGUID: yCH3SJs5Rmq4GLe/3EwqBQ==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32562611"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:37:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:4571]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.80:2525] with esmtp (Farcaster)
 id 5074b5e4-e326-48f7-b15e-99ceda232ba7; Fri, 30 Oct 2026 10:37:05 +0000 (UTC)
X-Farcaster-Flow-ID: 5074b5e4-e326-48f7-b15e-99ceda232ba7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:05 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:04 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>, "Bjoern
 Doebel" <doebel@amazon.de>
Subject: [PATCH 6.18.y 2/3] KVM: x86: Tell ->inject_page_fault() whether or a fault came from hardware
Date: Fri, 30 Oct 2026 10:36:42 +0000
Message-ID: <20261030103643.573356-3-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030103643.573356-1-doebel@amazon.de>
References: <20261030103643.573356-1-doebel@amazon.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit fe0b872d750023eda270cbc01c53ead52b1049d8 ]

When injecting a page fault (including nested TDP faults into L1), tell the
injection routine whether or not the fault originated in hardware, i.e. if
KVM is effectively forwarding a fault it intercept.  For nested TDP fault
injection, KVM needs to grab PAGE_WALK vs. GUEST_FINAL information from the
VMCB/VMCS, _if_ the fault originated in hardware.

Note, simply checking whether or not the original exit was due a #NPF or
EPT Violation isn't sufficient/correct, as the fault being synthesized for
L1 may or may not be the "same" fault that triggered a VM-Exit from L2.
E.g. if access to emulated MMIO in L2 hits a !PRESENT fault (EPT Violation
or #NPF), e.g. because MMIO caching is disabled or it's the first time the
GPA has been accessed by L2, then KVM will enter the emulator.  If
emulating the MMIO instruction then hits a nested TDP fault, e.g. because
L2 was accessing MMIO with a MOVSQ (memory-to-memory move), or because L1
has since unmapped the code stream, then the TDP fault synthesized to L1
will not be the same emulated fault the triggered the VM-Exit.

No functional change intended (nothing uses the new param, yet...).

Link: https://patch.msgid.link/20260522232701.3671446-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED bits")
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
 arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
 arch/x86/kvm/svm/nested.c       |  3 ++-
 arch/x86/kvm/vmx/nested.c       |  3 ++-
 arch/x86/kvm/x86.c              | 16 +++++++++-------
 5 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b2cf3431e2598..058e85cf2dc70 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -457,7 +457,8 @@ struct kvm_mmu {
 	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
-				  struct x86_exception *fault);
+				  struct x86_exception *fault,
+				  bool from_hardware);
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			    gpa_t gva_or_gpa, u64 access,
 			    struct x86_exception *exception);
@@ -2252,9 +2253,18 @@ void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 			   bool has_error_code, u32 error_code);
-void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
-void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
-				    struct x86_exception *fault);
+void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
+			   bool from_hardware);
+void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
+				      struct x86_exception *fault,
+				      bool from_hardware);
+
+static inline void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
+						  struct x86_exception *fault)
+{
+	__kvm_inject_emulated_page_fault(vcpu, fault, false);
+}
+
 bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl);
 bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index bae9c781a301f..8315868f783e8 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -785,7 +785,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 */
 	if (!r) {
 		if (!fault->prefetch)
-			kvm_inject_emulated_page_fault(vcpu, &walker.fault);
+			__kvm_inject_emulated_page_fault(vcpu, &walker.fault, true);
 
 		return RET_PF_RETRY;
 	}
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index df54df7ae2013..44de8cb0f0c30 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -35,7 +35,8 @@
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
-				       struct x86_exception *fault)
+				       struct x86_exception *fault,
+				       bool from_hardware)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 97ef2ebc2477c..32e58cf412818 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -416,7 +416,8 @@ static void nested_ept_invalidate_addr(struct kvm_vcpu *vcpu, gpa_t eptp,
 }
 
 static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
-		struct x86_exception *fault)
+					 struct x86_exception *fault,
+					 bool from_hardware)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ae33393c9b479..26ecbe540fb2b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -960,7 +960,8 @@ static int complete_emulated_insn_gp(struct kvm_vcpu *vcpu, int err)
 				       EMULTYPE_COMPLETE_USER_EXIT);
 }
 
-void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault)
+void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
+			   bool from_hardware)
 {
 	++vcpu->stat.pf_guest;
 
@@ -977,8 +978,9 @@ void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault)
 					fault->address);
 }
 
-void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
-				    struct x86_exception *fault)
+void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
+				      struct x86_exception *fault,
+				      bool from_hardware)
 {
 	struct kvm_mmu *fault_mmu;
 	WARN_ON_ONCE(fault->vector != PF_VECTOR);
@@ -995,9 +997,9 @@ void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 		kvm_mmu_invalidate_addr(vcpu, fault_mmu, fault->address,
 					KVM_MMU_ROOT_CURRENT);
 
-	fault_mmu->inject_page_fault(vcpu, fault);
+	fault_mmu->inject_page_fault(vcpu, fault, from_hardware);
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_inject_emulated_page_fault);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_inject_emulated_page_fault);
 
 void kvm_inject_nmi(struct kvm_vcpu *vcpu)
 {
@@ -13162,7 +13164,7 @@ bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 		fault.nested_page_fault = false;
 		fault.address = work->arch.token;
 		fault.async_page_fault = true;
-		kvm_inject_page_fault(vcpu, &fault);
+		kvm_inject_page_fault(vcpu, &fault, false);
 		return true;
 	} else {
 		/*
@@ -13329,7 +13331,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		fault.address = gva;
 		fault.async_page_fault = false;
 	}
-	vcpu->arch.walk_mmu->inject_page_fault(vcpu, &fault);
+	vcpu->arch.walk_mmu->inject_page_fault(vcpu, &fault, true);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_fixup_and_inject_pf_error);
 
-- 
2.50.1

