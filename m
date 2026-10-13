Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3503F5437FA;
	Tue, 13 Oct 2026 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921248; cv=none; b=DkkLmdKc/+COeaut56pTSTlDSspoHJVSMwrRl8H6ps6PBUy/zLlIgaaQRh/e+CXhR2iy8EJp2ZcFWVSVOqpyhjngPT//+VUY5bJ+KpK+HUiONJRsi9eD90bDfASWf2SjHuNGt30y3I3kBX2C1Hruaw1AfyYh2/zRp7koKV5q4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921248; c=relaxed/simple;
	bh=KgBJVhi+a3JJR/FFzMsm9BkMDU3pz5CXbIUC9gHYIwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTCXt58BMbAkxxbsna54qhmPwY4SannCHKBMb//1HB7mabIB5vNdcF/PXdQ4itk5Q5eULBqh/FZpfLFD76PuLzNtvH4jg5n9Ie94eqoluTZ9X+XVpZTs1mmu+FuL4PVKJMRNF/V3oH6hmZ2Mk6ie4/cLs9Klrlc/AZDQAAUDN8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgV+Oq7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgV+Oq7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311211F0089A;
	Tue, 13 Oct 2026 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791921246;
	bh=y8BNGx1B+oJ+F1czJnSm0HLm4uNAk3ocNXTsT6UmXCo=;
	h=From:To:Cc:Subject:Date;
	b=KgV+Oq7Yicw3cY/oF11b9sTL2uJUm8BHlsqgSoHg/l9GGJWDZI/z3NWdTMfCC5na8
	 tC6T7tn/JYBTZc6jkFp7LCd77MP20bqNfWjl0/dVNQWxi2IgDa+NZm1fwjgEn7D2Uk
	 W/xGR4triixpqhc65C7ny6rrxK1C8EpHYH2CQ2TEf2aAqjv9G84XfyvKoaqLH2UlR0
	 SdREkbyIDLiwk5AGgW4fmL+nvBQyVvzUoG2uTJyDM7WOlqWVr16nIFhKrw10OrmYCQ
	 a4hyzo+4+GR2wTmnrPj3ZfnEWKwMEPEIiwrL/REA26M6P9V1jnY6MjMJI7hQQwujKs
	 rhEMNYrPzHeLw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org,
	Stefan Teodorescu <fane@google.com>
Subject: [PATCH v2] KVM: SVM: Update tracked pCPU on pCPU switch
Date: Tue, 13 Oct 2026 19:53:58 +0000
Message-ID: <20261013195358.163375-1-yosry@kernel.org>
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

v1 -> v2:
- Drop confusing comment [Jim].

---
 arch/x86/kvm/svm/svm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44f..95c61b7a470b8 100644
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
@@ -3894,11 +3895,16 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 	 *   another vCPU/VM.
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

base-commit: 6bd2905303c58679e303941b7d8ae8c074cd95ce
-- 
2.56.0.385.gd3acb90ef8-goog

