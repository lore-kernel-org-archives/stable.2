Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050248;
	b=nkBHuJaCriL8q1fyRr1F2JzMsHTPtZN6ua63N04xEMRhgyd5R90L4NV4CcshU4gxn7US
	 ULrLcemw8/DzA+8CEIVo/vxBF6rePh1PRL2yNAmeiQAaCMbSCJmazXZacSFzv4idOyuk1
	 XS4I0zpJwnwSfP6FUGv7hW1z7yC80X++fEMucVRbA/aVj7c0ulRpXnamdTAt10lLY8Xbm
	 ythrmzrTwZItrhrMwyPs0M3iwkl4qDb1jOuolrqOAT8scI3xZxN1B3BgCpGTmRanHWvko
	 yphsdl0mi2TQzcgDNK0RE/dCCo+qpsAIXB7dwk4kQCvs1oZs9H+zn2C+FepkvI9tgTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050248;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=P68eMUZE4mPAmOPxqY8uCAylxd227jQGo18Vt1fw3kc=;
	b=qw+VdYmjv7wvwn+5lc2g4HOSzCnoNu5xE7OwMdlxdDZ5pyAIXQh3C87PwjYiZMxXGhRX
	 PH406mg3RxKQbm2Guvjw0m/dClOKQmgNwDs+ZdynMBPj5pXQSM/TDiGGsr4GvLX1+w/jK
	 1fUR9Wbc2Izib+XV3Vuj2z6fy0HRyiZ5/6A/9FUPeymBX9+tPt9jkvk7Es6nlC3pqhmqi
	 8IzkieHn144Va/LnYdnziICszrMJo5L2D9WUYAZxaHS9HPQLnJz1+xhJo2/GJMYUNvsG+
	 HLX4ENRbVBuylzCV3SxodHoNkYToFpFr3KxaGc7rU6lHSndnQZFkE8VAU48pQtjFonA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R/me/CbQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E93606D809
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/me/CbQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3661F008A2;
	Sat,  7 Nov 2026 11:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050247;
	bh=P68eMUZE4mPAmOPxqY8uCAylxd227jQGo18Vt1fw3kc=;
	h=From:To:Cc:Subject:Date;
	b=R/me/CbQe9hw7MHV1ibq9aJYcCDCiQ5R5WVNTlryjeZLVatIFQ4WW/+tXDG+QKKJa
	 6JhggFxXrSjJp3v9O8fmugXflnO8uvXBh1xL0nRQJO4BJYHlF7/9Ru9JvbWezYyVMg
	 jK+DIJFGznxS5BTb+R/76R+PuJTDnihBttWyQDyvIzDwmc+8APu02QVIlIrRXkvEcI
	 Kzr2vrybuGvf39Yd7f5i6v68N97cTklYfJo5Rfmt07btYH/YTbEGBwG9Jy/H2H82an
	 MPcyDcrk3TMeLkr49xqtLqbu8xBJvgNe8itld7W4poZ8bfTZPB2fetB38Jo+KhomsV
	 Sh7HeZTYArFuQ==
From: Sasha Levin <sashal@kernel.org>
To: yosry@kernel.org,
	fane@google.com,
	nikunj@amd.com,
	seanjc@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU switch" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:26 -0500
Message-ID: <20261107061725-failed-5.10-bf260dc9e7b8@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x bf260dc9e7b8bfcd06c1a8e739797b1cf0917c72
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061725-failed-5.10-bf260dc9e7b8@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bf260dc9e7b8bfcd06c1a8e739797b1cf0917c72 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 3 Sep 2026 22:32:58 +0000
Subject: [PATCH] KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU
 switch

When the pCPU where the VMCB was most recently used is switched, reset
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

[1] https://lore.kernel.org/lkml/20250205182402.2147495-2-yosry.ahmed@linux.dev
[2] https://lore.kernel.org/kvm/20260728003557.1136583-1-yosry@kernel.org

Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Link: https://patch.msgid.link/20260903223258.486034-1-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
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
index 7d59d301e1e54..2332814cd2034 100644
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
-- 
2.53.0




