Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E9D29B781;
	Thu,  3 Sep 2026 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474785; cv=none; b=H0Ia4qwJR02c6L9JS0Gq3OBd2GBF9SkBXV1TpsPtBaeV/5lijrxJhOTmmIJF8J7nXmOYrAU3TmaNrsOqTgyfFXpGupazDTTi2ZF/PJe9kXcdsHfMDTaaTMBHinyVre35pCNl9M4DJ9O5Im7FVZLSSCi85yYBkqsvKq7agCA04SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474785; c=relaxed/simple;
	bh=GOidwsnJhOip8VJp6afXe/zkz6g1Tqs6dQBAHsXAZMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYTx1uCpiV/UocFM9lxbY5fLxl1iHp0iS9N/Skhpp6a9IcWyJ8G7V7sHQKv7esd0NzmI7QR1QF/wfK63/YaiGwOkTp7Ld/HTK+52T///zTeTG0wNO56j15QWpHhjlpEsWiKAD5tT64apMVJ+++PhOKnuDUjuIJSlbMEfQ+5fKlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdAowHrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdAowHrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1F71F000E9;
	Thu,  3 Sep 2026 22:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474784;
	bh=5Tcdr3pRGwWdpsw0TS/QK24eDV88rpM7Wy5Pb9yKaKE=;
	h=From:To:Cc:Subject:Date;
	b=WdAowHrCemiBDo9KILZEKP6J2fM7tkoKk3fMWevXdEhq4Kr6rEtBuXFAcAFEH8L8g
	 vPfIjA8Sqxcyo6mVQICHYGgZK9W8UmwKzr8LbVA74shGRW9clZKLFOJFMjKOo9fY7J
	 k39EPz1sgayww0VgpEirP0tXO9pLNG58+DhUWikLWUCfs01AmUALO1jAu9cGQwezkF
	 OlklLTO2AO3N4rCD8vImp0Y1rYtqrpNQ05H1gDo9jg8Q6Tsk5PBPjlMtFNq1tE8XXR
	 Kr7A+yHZqm8Z/xxW740o1u43cSdsMB8op+svyiTzYDT9C0ANAxT0xaHyyRbvYNCR8D
	 m0iJAvNYABzRw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org,
	Stefan Teodorescu <fane@google.com>
Subject: [PATCH v2] KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU switch
Date: Thu,  3 Sep 2026 22:32:58 +0000
Message-ID: <20260903223258.486034-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the pCPU where the VMCB was mostly recently used is switched, reset
the ASID generation in both VMCBs, triggering new ASID allocation for
the immediate VMRUN as well as the next VMRUN on the other VMCB.

The ASID is shared between vmcb01 and vmcb02, and gets flushed on every
nested transition. However, since pCPU tracking is done per VMCB, it is
possible for one VMCB to allocate a new ASID when migrated to a new
pCPU, and then the other VMCB reuses that ASID on the old pCPU. This can
result in the same ASID being used by multiple vCPUs on the old pCPU.

Example scenario:
- vCPU runs on pCPU A, vmcb01 is active, asid=1.
- vCPU migrates to pCPU B, vmcb01 pCPU changes, new asid=2.
- Another vCPU runs on pCPU A and allocates asid=2 as well.
- vCPU migrates back to pCPU A, and then switches to vmcb02 before it
  runs again with vmcb01.
- No pCPU switch is detected for vmcb02, so VMRUN is done with asid=2.
- Two vCPUs end up using asid=2 on the same pCPU.

Keep the VMCB dirtying to the active VMCB only. Clean bits are tracked
by a pCPU for each VMCB, so do not unnecessarily dirty a VMCB if its
pCPU does not change.

Additionally, initialize the tracked pCPU for vmcb02 to -1 on nested
enablement as hardening, so that a new ASID allocation is always
triggered when nested is disabled and re-enabled.

No performance regression was noticed when overcommitting L1 vCPUs in L0
(to force rescheduling), pinning L1 <-> L2 vCPUs, and running CPUID in a
tight loop bouncing between 2 vCPUs in L2.

An alternative (and perhaps more proper) fix would be tracking the ASID
per-VMCB instead (e.g. [1]). However, that's a more involved change, and
it would result in having different ASIDs for L1 and L2 without actually
properly maintaining them. It would probably work because all TLB
flushes target the current VMCB, and the other VMCB is always flushed on
nested transitions, but the code ends up in an arguably more fragile
state. Punt a proper clean fix to an incoming (and overdue) overhaul of
SVM's ASID usage [2].

[1]https://lore.kernel.org/lkml/20250205182402.2147495-2-yosry.ahmed@linux.dev/
[2]https://lore.kernel.org/kvm/20260728003557.1136583-1-yosry@kernel.org/

Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---

v1 -> v2:
- Make resetting asid_generation in vmcb02 unconditional (Sean).

---
 arch/x86/kvm/svm/nested.c |  1 +
 arch/x86/kvm/svm/svm.c    | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a0..0c55c71fc6010 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1494,6 +1494,7 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 	if (!svm->nested.msrpm)
 		goto err_free_vmcb02;
 
+	svm->nested.vmcb02.cpu = -1;
 	svm->nested.initialized = true;
 	return 0;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ea647938a2a65..762b6059eda31 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3765,14 +3765,25 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	/*
-	 * If the previous vmrun of the vmcb occurred on a different physical
-	 * cpu, then mark the vmcb dirty and assign a new asid.  Hardware's
-	 * vmcb clean bits are per logical CPU, as are KVM's asid assignments.
+	 * If the previous VMRUN of the VMCB occurred on a different physical
+	 * cpu, then mark the VMCB dirty as hardware's clean bits are per pCPU.
+	 *
+	 * Reset the ASID generation in both VMCBs. This will lead to assigning
+	 * a new ASID now, and then again when switching to the other VMCB.
+	 * However, this is needed as the ASID is shared between the VMCBs, and
+	 * otherwise it would be possible to use an ASID allocated on one pCPU
+	 * on another, for example:
+	 * - vCPU migrates from pCPU A to pCPU B, allocates a new ASID.
+	 * - vCPU migrates back to pCPU A, and then switches the VMCB.
+	 * - The new VMCB does not detect a pCPU change and runs on pCPU A with
+	 *   the new ASID allocated on pCPU B, which is potentially used by
+	 *   another vCPU/VM.
 	 */
 	if (unlikely(svm->current_vmcb->cpu != vcpu->cpu)) {
-		svm->current_vmcb->asid_generation = 0;
 		vmcb_mark_all_dirty(svm->vmcb);
 		svm->current_vmcb->cpu = vcpu->cpu;
+		svm->vmcb01.asid_generation = 0;
+		svm->nested.vmcb02.asid_generation = 0;
         }
 
 	if (is_sev_guest(vcpu))

base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.979.g7e5102b832-goog

