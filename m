Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AA331EC9;
	Tue,  9 Jun 2026 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031127; cv=none; b=hO5uQdmTgkn728P6hv+pIY9aFt6eEkEqb7ie9ocKB8qlT4nP9gPk8+mxCOc/ZnhqhZbiWScnQvaUQ1lYGFA2Ozm3pFThR9tmSsoqdV5Op1HajMPaZn8xsgmLmJmXQDMvo3ZK6rsd922YGuhjIfStlvEUsEo9KHYKxvaeZc+RGdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031127; c=relaxed/simple;
	bh=DGl1UctW4pQt4/v+oSCprn2lZVrdwEANR80MTD1xZqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5+hgEhMEIuHUoMIf+lg5XgQUY9DASBz7+2gYQXweUZymqDJm8MA6EysVo8+M8WdW4/wWiGJ7q/sszaZSQQMFa9cunmi0BOuuNjl3ZzMQLeMw7rrf/hDatU3Wb5yIDoWEytX4NQycM6m8MFjesLcTnQGd2xdHehU4qIDHldDnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk3CEkbw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk3CEkbw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7DA1F0089A;
	Tue,  9 Jun 2026 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031126;
	bh=KEjO1bJMLzqhiMLtTNOIakJ3jp0Sg8etgxFbQaJmm8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nk3CEkbw01IylTwhPyr9QtMZjWXaM8tpnRDiIgT/OoN2pHbl9sk1mydiW5MqYM9Cr
	 lZtgA1/6E+YiTZPK6ix7lzW0KQE+hyq7zo8QI6zIA/ZTo6b8uHjPtAItOftzS4QUS3
	 D2AsOF8c3Uqgtx9v3Co41CEGAzBjwMN1wRDnP8rHMvcnv6r3PAdReEnMGXSncvafCr
	 zF1i36fH9WMcGewN/E387b5rHHAGqgX3szQUcS8rV2UyX7AV1N+AwcNwqT4BFaUzqP
	 k/sl9ewPqe0gX+rUWfYCtCX6Dmm2muA1G4TdlmbNSrrz6IgfyQJnQXxSJESOizrnN/
	 /atsXe9nd6nMQ==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] KVM: arm64: nv: Respect read-only PFN when mapping L1 VNCR
Date: Tue,  9 Jun 2026 11:51:57 -0700
Message-ID: <20260609185204.745929-2-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609185204.745929-1-oupton@kernel.org>
References: <20260609185204.745929-1-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM currently maps the L1 VNCR into the host stage-1 by relying entirely
on the permissions of the guest stage-1. At the same time, it is
entirely possible that the backing PFN is read-only (e.g. RO memslot),
meaning that the L1 VNCR should use at most a read-only mapping.

Cache the writability of the PFN in the VNCR TLB and use it to constrain
the resulting fixmap permissions. Promote VNCR permission faults to an
SEA in the case where the guest attempts to write to a read-only
endpoint. Conveniently, this also plugs a page leak found by Sashiko [*]
resulting from the early return for a read-only PFN.

Cc: stable@vger.kernel.org
Fixes: 2a359e072596 ("KVM: arm64: nv: Handle mapping of VNCR_EL2 at EL2")
Link: https://lore.kernel.org/kvm/20260608082603.16AEC1F00893@smtp.kernel.org/
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/nested.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 257813289c76..cdbdf47fa6a2 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -24,6 +24,7 @@ struct vncr_tlb {
 	struct s1_walk_result	wr;
 
 	u64			hpa;
+	bool			hpa_writable;
 
 	/* -1 when not mapped on a CPU */
 	int			cpu;
@@ -1395,7 +1396,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 	if (!*is_gmem) {
 		pfn = __kvm_faultin_pfn(memslot, gfn, write_fault ? FOLL_WRITE : 0,
 					&writable, &page);
-		if (is_error_noslot_pfn(pfn) || (write_fault && !writable))
+		if (is_error_noslot_pfn(pfn))
 			return -EFAULT;
 	} else {
 		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, &page, NULL);
@@ -1404,6 +1405,8 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 					      write_fault, false, false);
 			return ret;
 		}
+
+		writable = !(memslot->flags & KVM_MEM_READONLY);
 	}
 
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
@@ -1414,6 +1417,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 
 		vt->gva = va;
 		vt->hpa = pfn << PAGE_SHIFT;
+		vt->hpa_writable = writable;
 		vt->valid = true;
 		vt->cpu = -1;
 
@@ -1421,21 +1425,33 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 		kvm_release_faultin_page(vcpu->kvm, page, false, vt->wr.pw);
 	}
 
-	if (vt->wr.pw)
+	if (vt->wr.pw && vt->hpa_writable)
 		mark_page_dirty(vcpu->kvm, gfn);
 
 	return 0;
 }
 
-static void inject_vncr_perm(struct kvm_vcpu *vcpu)
+static void handle_vncr_perm(struct kvm_vcpu *vcpu)
 {
 	struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
 	u64 esr = kvm_vcpu_get_esr(vcpu);
+	u64 fsc;
+
+	/*
+	 * Promote to an external abort if the stage-1 permits writes but the
+	 * HPA is read-only (e.g. RO memslot).
+	 */
+	if (kvm_is_write_fault(vcpu) && vt->wr.pw && !vt->hpa_writable)
+		fsc = ESR_ELx_FSC_EXTABT;
+	/*
+	 * Otherwise, inject a permission fault using the guest's translation
+	 * level rather than the host's.
+	 */
+	else
+		fsc = ESR_ELx_FSC_PERM_L(vt->wr.level);
 
-	/* Adjust the fault level to reflect that of the guest's */
 	esr &= ~ESR_ELx_FSC;
-	esr |= FIELD_PREP(ESR_ELx_FSC,
-			  ESR_ELx_FSC_PERM_L(vt->wr.level));
+	esr |= FIELD_PREP(ESR_ELx_FSC, fsc);
 
 	kvm_inject_nested_sync(vcpu, esr);
 }
@@ -1469,7 +1485,7 @@ int kvm_handle_vncr_abort(struct kvm_vcpu *vcpu)
 		return kvm_handle_guest_sea(vcpu);
 
 	if (esr_fsc_is_permission_fault(esr)) {
-		inject_vncr_perm(vcpu);
+		handle_vncr_perm(vcpu);
 	} else if (esr_fsc_is_translation_fault(esr)) {
 		bool valid, is_gmem = false;
 		int ret;
@@ -1517,7 +1533,7 @@ int kvm_handle_vncr_abort(struct kvm_vcpu *vcpu)
 			break;
 		case -EPERM:
 			/* Hack to deal with POE until we get kernel support */
-			inject_vncr_perm(vcpu);
+			handle_vncr_perm(vcpu);
 			break;
 		case 0:
 			break;
@@ -1561,7 +1577,7 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 
 	vt->cpu = smp_processor_id();
 
-	if (vt->wr.pw && vt->wr.pr)
+	if (vt->hpa_writable && vt->wr.pw && vt->wr.pr)
 		prot = PAGE_KERNEL;
 	else if (vt->wr.pr)
 		prot = PAGE_KERNEL_RO;
-- 
2.47.3

