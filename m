Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511332BF24;
	Thu, 18 Jun 2026 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826134; cv=none; b=F2zxcjjH+8n0HV3VoN0VIQ2e9/bcFNaqmLNFbSPcaL4TIox2/sLLGUMHgGePerqM+FySCNA6cl/2OG3WNS9T1G8vLWDCwi7diiyqG7+TDIaxr8b6Pe/n/SU9M5NupnkYEZMDZw/Nzc4/dUX2RNDJhE1wAKJGmukToG/EaHjlmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826134; c=relaxed/simple;
	bh=g5lBboJ3d8nPq1vm+fj7L4eYDSYqPq6PoDX/J0mv8ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hd4UH7roao48Ekv3HJPjsSsRG69GVYV5tXV8Tjo3uuwlQMgQ3K8guTyGB60EZjZ/tOrfk5b/iewBRqVGxhxixo8X4KxKuP+snYYXKo0ggqwe0NNJge4IgpxAHEUVmd0hrf1Zm9WhGMA1gkYE+AgDDBcbPeJc+48BFCIqj1/vxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVLxt9xy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVLxt9xy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75C61F00ACA;
	Thu, 18 Jun 2026 23:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781826133;
	bh=mib5dkI6z13PhfcaIEt6PmIPCsO2JKCt+q6tfYGXims=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fVLxt9xyEKC56nHvbk29X2FPcdfFnuxiRsW5wKwUFpCGRo8NFzNhg2IsZzc6vQvMp
	 lUIweY3d+D9U2shjlJOnJTNwMikbmAwNu4imHr1oW1FE/anPAa3iOGmz8ga9pCsRw5
	 j7pVkE+6R5hVfzRWVuQEB+lzCk4L6kGowwDX9DJ7/eWifmkXbR/DW28qZwLKALybtn
	 GX/IbSo8Vzo+3IugiggyfKfKUzxRGouO45AmSvw0n8hRF6Be0uGPDsO4EKGOGMZekZ
	 QiaMsDX2ScFC+X5f50+I+fJ8Da/OB8rdRMn7NHO3DlNuychX1m+04E8ng7VGde6/E7
	 AVuzFATIDmZrQ==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 3/5] KVM: arm64: nv: Re-translate VNCR before injecting abort
Date: Thu, 18 Jun 2026 16:42:04 -0700
Message-ID: <20260618234207.1063941-4-oupton@kernel.org>
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
---
 arch/arm64/kvm/nested.c | 111 +++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 69 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 53dea9c3f14f..7fffd86eee94 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1466,88 +1466,61 @@ static void handle_vncr_perm(struct kvm_vcpu *vcpu)
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
+	if (!esr_fsc_is_translation_fault(esr) && !esr_fsc_is_permission_fault(esr)) {
+		WARN_ONCE(1, "Unhandled VNCR abort, ESR=%llx\n", esr);
+		return 1;
+	}
 
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
 
-			kvm_inject_nested_sync(vcpu, esr);
-			break;
-		case -EPERM:
-			/* Hack to deal with POE until we get kernel support */
+		kvm_inject_nested_sync(vcpu, esr);
+		break;
+	case 0:
+		perm = kvm_is_write_fault(vcpu) ? vt->wr.pw && vt->hpa_writable : vt->wr.pr;
+		if (!perm)
 			handle_vncr_perm(vcpu);
-			break;
-		case 0:
-			break;
-		}
-	} else {
-		WARN_ONCE(1, "Unhandled VNCR abort, ESR=%llx\n", esr);
+		break;
 	}
 
 	return 1;
-- 
2.47.3

