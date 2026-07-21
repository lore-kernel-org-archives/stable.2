Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610622157B
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627933; cv=none; b=d8qGz8Ua454aRKiftXFTVQH7/Rzvu7DvhphPyN7yHal/46y8IkMRxoA7sv7lgHO8sMJTsWYwzdCuPawMC22bx/XlWt0PXSMKsGaeWaqJsMC0cq818zS+/aDSFkbgzQKpPmN/g5qIdL9j+7nH7fkwrf5XcbsRftz1uEFgCy0K+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627933; c=relaxed/simple;
	bh=KLM8OWYAOBQYr7UN1LHvMGmH9qqo8km/Zes0oeq/zl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSTyrtg+VBbeiU+0Gy7ndNGE2tv3dB6ZTMCZhEJdN8QUqDLdTwtAZRKkIsD0kdR2pmjbMiKj10FtyyggaIFrCFvS3f2CkP6/xwqAcEOyiDtrQCrRETG7kkiAEA+8ySyee0FqWx5pNEeIHnPwO/6z8rdbNhUJzuxiQu8K7D/IG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIAEFau1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIAEFau1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1B91F00A3A;
	Tue, 21 Jul 2026 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627930;
	bh=81a1xdVzgh5R8VYK6/Gpx4Ih4feTMVhtVI9m4KgIaN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIAEFau1y9YEbrlZEdztAk7Z+942yOZHW2qdRLSb5h/ik6r3sQpfldWyEY8w9e2wR
	 fiob4n7Cc0D93sOmnKIzTSf6jsvMF8R+HsDk1wKeIthYk3aDvF6tJrFHqnlvincqEU
	 4jL83/uhkqVPcvdJNfHctDS9UpRDeCCxzwXXumbIs82IgxpVUoLgcO7IchHKK0XMU3
	 oCxKozDyBP4qltQaE6j//WMCWlit4StNX9gsTIrC6QdOeV1L9q/LJTFCoEOnG3YJL1
	 84OicOLIEpqVdL4YvmwstD4Ax3ni7Rl3Lko7ZQyPYepQ6lFO2AN3/TeLCtldWUo5+F
	 OJBcMjnl9IZAg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm7FQ-00000007A0q-3FVi;
	Tue, 21 Jul 2026 09:58:48 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Oliver Upton <oupton@kernel.org>
Subject: [PATCH 6.18.y 2/5] KVM: arm64: nv: Respect read-only PFN when mapping L1 VNCR
Date: Tue, 21 Jul 2026 10:58:38 +0100
Message-ID: <20260721095841.2845371-2-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721095841.2845371-1-maz@kernel.org>
References: <2026072033-frigidly-corncob-3b28@gregkh>
 <20260721095841.2845371-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, joey.gouly@arm.com, jonathan.cameron@huawei.com, oupton@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

From: Oliver Upton <oupton@kernel.org>

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
Link: https://patch.msgid.link/20260618234207.1063941-2-oupton@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
(cherry picked from commit 2684e02bac41c5220f6c1ab2bdcc957b71812977)
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/nested.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 255a69d03584f..7aabddfd895ef 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -24,6 +24,7 @@ struct vncr_tlb {
 	struct s1_walk_result	wr;
 
 	u64			hpa;
+	bool			hpa_writable;
 
 	/* -1 when not mapped on a CPU */
 	int			cpu;
@@ -1253,7 +1254,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 	if (!*is_gmem) {
 		pfn = __kvm_faultin_pfn(memslot, gfn, write_fault ? FOLL_WRITE : 0,
 					&writable, &page);
-		if (is_error_noslot_pfn(pfn) || (write_fault && !writable))
+		if (is_error_noslot_pfn(pfn))
 			return -EFAULT;
 	} else {
 		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, &page, NULL);
@@ -1262,6 +1263,8 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 					      write_fault, false, false);
 			return ret;
 		}
+
+		writable = !(memslot->flags & KVM_MEM_READONLY);
 	}
 
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
@@ -1272,28 +1275,41 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 
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
@@ -1327,7 +1343,7 @@ int kvm_handle_vncr_abort(struct kvm_vcpu *vcpu)
 		return kvm_handle_guest_sea(vcpu);
 
 	if (esr_fsc_is_permission_fault(esr)) {
-		inject_vncr_perm(vcpu);
+		handle_vncr_perm(vcpu);
 	} else if (esr_fsc_is_translation_fault(esr)) {
 		bool valid, is_gmem = false;
 		int ret;
@@ -1375,7 +1391,7 @@ int kvm_handle_vncr_abort(struct kvm_vcpu *vcpu)
 			break;
 		case -EPERM:
 			/* Hack to deal with POE until we get kernel support */
-			inject_vncr_perm(vcpu);
+			handle_vncr_perm(vcpu);
 			break;
 		case 0:
 			break;
@@ -1419,7 +1435,7 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 
 	vt->cpu = smp_processor_id();
 
-	if (vt->wr.pw && vt->wr.pr)
+	if (vt->hpa_writable && vt->wr.pw && vt->wr.pr)
 		prot = PAGE_KERNEL;
 	else if (vt->wr.pr)
 		prot = PAGE_KERNEL_RO;
-- 
2.47.3

