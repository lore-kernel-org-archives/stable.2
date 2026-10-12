Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816E309EEB;
	Mon, 12 Oct 2026 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845266; cv=none; b=GFuJhNQxopwkjIvj+6ZWrNx5rkjOsy4FVa0xyyURJICsU1IOHF8P9Jmx4foTcnty5en2RVgF3eKPaomC7tX8QExSO1ekmkhGBXAH8y3Y9BlkVErr+WZ4kK3D3PHf00v7KM9oDFCrIl5RnCxubihIaom8iZkm1hrJj2/9Q0Z6AZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845266; c=relaxed/simple;
	bh=gSzK43xwQsRWvXPMuD0BVIczHX5YfAk2idhvuv52m4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HoMwX3HhjAEsVp49sCYKkhNq3YkKzkbG9tzKZ/Uu1JSXgJRDfA5AcUiBSYP2LlP3cUo6xhTP/Utu30/KcT49RdiZ3/fKQzl9amJR5/bvzISd11QOgFB8VoqwUGBgLr46VUx89t6aVnyeBHvy2LHstNThHBfY3z/PpeiKxCLlZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKvUZqHn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKvUZqHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA381F0089B;
	Mon, 12 Oct 2026 22:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791845264;
	bh=IkZtVdQRBGfsQtRmAVvA981qRKbOGtIeucsyYcy0Vkg=;
	h=From:To:Cc:Subject:Date;
	b=AKvUZqHnellwhzCFtmtdw/5kQx/j9X9IbLKswp26pV7TkK7axqJmAu7RDpPS929cT
	 R1UYAKeFTKjUoYHm8IlrLDSuQ4Lf6n5YhUnJqag9F9504/6WjOj/icXDVJpaUTnuL0
	 NQdI+AH7gZIgLR1E26kGFGT4T/IHZkCPuGAhgpEjUG+RHYg7OKCxnqCRLLdm67Kja7
	 vLU1UQIxhSDu1auCHz3ldItagfS43CHmwqWiQ4Sn2rmpfxhuUb/gTzi2a4u75jX0dN
	 S3p+wMtfdtb9iBRWCktbVJHDG9epDlW1I3TbTyKZBoVBizCx/47JhZs0oE4htYAhvt
	 wSy8U33Gu2hcQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org,
	Stefan Teodorescu <fane@google.com>
Subject: [PATCH] KVM: SVM: Update tracked pCPU on pCPU switch
Date: Mon, 12 Oct 2026 22:47:36 +0000
Message-ID: <20261012224736.2306637-1-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a pCPU switch is detected in pre_svm_run(), update the tracked pCPU
and mark all fields dirty in both VMCBs (if nested is initialized), in
addition to resetting the ASID generation in both VMCBs.

Commit bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both
VMCBs on pCPU switch") reset the ASID generation in both VMCBs on a pCPU
switch, but only updated the tracked pCPU for the active VMCB to avoid
unnecessarily dirtying the inactive VMCB. Leaving the inactive VMCB's
tracked pCPU set to an old pCPU still allows an ASID allocated on one
pCPU to be used on another:

- vCPU runs with both vmcb01 and vmcb02 on pCPU A (both track cpu=A).
- With vmcb01 active, vCPU migrates to pCPU B. vmcb01.cpu is updated to
B, asid_generation is reset to 0 in both VMCBs, and a new ASID is
allocated on pCPU B (setting vmcb01.asid_generation = gen_B).
vmcb02.cpu remains A.
- vCPU switches to vmcb02 and migrates back to pCPU A before
pre_svm_run(). Because vmcb02.cpu is still A, no pCPU switch is
detected, leaving vmcb01 with cpu=B and asid_generation=gen_B.
Because vmcb02.asid_generation is 0, a new ASID (asid_A) is allocated
on pCPU A.
- vCPU switches back to vmcb01 and migrates to pCPU B. Neither a pCPU
change nor a generation mismatch is detected for vmcb01, so VMRUN on
pCPU B uses asid_A (allocated on pCPU A), which may collide with
another vCPU on pCPU B.

Because the per-VMCB cpu tracking is shared between ASID management and
per-pCPU hardware VMCB clean bits, also mark both VMCBs dirty when
updating their tracked pCPU so that the inactive VMCB does not run with
stale clean bits when later entered on the new pCPU.

Fixes: bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU switch")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44f..0a0af0cbb6bba 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3880,7 +3880,8 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 
 	/*
 	 * If the previous VMRUN of the VMCB occurred on a different physical
-	 * cpu, then mark the VMCB dirty as hardware's clean bits are per pCPU.
+	 * cpu, mark the VMCB dirty and reset the ASID generation, as hardware's
+	 * clean bits and ASIDs are per pCPU.
 	 *
 	 * Reset the ASID generation in both VMCBs. This will lead to assigning
 	 * a new ASID now, and then again when switching to the other VMCB.
@@ -3892,13 +3893,22 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 	 * - The new VMCB does not detect a pCPU change and runs on pCPU A with
 	 *   the new ASID allocated on pCPU B, which is potentially used by
 	 *   another vCPU/VM.
+	 *
+	 * Note that dirtying both VMCBs is not strictly needed, but the per-CPU
+	 * tracking is shared for both ASID and clean bits, and that CPU must
+	 * match where the ASID was allocated.
 	 */
 	if (unlikely(svm->current_vmcb->cpu != vcpu->cpu)) {
-		vmcb_mark_all_dirty(svm->vmcb);
-		svm->current_vmcb->cpu = vcpu->cpu;
+		vmcb_mark_all_dirty(svm->vmcb01.ptr);
+		svm->vmcb01.cpu = vcpu->cpu;
 		svm->vmcb01.asid_generation = 0;
-		svm->nested.vmcb02.asid_generation = 0;
-        }
+
+		if (svm->nested.initialized) {
+			svm->nested.vmcb02.cpu = vcpu->cpu;
+			svm->nested.vmcb02.asid_generation = 0;
+			vmcb_mark_all_dirty(svm->nested.vmcb02.ptr);
+		}
+	}
 
 	if (is_sev_guest(vcpu))
 		return pre_sev_run(svm, vcpu->cpu);
-- 
2.56.0.385.gd3acb90ef8-goog

