Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4913284693;
	Thu, 18 Jun 2026 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826133; cv=none; b=dVC6jx+osqDqnul/OjvEFN4ggx8hA89+mT7CKpyKkzjNqwzo22Duc1ixGDA84nZqp+2FCdmniobNf94KC3pRQvthfia33MasNNXwqxJSl6Th3LnapXm/i+qZWHnH0u9uYr/SldJQYc1AXTqnRvymvV48PM6QkPc9ayud0CAWj2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826133; c=relaxed/simple;
	bh=HlbFO1vRPdTxj/mELPo6g/VuNV7DiuuclUNyVf1thvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixWD8ogMYw08aB+VePldN3syZR/yC/nFQUNFOqKspxs3KtvdYJe/uXdOD2IXNMmgJDL4ajAXzG0JOsj8kfcxAacK08C3Opgv+rcC0EzgnERtjEoDxpT40xeetfURqNfqbJ4tmJg75fmINy7Ew9ulw2RMtZYE4RrNrsuBi4QRBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QER42AwK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QER42AwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725701F00A3E;
	Thu, 18 Jun 2026 23:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781826132;
	bh=BETV21yotoRrywAH48Ggq1x0Jn6tHp9YF3S+4kdohAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QER42AwKCmGqbns17YWWCk++4W2POQlputfom1X5JSoqbsGigOEzDKitgZm308BJZ
	 deyyCO+ljg2bKyM+r6poeta8Jf7a6khHaVR/sBBgLlxy4AFpjzLKxA8bR2T6dVPXI4
	 2HA76iUH4I83Jrjdvmp56l/EsWrrqFwgFyoi4zP8ftf8EnTyV+nY+IAnlAG7OM/+bf
	 Kwe5sPhKdElN7bZd1DStmjP3fm5ETgHebdmxv3FO7mT1dkoFTThntxLPwlR9XkFmZ6
	 HUS6OxgUC1iEUqK6rM+amyCvzDuy+IWTA4FBstvaUygOyka6u3om9SCWQ0pHp2Oq9v
	 eKNuZHzUFL1pQ==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/5] KVM: arm64: nv: Respect read-only PFN when mapping L1 VNCR
Date: Thu, 18 Jun 2026 16:42:02 -0700
Message-ID: <20260618234207.1063941-2-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618234207.1063941-1-oupton@kernel.org>
References: <20260618234207.1063941-1-oupton@kernel.org>
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
 arch/arm64/kvm/nested.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 3a5571c3c114..903ccabca78c 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -24,6 +24,7 @@ struct vncr_tlb {
 	struct s1_walk_result	wr;
 
 	u64			hpa;
+	bool			hpa_writable;
 
 	/* -1 when not mapped on a CPU */
 	int			cpu;
@@ -1401,7 +1402,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 	if (!*is_gmem) {
 		pfn = __kvm_faultin_pfn(memslot, gfn, write_fault ? FOLL_WRITE : 0,
 					&writable, &page);
-		if (is_error_noslot_pfn(pfn) || (write_fault && !writable))
+		if (is_error_noslot_pfn(pfn))
 			return -EFAULT;
 	} else {
 		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, &page, NULL);
@@ -1410,6 +1411,8 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 					      write_fault, false, false);
 			return ret;
 		}
+
+		writable = !(memslot->flags & KVM_MEM_READONLY);
 	}
 
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
@@ -1420,28 +1423,41 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 
 		vt->gva = va;
 		vt->hpa = pfn << PAGE_SHIFT;
+		vt->hpa_writable = writable;
 		vt->valid = true;
 		vt->cpu = -1;
 
 		kvm_make_request(KVM_REQ_MAP_L1_VNCR_EL2, vcpu);
-		kvm_release_faultin_page(vcpu->kvm, page, false, vt->wr.pw);
+		kvm_release_faultin_page(vcpu->kvm, page, false, vt->wr.pw && vt->hpa_writable);
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
@@ -1475,7 +1491,7 @@ int kvm_handle_vncr_abort(struct kvm_vcpu *vcpu)
 		return kvm_handle_guest_sea(vcpu);
 
 	if (esr_fsc_is_permission_fault(esr)) {
-		inject_vncr_perm(vcpu);
+		handle_vncr_perm(vcpu);
 	} else if (esr_fsc_is_translation_fault(esr)) {
 		bool valid, is_gmem = false;
 		int ret;
@@ -1523,7 +1539,7 @@ int kvm_handle_vncr_abort(struct kvm_vcpu *vcpu)
 			break;
 		case -EPERM:
 			/* Hack to deal with POE until we get kernel support */
-			inject_vncr_perm(vcpu);
+			handle_vncr_perm(vcpu);
 			break;
 		case 0:
 			break;
@@ -1567,7 +1583,7 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 
 	vt->cpu = smp_processor_id();
 
-	if (vt->wr.pw && vt->wr.pr)
+	if (vt->hpa_writable && vt->wr.pw && vt->wr.pr)
 		prot = PAGE_KERNEL;
 	else if (vt->wr.pr)
 		prot = PAGE_KERNEL_RO;
-- 
2.47.3

