Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DE44A739
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627933; cv=none; b=PWkO4WzCRsM257oRBlR+mHTPDrn3nNrtdxlNNR3CKwgiiKBjxpKAaEfMAP+PFHuhF2vAmyQbo+X3CPMBaPM7mwCGAb4dsYQJWPDTs3CumuMG7yu0XKkU2TFQHtAxG5w6O8bHezj5m9LEFt/7nGZr25h73XP+f+dIVrs21sPlAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627933; c=relaxed/simple;
	bh=RxdjQzcTS8iZSBm1U3ewY9jCV0xW/EPqjrWFGv5pyQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP4KsP62SDvtQ/4hk2iKUOnEHKakSX32O/j6NCBKqw15wfwTE92oJpxcWEBIFBw0VgETttwGB+BJ7s7xyZzYe0a1mk3gtrrMjylBk6h8Y4s2B0K8SsbY/f+/COrYdtziIQJqnQE3xmeT4hlUiGJKdfRi1lwvW+OiRzakVveP2q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z06w8U2x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z06w8U2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63F51F00A3F;
	Tue, 21 Jul 2026 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627930;
	bh=X2UlyPnPrKvzGLv0CXGBZUBDLgXgWo89q6dUatazPck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z06w8U2xKtGxN2lamsoqxnR5ylZd1b3fx2mtsAxM/yEo6QOVqhdG6Jl4WWSkzhycs
	 m3LkJCwN+W+v2plH7ZY2kNSADiYXMudxXJKD34eHbVt0pR6nElUswvUdo2l/blbn8y
	 xGEiUqro9Bjj6zMACFXhEtq3T7zalrmLnWEAV8tOnbP+Q1ZgE4DPA6m9RASsUTc2+T
	 vNU4sYUnG62xyFdugt00NfqlaKbxSUeJpsGJ4CBKKGpHCsIj71iSJ5Ycj6vEKrIZAe
	 qXFsTbEzYbh8GuqL4iYIwRStuXO98dam/S2TeIj/SRFhF5+f+qwI1O7DGBZgNK5Z8f
	 9Ho5IdRBNkrVA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm7FR-00000007A0q-0bKC;
	Tue, 21 Jul 2026 09:58:49 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Oliver Upton <oupton@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.18.y 4/5] KVM: arm64: nv: Re-translate VNCR before injecting abort
Date: Tue, 21 Jul 2026 10:58:40 +0100
Message-ID: <20260721095841.2845371-4-maz@kernel.org>
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
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, joey.gouly@arm.com, jonathan.cameron@huawei.com, oupton@kernel.org, sashiko-bot@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

From: Oliver Upton <oupton@kernel.org>

KVM faults in the VNCR page with FOLL_WRITE whenever the guest aborts
for a write, similar to how a regular stage-2 mapping is handled. It is
entirely possible that the guest reads from the VNCR before writing to
it, in which case the PFN could only be read-only.

Invalidate the VNCR TLB and re-fetch the translation upon taking a VNCR
abort, allowing the host mapping to be faulted in for write the second
time around. Interestingly enough, this also satisfies the ordering
requirements of FEAT_ETS2/3 between descriptor updates and MMU faults.

Cc: stable@vger.kernel.org
Fixes: 2a359e072596 ("KVM: arm64: nv: Handle mapping of VNCR_EL2 at EL2")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/20260618234207.1063941-4-oupton@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
(cherry picked from commit bb645aa0a4caeaf7f9cd32e9a948594d434c1a8f)
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/nested.c | 115 +++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index ece0fd268ecc2..0e418975649f2 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1318,88 +1318,61 @@ static void handle_vncr_perm(struct kvm_vcpu *vcpu)
 	kvm_inject_nested_sync(vcpu, esr);
 }
 
-static bool kvm_vncr_tlb_lookup(struct kvm_vcpu *vcpu)
-{
-	struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
-
-	lockdep_assert_held_read(&vcpu->kvm->mmu_lock);
-
-	if (!vt->valid)
-		return false;
-
-	if (read_vncr_el2(vcpu) != vt->gva)
-		return false;
-
-	if (vt->wr.nG)
-		return get_asid_by_regime(vcpu, TR_EL20) == vt->wr.asid;
-
-	return true;
-}
-
 int kvm_handle_vncr_abort(struct kvm_vcpu *vcpu)
 {
 	struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
 	u64 esr = kvm_vcpu_get_esr(vcpu);
+	bool is_gmem = false;
+	bool perm;
+	int ret;
 
 	WARN_ON_ONCE(!(esr & ESR_ELx_VNCR));
 
 	if (kvm_vcpu_abt_issea(vcpu))
 		return kvm_handle_guest_sea(vcpu);
 
-	if (esr_fsc_is_permission_fault(esr)) {
-		handle_vncr_perm(vcpu);
-	} else if (esr_fsc_is_translation_fault(esr)) {
-		bool valid, is_gmem = false;
-		int ret;
-
-		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
-			valid = kvm_vncr_tlb_lookup(vcpu);
-
-		if (!valid)
-			ret = kvm_translate_vncr(vcpu, &is_gmem);
-		else
-			ret = -EPERM;
-
-		switch (ret) {
-		case -EAGAIN:
-			/* Let's try again... */
-			break;
-		case -ENOMEM:
-			/*
-			 * For guest_memfd, this indicates that it failed to
-			 * create a folio to back the memory. Inform userspace.
-			 */
-			if (is_gmem)
-				return 0;
-			/* Otherwise, let's try again... */
-			break;
-		case -EFAULT:
-		case -EIO:
-		case -EHWPOISON:
-			if (is_gmem)
-				return 0;
-			fallthrough;
-		case -EINVAL:
-		case -ENOENT:
-		case -EACCES:
-			/*
-			 * Translation failed, inject the corresponding
-			 * exception back to EL2.
-			 */
-			esr &= ~ESR_ELx_FSC;
-			esr |= FIELD_PREP(ESR_ELx_FSC, vt->wr.fst);
-
-			kvm_inject_nested_sync(vcpu, esr);
-			break;
-		case -EPERM:
-			/* Hack to deal with POE until we get kernel support */
-			handle_vncr_perm(vcpu);
-			break;
-		case 0:
-			break;
-		}
-	} else {
+	if (!esr_fsc_is_translation_fault(esr) && !esr_fsc_is_permission_fault(esr)) {
 		WARN_ONCE(1, "Unhandled VNCR abort, ESR=%llx\n", esr);
+		return 1;
+	}
+
+	ret = kvm_translate_vncr(vcpu, &is_gmem);
+	switch (ret) {
+	case -EAGAIN:
+		/* Let's try again... */
+		return 1;
+	case -ENOMEM:
+		/*
+		 * For guest_memfd, this indicates that it failed to
+		 * create a folio to back the memory. Inform userspace.
+		 */
+		if (is_gmem)
+			return 0;
+		/* Otherwise, let's try again... */
+		break;
+	case -EFAULT:
+	case -EIO:
+	case -EHWPOISON:
+		if (is_gmem)
+			return 0;
+		fallthrough;
+	case -EINVAL:
+	case -ENOENT:
+	case -EACCES:
+		/*
+		 * Translation failed, inject the corresponding
+		 * exception back to EL2.
+		 */
+		esr &= ~ESR_ELx_FSC;
+		esr |= FIELD_PREP(ESR_ELx_FSC, vt->wr.fst);
+
+		kvm_inject_nested_sync(vcpu, esr);
+		break;
+	case 0:
+		perm = kvm_is_write_fault(vcpu) ? vt->wr.pw && vt->hpa_writable : vt->wr.pr;
+		if (!perm)
+			handle_vncr_perm(vcpu);
+		break;
 	}
 
 	return 1;
-- 
2.47.3

