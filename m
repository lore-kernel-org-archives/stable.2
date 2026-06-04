Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB68413246
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589264; cv=none; b=CfBQiwBvNsToPBaWLASNEaxje6HdsDq09KYEfNA6yvHU2WJDmvkvVmEbqIO834LOmNZMNngCbdpgpOtf4Hk/s4Jw7EQt8Yz9+G7tYOvUECZGCIYwJXtdXkAXymxh16qS5icBZgOmADGsAKjFFZE2d73cUrZXzQY61teCZhRILjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589264; c=relaxed/simple;
	bh=J5tZ9NNEIM9T2w2xibNmTr36mtNoOPW2WDlOYovucJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+TjAJ0xTcE0xh7bRfK+dyouMFoXVaFjH3yMmatqtFiHtS4mOh1iO8YAYf+ZvEMzi6orKCw1kFTH32H6Kd+Ln9fNwVCBa5ktwS/ftVka+41C+QDaPQEdHlD4SAx1Ssvu9XVceO7D3C3UUiB8aUOeGgxbsAcgEBpIWJWm4Fe2YTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwttSjS/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwttSjS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780589260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+/3qq3vcNnMSlbovUtLsbCgSAA5l6kz17jqK9FXU+0=;
	b=YwttSjS/5uPSrA8DWVbL+X7DX9RL8rYVDpKX3U68OrH2GJ59M2t+SVSplf5qhhNNsNkiMk
	YLsNge7gcRun5tAtzf3yZ8pvfszp9LaXu+nUb/62VT400d/qIXXsZL4Fq9dXiD327SVlzf
	4XQRicTw3+Ob9okWktPP4JDq+3+94yk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-vNOPzmBhNGGYrQaRoVI2SA-1; Thu,
 04 Jun 2026 12:07:36 -0400
X-MC-Unique: vNOPzmBhNGGYrQaRoVI2SA-1
X-Mimecast-MFC-AGG-ID: vNOPzmBhNGGYrQaRoVI2SA_1780589255
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25729195608E;
	Thu,  4 Jun 2026 16:07:35 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A14BB1800347;
	Thu,  4 Jun 2026 16:07:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/3] KVM: nVMX: unwind PDPTR load if processor triggers a nested VMFail
Date: Thu,  4 Jun 2026 12:07:31 -0400
Message-ID: <20260604160733.12555-2-pbonzini@redhat.com>
In-Reply-To: <20260604160733.12555-1-pbonzini@redhat.com>
References: <20260604160733.12555-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Upon a VM-entry failure that is caught by the processor rather than
KVM, nested_vmx_restore_host_state() restores L1's CR3 but not the
PDPTRs.  If shadow paging is used (enable_ept is false), the L2
PDPTRs loaded during the aborted entry attempt remain in
vcpu->arch.mmu->pdptrs[].

Note that the fact that the PDPTRs are stored in the MMU does not
save the day, because KVM only uses root_mmu if enable_ept is false.

To fix this, use nested_vmx_load_cr3() instead of open coding
just the load of vcpu->arch.cr3, in the same guise as
load_vmcs12_host_state().  nested_vmx_load_cr3() will mark the
register as dirty rather than available, but this is only a
very minor pessimization.

If EPT *is* in use, do not load the PDPTRs and rely solely on
ept_save_pdptrs() to reload them from VMCS01.  When vmx_load_mmu_pgd()
runs on the next entry, the PDPTRs are available---meaning they are
not incorrectly reloaded from memory.

kvm_mmu_unload() is preserved to keep the paths from the old
kvm_mmu_reset_context(), but is actually unnecessary.  It can
be removed as a separate patch.

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4690a4d23709..d612a5d071fc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4947,6 +4947,7 @@ static inline u64 nested_vmx_get_vmcs01_guest_efer(struct vcpu_vmx *vmx)
 
 static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 {
+	enum vm_entry_failure_code ignored;
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmx_msr_entry g, h;
@@ -4984,20 +4985,19 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 	vmx_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
 
 	nested_ept_uninit_mmu_context(vcpu);
-	vcpu->arch.cr3 = vmcs_readl(GUEST_CR3);
-	kvm_register_mark_available(vcpu, VCPU_REG_CR3);
 
 	/*
-	 * Use ept_save_pdptrs(vcpu) to load the MMU's cached PDPTRs
-	 * from vmcs01 (if necessary).  The PDPTRs are not loaded on
-	 * VMFail, like everything else we just need to ensure our
-	 * software model is up-to-date.
+	 * Now that nested EPT has been disabled, load the MMU's CR3 and
+	 * possibly PDPTRs from vmcs01 (if necessary).  This should not
+	 * happen for VMFail, but we get here if the check was caught by
+	 * the processor and therefore the guest CR3 was loaded prematurely.
 	 */
+	kvm_mmu_unload(vcpu);
+	if (nested_vmx_load_cr3(vcpu, vmcs_readl(GUEST_CR3), false, !enable_ept, &ignored))
+		nested_vmx_abort(vcpu, VMX_ABORT_LOAD_HOST_PDPTE_FAIL);
 	if (enable_ept && is_pae_paging(vcpu))
 		ept_save_pdptrs(vcpu);
 
-	kvm_mmu_reset_context(vcpu);
-
 	/*
 	 * This nasty bit of open coding is a compromise between blindly
 	 * loading L1's MSRs using the exit load lists (incorrect emulation
-- 
2.52.0


