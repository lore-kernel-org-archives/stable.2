Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557763F326B;
	Tue,  6 Oct 2026 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289490; cv=none; b=qHRV5MNhv7O4k1Y1fjDSuiCWaLJN2y9BWgsS3UpGhgOxqa60Zk5ciU67AuPbFcRwOvPDwo9ugZPLT3YeLm0jVLAWvM2+ofPGqkmK+ZOmYTie2Ck5tGVF7b266AkLGm5qIRxczAl7lqA662lPvn4PkbpjYzKxwfmvBc77KbhnmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289490; c=relaxed/simple;
	bh=B5wgC1Uq0jdwxBr3ymwQRzWJF/eb1cPkeZjLlU+eJeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSA4RdaIUhw+fl/TdGQS39/gBXRXWdps6cSPBO3V4OCaCFcdL/AdGC8yb/nhzUjrzJBDt+EDJIdxz25vp3RXkWDUgL+JUTQENiY2V83rOX83lmUB+4pWl4H/OGOuaIFDnjAGN4PYdjhiiBVYeAWLopCiss3eTtjAeXQ7QpJ6lJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OMZcxCVX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OMZcxCVX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BZxaK2400512;
	Tue, 6 Oct 2026 12:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wGlnoY67mFEM5mpuF
	m6j02HB+6JqMwvRhL9oRkyEGnc=; b=OMZcxCVXUt1l/Hg3Tw93jK0EbMXu7mNS0
	SunmzKw8svxrpRN/unu0B4HFmZP7rUzjZz5/3OMhNeKfrcUF2SN4282CwokGjxw8
	Tukl5nxkrpNaPOEMC9zgSzkf+4e5jm9TNnwYuz83Li0DwQ0Y2URhag/kBF03lvdq
	I1WZnSxBOi0R4s9Ub4VJBXCfEFAMvUVdJb2RNKp9LoX1f2AezvZswbtbgpwtYHgk
	UPZtHAS49/wpzlQ2DuZt9zXSzsZqi48vUkVxNa/0Q+w6olw8e8YxH/ZzCLJPPQQO
	zD1RPEYasigRrkXXYBJpp0cE6oR6DQaSVarE+FeaZ2B5En9vOjPKg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fy3fj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696BWZFE3160993;
	Tue, 6 Oct 2026 12:24:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g9n35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696CORcd52232700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 12:24:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE0C2004E;
	Tue,  6 Oct 2026 12:24:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97E7D2004B;
	Tue,  6 Oct 2026 12:24:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.214.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 12:24:22 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: [PATCH v3 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
Date: Tue,  6 Oct 2026 17:54:03 +0530
Message-ID: <20261006122404.99358-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006122404.99358-1-amachhiw@linux.ibm.com>
References: <20261006122404.99358-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac4e881 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NEo4lJzpL-rF_pqbu-AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX8YExui12f2sH
 S1eWvxFq99zO9DCzsF++3reSNzjFVwzKvqeJaXhuY5rj211YmKDwxu5XaVXpfiWuXqaXYj5yWta
 mbYu/4u0M3g9zhq6lA6Ly7nTlKY1zC5Ee3b8wgjEKO9cRF9dwyD0wmW1RaZxV27bXoVoVSXvMZD
 ZlDlHlcneyO7s07EbmfAVJVQNbhhjdqrHidFZZNZ5PlQNLdKKLd6nkGc8aNFgyA2YuivszPonFY
 OOqJ6ntgD/kYZ6pwc874RqIJyLWAOT3+um/cYH50dCAwMc1m7zAm9hVlWG+yafQJ/JG9SqMJ1Tn
 9MqtA3vFJaae48uggU1XIxNimelMLmgmu2UK3MW6Rnq6hiEM5IzQ0s0CDcCqgSkNnx2WuHTYJHL
 C4lxEXk42FmQyGutXn3gh67EQAzYhRmWrpUObiOo7+EQxCzS3Kkgt4ekIAqVg8v6hQhPyHDf7qr
 ZG/yCGSU3ZgImOXJDcA==
X-Proofpoint-GUID: CzvdfDh3WhkGuznRiYqik9qKed2aEBIO
X-Proofpoint-ORIG-GUID: K01Ka8aaA_5x2MNnZMK0V85Wlhgj3Imf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX4P7QYyoXhR75
 C0Qe9/Z2EfrD5oa0FDviFINKdBGwdoR8/XDGXzmITlERqRA60RRlm+Gd7ZqPORG2ORHy0crXd3C
 IgnSqM0HEVun8eg59pm7c7qnEEpbGU4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060048

kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
preemption disabled, because it can return with HPTE_V_HVLOCK still held
until the caller later unlocks the HPTE.  Existing virtual-mode callers
in book3s_64_mmu_hv.c already follow that rule, but several paths do
not.

kvmppc_handle_exit_hv() calls kvmppc_hpte_hv_fault() for hash-mode
data-side and instruction-side faults after guest exit with preemption
enabled.  kvmppc_pseries_do_hcall() executes virtual-mode HPT hcall
handlers via kvmppc_pseries_do_hpt_hcall() with preemption enabled; the
handlers for H_ENTER, H_REMOVE, H_READ, H_CLEAR_MOD, H_CLEAR_REF,
H_PROTECT, and H_BULK_REMOVE all spin on try_lock_hpte() or lock_rmap().
H_ENTER also reaches kvmppc_do_h_enter(), which uses arch_spin_lock() on
kvm->mmu_lock.  That raw lock choice is intentional because
kvmppc_do_h_enter() is also called from real-mode paths, so the correct
fix is to establish the proper preemption context at the virtual-mode
caller boundary.

On the host side, kvm_unmap_rmapp(), kvm_age_rmapp(),
kvm_test_clear_dirty_npages(), and resize_hpt_rehash_hpte() also acquire
HPTE_V_HVLOCK via try_lock_hpte() in process context with preemption
enabled, serving MMU notifier callbacks, dirty-log harvesting, and HPT
resize respectively.

If any of these threads is preempted while holding HPTE_V_HVLOCK, any
other thread on the same CPU spinning on the same bit-lock can never
make progress, as the lock owner cannot be rescheduled to release it.
This is particularly acute when the spinning thread has preemption
disabled: it will never yield, causing a permanent CPU hang.

Fix this by adding preempt_disable()/preempt_enable() pairs around the
two kvmppc_hpte_hv_fault() call sites in kvmppc_handle_exit_hv() and
around the kvmppc_pseries_do_hpt_hcall() invocation in
kvmppc_pseries_do_hcall().

For kvm_unmap_rmapp() and kvm_age_rmapp(), place preempt_disable() before
lock_rmap() so that both the rmap chain lock and the subsequent
HPTE_V_HVLOCK bit-lock are held under a single non-preemptible window.
There is an ABBA ordering constraint between the two locks: the rmap chain
lock must be dropped before spinning on the HPTE bit-lock (documented in
the comment above the try_lock_hpte() call in kvm_unmap_rmapp()).  To
preserve this, preempt_enable() is called after unlock_rmap() on the
failed try_lock_hpte() retry path and on any early-exit path, before the
cpu_relax() spin, so the HPTE lock owner can be scheduled.

For kvm_test_clear_dirty_npages(), remove the per-iteration
preempt_disable()/preempt_enable() pairs: this function has a single call
site, kvmppc_hv_get_dirty_log_hpt(), which already holds preempt_disable()
across the entire loop, making the inner guards redundant.

For resize_hpt_rehash_hpte(), place preempt_disable() before the
unconditional try_lock_hpte() spin loop and preempt_enable() after
unlock_hpte() at the single exit point.  This function is called from
kvm_vm_ioctl_resize_hpt_commit(), which first quiesces all vCPUs by
clearing kvm->arch.mmu_ready and calling on_each_cpu() to flush any vCPU
currently running in guest mode back to host.  With all vCPUs out of the
guest, no vCPU thread can hold HPTE_V_HVLOCK; any remaining lock holder
(an MMU notifier callback or dirty-log walker) runs on a separate CPU
and is not preempted, so the spin always makes forward progress.

Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
Cc: stable@vger.kernel.org # v5.14+
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v3:
- In kvm_unmap_rmapp() and kvm_age_rmapp(), moved preempt_disable() before
  lock_rmap() so both rmap and HPTE locks are held under a single
  non-preemptible section; added preempt_enable() on early-exit and retry paths.
- Removed redundant per-iteration preempt_disable()/preempt_enable() from
  kvm_test_clear_dirty_npages() as kvmppc_hv_get_dirty_log_hpt() already holds
  it.
- Updated commit log to explain the locking design per function.
- Picked up Reviewed-by tag from Shrikanth Hegde.

Changes in v2:
- Extended preempt_disable()/preempt_enable() to also cover four
  host-side virtual-mode HPTE bit-lock users in book3s_64_mmu_hv.c.
- Added warning comment above kvmppc_pseries_do_hpt_hcall().
- Dropped Reviewed-by as the patch was materially extended.

 arch/powerpc/kvm/book3s_64_mmu_hv.c | 10 ++++++++++
 arch/powerpc/kvm/book3s_hv.c        | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2ccb3d138f46..908495f2b001 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -810,9 +810,11 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 
 	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
 	for (;;) {
+		preempt_disable();
 		lock_rmap(rmapp);
 		if (!(*rmapp & KVMPPC_RMAP_PRESENT)) {
 			unlock_rmap(rmapp);
+			preempt_enable();
 			break;
 		}
 
@@ -826,6 +828,7 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
 			/* unlock rmap before spinning on the HPTE lock */
 			unlock_rmap(rmapp);
+			preempt_enable();
 			while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
 				cpu_relax();
 			continue;
@@ -834,6 +837,7 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		kvmppc_unmap_hpte(kvm, i, memslot, rmapp, gfn);
 		unlock_rmap(rmapp);
 		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
+		preempt_enable();
 	}
 }
 
@@ -890,6 +894,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 
 	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
  retry:
+	preempt_disable();
 	lock_rmap(rmapp);
 	if (*rmapp & KVMPPC_RMAP_REFERENCED) {
 		*rmapp &= ~KVMPPC_RMAP_REFERENCED;
@@ -897,6 +902,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	}
 	if (!(*rmapp & KVMPPC_RMAP_PRESENT)) {
 		unlock_rmap(rmapp);
+		preempt_enable();
 		return ret;
 	}
 
@@ -912,6 +918,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
 			/* unlock rmap before spinning on the HPTE lock */
 			unlock_rmap(rmapp);
+			preempt_enable();
 			while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
 				cpu_relax();
 			goto retry;
@@ -931,6 +938,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
+	preempt_enable();
 	return ret;
 }
 
@@ -1219,6 +1227,7 @@ static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
 	if (!(vpte & HPTE_V_VALID) && !(vpte & HPTE_V_ABSENT))
 		return 0; /* nothing to do */
 
+	preempt_disable();
 	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
 		cpu_relax();
 
@@ -1346,6 +1355,7 @@ static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
 
 out:
 	unlock_hpte(hptep, vpte);
+	preempt_enable();
 	return ret;
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 46dd550115a4..56083b415a29 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1159,6 +1159,10 @@ static long kvmppc_h_rpt_invalidate(struct kvm_vcpu *vcpu,
 	return H_SUCCESS;
 }
 
+/*
+ * Must be called with preemption disabled. The HPT hcall handlers spin
+ * on HPTE bit-locks and cannot make any blocking/sleeping calls.
+ */
 static long kvmppc_pseries_do_hpt_hcall(struct kvm_vcpu *vcpu, unsigned long req)
 {
 	switch (req) {
@@ -1212,9 +1216,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 	case H_CLEAR_REF:
 	case H_PROTECT:
 	case H_BULK_REMOVE:
+		preempt_disable();
 		idx = srcu_read_lock(&kvm->srcu);
 		ret = kvmppc_pseries_do_hpt_hcall(vcpu, req);
 		srcu_read_unlock(&kvm->srcu, idx);
+		preempt_enable();
 		if (ret == H_TOO_HARD)
 			return RESUME_HOST;
 		break;
@@ -1834,8 +1840,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
 		else
 			vsid = vcpu->arch.fault_gpa;
 
+		preempt_disable();
 		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
 				vsid, vcpu->arch.fault_dsisr, true);
+		preempt_enable();
 		if (err == 0) {
 			r = RESUME_GUEST;
 		} else if (err == -1 || err == -2) {
@@ -1881,8 +1889,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
 		else
 			vsid = vcpu->arch.fault_gpa;
 
+		preempt_disable();
 		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
 				vsid, vcpu->arch.fault_dsisr, false);
+		preempt_enable();
 		if (err == 0) {
 			r = RESUME_GUEST;
 		} else if (err == -1) {
-- 
2.54.0 (Apple Git-157)

