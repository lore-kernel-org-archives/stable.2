Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7E436BEA
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201125; cv=none; b=ajVYYOOe9G9K9xwpr0etHpGF2hXyBRb4351tF7aTD2I4+ah3/ALShTfP04OGfrHwBS+qf+gfMJP6Sadk4viMa36pAnCYRKsYDLQ8kFz2XZec9eKKirwpWTHaik43dDkbs5L8NGTXz4iwH36f9nXvK2mdcM6qRx3OSz8emEen1+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201125; c=relaxed/simple;
	bh=2GLbv8bc3TuAR/OrOPMwCdjcqUpBkeZTUBcZQ/2dK/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gR/DKiq0W1XwnD7GJ6GV52yztXiEkEBgaryRaw147d5RIQCDK32McmVsSM1Rin4zRHIqY9NVdFNk4Zl4A9DOAM3eebtTnB2V9wwu15Kh9p0ccRCFOXukvfM0+lpCAxRG4EiZgFlbuR7zvncHd4nmhpvzcTm0keXRHbyYRm76H4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI9ZSmC6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI9ZSmC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2231F00A3E;
	Mon, 31 Aug 2026 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201124;
	bh=nPvNvrO7QeWCBE67lO31NK75h7HUWuXYjZcetB3wBjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CI9ZSmC6acO+yby8SZKtGoM0lSBPxcEQAU+we5+RC8DK/7CYp4qupt8yWXs7WOMyd
	 Tabm5jUWQq5SOKslZAv//x7Jzh4r/YkKVBJ9dRq5AwlFbrjHZZhCoc2hAh1zqPebQG
	 qcvTM+d+ezbK4xsFd6S/7+VZo4Ez8UqwY9E/inWtz8lZ8vVvrA0h/JAKkinONPQ2K/
	 91rnhHPzmYRL19gDhTcCJSpTlaMCKv66BM32PzihhwfwbyzRdn6vvcnBGA5kVG3765
	 2FlnHVF/bJHS4pNjm7Dh2kG1O9lKlDEobBFVqkj2fzWnhQswmuwFVK9MmPi/7pjMJr
	 KaXRBcuQ9WnqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/6] KVM: SVM: Move SEV-ES VMSA allocation to a dedicated sev_vcpu_create() helper
Date: Mon, 31 Aug 2026 14:31:56 -0400
Message-ID: <20260831183157.1673215-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831183157.1673215-1-sashal@kernel.org>
References: <2026083106-utensil-mangy-28f5@gregkh>
 <20260831183157.1673215-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 34bd82aab15b8b9e8e9d923267283c84aa8c2789 ]

Add a dedicated sev_vcpu_create() helper to allocate the VMSA page for
SEV-ES+ vCPUs, and to allow for consolidating a variety of related SEV+
code in the near future.

No functional change intended.

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Link: https://lore.kernel.org/r/20250819234833.3080255-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 42a39ad5d592 ("KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 20 ++++++++++++++++++++
 arch/x86/kvm/svm/svm.c | 25 +++++++------------------
 arch/x86/kvm/svm/svm.h |  2 ++
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d4026cd634c0f..ca07b2c05a4c6 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4669,6 +4669,26 @@ void sev_init_vmcb(struct vcpu_svm *svm)
 		sev_es_init_vmcb(svm);
 }
 
+int sev_vcpu_create(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct page *vmsa_page;
+
+	if (!sev_es_guest(vcpu->kvm))
+		return 0;
+
+	/*
+	 * SEV-ES guests require a separate (from the VMCB) VMSA page used to
+	 * contain the encrypted register state of the guest.
+	 */
+	vmsa_page = snp_safe_alloc_page();
+	if (!vmsa_page)
+		return -ENOMEM;
+
+	svm->sev_es.vmsa = page_address(vmsa_page);
+	return 0;
+}
+
 void sev_es_vcpu_reset(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 44819d9470dcf..c996f07b9c80a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1433,7 +1433,6 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm;
 	struct page *vmcb01_page;
-	struct page *vmsa_page = NULL;
 	int err;
 
 	BUILD_BUG_ON(offsetof(struct vcpu_svm, vcpu) != 0);
@@ -1444,24 +1443,18 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 	if (!vmcb01_page)
 		goto out;
 
-	if (sev_es_guest(vcpu->kvm)) {
-		/*
-		 * SEV-ES guests require a separate VMSA page used to contain
-		 * the encrypted register state of the guest.
-		 */
-		vmsa_page = snp_safe_alloc_page();
-		if (!vmsa_page)
-			goto error_free_vmcb_page;
-	}
+	err = sev_vcpu_create(vcpu);
+	if (err)
+		goto error_free_vmcb_page;
 
 	err = avic_init_vcpu(svm);
 	if (err)
-		goto error_free_vmsa_page;
+		goto error_free_sev;
 
 	svm->msrpm = svm_vcpu_alloc_msrpm();
 	if (!svm->msrpm) {
 		err = -ENOMEM;
-		goto error_free_vmsa_page;
+		goto error_free_sev;
 	}
 
 	svm->x2avic_msrs_intercepted = true;
@@ -1471,16 +1464,12 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
 	svm_switch_vmcb(svm, &svm->vmcb01);
 
-	if (vmsa_page)
-		svm->sev_es.vmsa = page_address(vmsa_page);
-
 	svm->guest_state_loaded = false;
 
 	return 0;
 
-error_free_vmsa_page:
-	if (vmsa_page)
-		__free_page(vmsa_page);
+error_free_sev:
+	sev_free_vcpu(vcpu);
 error_free_vmcb_page:
 	__free_page(vmcb01_page);
 out:
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index c34cd7f1408fc..a595064d6a52f 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -757,6 +757,7 @@ static inline struct page *snp_safe_alloc_page(void)
 	return snp_safe_alloc_page_node(numa_node_id(), GFP_KERNEL_ACCOUNT);
 }
 
+int sev_vcpu_create(struct kvm_vcpu *vcpu);
 void sev_free_vcpu(struct kvm_vcpu *vcpu);
 void sev_vm_destroy(struct kvm *kvm);
 void __init sev_set_cpu_caps(void);
@@ -781,6 +782,7 @@ static inline struct page *snp_safe_alloc_page(void)
 	return snp_safe_alloc_page_node(numa_node_id(), GFP_KERNEL_ACCOUNT);
 }
 
+static inline int sev_vcpu_create(struct kvm_vcpu *vcpu) { return 0; }
 static inline void sev_free_vcpu(struct kvm_vcpu *vcpu) {}
 static inline void sev_vm_destroy(struct kvm *kvm) {}
 static inline void __init sev_set_cpu_caps(void) {}
-- 
2.53.0

