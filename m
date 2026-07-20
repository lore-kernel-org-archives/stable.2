Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904D414DCC
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550163; cv=none; b=t6+5Ld4MbUs5aTVZAsMFpHXk1zf92/6Ga5ouCvvsOP/LyzuQ5jcIr33bXr6pA23SrWStTZVnZOli2kX46nmbzvV/ihRJ0PdM6iQF2M43Gw0YiF+ocdYf4LbeclM8dt1OMinA6aFdG7i0ugx7DpHsfPAql/eQcEL1W6YEZ/eAPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550163; c=relaxed/simple;
	bh=AFWrarc6zvU9Bp0BWHvz+TTgpeJq5TtFy7whwVnggZM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UllnJQ2yG+LVSiV15VyYA0a4WN/R2ktawA0OW3+nKXcxk/JzeodI1y9ix1/+xdsapgoD/ZZVBO3Xe7ZjRlJvqGz8SVjqtQXzrjFchRPcLyWPBFHRUbqvuIc8AYrAHdQjd1RNr4KejrdoM9Isj51JuGlPflIBXvr7v43rhJKqa1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GOsSzIF0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GOsSzIF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0676A1F00A3A;
	Mon, 20 Jul 2026 12:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550162;
	bh=7djA0H6Atd0pFODS8IYc5SYFRsuaNmUkmJqvuKeas4E=;
	h=Subject:To:Cc:From:Date;
	b=GOsSzIF0tJJXk7DOpYKWxwL3vfWp5tw864ccPheVPYYx7jtdaU0uf71XR1SDeX9Gh
	 yGmu8vemMbQ8diJgByEmgcbr28fFe96VBAUADngzba7shqoywQqsPzjTmtJQCCxYkr
	 ky6rlPqfkT4BZO1qdUxBraLfDs7CxeBULDKe9b5U=
Subject: FAILED: patch "[PATCH] KVM: arm64: nv: Re-translate VNCR before injecting abort" failed to apply to 6.18-stable tree
To: oupton@kernel.org,maz@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:22:33 +0200
Message-ID: <2026072033-frigidly-corncob-3b28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x bb645aa0a4caeaf7f9cd32e9a948594d434c1a8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072033-frigidly-corncob-3b28@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bb645aa0a4caeaf7f9cd32e9a948594d434c1a8f Mon Sep 17 00:00:00 2001
From: Oliver Upton <oupton@kernel.org>
Date: Thu, 18 Jun 2026 16:42:04 -0700
Subject: [PATCH] KVM: arm64: nv: Re-translate VNCR before injecting abort

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

